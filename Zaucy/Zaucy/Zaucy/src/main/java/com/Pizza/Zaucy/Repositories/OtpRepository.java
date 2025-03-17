package com.Pizza.Zaucy.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Pizza.Zaucy.Beans.Otp;
import com.Pizza.Zaucy.Beans.User;

import java.util.Optional;

@Repository
public interface OtpRepository extends JpaRepository<Otp, Long> {
    // Find OTP by user (you can add more queries if needed)
    Optional<Otp> findByUser_UserId(Long userId);

    Optional<Otp> findByotpCode(String otpCode);
}
