package ge.mimino.travel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author ucha
 */
@Controller
@RequestMapping
public class WebController {

    @RequestMapping("/users")
    public String users() {
        return "users";
    }

    @RequestMapping("/requests")
    public String home() {
        return "requests";
    }

    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping("/contacts")
    public String contacts() {
        return "contacts";
    }

    @RequestMapping("/")
    public String defaultFnc() {
        return "";
    }

}
