package com.steamedegg.controller;

import com.steamedegg.databaseservice.AppDao;
import com.steamedegg.model.App;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Juntao Peng
 */
@Controller
public class AppController {

    AppDao appDao;

    @Autowired
    public AppController(AppDao appDao) {
        this.appDao = appDao;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView service(@RequestParam("page") int page) {
        ModelAndView mv = new ModelAndView("list");
        List<App> appList = this.appDao.queryAllApp((page - 1) * 20, 20);
        int totalDocumentNumber = this.appDao.queryDocumentNumber();
        int pageNumber = totalDocumentNumber / 20 + 1;
        mv.addObject("searchResult", "游戏列表");
        mv.addObject("appList", appList);
        mv.addObject("totalPage", pageNumber);
        mv.addObject("totalDocument", totalDocumentNumber);
        mv.addObject("currentPage", page);
        return mv;
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public ModelAndView search(@RequestParam("field") String field, @RequestParam("value") String value,
                               @RequestParam("page") int page) {
        ModelAndView mv = new ModelAndView("list");
        List<App> appList;
        switch (field) {
            case "category":
                List<String> categories = new ArrayList<>();
                categories.add(value);
                appList = this.appDao.queryAppByCategory(categories, 0, 20);
                break;
            case "name":
                appList = this.appDao.queryAppByName(value, 0, 20);
                break;
            case "appid":
                int appid = Integer.parseInt(value);
                appList = new ArrayList<>();
                appList.add(this.appDao.queryAppByAppId(appid));
                break;
            default:
                appList = this.appDao.queryAllApp(0, 20);
        }
        int totalDocumentNumber = appList.size();
        int pageNumber = totalDocumentNumber / 20 + 1;
        mv.addObject("searchResult", "搜索结果");
        mv.addObject("appList", appList);
        mv.addObject("totalPage", pageNumber);
        mv.addObject("totalDocument", totalDocumentNumber);
        mv.addObject("currentPage", page);
        return mv;
    }

    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public ModelAndView detail(@RequestParam("appid") int appid) {
        ModelAndView mv = new ModelAndView("detail");
        App app = this.appDao.queryAppByAppId(appid);
        mv.addObject("app", app);
        return mv;
    }

    @RequestMapping(value = "/chart", method = RequestMethod.GET)
    @ResponseBody
    public String getChartJSON(int appId) {
        App app = this.appDao.queryAppByAppId(appId);
        String json = app.getPricesJSON();
        return json;
    }
}
