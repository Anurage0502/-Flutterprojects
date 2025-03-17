package com.Pizza.Zaucy.controllers;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.Pizza.Zaucy.Beans.User;
import com.Pizza.Zaucy.Beans.*;
import com.Pizza.Zaucy.Services.UserService;
import com.Pizza.Zaucy.Services.OtpService;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserService userService;
    @Autowired
    private OtpService otpservice;

    // Signup endpoint
    @PostMapping("/signup")
    public ResponseEntity<User> signup(@RequestParam String username, @RequestParam String password,
            @RequestParam String email) {
        User response = userService.registerUser(username, password, email);
        String otp = otpservice.generateOtp(response.getUserId());
        System.out.println(otp);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestParam String username,
            @RequestParam String otpCode) {
        String token = userService.loginUser(username, otpCode);

        return ResponseEntity.ok(token);
    }

    @GetMapping("/otp")
    public ResponseEntity<String> getotp(@RequestParam String username) {
        String otp = otpservice.generateOtp(userService.findByUsername(username).getUserId());
        System.out.println(otp);
        return ResponseEntity.ok(otp);
    }
}
