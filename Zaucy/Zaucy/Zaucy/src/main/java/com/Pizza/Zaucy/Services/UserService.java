package com.Pizza.Zaucy.Services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.Pizza.Zaucy.Beans.Otp;
import com.Pizza.Zaucy.Beans.User;
import com.Pizza.Zaucy.Repositories.OtpRepository;
import com.Pizza.Zaucy.Repositories.UserRepository;
import com.Pizza.Zaucy.Utility.PasswordUtil;

import lombok.RequiredArgsConstructor;

import com.Pizza.Zaucy.Utility.JwtUtil;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private OtpRepository otpRepository;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private JwtService jwtService;

    // Register user by hashing password
    public User registerUser(String username, String password, String email) {
        // Check if username already exists
        Optional<User> existingUser = userRepository.findByUsername(username);
        if (existingUser.isPresent()) {
            throw new RuntimeException("Username already exists");
        }

        // Hash password before storing
        String hashedPassword = PasswordUtil.hashPassword(password);

        User user = new User();
        user.setUsername(username);
        user.setPassword(hashedPassword);
        user.setEmail(email);
        // Set the user as not verified yet
        user.setVerified(false);

        return userRepository.save(user);
    }

    // Find user by username
    public User findByUsername(String username) {
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }

    // Verify user after OTP validation
    public void verifyUser(int userId) {
        Optional<User> user = userRepository.findById(userId);
        if (user.isPresent()) {
            user.get().setVerified(true);
            userRepository.save(user.get());
        } else {
            throw new UsernameNotFoundException("User not found");
        }
    }

    public String loginUser(String username, String otpCode) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        Optional<Otp> otp = otpRepository.findByotpCode(otpCode);

        if (otp.isPresent() && userOpt.isPresent()) {
            User user = userOpt.get();
            return jwtService.generateJwtToken(user);
        }
        return "Invalid username or password";
    }
}
