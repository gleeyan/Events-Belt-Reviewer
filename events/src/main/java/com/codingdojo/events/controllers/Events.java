package com.codingdojo.events.controllers;

import java.security.Principal;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.events.models.Event;
import com.codingdojo.events.models.Message;
import com.codingdojo.events.models.User;
import com.codingdojo.events.services.ApiService;

@Controller
public class Events {

	private ApiService as;
	private String[] states;
	
	public Events(ApiService as) {
		this.as = as;
		this.states = new String[] {"AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","GU","HI","IA","ID", "IL","IN","KS","KY","LA","MA","MD","ME","MH","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY", "OH","OK","OR","PA","PR","PW","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"};
	}
	
	public Model addModels(Principal principal,
			HttpSession session,
			Model model) {
		User user = as.findByUsername(principal.getName());
		Page<Event> inStateEvents = as.inStateEventsPerPage(user.getState(), (Integer) session.getAttribute("inStatePage") - 1);
		Page<Event> outOfStateEvents = as.outOfStateEventsPerPage(user.getState(), (Integer) session.getAttribute("outOfStatePage") - 1);
		model.addAttribute("user", user);
		model.addAttribute("inStateEvents", inStateEvents);
		model.addAttribute("inStatePages", inStateEvents.getTotalPages());
		model.addAttribute("outOfStateEvents", outOfStateEvents);
		model.addAttribute("outOfStatePages", outOfStateEvents.getTotalPages());
		model.addAttribute("usersEvents", as.findAllUsersEvents());
		model.addAttribute("states", states);
		return model;
	}
	
	@RequestMapping("/events")
	public String showEvents(@Valid @ModelAttribute("event") Event event,
			Principal principal,
			Model model,
			HttpSession session) {
		if (session.getAttribute("inStatePage") == null) {
			session.setAttribute("inStatePage", 1);
			session.setAttribute("outOfStatePage", 1);
		}
		model = addModels(principal, session, model);
		return "showEvents.jsp";
	}
	
	@PostMapping("/events")
	public String showEventPages(@Valid @ModelAttribute("event") Event event,
			@RequestParam(value = "inStateIndex", required = false) Integer inStateIndex,
			@RequestParam(value = "outOfStateIndex", required = false) Integer outOfStateIndex,
			Principal principal,
			HttpSession session,
			Model model) {
		
		if (inStateIndex != (Integer) session.getAttribute("inStatePage") && inStateIndex != null) {
			System.out.println("hello");
			session.setAttribute("inStatePage", inStateIndex);
		}
		if (outOfStateIndex != (Integer) session.getAttribute("outOfStatePage") && outOfStateIndex != null) {
			session.setAttribute("outOfStatePage", outOfStateIndex);
		}
		model = addModels(principal, session, model);
		return "showEvents.jsp";
	}
	
	@PostMapping("/events/create")
	public String createEvent(@Valid @ModelAttribute("event") Event event,
			BindingResult result,
			Principal principal,
			Model model) {
		User user = as.findByUsername(principal.getName());
		if (result.hasErrors()) {
			model.addAttribute("states", states);
			return "showEvents.jsp";
		}
		event.setCreatedBy(user);
		Event e = as.saveEvent(event);
		return "redirect:/events/show/" + e.getId();
	}
	
	@RequestMapping("/events/show/{id}")
	public String showEvent(@PathVariable("id") Long id,
			@Valid @ModelAttribute("message") Message message,
			Principal principal,
			Model model) {
		model.addAttribute("user", as.findByUsername(principal.getName()));
		model.addAttribute("event", as.findEventById(id));
		return "showEvent.jsp";
	}
	
	@RequestMapping("/events/update/{id}")
	public String editEvent(@PathVariable("id") Long id,
			Principal principal,
			Model model) {
		model.addAttribute("states", states);
		model.addAttribute("user", as.findByUsername(principal.getName()));
		model.addAttribute("event", as.findEventById(id));
		return "editEvent.jsp";
	}
	
	@PostMapping("/events/update/{id}")
	public String updateEvent(@Valid @ModelAttribute("event") Event event,
			BindingResult result,
			Principal principal,
			Model model) {
		if (result.hasErrors()) {
			model.addAttribute("user", as.findByUsername(principal.getName()));
			model.addAttribute("states", states);
			return "editEvent.jsp";
		}
		as.saveEvent(event);
		return "redirect:/events/show/" + event.getId();
	}
	
	@RequestMapping("/events/delete/{id}")
	public String destroyEvent(@PathVariable("id") Long id) {
		as.destroyEvent(as.findEventById(id));
		return "redirect:/events";
	}
	
}
