package com.codingdojo.events.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

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
import com.codingdojo.events.models.UserEvent;
import com.codingdojo.events.services.ApiService;
import com.codingdojo.events.validator.UserValidator;

@Controller
public class Users {
	
	private ApiService as;
	private UserValidator uv;
	private String[] states; 
	
	public Users(ApiService as,
			UserValidator uv) {
		this.as = as;
		this.uv = uv;
		this.states = new String[] {"AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","GU","HI","IA","ID", "IL","IN","KS","KY","LA","MA","MD","ME","MH","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY", "OH","OK","OR","PA","PR","PW","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"};
	}

	@RequestMapping("/")
	public String index(@Valid @ModelAttribute("user") User user,
			@RequestParam(value="error", required=false) String error,
			@RequestParam(value="logout", required=false) String logout,
			Model model) {
        if(error != null) {
            model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
        }
        if(logout != null) {
            model.addAttribute("logoutMessage", "Logout Successful!");
        }
        model.addAttribute("states", states);
		return "index.jsp";
	}
	
	@PostMapping("/register")
	public String createUser(@Valid @ModelAttribute("user") User user,
			BindingResult result,
			Model model,
			HttpSession sesh) {
		uv.validate(user, result);
		if (result.hasErrors()) {
			model.addAttribute("states", states);
			return "index.jsp";
		}
		as.saveWithUserRole(user);
		return "redirect:/";
	}
	
}
