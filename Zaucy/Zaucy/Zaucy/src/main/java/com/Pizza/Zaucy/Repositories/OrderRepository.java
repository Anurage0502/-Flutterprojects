package com.Pizza.Zaucy.Repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Pizza.Zaucy.Beans.Order;
import com.Pizza.Zaucy.OrderStatus;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    // You can add custom query methods if needed
    Optional<Order> findByIsPlacedFalse(); // Get the ongoing order

    void deleteAllByIsPlacedFalse();

    List<Order> findByUser_UserId(Long userId);

    List<Order> findByStatus(OrderStatus status);

    List<Order> findByIsPlacedTrue();
}