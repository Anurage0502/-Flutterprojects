package com.Pizza.Zaucy.Services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.Pizza.Zaucy.OrderStatus;
import com.Pizza.Zaucy.Beans.Coupon;
import com.Pizza.Zaucy.Beans.Order;
import com.Pizza.Zaucy.Beans.OrderItem;
import com.Pizza.Zaucy.Beans.User;
import com.Pizza.Zaucy.Repositories.CouponRepository;
import com.Pizza.Zaucy.Repositories.ListToppingsRepository;
import com.Pizza.Zaucy.Repositories.OrderItemRepository;
import com.Pizza.Zaucy.Repositories.OrderRepository;
import com.Pizza.Zaucy.Repositories.UserRepository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ListToppingsRepository listToppingsRepository;

    @Autowired
    private CouponRepository couponRepository;

    // Create a new order
    @Transactional
    public Order createOrder(Order order, int userId) {
        // deleteUnplacedOrders();// ADHICHE sGALE dELETE JHALE
        // Save the order and return the saved entity
        User user = userRepository.getReferenceById(userId);
        order.setUser(user);
        return orderRepository.save(order);
    }

    // Get a list of all orders
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    // Get a single order by ID
    public Optional<Order> getOrderById(Integer id) {
        return orderRepository.findById(id);
    }

    // Update the status of an order
    public Order updateOrderStatus(Integer orderId, OrderStatus status) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setStatus(status);
            return orderRepository.save(order);
        } else {
            return null; // Return null if order is not found
        }
    }

    public Order updateOrderCoupon(Integer orderId, String Couponcode) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        Optional<Coupon> optionalCoupon = couponRepository.findByCode(Couponcode);
        if (optionalOrder.isPresent() && optionalCoupon.isPresent()) {
            Order order = optionalOrder.get();
            order.setCouponCode(Couponcode);
            return orderRepository.save(order);
        } else {
            return null;
        }
    }

    public Order updateOrderDiscountPrice(Integer orderId, BigDecimal DiscountedPrice) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);

        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setDiscountApplied(DiscountedPrice);
            return orderRepository.save(order);
        } else {
            return null;
        }
    }

    @Transactional
    public Order placeOrder(int orderId, Order updatedOrder) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        if (order.getisPlaced()) {
            throw new RuntimeException("Order is already placed!");
        }
        // Update the order details
        order.setTotalPrice(updatedOrder.getTotalPrice());
        order.setisPlaced(true);
        order.setOrderItems(updatedOrder.getOrderItems());
        return orderRepository.save(order); // Save and return updated order
    }

    // Delete an order
    public void deleteOrder(Integer id) {
        orderRepository.deleteById(id);
    }

    // Add order items to an order
    @Transactional
    public void addOrderItemsToOrder(Integer orderId, List<OrderItem> orderItems) {
        Optional<Order> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            for (OrderItem item : orderItems) {
                item.setOrder(order); // link the order to the order items
                orderItemRepository.save(item);
            }
        }
    }

    @Transactional
    public void deleteUnplacedOrders() {

        orderRepository.deleteAllByIsPlacedFalse();
    }

    public List<Order> getOrdersByUserId(Long userId) {
        return orderRepository.findByUser_UserId(userId);
    }

    public List<Order> getPendingOrders() {

        return orderRepository.findByStatus(OrderStatus.pending);
    }
}
