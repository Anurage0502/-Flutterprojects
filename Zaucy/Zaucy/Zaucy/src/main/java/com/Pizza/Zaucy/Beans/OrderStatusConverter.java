package com.Pizza.Zaucy.Beans;

import java.beans.PropertyEditorSupport;

import com.Pizza.Zaucy.OrderStatus;

public class OrderStatusConverter extends PropertyEditorSupport {
    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        // Convert the string to lowercase and map it to the enum value
        setValue(OrderStatus.valueOf(text.toLowerCase()));
    }
}
