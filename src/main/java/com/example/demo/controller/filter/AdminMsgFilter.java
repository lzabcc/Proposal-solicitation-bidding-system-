package com.example.demo.controller.filter;

import com.example.demo.dao.mapper.SysMsgMapper;
import com.example.demo.dao.model.SysMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Order(2)
@WebFilter(urlPatterns = {"/admin/*"},filterName = "adminMsgFilter")
public class AdminMsgFilter implements Filter {

	@Autowired
	private SysMsgMapper msgMapper;
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
		SysMsg record = new SysMsg();
		record.setReviever(-1);//接收者-1表示管理员
		record.setIsRead(-1);//未读状态的消息
		List<SysMsg> list = msgMapper.select(record);
		int unActiveEnt = 0, unActiveSup = 0, unCheckTender = 0;
		for (SysMsg msg : list) {
			if("NEW_REGIST_ENT".equals(msg.getMsgType())) {
				unActiveEnt++;
			}else if("NEW_REGIST_SUP".equals(msg.getMsgType())) {
				unActiveSup++;
			}else if("NEW_TENDER".equals(msg.getMsgType())) {
				unCheckTender++;
			}
		}
		session.setAttribute("NEW_REGIST_ENT", unActiveEnt);//待激活的征集人数量
		session.setAttribute("NEW_REGIST_SUP", unActiveSup);
		session.setAttribute("NEW_TENDER", unCheckTender);
		chain.doFilter(request, response);
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
