package com.Pizza.Zaucy.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Pizza.Zaucy.Beans.menu;
import com.Pizza.Zaucy.Repositories.MenuRepo;

@Service
public class menuservices {

    @Autowired
    private MenuRepo menuRepo;

    public List<menu> getallmenuitems() {
        return menuRepo.findAll();
    }

    public Optional<menu> getmenuitembyid(String id) {
        return menuRepo.findById(id);
    }

    public menu additemmenu(menu menu) {
        return menuRepo.save(menu);
    }

    public void removeitemmenu(String id) {
        if (menuRepo.existsById(id))
            menuRepo.deleteById(id);
    }

    public menu updateitemmenu(String id, menu menu22) {
        if (menuRepo.existsById(id)) {
            menu22.setId(id);
            return menuRepo.save(menu22);
        } else {
            return null;
        }
    }
}
