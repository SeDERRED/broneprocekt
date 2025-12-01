package com.example.demo;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/hotel2")
public class Roomcontroller {

    private final RoomRepository roomRepository;
    private final UserRepository userRepository;
    private final BookingRepository bookingRepository;

    public Roomcontroller(RoomRepository roomRepository, UserRepository userRepository, BookingRepository bookingRepository) {
        this.roomRepository = roomRepository;
        this.userRepository = userRepository;
        this.bookingRepository = bookingRepository;
    }

    @GetMapping("/rooms")
    public List<Room> getAllRoom() {
        return roomRepository.findAll();
    }

    @PostMapping("/rooms/{id}/book")
    public ResponseEntity<String> bookRoom(
            @PathVariable Long id,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam Long userId
    ) {
        Room room = roomRepository.findById(id.intValue())
                .orElseThrow(() -> new RuntimeException("Комната не найдена"));

        if (!room.isVacant()) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Комната уже забронирована");
        }

        Booking booking = new Booking();
        booking.setRoomId(id);
        booking.setStartDate(startDate);
        booking.setEndDate(endDate);
        booking.setUserId(userId);
        booking.setCanceled(false);

        bookingRepository.save(booking);

        room.setVacant(false);
        roomRepository.save(room);

        return ResponseEntity.ok("Бронь создана. ID брони: " + booking.getId());
    }

    @PostMapping("/rooms/{id}/cancel")
    public ResponseEntity<String> cancelBooking(
            @PathVariable Long id,
            @RequestParam Long userId,
            @RequestParam(required = false) String role
    ) {
        Booking booking = bookingRepository.findByRoomId(id)
                .orElseThrow(() -> new RuntimeException("Бронирование не найдено"));

        boolean isAdmin = "admin".equalsIgnoreCase(role);

        if (!isAdmin && !booking.getUserId().equals(userId)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN)
                    .body("У вас нет прав отменять чужое бронирование");
        }

        booking.setCanceled(true);
        bookingRepository.save(booking);

        Room room = roomRepository.findById(Math.toIntExact(id))
                .orElseThrow(() -> new RuntimeException("Комната не найдена"));

        room.setVacant(true);
        roomRepository.save(room);

        return ResponseEntity.ok("Бронирование отменено");
    }
}