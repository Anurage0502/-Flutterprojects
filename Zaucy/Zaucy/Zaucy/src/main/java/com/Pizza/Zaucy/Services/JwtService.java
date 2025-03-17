package com.Pizza.Zaucy.Services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Pizza.Zaucy.Beans.User;
import com.Pizza.Zaucy.Beans.UserToken;
import com.Pizza.Zaucy.Repositories.UserRepository;
import com.Pizza.Zaucy.Repositories.UserTokenRepository;
import com.Pizza.Zaucy.Utility.JwtUtil;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class JwtService {

    @Autowired
    private UserTokenRepository userTokenRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtUtil jwtUtil;

    // Generate JWT for a user
    public String generateJwtToken(User user) {
        // Generate JWT token using JwtUtil (you'll need to implement this utility)
        String jwtToken = jwtUtil.generateToken(user.getUsername());

        // Store the JWT in the user_tokens table
        UserToken userToken = new UserToken();
        userToken.setUser(user);
        userToken.setJwtToken(jwtToken);
        userToken.setExpiresAt(LocalDateTime.now().plusDays(7)); // Set token expiry time

        userTokenRepository.save(userToken);

        return jwtToken;
    }

    // Retrieve JWT token from user_tokens table
    public Optional<UserToken> getJwtToken(Long userId) {
        return userTokenRepository.findByUser_UserId(userId);
    }

    public Optional<User> getUserFromToken(String jwtToken) {
        Integer userId = userTokenRepository.findUserIdByJwtToken(jwtToken);
        if (userId == null) {
            return Optional.empty(); // Token not found or invalid
        }
        return userRepository.findById(userId); // Fetch user by ID
    }
}
