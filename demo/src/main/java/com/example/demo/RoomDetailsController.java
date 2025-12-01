package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class RoomDetailsController {

    private final RoomRepository roomRepository;
    private final RoomDetailsRepository detailsRepository;

    public RoomDetailsController(RoomRepository roomRepository, RoomDetailsRepository detailsRepository) {
        this.roomRepository = roomRepository;
        this.detailsRepository = detailsRepository;
    }

    @GetMapping("/rooms/{id}")
    public String getRoomDetailsPage(@PathVariable Long id, Model model) {
        Room room = roomRepository.findById(id.intValue())
                .orElse(null);
        if (room == null) return "room-not-found";

        model.addAttribute("room", room);

        RoomDetails desc = detailsRepository.findByRoomId((long) id).orElse(new RoomDetails());

        model.addAttribute("roomDescription", desc);

        // Разбиваем "more" по строкам
        String[] moreList = desc.getMore() != null ? desc.getMore().split("\\r?\\n") : new String[0];
        model.addAttribute("moreList", moreList);

        // Фото
        model.addAttribute("photos", new String[]{
                "/images/room_" + id + "_1.jpg",
                "/images/room_" + id + "_2.jpg"
        });

        return "room-details";
    }
}