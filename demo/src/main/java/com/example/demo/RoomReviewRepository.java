package com.example.demo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface RoomReviewRepository extends JpaRepository<RoomReview, Integer> {

    boolean existsByUserAndRoom(User user, Room room);

    @Query("SELECT AVG(r.rating) FROM RoomReview r WHERE r.room = :room")
    Double averageRating(Room room);

    long countByRoom(Room room);

    List<RoomReview> findByRoomOrderByCreatedAtDesc(Room room);
}
