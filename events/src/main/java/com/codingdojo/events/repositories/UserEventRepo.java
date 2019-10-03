package com.codingdojo.events.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.codingdojo.events.models.Event;
import com.codingdojo.events.models.User;
import com.codingdojo.events.models.UserEvent;

@Transactional
@Repository
public interface UserEventRepo extends PagingAndSortingRepository<UserEvent, Long>, CrudRepository<UserEvent, Long> {

	@Query("SELECT ue from UserEvent ue")
	List<UserEvent> findAll();
	
	@Modifying
	@Query("DELETE from UserEvent ue WHERE user = ?1 AND event = ?2")
	void deleteUserEventByUserAndEvent(User user, Event event);
}
