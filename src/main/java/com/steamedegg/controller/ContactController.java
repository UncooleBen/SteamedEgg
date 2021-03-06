package com.steamedegg.controller;

import com.steamedegg.databaseservice.AppDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author Juntao Peng
 */
@Controller
public class ContactController {

    AppDao appDao;

    @Autowired
    public ContactController(AppDao appDao) {
        this.appDao = appDao;
    }

    @RequestMapping(value = "/contact", method = RequestMethod.GET)
    public ModelAndView service() {
        ModelAndView mv = new ModelAndView("contact");
        return mv;
    }
}
