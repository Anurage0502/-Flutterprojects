package com.Pizza.Zaucy.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Pizza.Zaucy.Beans.Coupon;
import com.Pizza.Zaucy.Beans.Coupon.CouponStatus;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Locale.Category;

@Repository
public interface CouponRepository extends JpaRepository<Coupon, Long> {

    Optional<Coupon> findByCode(String code);

    List<Coupon> findByStatus(CouponStatus status);

    List<Coupon> findByStatusAndExpiryDateAfter(CouponStatus status, LocalDateTime currentTime);

    List<Coupon> findBycategoryAndStatusAndExpiryDateAfter(com.Pizza.Zaucy.Beans.Coupon.Category category,
            CouponStatus status,
            LocalDateTime currentTime);

    List<Coupon> findByCategoryAndStatusAndExpiryDateAfterAndMinimumOrderValueLessThan(
            com.Pizza.Zaucy.Beans.Coupon.Category category,
            CouponStatus status,
            LocalDateTime currentTime,
            BigDecimal minimumOrderValue);
}
