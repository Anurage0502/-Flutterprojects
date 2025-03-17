package com.Pizza.Zaucy.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Pizza.Zaucy.Beans.menu;

@Repository
public interface MenuRepo extends JpaRepository<menu, String> {

    List<menu> findByIsvegFalse();

    List<menu> findByIsvegTrue();

}
