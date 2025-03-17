package com.Pizza.Zaucy.Beans;

import org.springframework.core.convert.converter.Converter;

import com.Pizza.Zaucy.Beans.Coupon.Category;

public class CategoryConverter implements Converter<String, Category> {
    @Override
    public Category convert(String source) {
        return Category.valueOf(source.toUpperCase());
    }
}
