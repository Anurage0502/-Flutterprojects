// package com.Pizza.Zaucy.controllers;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.http.HttpStatus;
// import org.springframework.http.ResponseEntity;
// import org.springframework.web.bind.annotation.*;

// import com.Pizza.Zaucy.Beans.User;
// import com.Pizza.Zaucy.Services.UserService;
// import com.Pizza.Zaucy.Utility.JwtUtil;
// import com.Pizza.Zaucy.Utility.PasswordUtil;

// @RestController
// @RequestMapping("/auth")
// public class Logincontroller {

// @Autowired
// private UserService userService;

// @Autowired
// private PasswordUtil hashPasswordUtil;

// @Autowired
// private JwtUtil jwtUtil;

// // Login endpoint
// @PostMapping("/login")
// public ResponseEntity<String> login(@RequestBody User user) {
// // Fetch user from the database
// User existingUser = userService.findByUsername(user.getUsername());

// if (existingUser == null) {
// return new ResponseEntity<>("Invalid username", HttpStatus.BAD_REQUEST);
// }

// // Verify the password
// if (hashPasswordUtil.matches(user.getPassword(),
// existingUser.getPassword())) {
// return new ResponseEntity<>("Invalid password", HttpStatus.BAD_REQUEST);
// }

// // Generate JWT token
// String token = jwtUtil.generateToken(existingUser.getUsername());

// return ResponseEntity.ok("Bearer " + token);
// }
// }
