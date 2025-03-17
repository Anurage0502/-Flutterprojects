package com.Pizza.Zaucy.Beans;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "vegtop")
@Getter
@Setter
@NoArgsConstructor
public class VegTop {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Boolean crispCapsicum;
    private Boolean freshTomato;
    private Boolean paneer;
    private Boolean redPaneer;
    private Boolean jalpeno;
    private Boolean blackOlive;
    private Boolean grilledMushrooms;
    private Boolean onion;
}