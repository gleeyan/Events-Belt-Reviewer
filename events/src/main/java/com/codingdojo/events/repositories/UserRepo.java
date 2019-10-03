package com.codingdojo.events.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.events.models.User;

@Repository
public interface UserRepo extends CrudRepository<User, Long> {

	@Query("SELECT u FROM User u")
	List<User> findAll();
	
	@Query("SELECT u FROM User u WHERE u.username = ?1")
	User findByUsername(String username);
	
}
