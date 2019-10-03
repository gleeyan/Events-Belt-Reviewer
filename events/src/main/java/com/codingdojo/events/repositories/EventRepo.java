package com.codingdojo.events.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.events.models.Event;

@Repository
public interface EventRepo extends PagingAndSortingRepository<Event, Long>, CrudRepository<Event, Long> {
	
	@Query("SELECT e FROM Event e")
	List<Event> findAll();
	
	@Query("SELECT e FROM Event e WHERE e.state != ?1")
	Page<Event> outOfStateEvents(String state, Pageable pageable);
	
	@Query("SELECT e FROM Event e WHERE e.state = ?1")
	Page<Event> inStateEvents(String state, Pageable pageable);
}
