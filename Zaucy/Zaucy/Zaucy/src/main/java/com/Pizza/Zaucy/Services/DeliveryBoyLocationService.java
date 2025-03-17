package com.Pizza.Zaucy.Services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Pizza.Zaucy.Beans.DeliveryBoyLocation;
import com.Pizza.Zaucy.Repositories.DeliveryBoyLocationRepository;

@Service
public class DeliveryBoyLocationService {

    @Autowired
    private DeliveryBoyLocationRepository repository;

    public void createLocation(Double latitude, Double longitude) {
        DeliveryBoyLocation location = new DeliveryBoyLocation(latitude, longitude);
        repository.save(location);
    }

    public void updateLocation(Long deliveryBoyId, Double latitude, Double longitude) {
        DeliveryBoyLocation location = repository.findById(deliveryBoyId)
                .orElse(new DeliveryBoyLocation(deliveryBoyId, latitude, longitude));

        location.setLatitude(latitude);
        location.setLongitude(longitude);
        repository.save(location);
    }

    public DeliveryBoyLocation getLocation(Long deliveryBoyId) {
        return repository.findById(deliveryBoyId).orElse(null);
    }

}
