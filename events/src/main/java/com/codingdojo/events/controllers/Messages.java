package com.codingdojo.events.controllers;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.events.models.Event;
import com.codingdojo.events.models.Message;
import com.codingdojo.events.models.User;
import com.codingdojo.events.services.ApiService;

@Controller
public class Messages {

	@Autowired
	ApiService as;

	@PostMapping("/messages/create")
	public String createMessage(@Valid @ModelAttribute("message") Message message,
			BindingResult result,
			Principal principal,
			@RequestParam("eventId") Long id,
			Model model) {
		User user = as.findByUsername(principal.getName());
		Event event = as.findEventById(id);
		if (result.hasErrors()) {
			model.addAttribute("user", user);
			model.addAttribute("event", event);
			return "showEvent.jsp";
		}
		message.setAuthor(user);
		message.setEvent(event);
		as.saveMessage(message);
		return "redirect:/events/show/" + event.getId();
	}
}
