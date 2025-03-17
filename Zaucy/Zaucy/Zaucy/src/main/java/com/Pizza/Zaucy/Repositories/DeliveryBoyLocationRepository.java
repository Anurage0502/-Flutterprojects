package com.Pizza.Zaucy.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Pizza.Zaucy.Beans.DeliveryBoyLocation;

@Repository
public interface DeliveryBoyLocationRepository extends JpaRepository<DeliveryBoyLocation, Long> {
}
