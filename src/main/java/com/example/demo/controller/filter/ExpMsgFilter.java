package com.example.demo.controller.filter;

import com.example.demo.dao.mapper.SysMsgMapper;
import com.example.demo.dao.model.Expert;
import com.example.demo.dao.model.SysMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Order(4)
@WebFilter(urlPatterns = {"/exp/*"},filterName = "expMsgFilter")
public class ExpMsgFilter implements Filter {

	@Autowired
	private SysMsgMapper msgMapper;
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		String uri = req.getRequestURI();
		if(uri.contains("login") || uri.contains("logout")) {
			chain.doFilter(request, response);
		}else {
			HttpSession session = req.getSession();
			if(session.getAttribute("currExp") == null) {
				HttpServletResponse resp = (HttpServletResponse) response;
				System.out.println("未登录拦截--专家登录");
				resp.sendRedirect("/ssm/exp/login");
				return;
			}
			Expert exp = (Expert) session.getAttribute("currExp");
			SysMsg record = new SysMsg();
			record.setReviever(exp.getExpertId());//接收者
//			record.setMsgType("ASSESS_INVITE");
			record.setIsRead(-1);//未读状态的消息
			List<SysMsg> list = msgMapper.select(record);
			int newinvite = 0; //unActiveSup = 0, unCheckTender = 0;
			for (SysMsg msg : list) {
				if("ASSESS_INVITE".equals(msg.getMsgType())) {
					newinvite++;
				}
			}
			session.setAttribute("ASSESS_INVITE", newinvite);//征集邀请
			chain.doFilter(request, response);
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		ServletContext sc = filterConfig.getServletContext();
		WebApplicationContext cxt = WebApplicationContextUtils.getWebApplicationContext(sc);
		if(cxt != null && cxt.getBean(SysMsgMapper.class) != null && msgMapper == null){
			msgMapper = (SysMsgMapper) cxt.getBean(SysMsgMapper.class);
		}
	}
	
	@Override
	public void destroy() {
		
	}

}
