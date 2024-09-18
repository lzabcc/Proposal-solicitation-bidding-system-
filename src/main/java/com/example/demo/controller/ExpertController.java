package com.example.demo.controller;

import com.example.demo.controller.vo.InviteVo;
import com.example.demo.controller.vo.TenderVo;
import com.example.demo.dao.mapper.*;
import com.example.demo.dao.model.*;
import com.example.demo.utils.MD5Util;
import com.example.demo.utils.page.PageView;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@RequestMapping("/exp")
@Controller
public class ExpertController {

	@Autowired
	private TenderMapper tenderMapper;
	@Autowired
	private SupplierMapper supMapper;
	@Autowired
	private SysMsgMapper msgMapper;
	@Autowired
	private EnterpriseMapper entMapper;
	@Autowired
	private TenderHistoryMapper thMapper;
	@Autowired
	private AssessInviteMapper aiMapper;
	@Autowired
	private AssessMapper assMapper;
	@Autowired
	private ExpertMapper expMapper;
	@Autowired
	private NoticeMapper noticeMapper;

	@InitBinder
    public void initBinder(WebDataBinder binder, WebRequest request) {
        //转换日期格式
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        //注册自定义的编辑器
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	
	@RequestMapping("login")
	public String login() {
		return "exp/login";
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.removeAttribute("currExp");
		return "redirect:/index";
	}
	
	@RequestMapping("loginform")
	public String loginform(HttpSession session, HttpServletRequest req, String username, String pwd) {
		String code=req.getParameter("vercode");
		if (!(code.equalsIgnoreCase(session.getAttribute("code").toString()))) {  //忽略验证码大小写  
			req.setAttribute("msg", "验证码不正确！");
			return "exp/login";
		}
		Expert record = new Expert();
		record.setUserName(username);
//		record.setPwd(pwd);
		record.setPwd(MD5Util.md5Encrypt32Upper(pwd));
		List<Expert> exps = expMapper.select(record );
		if(exps != null && exps.size() > 0) {
			session.setAttribute("currExp", exps.get(0));
			return "redirect:home";
		}else {
			req.setAttribute("msg", "用户名或密码错误");
			return "exp/login";
		}
	}
	
	@RequestMapping("home")
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView("exp/home");
		
		return mav;
	}
	
