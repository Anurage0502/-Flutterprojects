package com.Pizza.Zaucy.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Pizza.Zaucy.Beans.Toppings;
import com.Pizza.Zaucy.Services.ToppingsServices;

@RestController
@RequestMapping("api/Toppings")
public class ToppingsController {

    @Autowired
    private ToppingsServices toppingsService;

    @GetMapping
    public List<Toppings> getToppings() {
        return toppingsService.getAllToppings();
    }

    @PutMapping("/id")
    public Toppings updateToppings(@PathVariable int id, @RequestBody Toppings topping,
            @RequestHeader Map<String, String> headers) {
        headers.forEach((key, value) -> System.out.println("Header: " + key + " Value: " + value));
        return toppingsService.UpdateToppings(topping, id);
    }
}
