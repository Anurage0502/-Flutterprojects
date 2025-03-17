package com.Pizza.Zaucy.Beans;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "coupons")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Coupon {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String code; // Unique coupon code

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DiscountType discountType; // PERCENTAGE or FLAT

    @Column(nullable = false)
    private BigDecimal discountValue; // Discount amount or percentage

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Category category; // VEG, NON_VEG, ALL

    @Column(nullable = false)
    private LocalDateTime expiryDate; // Expiry date

    @Column(nullable = false)
    private Integer usageCount; // How many times it can be used

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CouponStatus status; // ACTIVE, INACTIVE, DISCARDED

    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();
    @Column(nullable = true)
    private BigDecimal minimumOrderValue; // Minimum order value to use the coupon (nullable)

    @Column(nullable = true)
    private Boolean isFirstTimeUserOnly;

    public enum DiscountType {
        PERCENTAGE, FLAT
    }

    public enum Category {
        VEG, NON_VEG, ALL
    }

    public enum CouponStatus {
        ACTIVE, INACTIVE, DISCARDED
    }
}