	/**
	 * 评标邀请列表
	 * @param session
	 * @param page
	 * @return
	 */
	@RequestMapping("ivitedlist")
	public ModelAndView ivitedList(HttpSession session, PageView<InviteVo> page) {
		ModelAndView mav = new ModelAndView("exp/invite-list");
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "assess");
		Expert exp = (Expert) session.getAttribute("currExp");
		AssessInvite record = new AssessInvite();
		record.setExpert(exp.getExpertId());
		List<AssessInvite> list = aiMapper.selectByRowBounds(record, new RowBounds(page.getFirstResult(), page.getMaxresult()));
		List<InviteVo> vos = new ArrayList<>();
		for (AssessInvite invite : list) {
			InviteVo vo = new InviteVo();
			Tender ten = tenderMapper.selectByPrimaryKey(invite.getTender());
			vo.setEnt(entMapper.selectByPrimaryKey(entMapper.selectByPrimaryKey(ten.getTenderee())));
			vo.setTen(ten);
			vo.setInvite(invite);
			vos.add(vo);
		}
		page.setRecords(vos);
		page.setTotalrecord(aiMapper.selectCount(record));
		mav.addObject("page", page);
		return mav;
	}
	
	/**
	 * 进入某个征集项目的邀请，查看收到的所有标书
	 * @param session
	 * @param iid
	 * @param tid
	 * @param page
	 * @return
	 */
	@RequestMapping("toassess")
	public ModelAndView toAssess(HttpSession session, Integer iid, Integer tid, PageView<TenderVo> page) {
		ModelAndView mav = new ModelAndView("exp/tender-history");
		Tender tender = tenderMapper.selectByPrimaryKey(tid);
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "myapply");
		TenderHistory record = new TenderHistory();
		record.setTendering(tid);
		//征集记录
		List<TenderHistory> ths = thMapper.select(record);
		Collections.sort(ths, new Comparator<TenderHistory>() {
			@Override
			public int compare(TenderHistory o1, TenderHistory o2) {
				return o1.getTenderTime().compareTo(o2.getTenderTime());
			}
		});
		List<TenderVo> vos = new ArrayList<>();
		for (TenderHistory th : ths) {
			TenderVo vo = new TenderVo();
			vo.setEnt(entMapper.selectByPrimaryKey(th.getTenderee()));
			vo.setTh(th);
			vo.setSup(supMapper.selectByPrimaryKey(th.getBidder()));//征集人
			vo.setTen(tenderMapper.selectByPrimaryKey(th.getTendering()));
			vos.add(vo);
		}
		page.setRecords(vos);
		page.setTotalrecord(thMapper.selectCount(record));
		//标记已读
		Expert exp = (Expert) session.getAttribute("currExp");
		SysMsg msg = new SysMsg();
		msg.setReviever(exp.getExpertId());
		msg.setMsgType("ASSESS_INVITE");
		msg.setRemark(iid+"");
		List<SysMsg> readMsg = msgMapper.select(msg);
		for (SysMsg sysMsg : readMsg) {
			sysMsg.setIsRead(1);
			msgMapper.updateByPrimaryKeySelective(sysMsg);
		}
		mav.addObject("page", page);
		mav.addObject("tender", tender);
		mav.addObject("iid", iid);
		mav.addObject("tid", tid);
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "assess");
		return mav;
	}
	
	/**
	 * 某个征集的详情页面
	 * @param session
	 * @param thid
	 * @return
	 */
	@RequestMapping("tenderdetail")
	public ModelAndView tenderDetail(HttpSession session, Integer thid) {
		ModelAndView mav = new ModelAndView("exp/tender-history-detail");
		TenderHistory th = thMapper.selectByPrimaryKey(thid);
		System.out.println(th.getStatus());
		TenderVo vo = new TenderVo();
		vo.setEnt(entMapper.selectByPrimaryKey(th.getTenderee()));
		vo.setTh(th);
		vo.setTen(tenderMapper.selectByPrimaryKey(th.getTendering()));
		mav.addObject("vo", vo);
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "assess");
		return mav;
	}
	
	/**
	 * 进入评标页面
	 * @param session
	 * @param
	 * @return
	 */
	@RequestMapping("toassform")
	public ModelAndView toAssessFormPage(HttpSession session, Integer tid, Integer iid) {
		ModelAndView mav = new ModelAndView("exp/invite-form");
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "assess");
		Tender tender = tenderMapper.selectByPrimaryKey(tid);
		TenderHistory th = new TenderHistory();
		th.setTendering(tid);
		List<TenderHistory> ths = thMapper.select(th);
		List<Supplier> suplist = new ArrayList<>();
		for (TenderHistory item : ths) {
			suplist.add(supMapper.selectByPrimaryKey(item.getBidder()));
		}
		mav.addObject("suplist", suplist);
		mav.addObject("tid", tid);
		mav.addObject("ten", tender);
		mav.addObject("ent", entMapper.selectByPrimaryKey(tender.getTenderee()));
		mav.addObject("iid", iid);
		return mav;
	}
	
	/**
	 * 提交评估
	 * @param ass
	 * @param iid
	 * @return
	 */
	@RequestMapping("submitass")
	private String submitAssess(HttpSession session, Assess ass, Integer iid, Integer tid) {
		Expert exp = (Expert) session.getAttribute("currExp");
		ass.setExpert(exp.getExpertId());
		assMapper.insertSelective(ass);
		AssessInvite ai = aiMapper.selectByPrimaryKey(iid);
		ai.setStatus(1);
		aiMapper.updateByPrimaryKeySelective(ai);
		return "redirect:myassess";
	}
	
	/**
	 * 我的评估历史
	 * @param session
	 * @param page
	 * @return
	 */
	@RequestMapping("myassess")
	public ModelAndView myAssess(HttpSession session, PageView<InviteVo> page) {
		ModelAndView mav = new ModelAndView("exp/assess-list");
		Expert exp = (Expert) session.getAttribute("currExp");
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "myassess");
		Assess record = new Assess();
		record.setExpert(exp.getExpertId());
		List<Assess> list = assMapper.select(record);
		List<InviteVo> vos = new ArrayList<>();
		for (Assess assess : list) {
			InviteVo vo = new InviteVo();
			vo.setAss(assess);
			vo.setTen(tenderMapper.selectByPrimaryKey(assess.getTender()));
			vo.setEnt(entMapper.selectByPrimaryKey(vo.getTen().getTenderee()));
			vo.setWinner(supMapper.selectByPrimaryKey(assess.getWinner()));
			vos.add(vo);
		}
		page.setRecords(vos);
		page.setTotalrecord(assMapper.selectCount(record));
		mav.addObject("page", page);
		return mav;
	}
	
	@RequestMapping("sysmsg")
	public ModelAndView sysmsg(HttpSession session, PageView<SysMsg> page, String msgType) {
		ModelAndView mav = new ModelAndView("exp/msg-list");
		Expert exp = (Expert) session.getAttribute("currExp");
		List<SysMsg> msg = msgMapper.selectMsg(msgType, exp.getExpertId(), page.getFirstResult(), page.getMaxresult());
		SysMsg record = new SysMsg();
		record.setReviever(exp.getExpertId());
		record.setMsgType(msgType);
		page.setRecords(msg);
		page.setTotalrecord(msgMapper.selectCount(record));
		mav.addObject("page", page);
		return mav;
	}
	
	@RequestMapping("noticemgr")
	public ModelAndView noticeMgr(HttpSession session, PageView<Notice> page) {
		ModelAndView mav = new ModelAndView("exp/notice-list");
		mav.addObject("currMenu0", "notice");
		mav.addObject("currMenu1", "noticemgr");
		Notice record = new Notice();
		List<Notice> list = noticeMapper.selectByRowBounds(record, new RowBounds(page.getFirstResult(), page.getMaxresult()));
		page.setRecords(list);
		page.setTotalrecord(noticeMapper.selectCount(record));
		mav.addObject("page", page);
		return mav;
	}
	
	@RequestMapping("notice-detail")
	public ModelAndView noticeDetail(Integer tid) {
		ModelAndView mav = new ModelAndView("exp/notice-detail");
		Notice notice = noticeMapper.selectByPrimaryKey(tid);
		mav.addObject("notice", notice);
		mav.addObject("currMenu0", "notice");
		mav.addObject("currMenu1", "noticemgr");
		return mav;
	}
	
	@RequestMapping("profile")
	public ModelAndView profile(HttpSession session) {
		ModelAndView mav = new ModelAndView("exp/profile");
		Expert exp = (Expert) session.getAttribute("currExp");
		mav.addObject("exp", exp);
		mav.addObject("currMenu0", "profile");
		mav.addObject("currMenu1", "userinfo");
		return mav;
	}
	
	@RequestMapping("tomdfpwd")
	public ModelAndView tomdfpwd(HttpSession session) {
		ModelAndView mav = new ModelAndView("exp/mdfpwd");
		Expert exp = (Expert) session.getAttribute("currExp");
		mav.addObject("expert", exp);
		mav.addObject("currMenu0", "profile");
		mav.addObject("currMenu1", "mdfpwd");
		return mav;
	}
	
	@RequestMapping("updatepwd")
	public String updatepwd(HttpSession session, String pwd) {
		Expert exp = (Expert) session.getAttribute("currExp");
		pwd = MD5Util.md5Encrypt32Upper(pwd);
		exp.setPwd(pwd);
		expMapper.updateByPrimaryKeySelective(exp);
		return "redirect:profile";
	}
}
