package com.example.demo.controller.filter;

import org.springframework.core.annotation.Order;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

//@Order规定多个Filter的执行顺序,按照从小到大执行()中的值
@Order(1)
//@WebFilter过滤对应的请求路径
@WebFilter(urlPatterns = {"/ent/*", "/sup/*", "/admin/*", "/exp/*"},filterName = "loginFilter")
public class LoginFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		String uri = req.getRequestURI();
		if(uri.contains("login") || uri.contains("logout") || uri.contains("regist") || uri.contains("checkuser") || uri.contains("regform")) {
			chain.doFilter(request, response);
		}else {
			if(uri.contains("/ent/")) {
				Object obj = req.getSession().getAttribute("currEnt");
				if(obj == null) {
					HttpServletResponse resp = (HttpServletResponse) response;
					System.out.println("未登录拦截111");
					resp.sendRedirect("/ssm/ent/login");
				}else {
					chain.doFilter(request, response);
				}
			}else if(uri.contains("/sup/")) {
				Object obj = req.getSession().getAttribute("currSup");
				if(obj == null) {
					HttpServletResponse resp = (HttpServletResponse) response;
					System.out.println("未登录拦截--供应商登录");
					resp.sendRedirect("/ssm/sup/login");
				}else {
					chain.doFilter(request, response);
				}
			}else if(uri.contains("/exp/")) {
				Object obj = req.getSession().getAttribute("currExp");
				if(obj == null) {
					HttpServletResponse resp = (HttpServletResponse) response;
					System.out.println("未登录拦截--专家登录");
					resp.sendRedirect("/ssm/exp/login");
				}else {
					chain.doFilter(request, response);
				}
			}else {
				Object obj = req.getSession().getAttribute("currAdmin");
				if(obj == null) {
					HttpServletResponse resp = (HttpServletResponse) response;
					System.out.println("未登录拦截--管理员登录");
					resp.sendRedirect("/ssm/admin/login");
				}else {
					chain.doFilter(request, response);
				}
			}
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}

	@Override
	public void destroy() {
		
	}
}
