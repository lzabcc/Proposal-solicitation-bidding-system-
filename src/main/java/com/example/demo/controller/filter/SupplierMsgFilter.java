package com.example.demo.controller.filter;

import com.example.demo.dao.mapper.SysMsgMapper;
import com.example.demo.dao.model.Supplier;
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

@Order(3)
@WebFilter(urlPatterns = {"/sup/*"},filterName = "supMsgFilter")
public class SupplierMsgFilter implements Filter {

	@Autowired
	private SysMsgMapper msgMapper;
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		String uri = req.getRequestURI();
		if(uri.contains("login") || uri.contains("logout") || uri.contains("regist") || uri.contains("checkuser") || uri.contains("regform")) {
			chain.doFilter(request, response);
		}else {
			HttpSession session = req.getSession();
			Supplier sup = (Supplier) session.getAttribute("currSup");
			SysMsg record = new SysMsg();
			record.setReviever(sup.getSupplierId());//接收者
			record.setIsRead(-1);//未读状态的消息
			List<SysMsg> list = msgMapper.select(record);
			int newinvite = 0, faild = 0, success = 0;
			for (SysMsg msg : list) {
				if("TENDER_INVITE".equals(msg.getMsgType())) {
					newinvite++;
				}else if("TENDER_FAILD".equals(msg.getMsgType())) {
					faild++;
				}else if("TENDER_SUCCESS".equals(msg.getMsgType())) {
					success++;
				}
			}
			int result = faild+success;
			session.setAttribute("TENDER_INVITE", newinvite);//征集邀请
			session.setAttribute("TENDER_RESULT", result);//征集结果
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
