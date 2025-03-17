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

import com.Pizza.Zaucy.Beans.Size;
import com.Pizza.Zaucy.Services.SizeService;

@RestController
@RequestMapping("api/size")
public class SizeController {

    @Autowired
    private SizeService sizeService;

    @GetMapping
    public List<Size> getSize() {
        return sizeService.getallSizes();
    }

    @PutMapping("/{id}")
    public Size Update(@RequestBody Size size, @PathVariable int id, @RequestHeader Map<String, String> headers) {
        headers.forEach((key, value) -> System.out.println("Header: " + key + " Value: " + value));
        return sizeService.UpdateSize(size, id);
    }

}
