package com.example.demo;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="room")
public class Room {
    @Id
    private int id;
    private String name;
    private String Type;
    private String Room;
    private boolean Vacant;
    private float price;

    public String getName() {
        return name;
    }

    public int getId() {
        return id;
    }

    public String getType() {
        return Type;
    }

    public String getRoom() {
        return Room;
    }

    public boolean isVacant() {
        return Vacant;
    }

    public void setVacant(boolean vacant) {
        this.Vacant= vacant;
    }

    public float getPrice() {
        return price;
    }
}

