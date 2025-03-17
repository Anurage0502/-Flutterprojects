package com.Pizza.Zaucy.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Pizza.Zaucy.Beans.OrderItem;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, Integer> {
    // You can add custom query methods if needed
    List<OrderItem> findByOrder_OrderId(int orderId);

}
