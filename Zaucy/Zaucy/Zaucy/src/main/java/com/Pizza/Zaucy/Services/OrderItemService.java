package com.Pizza.Zaucy.Services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Pizza.Zaucy.Beans.OrderItem;
import com.Pizza.Zaucy.Repositories.OrderItemRepository;

import java.util.List;
import java.util.Optional;

@Service
public class OrderItemService {

    @Autowired
    private OrderItemRepository orderItemRepository;

    // Create an order item
    public OrderItem createOrderItem(OrderItem orderItem) {
        return orderItemRepository.save(orderItem);
    }

    // Get a list of all order items
    public List<OrderItem> getAllOrderItems() {
        return orderItemRepository.findAll();
    }

    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        return orderItemRepository.findByOrder_OrderId(orderId);
    }

    // Get a single order item by ID
    public Optional<OrderItem> getOrderItemById(int id) {
        return orderItemRepository.findById(id);
    }

    // Delete an order item
    public void deleteOrderItem(int id) {
        orderItemRepository.deleteById(id);
    }

    public OrderItem updateOrderItem(int id, OrderItem updatedOrderItem) {
        return orderItemRepository.findById(id)
                .map(existingOrderItem -> {
                    existingOrderItem.setQuantity(updatedOrderItem.getQuantity());
                    return orderItemRepository.save(existingOrderItem);
                })
                .orElseThrow(() -> new RuntimeException("OrderItem not found with id: " + id));
    }

    public OrderItem updateOrderItemQuantity(int id, int newQuantity) {
        return orderItemRepository.findById(id)
                .map(existingOrderItem -> {
                    existingOrderItem.setQuantity(newQuantity);
                    return orderItemRepository.save(existingOrderItem);
                })
                .orElseThrow(() -> new RuntimeException("OrderItem not found with id: " + id));
    }

    public OrderItem updateOrderItemPrice(int id, double newPrice) {
        return orderItemRepository.findById(id)
                .map(existingOrderItem -> {
                    existingOrderItem.setPrice(newPrice);
                    return orderItemRepository.save(existingOrderItem);
                })
                .orElseThrow(() -> new RuntimeException("OrderItem not found with id: " + id));
    }
}
