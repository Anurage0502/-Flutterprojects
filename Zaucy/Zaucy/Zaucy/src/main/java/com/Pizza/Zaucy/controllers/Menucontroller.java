package com.Pizza.Zaucy.controllers;

import java.util.List;
import java.util.Optional;

import org.apache.catalina.connector.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Pizza.Zaucy.Beans.menu;
import com.Pizza.Zaucy.Repositories.MenuRepo;
import com.Pizza.Zaucy.Services.menuservices;

@RestController
@RequestMapping("/api/menu")
public class Menucontroller {

    @Autowired
    private menuservices menuservices;

    @Autowired
    private MenuRepo menuRepo;

    Menucontroller(menuservices menuservices) {
        this.menuservices = menuservices;
    }

    @GetMapping
    @CrossOrigin(origins = "*")
    public ResponseEntity<List<menu>> getAllmenu() {
        List<menu> menuitems = menuservices.getallmenuitems();
        return ResponseEntity.ok(menuitems);
    }

    @GetMapping("/vegpizza")
    @CrossOrigin(origins = "*")
    public ResponseEntity<List<menu>> getVegpizza() {
        List<menu> vegpizza = menuRepo.findByIsvegTrue();
        return ResponseEntity.ok(vegpizza);
    }

    @GetMapping("/nonvegpizza")
    @CrossOrigin(origins = "*")
    public ResponseEntity<List<menu>> getNonVegpizza() {
        List<menu> nonvegpizza = menuRepo.findByIsvegFalse();
        return ResponseEntity.ok(nonvegpizza);
    }

    @GetMapping("/{id}")
    @CrossOrigin(origins = "*")
    public ResponseEntity<menu> getmenubyid(@PathVariable String id) {
        Optional<menu> menuitem = menuservices.getmenuitembyid(id);
        if (menuitem != null) {
            return new ResponseEntity<>(menuitem.get(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping
    @CrossOrigin(origins = "*")
    public ResponseEntity<menu> addmenuitem(@RequestBody menu menu) {
        menu newmenuitem = menuservices.additemmenu(menu);
        return new ResponseEntity<>(newmenuitem, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    @CrossOrigin(origins = "*")
    public ResponseEntity<menu> updatemenuitem(@PathVariable String id, @RequestBody menu menu) {
        menu updatedmenu = menuservices.updateitemmenu(id, menu);
        if (updatedmenu != null) {
            return new ResponseEntity<>(updatedmenu, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    @CrossOrigin(origins = "*")
    public void deletedmanuitem(@PathVariable String id) {
        menuservices.removeitemmenu(id);
    }

}
