package com.Pizza.Zaucy.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.Pizza.Zaucy.Beans.ListToppings;
import com.Pizza.Zaucy.Beans.OrderItem;
import com.Pizza.Zaucy.Beans.Toppings;
import com.Pizza.Zaucy.Repositories.ListToppingsRepository;
import com.Pizza.Zaucy.Repositories.OrderItemRepository;
import com.Pizza.Zaucy.Repositories.ToppingsRepo;
import com.Pizza.Zaucy.Services.ListToppingsServices;

@RestController
@RequestMapping("/api/ListTopping")
public class ListToppingsController {

    @Autowired
    private ListToppingsServices listToppingsServices;

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Autowired
    private ToppingsRepo toppingsRepo;

    @Autowired
    private ListToppingsRepository listToppingsRepository;

    @GetMapping("/{id}")
    public List<Toppings> getToppings(@PathVariable int id) {
        List<Toppings> toppings22 = new ArrayList<>();
        List<ListToppings> listToppings;

        listToppings = listToppingsServices.getAllToppingsofOrderItem(id);
        for (int i = 0; i < listToppings.size(); i++) {
            toppings22.add(listToppings.get(i).getTopping());
        }
        return toppings22;
    }

    @PostMapping
    public ListToppings addListToppings(@RequestParam int orderitemid, @RequestParam int toppingsid) {
        Optional<OrderItem> orderitem = orderItemRepository.findById(orderitemid);
        Optional<Toppings> toppings = toppingsRepo.findById(toppingsid);
        if (orderitem.isPresent() && toppings.isPresent()) {
            ListToppings listToppings = new ListToppings(
                    orderitem.get(), toppings.get());
            return listToppingsServices.addListToppings(listToppings);
        } else {
            return null;
        }
    }

    @DeleteMapping
    public void deleteListToppings(@RequestParam int orderitemid, @RequestParam int toppingsid) {
        Optional<OrderItem> orderitem = orderItemRepository.findById(orderitemid);
        Optional<Toppings> toppings = toppingsRepo.findById(toppingsid);

        if (orderitem.isPresent() && toppings.isPresent()) {
            // Find the ListToppings using the orderItem and toppings IDs
            ListToppings listToppings = listToppingsRepository.findByOrderItem_ItemIdAndTopping_id(orderitemid,
                    toppingsid);

            if (listToppings != null) {
                listToppingsRepository.delete(listToppings);

            } else {

            }
        } else {

        }
    }
}
