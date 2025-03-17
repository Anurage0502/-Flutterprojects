package com.Pizza.Zaucy.Beans;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "nonvegtop")
@Getter
@Setter
@NoArgsConstructor
public class NonVegTop {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Boolean pepperBarbeque;
    private Boolean periPeri;
    private Boolean grilledChicken;
    private Boolean chickenSausage;
    private Boolean chickenTikka;
    private Boolean chickenPepperoni;
    private Boolean chickenKeema;
}
