package com.Pizza.Zaucy.Services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Pizza.Zaucy.Beans.Otp;
import com.Pizza.Zaucy.Beans.User;
import com.Pizza.Zaucy.Repositories.OtpRepository;
import com.Pizza.Zaucy.Repositories.UserRepository;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;

@Service
public class OtpService {

    @Autowired
    private OtpRepository otpRepository;

    @Autowired
    private UserRepository userRepository;

    // Generate OTP and store it
    public String generateOtp(int userId) {
        // Find user by ID
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // Generate random 6-digit OTP
        String otpCode = String.format("%06d", new Random().nextInt(999999));

        // Store OTP with expiration time (e.g., 5 minutes)
        Otp otp = new Otp();
        otp.setUser(user);
        otp.setOtpCode(otpCode);
        otp.setExpiresAt(LocalDateTime.now().plusMinutes(5));

        otpRepository.save(otp);

        return otpCode;
    }

    // Verify OTP
    public boolean verifyOtp(Long userId, String otpCode) {
        Optional<Otp> otp = otpRepository.findByUser_UserId(userId);

        if (otp.isPresent() && otp.get().getOtpCode().equals(otpCode) &&
                otp.get().getExpiresAt().isAfter(LocalDateTime.now())) {
            return true;
        }
        return false;
    }
}
