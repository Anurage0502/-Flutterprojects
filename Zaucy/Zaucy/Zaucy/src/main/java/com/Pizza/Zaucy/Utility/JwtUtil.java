package com.Pizza.Zaucy.Utility;

import java.time.LocalDateTime;
import java.util.Base64;
import java.util.Date;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.Pizza.Zaucy.Repositories.UserRepository;
import com.Pizza.Zaucy.Repositories.UserTokenRepository;
import com.Pizza.Zaucy.Beans.UserToken;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.Claims;

@Component
public class JwtUtil {

    @Autowired
    UserTokenRepository userTokenRepository;

    public static String generateSecretKey() {
        try {
            // Use the AES algorithm to generate a key
            KeyGenerator keyGenerator = KeyGenerator.getInstance("HmacSHA256");
            keyGenerator.init(256); // Use a 256-bit key
            SecretKey secretKey = keyGenerator.generateKey();

            // Convert the secret key to a Base64 string to use in the JWT signing
            return Base64.getEncoder().encodeToString(secretKey.getEncoded());
        } catch (Exception e) {
            throw new RuntimeException("Error generating secret key", e);
        }
    }

    private SecretKey secretkey = Keys.hmacShaKeyFor(Base64.getDecoder().decode(generateSecretKey()));

    public String generateToken(String username) {
        String encodedKey = Base64.getEncoder().encodeToString(secretkey.getEncoded());
        System.out.println("Generated Key (Base64): " + encodedKey);
        String Generatedtoken = Jwts.builder().claim("username", username).claim("issuedAt", new Date())
                .claim("expiration", new Date(System.currentTimeMillis() + 1000L * 60 * 60 * 24 * 7))
                .signWith(secretkey).compact();
        return Generatedtoken;

    }

    public String extractUsername(String token) {
        Claims claims = getClaims(token);
        return claims.get("username", String.class);
    }

    public Date extractExpiration(String token) {
        Claims claims = getClaims(token);
        return claims.get("expiration", Date.class);
    }

    // Validate the token (checks if the username matches and if the token is not
    // expired)
    public boolean validateToken(String token, String username) {
        return (extractUsername(token).equals(username) && !isTokenExpired(token));
    }

    private boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    public Claims getClaims(String token) {
        String retrievedKey = Base64.getEncoder().encodeToString(secretkey.getEncoded()); // Or however you retrieve it
        System.out.println("Retrieved Key (Base64): " + retrievedKey);

        // Parse the token using the secret key
        return Jwts.parser()
                .verifyWith(secretkey) // Set the secret key for validation
                .build()
                .parseSignedClaims(token)
                .getPayload(); // Extract claims
    }
}
