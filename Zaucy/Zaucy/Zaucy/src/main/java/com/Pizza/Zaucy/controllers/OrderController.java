package com.Pizza.Zaucy.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import com.Pizza.Zaucy.OrderStatus;
import com.Pizza.Zaucy.Beans.Order;
import com.Pizza.Zaucy.Beans.OrderStatusConverter;
import com.Pizza.Zaucy.Repositories.OrderRepository;
import com.Pizza.Zaucy.Services.OrderService;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(OrderStatus.class, new OrderStatusConverter());
    }

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderRepository orderRepository;

    // Get a list of all orders
    @GetMapping
    @CrossOrigin(origins = "*")
    public ResponseEntity<List<Order>> getAllOrders() {
        List<Order> orders = orderService.getAllOrders();
        return new ResponseEntity<>(orders, HttpStatus.OK);
    }

    @GetMapping("/PlacedOrders")
    @CrossOrigin(origins = "*")
    public ResponseEntity<List<Order>> getAllPlacedOrders() {
        List<Order> orders = orderRepository.findByIsPlacedTrue();
        return new ResponseEntity<>(orders, HttpStatus.OK);
    }

    // Get a single order by ID
    @GetMapping("/{id}")
    public ResponseEntity<Order> getOrderById(@PathVariable("id") Integer id) {
        Optional<Order> order = orderService.getOrderById(id);
        return order.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Create a new order
    @PostMapping("/{userId}")
    public ResponseEntity<Order> createOrder(@PathVariable("userId") Integer userid, @RequestBody Order order) {
        Order createdOrder = orderService.createOrder(order, userid);
        return new ResponseEntity<>(createdOrder, HttpStatus.CREATED);
    }

    // Update the status of an order
    @PutMapping("/{id}")
    @CrossOrigin(origins = "*")
    public ResponseEntity<Order> updateOrderStatus(
            @PathVariable("id") Integer id,
            @RequestParam("status") OrderStatus status) {
        Order updatedOrder = orderService.updateOrderStatus(id, status);
        return updatedOrder != null ? ResponseEntity.ok(updatedOrder) : ResponseEntity.notFound().build();
    }

    @PutMapping("/Coupon/{id}")
    @CrossOrigin(origins = "*")
    public ResponseEntity<Order> updateOrderCoupon(
            @PathVariable("id") Integer id,
            @RequestParam("CouponCode") String code) {
        Order updatedOrder = orderService.updateOrderCoupon(id, code);
        return updatedOrder != null ? ResponseEntity.ok(updatedOrder) : ResponseEntity.notFound().build();
    }

    @PutMapping("/DiscountedPrice/{id}")
    @CrossOrigin(origins = "*")
    public ResponseEntity<Order> updateOrderDiscountPrice(
            @PathVariable("id") Integer id,
            @RequestParam("DiscountPrice") BigDecimal price) {
        Order updatedOrder = orderService.updateOrderDiscountPrice(id, price);
        return updatedOrder != null ? ResponseEntity.ok(updatedOrder) : ResponseEntity.notFound().build();
    }

    // Delete an order
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrder(@PathVariable("id") Integer id) {
        orderService.deleteOrder(id);
        return ResponseEntity.noContent().build();
    }

    @PutMapping("/place/{orderId}")
    public ResponseEntity<Order> placeOrder(@PathVariable int orderId, @RequestBody Order updatedOrder) {
        try {
            // Call the service to place the order
            Order placedOrder = orderService.placeOrder(orderId, updatedOrder);
            return ResponseEntity.ok(placedOrder); // Return updated order if placed successfully
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(null); // Return error if order already placed
        }
    }

    @GetMapping("/user/{userId}") // Path: /api/orders/user/{userId}
    public ResponseEntity<List<Order>> getOrdersByUserId(@PathVariable Long userId) {
        List<Order> orders = orderService.getOrdersByUserId(userId);

        if (orders.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT); // 204 No Content if no orders found
        } else {
            return new ResponseEntity<>(orders, HttpStatus.OK); // 200 OK with the list of orders
        }
    }

    @GetMapping("/pending")
    @CrossOrigin(origins = "*")
    public ResponseEntity<List<Order>> getPendingOrders() {
        orderService.deleteUnplacedOrders();
        List<Order> pendingOrders = orderService.getPendingOrders();

        if (pendingOrders.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT); // 204 No Content if no pending orders
        } else {
            return new ResponseEntity<>(pendingOrders, HttpStatus.OK); // 200 OK with the list of orders
        }
    }
}
