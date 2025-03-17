package com.Pizza.Zaucy.Beans;

import org.hibernate.annotations.Table;
import org.springframework.data.annotation.Id;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import lombok.Getter;
import lombok.Setter;

@Entity
@Setter
@Getter
@jakarta.persistence.Table(name = "delivery_boy_location")
public class DeliveryBoyLocation {

    @jakarta.persistence.Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long deliveryBoyId; // Unique ID for the delivery boy

    private Double latitude;
    private Double longitude;

    public DeliveryBoyLocation(Double latitude, Double longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public DeliveryBoyLocation() {
    }

    public DeliveryBoyLocation(Long deliveryBoyId, Double latitude, Double longitude) {
        this.deliveryBoyId = deliveryBoyId;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    // Getters and Setters
}
