package com.Pizza.Zaucy.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.Pizza.Zaucy.Services.JwtService;
import com.Pizza.Zaucy.Utility.JwtUtil;

@RestController
@RequestMapping("/auth")
public class tokenController {

    @Autowired
    private JwtUtil jwtUtil;
    @Autowired
    private JwtService userTokenService;

    // Token validation endpoint
    @GetMapping("/validate-token")
    public ResponseEntity<Boolean> validateToken(@RequestHeader("Authorization") String token,
            @RequestParam String username) {
        // Extract the token
        String jwtToken = token.substring(7); // Remove "Bearer " from the token

        if (!jwtUtil.validateToken(jwtToken, username)) {
            return new ResponseEntity<>(false, HttpStatus.UNAUTHORIZED);
        }

        return ResponseEntity.ok(true);
    }

    @GetMapping("/get-user")
    public ResponseEntity<?> getUser(@RequestHeader("Authorization") String token) {
        String jwtToken = token.substring(7); // Remove "Bearer " prefix
        return userTokenService.getUserFromToken(jwtToken)
                .map(user -> ResponseEntity.ok().body(user)) // Returns ResponseEntity<User>
                .orElseGet(() -> ResponseEntity.status(404).body(null)); // Ensure it returns ResponseEntity<User>
    }
}
