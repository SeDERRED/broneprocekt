package com.example.demo;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoomDetailsRepository extends JpaRepository<RoomDetails, Long> {
    Optional<RoomDetails> findByRoomId(Long roomId);
}