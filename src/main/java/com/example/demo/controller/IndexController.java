package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 * @author
 */
@Controller
@RequestMapping("/")
public class IndexController {

	/*
	 * @Resource private UserService userService;
	 */

	@RequestMapping("/index")
	public String index(HttpServletRequest req) {
		req.setAttribute("msg", 0);
		System.out.println("进入主页--------->");
		return "login";
	}
	
	@RequestMapping("/index2")
	public String index2() {
		System.out.println("进入主页--------->");
		return "login2";
	}
	
	@RequestMapping("verify")
	public void loginform(HttpSession session, String vercode, PrintWriter pw) {
		if (!(vercode.equalsIgnoreCase(session.getAttribute("code").toString()))) {  //忽略验证码大小写  
			pw.write("-1");
		}else {
			pw.write("0");
		}
	}
}
