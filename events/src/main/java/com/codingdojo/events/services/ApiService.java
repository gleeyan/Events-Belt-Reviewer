package com.codingdojo.events.services;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.codingdojo.events.models.Event;
import com.codingdojo.events.models.Message;
import com.codingdojo.events.models.User;
import com.codingdojo.events.models.UserEvent;
import com.codingdojo.events.repositories.EventRepo;
import com.codingdojo.events.repositories.MessageRepo;
import com.codingdojo.events.repositories.RoleRepo;
import com.codingdojo.events.repositories.UserEventRepo;
import com.codingdojo.events.repositories.UserRepo;

@Service
@Transactional
public class ApiService {

	private UserRepo ur;
	private EventRepo er;
	private RoleRepo rr;
	private MessageRepo mr;
	private UserEventRepo uer;
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	private static final int PAGE_SIZE = 5;
	
    public Page<Event> inStateEventsPerPage(String state, int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber, PAGE_SIZE, Sort.Direction.ASC, "eventDate");
        return er.inStateEvents(state, pageRequest);
    }
    
    public Page<Event> outOfStateEventsPerPage(String state, int pageNumber) {
        PageRequest pageRequest = new PageRequest(pageNumber, PAGE_SIZE, Sort.Direction.ASC, "eventDate");
        return er.outOfStateEvents(state, pageRequest);
    }
	
	public ApiService(UserRepo ur,
			EventRepo er,
			RoleRepo rr,
			MessageRepo mr,
			UserEventRepo uer,
			BCryptPasswordEncoder bCryptPasswordEncoder) {
		this.ur = ur;
		this.er = er;
		this.rr = rr;
		this.mr = mr;
		this.uer = uer;
		this.bCryptPasswordEncoder = bCryptPasswordEncoder;
	}
	
	public void saveWithUserRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(rr.findByName("ROLE_USER"));
		ur.save(user);
	}
	
	public void saveUserWithAdminRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(rr.findByName("ROLE_ADMIN"));
		ur.save(user);
	}
	
	public User findByUsername(String username) {
		return ur.findByUsername(username);
	}
	
	public List<Event> findAllEvents() {
		return er.findAll();
	}
	
	public Event findEventById(Long id) {
		Optional<Event> event = er.findById(id);
		if (event != null) {
			return event.get();
		}
		return null;
	}
	
	public Event saveEvent(Event event) {
		return er.save(event);
	}
	
	public void destroyEvent(Event event) {
		er.delete(event);
	}
	
	public void createUserEvent(User user, Event event) {
		UserEvent userEvent = new UserEvent(user, event);
		uer.save(userEvent);
	}
	
	public void deleteUserEvent(User user, Event event) {
		uer.deleteUserEventByUserAndEvent(user, event);
	}
	
	public List<UserEvent> findAllUsersEvents() {
		return uer.findAll();
	}
	
	public void saveMessage(Message message) {
		mr.save(message);
	}
	
}
