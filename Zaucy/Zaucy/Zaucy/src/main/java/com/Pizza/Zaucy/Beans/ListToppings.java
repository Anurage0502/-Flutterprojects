package com.Pizza.Zaucy.Beans;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "listtoppings")

@NoArgsConstructor
@AllArgsConstructor
public class ListToppings {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "orderitem_id", nullable = false)
    private OrderItem orderItem;

    public OrderItem getOrderItem() {
        return orderItem;
    }

    public void setOrderItem(OrderItem orderItem) {
        this.orderItem = orderItem;
    }

    public ListToppings(OrderItem orderItem, Toppings topping) {
        this.orderItem = orderItem;
        this.topping = topping;
    }

    @ManyToOne
    @JoinColumn(name = "topping_id", nullable = false)
    private Toppings topping;

    public Toppings getTopping() {
        return topping;
    }

    public void setTopping(Toppings topping) {
        this.topping = topping;
    }
}
