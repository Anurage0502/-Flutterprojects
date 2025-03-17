package com.Pizza.Zaucy.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Pizza.Zaucy.Beans.ListToppings;
import com.Pizza.Zaucy.Beans.Toppings;
import com.Pizza.Zaucy.Repositories.ListToppingsRepository;

@Service
public class ListToppingsServices {

    @Autowired
    private ListToppingsRepository listToppingsRepository;

    public List<ListToppings> getAllToppingsofOrderItem(int id) {
        return listToppingsRepository.findByOrderItem_ItemId(id);
    }

    public ListToppings addListToppings(ListToppings listToppings) {
        return listToppingsRepository.save(listToppings);
    }

    public void deleteToppings(ListToppings listToppings) {
        listToppingsRepository.delete(listToppings);
    }
}
