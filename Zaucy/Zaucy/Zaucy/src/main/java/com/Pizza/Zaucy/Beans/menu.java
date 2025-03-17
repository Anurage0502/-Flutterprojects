package com.Pizza.Zaucy.Beans;

import java.math.BigDecimal;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "menu")
public class menu {
    @Id
    private String id;

    private String name;
    private BigDecimal price;
    private String description;
    private String size;
    private String image_url;
    private boolean isveg;
}
