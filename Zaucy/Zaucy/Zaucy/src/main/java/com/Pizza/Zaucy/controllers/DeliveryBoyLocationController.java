package com.Pizza.Zaucy.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Pizza.Zaucy.Beans.DeliveryBoyLocation;
import com.Pizza.Zaucy.Services.DeliveryBoyLocationService;

@RestController
@RequestMapping("/api/location")
public class DeliveryBoyLocationController {

    @Autowired
    private DeliveryBoyLocationService service;

    @PostMapping("/create")
    public ResponseEntity<Long> createLocation(@RequestBody DeliveryBoyLocation location) {
        service.createLocation(location.getLatitude(), location.getLongitude());
        return ResponseEntity.ok(location.getDeliveryBoyId());
    }

    @PutMapping("/update")
    public ResponseEntity<String> updateLocation(@RequestBody DeliveryBoyLocation location) {
        service.updateLocation(location.getDeliveryBoyId(), location.getLatitude(), location.getLongitude());
        return ResponseEntity.ok("Location updated successfully.");
    }

    // 3️⃣ Get latest location
    @GetMapping("/get/{deliveryBoyId}")
    public ResponseEntity<DeliveryBoyLocation> getLocation(@PathVariable Long deliveryBoyId) {
        DeliveryBoyLocation location = service.getLocation(deliveryBoyId);
        return location != null ? ResponseEntity.ok(location) : ResponseEntity.notFound().build();
    }

}
