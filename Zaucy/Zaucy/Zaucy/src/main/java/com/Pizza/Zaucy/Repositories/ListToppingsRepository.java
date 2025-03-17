package com.Pizza.Zaucy.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Pizza.Zaucy.Beans.ListToppings;

import java.util.List;

@Repository
public interface ListToppingsRepository extends JpaRepository<ListToppings, Integer> {

    List<ListToppings> findByOrderItem_ItemId(int orderItemId);

    ListToppings findByOrderItem_ItemIdAndTopping_id(int orderItemId, int toppingid);

}
