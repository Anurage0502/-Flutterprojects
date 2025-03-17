package com.Pizza.Zaucy.controllers;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Locale.Category;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.Pizza.Zaucy.Beans.Coupon;
import com.Pizza.Zaucy.Beans.Coupon.CouponStatus;
import com.Pizza.Zaucy.Repositories.CouponRepository;
import com.Pizza.Zaucy.Services.CouponService;

@RestController
@RequestMapping("/api/coupons")
public class CouponController {

    @Autowired
    private CouponService couponService;

    @Autowired
    private CouponRepository couponRepository;

    @PostMapping
    public Coupon createCoupon(@RequestBody Coupon coupon) {
        return couponService.saveCoupon(coupon);
    }

    @GetMapping("/code")
    public Coupon getcouponbycode(
            @RequestParam String code) {
        return couponService.getCouponByCode(code).get();
    }

    @GetMapping("/AllCoupons")
    public List<Coupon> getallCoupons() {
        return couponRepository.findAll();
    }

    @GetMapping("/ActiveCoupons")
    public List<Coupon> getAllActiveCoupons() {
        return couponService.getActiveCoupons();
    }

    @GetMapping("/ActiveValidateCoupons")
    public List<Coupon> getAllActiveValidateCoupons() {
        return couponService.getActiveValidCoupons();
    }

    @GetMapping("/ActiveValidateCategoryCoupons")
    public List<Coupon> getAllActiveValidateCategoryCoupons(
            @RequestParam com.Pizza.Zaucy.Beans.Coupon.Category category) {
        return couponService.getActiveValidCategoryCoupons(category);
    }

    @GetMapping("/ActiveValidateCategoryMinimumValueCoupons")
    public List<Coupon> getallCouponswithlessminimumValue(
            @RequestParam com.Pizza.Zaucy.Beans.Coupon.Category category, @RequestParam BigDecimal TotalValue) {
        return couponService.getActiveValidCategoryMinimumValue(category, TotalValue);
    }

    @PutMapping("/Discard/{id}")
    public void discardCoupon(@PathVariable Long id, @RequestHeader Map<String, String> headers) {
        headers.forEach((key, value) -> System.out.println("Header: " + key + " Value: " + value));
        couponService.discardCoupon(id);
    }

    @PutMapping("/Deactive/{id}")
    public void DeactiveCoupon(@PathVariable long id, @RequestHeader Map<String, String> headers) {
        headers.forEach((key, value) -> System.out.println("Header: " + key + " Value: " + value));
        couponService.deactivateCoupon(null);
    }

    @PutMapping("/updateusage/{id}")
    public void reducecount(@PathVariable long id, @RequestHeader Map<String, String> headers) {
        couponRepository.findById(id).ifPresent(coupon -> {
            coupon.setUsageCount(coupon.getUsageCount() - 1);
            couponRepository.save(coupon);
        });
    }
}
