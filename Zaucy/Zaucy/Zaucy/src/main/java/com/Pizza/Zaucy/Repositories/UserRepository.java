package com.Pizza.Zaucy.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Pizza.Zaucy.Beans.User;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    // Find user by username
    Optional<User> findByUsername(String username);

    // Find user by email (if you plan to use email for login)
    Optional<User> findByEmail(String email);
}
