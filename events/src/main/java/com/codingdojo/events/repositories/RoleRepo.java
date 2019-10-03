package com.codingdojo.events.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.events.models.Role;

@Repository
public interface RoleRepo extends CrudRepository<Role, Long> {

	@Query("SELECT r from Role r")
	List<Role> findAll();
	
	@Query("SELECT r from Role r WHERE r.name = ?1")
	List<Role> findByName(String name);
}
