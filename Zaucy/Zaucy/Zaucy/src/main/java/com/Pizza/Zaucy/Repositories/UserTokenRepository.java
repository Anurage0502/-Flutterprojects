package com.Pizza.Zaucy.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.Pizza.Zaucy.Beans.UserToken;

import java.util.Optional;

@Repository
public interface UserTokenRepository extends JpaRepository<UserToken, Long> {
    // Find a token by user ID
    Optional<UserToken> findByUser_UserId(Long userId);

    // Optionally, find by token itself (for validation)
    Optional<UserToken> findByJwtToken(String jwtToken);

    @Query("SELECT ut.user.id FROM UserToken ut WHERE ut.jwtToken = :jwtToken")
    Integer findUserIdByJwtToken(@Param("jwtToken") String jwtToken);
}
