package com.Pizza.Zaucy.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Pizza.Zaucy.Beans.Toppings;
import com.Pizza.Zaucy.Repositories.ToppingsRepo;

@Service
public class ToppingsServices {

    @Autowired
    private ToppingsRepo toppingsRepository;

    public List<Toppings> getAllToppings() {
        return toppingsRepository.findAll();
    }

    public Toppings addToppings(Toppings toppings) {
        return toppingsRepository.save(toppings);
    }

    public Toppings UpdateToppings(Toppings toppings, int id) {
        if (toppingsRepository.existsById(id)) {
            toppings.setId(id);
            return toppingsRepository.save(toppings);
        } else {
            return null;

        }
    }

    public void deleteToppings(int id) {
        toppingsRepository.deleteById(id);
    }
}
