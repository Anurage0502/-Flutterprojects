package com.Pizza.Zaucy.DTO;

import com.fasterxml.jackson.annotation.JsonProperty;

public class OrderItemDTO {
    @JsonProperty("menu_id")
    private String menuId;
    @JsonProperty("order_id")
    private int orderId;
    @JsonProperty("size_id")
    private int sizeid;

    public int getSizeid() {
        return sizeid;
    }

    public void setSizeid(int sizeid) {
        this.sizeid = sizeid;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    private int quantity; // Quantity of the item
    private Double price; // Price of the item

    // Getters and Setters
    public String getMenuId() {
        return menuId;
    }

    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
