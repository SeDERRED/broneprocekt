package com.example.demo;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/rooms")
public class RoomDetailsController {

    private final RoomRepository roomRepository;
    private final RoomDetailsRepository detailsRepository;
    private final RoomReviewRepository roomReviewRepository;
    private final UserRepository userRepository;

    public RoomDetailsController(RoomRepository roomRepository,
                                 RoomDetailsRepository detailsRepository,
                                 RoomReviewRepository roomReviewRepository,
                                 UserRepository userRepository) {
        this.roomRepository = roomRepository;
        this.detailsRepository = detailsRepository;
        this.roomReviewRepository = roomReviewRepository;
        this.userRepository = userRepository;
    }

    @GetMapping("/{id}")
    public String getRoomDetailsPage(@PathVariable Integer id,
                                     @RequestParam(required = false) Long userId,
                                     HttpSession session,
                                     Model model) {
        if (userId == null) {
            Object sessionUserId = session.getAttribute("userId");
            if (sessionUserId != null) {
                userId = (Long) sessionUserId;
            }
        }
        Room room = roomRepository.findById(id).orElseThrow();
        RoomDetails details = detailsRepository.findByRoomId((long) id).orElse(new RoomDetails());

        model.addAttribute("room", room);
        model.addAttribute("roomDescription", details);
        model.addAttribute("userId", userId);


        // moreList
        String[] moreList = details.getMore() != null ? details.getMore().split("\\r?\\n") : new String[0];
        model.addAttribute("moreList", moreList);

        // Фото
        model.addAttribute("photos", new String[]{
                "/images/room_" + id + "_1.jpg",
                "/images/room_" + id + "_2.jpg"
        });

        // Reviews
        List<RoomReview> reviews = roomReviewRepository.findByRoomOrderByCreatedAtDesc(room);
        model.addAttribute("reviews", reviews);

        Long currentUserId = userId;
        if (currentUserId == null) {
            Object sessionUserId = session.getAttribute("userId");
            if (sessionUserId != null) {
                currentUserId = (Long) sessionUserId;
            }
        }
        model.addAttribute("userId", currentUserId);

        // Проверяем, может ли пользователь оставить отзыв для этой конкретной комнаты
        boolean canReview = false;
        if (currentUserId != null) {
            Optional<User> optionalUser = userRepository.findById(currentUserId);
            if (optionalUser.isPresent()) {
                User currentUser = optionalUser.get();
                // Проверяем отзыв **только для этой комнаты**
                canReview = !roomReviewRepository.existsByUserAndRoom(currentUser, room);
            }
        }
        model.addAttribute("canReview", canReview);

        // Рейтинг в виде звезд
        int fullStars = (int) Math.floor(details.getRating());
        int emptyStars = 5 - fullStars;
        StringBuilder stars = new StringBuilder();
        for (int i = 0; i < fullStars; i++) stars.append("⭐");
        for (int i = 0; i < emptyStars; i++) stars.append("☆");
        model.addAttribute("stars", stars.toString());

        return "room-details";
    }

    @PostMapping("/{id}/review")
    public String addReview(@PathVariable Integer id,
                            @RequestParam Long userId,
                            @RequestParam int rating,
                            @RequestParam String comment) {

        Room room = roomRepository.findById(id).orElseThrow();
        User user = userRepository.findById(userId).orElseThrow();

        // Проверяем, оставлял ли уже отзыв
        if (!roomReviewRepository.existsByUserAndRoom(user, room)) {
            RoomReview review = new RoomReview();
            review.setRoom(room);
            review.setUser(user);
            review.setRating(rating);
            review.setComment(comment);
            roomReviewRepository.save(review);

            // Обновляем средний рейтинг и количество отзывов
            Double avg = roomReviewRepository.averageRating(room);
            long count = roomReviewRepository.countByRoom(room);

            RoomDetails details = detailsRepository.findByRoomId((long) id).orElse(new RoomDetails());
            details.setRating(avg != null ? avg.floatValue() : 0);
            details.setReviews((int) count);
            detailsRepository.save(details);
        }

        return "redirect:/rooms/" + id + "?userId=" + userId;
    }
}