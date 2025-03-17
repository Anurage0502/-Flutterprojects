package com.Pizza.Zaucy.Services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Pizza.Zaucy.Beans.Coupon;
import com.Pizza.Zaucy.Beans.Coupon.CouponStatus;
import com.Pizza.Zaucy.Repositories.CouponRepository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Locale.Category;

@Service
public class CouponService {

    private final CouponRepository couponRepository;

    @Autowired
    public CouponService(CouponRepository couponRepository) {
        this.couponRepository = couponRepository;
    }

    // Create or Update a coupon
    public Coupon saveCoupon(Coupon coupon) {
        return couponRepository.save(coupon);
    }

    public Optional<Coupon> getCouponByCode(String code) {
        return couponRepository.findByCode(code);
    }

    public List<Coupon> getActiveCoupons() {
        return couponRepository.findByStatus(CouponStatus.ACTIVE);
    }

    public List<Coupon> getActiveValidCoupons() {
        return couponRepository.findByStatusAndExpiryDateAfter(CouponStatus.ACTIVE, LocalDateTime.now());
    }

    public List<Coupon> getActiveValidCategoryCoupons(com.Pizza.Zaucy.Beans.Coupon.Category category) {
        return couponRepository.findBycategoryAndStatusAndExpiryDateAfter(category, CouponStatus.ACTIVE,
                LocalDateTime.now());
    }

    public List<Coupon> getActiveValidCategoryMinimumValue(com.Pizza.Zaucy.Beans.Coupon.Category category,
            BigDecimal TotalValue) {
        List<Coupon> forall = couponRepository.findByCategoryAndStatusAndExpiryDateAfterAndMinimumOrderValueLessThan(
                com.Pizza.Zaucy.Beans.Coupon.Category.ALL,
                CouponStatus.ACTIVE, LocalDateTime.now(), TotalValue);
        forall.addAll(couponRepository.findByCategoryAndStatusAndExpiryDateAfterAndMinimumOrderValueLessThan(category,
                CouponStatus.ACTIVE, LocalDateTime.now(), TotalValue));
        return forall;
    }

    public void discardCoupon(Long couponId) {
        couponRepository.findById(couponId).ifPresent(coupon -> {
            coupon.setStatus(CouponStatus.DISCARDED);
            couponRepository.save(coupon);
        });
    }

    public void deactivateCoupon(Long couponId) {
        couponRepository.findById(couponId).ifPresent(coupon -> {
            coupon.setStatus(CouponStatus.INACTIVE);
            couponRepository.save(coupon);
        });
    }
}
