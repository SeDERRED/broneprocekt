package com.example.demo;

import jakarta.persistence.*;

@Entity
@Table(name = "room_details")
public class RoomDetails {

    @Id
    @Column(name = "room_id")
    private Long roomId;

    @Column(name = "sq_m")
    private Integer sqM;

    @Column(name = "wifi")
    private String wifi;

    @Column(name = "air_conditioning")
    private boolean airConditioning;

    @Column(name = "bed_number")
    private Integer bedNumber;

    @Column(name = "more")
    private String more;

    @Column(name = "rating")
    private float rating;

    @Column(name = "reviews")
    private int reviews;

    // Геттеры и сеттеры

    public Long getRoomId() {
        return roomId;
    }

    public void setRoomId(Long roomId) {
        this.roomId = roomId;
    }

    public Integer getSqM() {
        return sqM;
    }

    public void setSqM(Integer sqM) {
        this.sqM = sqM;
    }

    public String getWifi() {
        return wifi;
    }

    public void setWifi(String wifi) {
        this.wifi = wifi;
    }

    public boolean isAirConditioning() {
        return airConditioning;
    }

    public void setAirConditioning(boolean airConditioning) {
        this.airConditioning = airConditioning;
    }

    public Integer getBedNumber() {
        return bedNumber;
    }

    public void setBedNumber(Integer bedNumber) {
        this.bedNumber = bedNumber;
    }

    public String getMore() {
        return more;
    }

    public void setMore(String more) {
        this.more = more;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public int getReviews() {
        return reviews;
    }

    public void setReviews(int reviews) {
        this.reviews = reviews;
    }
}