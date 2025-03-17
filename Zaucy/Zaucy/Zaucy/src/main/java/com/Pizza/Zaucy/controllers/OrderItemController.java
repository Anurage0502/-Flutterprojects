package com.Pizza.Zaucy.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.Pizza.Zaucy.Beans.Order;
import com.Pizza.Zaucy.Beans.OrderItem;
import com.Pizza.Zaucy.Beans.menu;
import com.Pizza.Zaucy.DTO.OrderItemDTO;

import com.Pizza.Zaucy.Repositories.MenuRepo;
import com.Pizza.Zaucy.Repositories.OrderRepository;
import com.Pizza.Zaucy.Services.OrderItemService;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/orderitems")
public class OrderItemController {
    @Autowired
    private MenuRepo menuRepo;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderItemService orderItemService;

    // Get a list of all order items
    @GetMapping
    public ResponseEntity<List<OrderItem>> getAllOrderItems() {
        List<OrderItem> orderItems = orderItemService.getAllOrderItems();
        return new ResponseEntity<>(orderItems, HttpStatus.OK);
    }

    // Get a single order item by ID
    @GetMapping("/single/{id}")
    public ResponseEntity<OrderItem> getOrderItemById(@PathVariable("id") int id) {
        Optional<OrderItem> orderItem = orderItemService.getOrderItemById(id);
        return orderItem.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Create a new order item
    @PostMapping
    public ResponseEntity<OrderItem> createOrderItem(@RequestBody OrderItemDTO orderItemDTO) {
        // Fetch the Menu entity using the menuId from the DTO
        if (orderItemDTO.getMenuId() == null) {
            return ResponseEntity.badRequest().body(null);
        }

        // Fetch the Menu entity using the menuId from the DTO
        menu menu = menuRepo.findById(orderItemDTO.getMenuId())
                .orElseThrow(() -> new RuntimeException("Menu not found"));

        Order order = orderRepository.findById(orderItemDTO.getOrderId())
                .orElseThrow(() -> new RuntimeException("Order not found"));

        // Create a new OrderItem and set the Menu, quantity, and price
        OrderItem orderItem = new OrderItem();
        orderItem.setOrder(order);
        orderItem.setMenu(menu);// Set the menuId directly
        orderItem.setQuantity(orderItemDTO.getQuantity());
        orderItem.setPrice(orderItemDTO.getPrice());

        // Save the OrderItem to the database
        OrderItem createdOrderItem = orderItemService.createOrderItem(orderItem);
        return new ResponseEntity<>(createdOrderItem, HttpStatus.CREATED);
    }

    // Delete an order item
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrderItem(@PathVariable("id") int id) {
        orderItemService.deleteOrderItem(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{orderId}")
    public List<OrderItem> getOrderItems(@PathVariable int orderId) {
        return orderItemService.getOrderItemsByOrderId(orderId);
    }

    @PutMapping("/{id}")
    public ResponseEntity<OrderItem> updateOrderItemQuantity(
            @PathVariable int id, @RequestParam int quantity, @RequestHeader Map<String, String> headers) {
        headers.forEach((key, value) -> System.out.println("Header: " + key + " Value: " + value));
        OrderItem updatedOrderItem = orderItemService.updateOrderItemQuantity(id, quantity);
        return ResponseEntity.ok(updatedOrderItem);
    }

    @PutMapping("/Price/{id}")
    public ResponseEntity<OrderItem> updateOrderItemPrice(
            @PathVariable int id, @RequestParam double Price, @RequestHeader Map<String, String> headers) {
        headers.forEach((key, value) -> System.out.println("Header: " + key + " Value: " + value));
        OrderItem updatedOrderItem = orderItemService.updateOrderItemPrice(id, Price);
        return ResponseEntity.ok(updatedOrderItem);
    }
}
