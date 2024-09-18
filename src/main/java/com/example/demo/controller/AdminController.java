package com.example.demo.controller;

import com.example.demo.controller.vo.TenderVo;
import com.example.demo.dao.mapper.*;
import com.example.demo.dao.model.*;
import com.example.demo.service.TenderService;
import com.example.demo.utils.MD5Util;
import com.example.demo.utils.page.PageView;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 系统管理员控制器
 * @author
 *
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private TenderMapper tenderMapper;
	@Autowired
	private EnterpriseMapper entMapper;
	@Autowired
	private AdminMapper adminMapper;
	@Autowired
	private ExpertMapper expertMapper;
	@Autowired
	private SupplierMapper supMapper;
	@Autowired
	private SysMsgMapper msgMapper;
	@Autowired
	private TenderService tenderService;
	@Autowired
	private NoticeMapper noticeMapper;
	@Autowired
	private TenderHistoryMapper thMapper;

	@InitBinder
    public void initBinder(WebDataBinder binder, WebRequest request) {
        //转换日期格式
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        //注册自定义的编辑器
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	
	@RequestMapping("login")
	public String login() {
		return "admin/login";
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.removeAttribute("currAdmin");
		return "redirect:/index";
	}
	
	@RequestMapping("loginform")
	public String loginform(HttpSession session, HttpServletRequest req, String username, String pwd) {
		String code=req.getParameter("vercode");
		if (!(code.equalsIgnoreCase(session.getAttribute("code").toString()))) {  //忽略验证码大小写  
			req.setAttribute("msg", "验证码不正确！");
			return "admin/login";
		}
		Admin record = new Admin();
		record.setUserName(username);
		pwd = MD5Util.md5Encrypt32Upper(pwd);
		record.setPwd(pwd);
		List<Admin> admins = adminMapper.select(record );
		if(admins != null && admins.size() > 0) {
			session.setAttribute("currAdmin", admins.get(0));
			return "redirect:home";
		}else {
			req.setAttribute("msg", "用户名或密码错误");
			return "admin/login";
		}
	}
	
	@RequestMapping("home")
	public ModelAndView home(@RequestParam(value = "sdateStr", required = false) String sdateStr,
                             @RequestParam(value = "edateStr", required = false) String edateStr) {
		ModelAndView mav = new ModelAndView("admin/chart");
		Date sdate = null, edate = null;
		if(sdateStr == null || edateStr == null) {
			sdate = DateUtils.addDays(new Date(), -30);
			edate = DateUtils.addDays(new Date(), 1);
		}else {
			try {
				sdate = DateUtils.parseDate(sdateStr, "yyyy-MM-dd");
				edate = DateUtils.parseDate(edateStr, "yyyy-MM-dd");
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		List<Tender> tenders = tenderMapper.selectTendersDay(sdate, edate);//查询最近一个月数据
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Map<String, Integer> cacul = new HashMap<>();
		StringBuilder days = new StringBuilder();
		List<String> sortKeys = new ArrayList<>();
		long betweend = (edate.getTime() - sdate.getTime()) / (1000L*3600L*24L);//edate.compareTo(sdate);
		for(int i = 0; i<betweend; i++) {
			String str = sdf.format(DateUtils.addDays(sdate, i));
			System.out.println(str);
			for (Tender tender : tenders) {
				String tenderDate = sdf.format(tender.getPublishTime());
				if(tenderDate.equals(str)) {
					System.out.println("命中！");
					if(cacul.containsKey(str)) {
						int cal = cacul.get(str);
						cal++;
						cacul.put(str, cal);
					}else {
						cacul.put(str, 1);
					}
					if(!sortKeys.contains(str)) {
						sortKeys.add(str);
					}
				}else {
					if(!cacul.containsKey(str)) {
						cacul.put(str, 0);
					}
					if(!sortKeys.contains(str)) {
						sortKeys.add(str);
					}
				}
			}
		}
//		for (Tender tender : tenders) {
//			String str = sdf.format(tender.getPublishTime());
//			if(cacul.containsKey(str)) {
//				int i = cacul.get(str);
//				i++;
//				cacul.put(str, i);
//			}else {
//				cacul.put(str, 1);
//				sortKeys.add(str);
//			}
//		}
		StringBuilder sb = new StringBuilder();
		for (String key : sortKeys) {
			sb.append(cacul.get(key)+"");
			sb.append(",");
			days.append("'").append(key);
			days.append("',");
		}
		String dayStr = days.toString();
		if(dayStr.endsWith(",")) {
			dayStr = dayStr.substring(0, dayStr.length() - 1);
		}
		String countStr = sb.toString();
		if(countStr.endsWith(",")) {
			countStr = sb.substring(0, countStr.length() - 1);
		}
		System.out.println(dayStr);
		System.out.println(countStr);
		
		//征集结果分布
		List<Tender> allTenders = tenderMapper.selectAll();
		Map<Integer, Integer> resultMap = new HashMap<>();
		for (Tender ten : allTenders) {
			Integer curr = ten.getStatus();
			if(resultMap.containsKey(curr)) {
				int count = resultMap.get(curr);
				count++;
				resultMap.put(curr, count);
			}else {
				resultMap.put(curr, 1);
			}
		}
		StringBuilder rtsb = new StringBuilder();
		int faildCount = 0;
		for(Map.Entry<Integer, Integer> entry:resultMap.entrySet()) {
			//{value: 1, name: '后台_bug'}, {value: 3, name: 'IOS_bug'},
			if(entry.getKey() == 0) {
				rtsb.append("{value:"+entry.getValue()+", name:'待审核'},");
			}else if(entry.getKey() == 1) {
				rtsb.append("{value:"+entry.getValue()+", name:'征集中'},");
			}else if(entry.getKey() == 2) {
				rtsb.append("{value:"+entry.getValue()+", name:'已完成'},");
			}else if(entry.getKey() == 3) {
				rtsb.append("{value:"+entry.getValue()+", name:'流标'},");
				faildCount = entry.getValue();
			}else if(entry.getKey() == -1) {
				rtsb.append("{value:"+entry.getValue()+", name:'已拒绝'},");
			}
		}
		String rtStr = rtsb.toString();
		if(rtStr.endsWith(",")) {
			rtStr = rtStr.substring(0, rtStr.length() - 1);
		}
		
		//征集类型分布
		Map<String, Integer> typeMap = new HashMap<>();
		for (Tender ten : allTenders) {
			String curr = ten.getProjectType();
			if(typeMap.containsKey(curr)) {
				int count = typeMap.get(curr);
				count++;
				typeMap.put(curr, count);
			}else {
				typeMap.put(curr, 1);
			}
		}
		StringBuilder ptsb = new StringBuilder();
		for(Map.Entry<String, Integer> entry:typeMap.entrySet()) {
			//{value: 1, name: '后台_bug'}, {value: 3, name: 'IOS_bug'},
			if("工程类".equals(entry.getKey())) {
				ptsb.append("{value:"+entry.getValue()+", name:'工程类'},");
			}else if("产品类".equals(entry.getKey())) {
				ptsb.append("{value:"+entry.getValue()+", name:'产品类'},");
			}else if("服务类".equals(entry.getKey())) {
				ptsb.append("{value:"+entry.getValue()+", name:'服务类'},");
			}
		}
		String ptStr = ptsb.toString();
		if(ptStr.endsWith(",")) {
			ptStr = ptStr.substring(0, ptStr.length() - 1);
		}
		
		//收到征集数量排名
		List<TenderHistory> ths = thMapper.selectAll();
		Map<Integer, Integer> rankMap = new HashMap<>();
		for (TenderHistory th : ths) {
			Integer curr = th.getTendering();
			if(rankMap.containsKey(curr)) {
				int count = rankMap.get(curr);
				count++;
				rankMap.put(curr, count);
			}else {
				rankMap.put(curr, 1);
			}
		}
		StringBuilder sbRank = new StringBuilder();
		StringBuilder sbRankValue = new StringBuilder();
		for(Map.Entry<Integer, Integer> entry:rankMap.entrySet()) {
			Integer tid = entry.getKey();
			sbRank.append("'");
			Tender ten = tenderMapper.selectByPrimaryKey(tid);
			sbRank.append(ten.getProjectName());
			sbRank.append("',");
			sbRankValue.append(entry.getValue()).append(",");
		}
		String sbRankStr = sbRank.toString();
		if(sbRankStr.endsWith(",")) {
			sbRankStr = sbRankStr.substring(0, sbRankStr.length() - 1);
		}
		String sbRankValueStr = sbRankValue.toString();
		if(sbRankValueStr.endsWith(",")) {
			sbRankValueStr = sbRankValueStr.substring(0, sbRankValueStr.length() - 1);
		}
		
		mav.addObject("dayStr", dayStr);
		mav.addObject("countStr", countStr);
		mav.addObject("rtStr", rtStr);
		mav.addObject("ptStr", ptStr);
		mav.addObject("sbRankStr", sbRankStr);
		mav.addObject("sbRankValueStr", sbRankValueStr);
		mav.addObject("sdate", sdate);
		mav.addObject("edate", edate);
		mav.addObject("tendersCount", allTenders.size());
		mav.addObject("entCount", entMapper.selectCount(new Enterprise()));
		mav.addObject("supCount", supMapper.selectCount(new Supplier()));
		DecimalFormat df=new DecimalFormat("0.0");
		float f = (float)faildCount;
		//System.out.println((f/(double)allTenders.size())*100);
		mav.addObject("faildCount", df.format((f/(double)allTenders.size())*100));
		mav.addObject("currMenu0", "home");
		mav.addObject("currMenu1", "home");
		return mav;
	}
	
	@RequestMapping("toaddexpert")
	public String toAddExpert(HttpServletRequest req) {
		req.setAttribute("currMenu0", "expert");
		req.setAttribute("currMenu1", "expertadd");
		return "admin/expert-add";
	}
	
	@RequestMapping("saveexpert")
	public String saveExpert(HttpSession session, HttpServletRequest request, Expert expert) {
		expert.setPwd(MD5Util.md5Encrypt32Upper(expert.getPwd()));
		expertMapper.insertSelective(expert);
		return "redirect:expertmgr";
	}
	
	@RequestMapping("expertmgr")
	public ModelAndView expertMgr(HttpSession session, PageView<Expert> page,
                                  @RequestParam(value = "kw", required = false) String kw,
                                  @RequestParam(value = "type", required = false) String type) {
		ModelAndView mav = new ModelAndView("admin/expert-list");
		mav.addObject("currMenu0", "expert");
		mav.addObject("currMenu1", "expertmgr");
		Expert record = new Expert();
		Map<String, Object> params = new HashMap<>();
		params.put("start", page.getFirstResult());
		params.put("end", page.getMaxresult());
		if(kw != null) {
			params.put("kw", kw);	
		}
		if(type != null && !type.equals("-1")) {
			params.put("type", type);
		}
		List<Expert> list = expertMapper.searchExperts(params);//.selectByRowBounds(record, new RowBounds(page.getFirstResult(), page.getMaxresult()));
		page.setRecords(list);
		page.setTotalrecord(expertMapper.selectCount(record));
		mav.addObject("page", page);
		mav.addObject("kw", kw);
		mav.addObject("type", type);
		return mav;
	}
	
	@RequestMapping("expert-detail")
	public ModelAndView expertDetail(Integer tid) {
		ModelAndView mav = new ModelAndView("admin/expert-detail");
		Expert expert = expertMapper.selectByPrimaryKey(tid);
		mav.addObject("expert", expert);
		mav.addObject("currMenu0", "expert");
		mav.addObject("currMenu1", "expertmgr");
		return mav;
	}
	
	@RequestMapping("tomdfexpert")
	public ModelAndView toUpdateExpert(Integer eid) {
		ModelAndView mav = new ModelAndView("admin/expert-update");
		Expert expert = expertMapper.selectByPrimaryKey(eid);
		mav.addObject("expert", expert);
		mav.addObject("currMenu0", "expert");
		mav.addObject("currMenu1", "expertmgr");
		return mav;
	}
	
	@RequestMapping("updateexpert")
	public String updateExpert(HttpSession session, Expert expert) {
		expertMapper.updateByPrimaryKeySelective(expert);
		return "redirect:expertmgr";
	}
	
	@RequestMapping("deleteexpert")
	public String deleteExpert(Integer eid) {
		expertMapper.deleteByPrimaryKey(eid);
		return "redirect:expertmgr";
	}
	
	/**
	 * 征集方列表
	 * @param session
	 * @param page
	 * @return
	 */
	@RequestMapping("entmgr")
	public ModelAndView entMgr(HttpSession session, PageView<Enterprise> page, @RequestParam(value = "kw", required = false) String kw) {
		ModelAndView mav = new ModelAndView("admin/ent-list");
		mav.addObject("currMenu0", "ent");
		mav.addObject("currMenu1", "entmgr");
		Enterprise record = new Enterprise();
		Map<String, Object> params = new HashMap<>();
		params.put("start", page.getFirstResult());
		params.put("end", page.getMaxresult());
		if(kw != null) {
			params.put("kw", kw);	
		}
		List<Enterprise> list = entMapper.searchEnterprise(params);//.selectByRowBounds(record, new RowBounds(page.getFirstResult(), page.getMaxresult()));
		page.setRecords(list);
		page.setTotalrecord(entMapper.selectCount(record));
		mav.addObject("page", page);
		mav.addObject("kw", kw);
		return mav;
	}
	
	/**
	 * 待激活的征集方列表
	 * @param session
	 * @param page
	 * @return
	 */
	@RequestMapping("entactive")
	public ModelAndView entActive(HttpSession session, PageView<Enterprise> page, @RequestParam(value = "kw", required = false) String kw) {
		ModelAndView mav = new ModelAndView("admin/ent-active");
		mav.addObject("currMenu0", "ent");
		mav.addObject("currMenu1", "entmgr");
		Enterprise record = new Enterprise();
		record.setStatus(-1);
		Map<String, Object> params = new HashMap<>();
		params.put("start", page.getFirstResult());
		params.put("end", page.getMaxresult());
		if(kw != null) {
			params.put("kw", kw);	
		}
		params.put("status", -1);
		List<Enterprise> list = entMapper.searchEnterprise(params);//selectByRowBounds(record, new RowBounds(page.getFirstResult(), page.getMaxresult()));
		page.setRecords(list);
		page.setTotalrecord(entMapper.selectCount(record));
		mav.addObject("page", page);
		mav.addObject("kw", kw);
		return mav;
	}
	
	/**
	 * 征集方详情页面
	 * @param tid
	 * @return
	 */
	@RequestMapping("ent-detail")
	public ModelAndView entDetail(Integer tid) {
		ModelAndView mav = new ModelAndView("admin/ent-detail");
		Enterprise ent = entMapper.selectByPrimaryKey(tid);
		mav.addObject("ent", ent);
		mav.addObject("currMenu0", "ent");
		mav.addObject("currMenu1", "entmgr");
		return mav;
	}
	
	/**
	 * 激活征集人账号
	 * @param eid
	 * @return
	 */
	@RequestMapping("actent")
	public String confirmEnt(Integer eid) {
		Enterprise ent = entMapper.selectByPrimaryKey(eid);
		ent.setStatus(1);
		entMapper.updateByPrimaryKeySelective(ent);
		SysMsg record = new SysMsg();
		record.setRemark(ent.getEntId()+"");
		record.setMsgType("NEW_REGIST_ENT");
		List<SysMsg> msgs = msgMapper.select(record);
		for (SysMsg m : msgs) {
			m.setIsRead(1);
			msgMapper.updateByPrimaryKey(m);
		}
		return "redirect:sysmsg?msgType=NEW_REGIST_ENT";
	}
	
	/**
	 * 删除征集人账号
	 * @param eid
	 * @return
	 */
	@RequestMapping("deleteent")
	public String deleteEnt(Integer eid) {
		entMapper.deleteByPrimaryKey(eid);
		return "redirect:entmgr";
	}
	
	/**
	 * 停用征集人账号
	 * @param eid
	 * @return
	 */
	@RequestMapping("disent")
	public String disableEnt(Integer eid) {
		Enterprise ent = entMapper.selectByPrimaryKey(eid);
		ent.setStatus(-1);
		entMapper.updateByPrimaryKeySelective(ent);
		return "redirect:entmgr";
	}
	
	
	/**************************************/
	
	/**
	 * 供应商列表
	 * @param session
	 * @param page
	 * @return
	 */
	@RequestMapping("supmgr")
	public ModelAndView supMgr(HttpSession session, PageView<Supplier> page, @RequestParam(value = "kw", required = false) String kw) {
		ModelAndView mav = new ModelAndView("admin/sup-list");
		mav.addObject("currMenu0", "ent");
		mav.addObject("currMenu1", "supmgr");
		Supplier record = new Supplier();
		Map<String, Object> params = new HashMap<>();
		params.put("start", page.getFirstResult());
		params.put("end", page.getMaxresult());
		if(kw != null) {
			params.put("kw", kw);	
		}
		List<Supplier> list = supMapper.searchSuppliers(params);//.selectByRowBounds(record, new RowBounds(page.getFirstResult(), page.getMaxresult()));
		page.setRecords(list);
		page.setTotalrecord(supMapper.selectCount(record));
		mav.addObject("page", page);
		mav.addObject("kw", kw);
		return mav;
	}
	
	/**
	 * 待激活的供应商列表
	 * @param session
	 * @param page
	 * @return
	 */
	@RequestMapping("supactive")
	public ModelAndView supActive(HttpSession session, PageView<Supplier> page) {
		ModelAndView mav = new ModelAndView("admin/sup-active");
		mav.addObject("currMenu0", "ent");
		mav.addObject("currMenu1", "supmgr");
		Supplier record = new Supplier();
		record.setStatus(-1);
		List<Supplier> list = supMapper.selectByRowBounds(record, new RowBounds(page.getFirstResult(), page.getMaxresult()));
		page.setRecords(list);
		page.setTotalrecord(supMapper.selectCount(record));
		mav.addObject("page", page);
		return mav;
	}
	
	/**
	 * 供应商详情页面
	 * @param tid
	 * @return
	 */
	@RequestMapping("sup-detail")
	public ModelAndView supDetail(Integer tid) {
		ModelAndView mav = new ModelAndView("admin/sup-detail");
		Supplier sup = supMapper.selectByPrimaryKey(tid);
		mav.addObject("sup", sup);
		mav.addObject("currMenu0", "ent");
		mav.addObject("currMenu1", "supmgr");
		return mav;
	}
	
	/**
	 * 激活供应商账号
	 * @param eid
	 * @return
	 */
	@RequestMapping("actsup")
	public String confirmSup(Integer eid) {
		Supplier sup = supMapper.selectByPrimaryKey(eid);
		sup.setStatus(1);
		supMapper.updateByPrimaryKeySelective(sup);
		SysMsg record = new SysMsg();
		record.setRemark(sup.getSupplierId()+"");
		record.setMsgType("NEW_REGIST_SUP");
		List<SysMsg> msgs = msgMapper.select(record);
		for (SysMsg m : msgs) {
			m.setIsRead(1);
			msgMapper.updateByPrimaryKey(m);
		}
		return "redirect:sysmsg?msgType=NEW_REGIST_SUP";
	}
	
	/**
	 * 删除供应商账号
	 * @param eid
	 * @return
	 */
	@RequestMapping("deletesup")
	public String deleteSup(Integer eid) {
		supMapper.deleteByPrimaryKey(eid);
		return "redirect:supmgr";
	}
	
	/**
	 * 停用供应商账号
	 * @param eid
	 * @return
	 */
	@RequestMapping("dissup")
	public String disableSup(Integer eid) {
		Supplier sup = supMapper.selectByPrimaryKey(eid);
		sup.setStatus(-1);
		supMapper.updateByPrimaryKeySelective(sup);
		return "redirect:supmgr";
	}
	
	/**
	 * 标书列表，用于审核
	 * @param session
	 * @param page
	 * @return
	 */
	@RequestMapping("tendermgr")
	public ModelAndView tenderMgr(HttpSession session, PageView<TenderVo> page,
                                  @RequestParam(value = "kw", required = false) String kw,
                                  @RequestParam(value = "entName", required = false) String entName,
                                  @RequestParam(value = "type", required = false) String type) {
		ModelAndView mav = new ModelAndView("admin/tender-list");
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "tendermgr");
		Tender record = new Tender();
		Map<String, Object> params = new HashMap<>();
		params.put("start", page.getFirstResult());
		params.put("end", page.getMaxresult());
		if(kw != null) {
			params.put("kw", kw);	
		}
		if(entName != null) {
			params.put("entName", entName);	
		}
		if(type != null && !type.equals("-1")) {
			params.put("type", type);	
		}
		List<Tender> list = tenderMapper.searchTenders(params);//.selectByRowBounds(record, new RowBounds(page.getFirstResult(), page.getMaxresult()));
		Date today = new Date();
		for (Tender tender : list) {
			if(tender.getEndTime().before(today)) {
				tender.setStatus(99);
			}
		}
		List<TenderVo> vos = new ArrayList<>();
		for (Tender ten : list) {
			TenderVo vo = new TenderVo();
			vo.setEnt(entMapper.selectByPrimaryKey(ten.getTenderee()));
			vo.setTen(ten);
			vos.add(vo);
		}
		page.setRecords(vos);
		page.setTotalrecord(tenderMapper.selectCount(record));
		mav.addObject("page", page);
		mav.addObject("kw", kw);
		mav.addObject("entName", entName);
		mav.addObject("type", type);
		return mav;
	}
	
	@RequestMapping("tender-detail")
	public ModelAndView tenderDetail(Integer tid) {
		ModelAndView mav = new ModelAndView("admin/tender-detail");
		Tender tender = tenderMapper.selectByPrimaryKey(tid);
		Date today = new Date();
		if(tender.getEndTime().before(today)) {
			tender.setStatus(99);
		}
		mav.addObject("tender", tender);
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "tendermgr");
		return mav;
	}
	
	/**
	 * 审核征集申请
	 * @param tid
	 * @param status
	 * @return
	 */
	@RequestMapping("checktender")
	public String checkTender(Integer tid, Integer status) {
		Tender tender = tenderMapper.selectByPrimaryKey(tid);
		tender.setStatus(status);
		tenderMapper.updateByPrimaryKeySelective(tender);
		if(status == 1) {
			//通过，推送征集邀请
			tenderService.sendTenderInvite(tender);
		}
		SysMsg record = new SysMsg();
		record.setRemark(tender.getTenderId()+"");
		record.setMsgType("NEW_TENDER");
		List<SysMsg> msgs = msgMapper.select(record);
		for (SysMsg m : msgs) {
			m.setIsRead(1);
			msgMapper.updateByPrimaryKey(m);
		}
		return "redirect:tendermgr";
	}
	
	/*******个人信息管理********/
	
	@RequestMapping("profile")
	public ModelAndView profile(HttpSession session) {
		ModelAndView mav = new ModelAndView("admin/profile");
		Admin admin = (Admin) session.getAttribute("currAdmin");
		mav.addObject("admin", admin);
		mav.addObject("currMenu0", "profile");
		mav.addObject("currMenu1", "userinfo");
		return mav;
	}
	
	@RequestMapping("tomdfpwd")
	public ModelAndView toMdfPwd(HttpSession session) {
		ModelAndView mav = new ModelAndView("admin/mdfpwd");
		Admin admin = (Admin) session.getAttribute("currAdmin");
		mav.addObject("admin", admin);
		mav.addObject("currMenu0", "profile");
		mav.addObject("currMenu1", "mdfpwd");
		return mav;
	}
	
	@RequestMapping("updatepwd")
	public String updatepwd(HttpSession session, String pwd) {
		Admin admin = (Admin) session.getAttribute("currAdmin");
		pwd = MD5Util.md5Encrypt32Upper(pwd);
		admin.setPwd(pwd);
		adminMapper.updateByPrimaryKeySelective(admin);
		session.setAttribute("currAdmin", admin);
		return "redirect:profile";
	}
	
	@RequestMapping("sysmsg")
	public ModelAndView sysmsg(PageView<SysMsg> page, @RequestParam(value = "msgType", required = false) String msgType) {
		ModelAndView mav = new ModelAndView("admin/msg-list");
		List<SysMsg> msg = msgMapper.selectAdminMsg(msgType, page.getFirstResult(), page.getMaxresult());
		SysMsg record = new SysMsg();
		record.setReviever(-1);
		record.setMsgType(msgType);
		page.setRecords(msg);
		page.setTotalrecord(msgMapper.selectCount(record));
		mav.addObject("page", page);
		return mav;
	}
	
	@RequestMapping("msgdetail")
	public ModelAndView msgdetail(Integer mid) {
		ModelAndView mav = new ModelAndView("admin/msg-detail");
		SysMsg msg = msgMapper.selectByPrimaryKey(mid);
		mav.addObject("msg", msg);
		return mav;
	}

	@RequestMapping("toaddnotice")
	public String toAddNotice(HttpServletRequest req) {
		req.setAttribute("currMenu0", "notice");
		req.setAttribute("currMenu1", "noticeadd");
		return "admin/notice-add";
	}
	
	@RequestMapping("savenotice")
	public String saveNotice(HttpSession session, HttpServletRequest request, Notice notice) {
		notice.setPublishTime(new Date());
		noticeMapper.insertSelective(notice);
		return "redirect:noticemgr";
	}
	
	@RequestMapping("noticemgr")
	public ModelAndView noticeMgr(HttpSession session, PageView<Notice> page, @RequestParam(value = "kw", required = false) String kw) {
		ModelAndView mav = new ModelAndView("admin/notice-list");
		mav.addObject("currMenu0", "notice");
		mav.addObject("currMenu1", "noticemgr");
		Notice record = new Notice();
		Map<String, Object> params = new HashMap<>();
		params.put("start", page.getFirstResult());
		params.put("end", page.getMaxresult());
		if(kw != null) {
			params.put("kw", kw);	
		}
		List<Notice> list = noticeMapper.searchNotice(params);//.selectByRowBounds(record, new RowBounds(page.getFirstResult(), page.getMaxresult()));
		page.setRecords(list);
		page.setTotalrecord(noticeMapper.selectCount(record));
		mav.addObject("page", page);
		mav.addObject("kw", kw);
		return mav;
	}
	
	@RequestMapping("notice-detail")
	public ModelAndView noticeDetail(Integer tid) {
		ModelAndView mav = new ModelAndView("admin/notice-detail");
		Notice notice = noticeMapper.selectByPrimaryKey(tid);
		mav.addObject("notice", notice);
		mav.addObject("currMenu0", "notice");
		mav.addObject("currMenu1", "noticemgr");
		return mav;
	}
	
	@RequestMapping("tomdfnotice")
	public ModelAndView toUpdateNotice(Integer eid) {
		ModelAndView mav = new ModelAndView("admin/notice-update");
		Notice notice = noticeMapper.selectByPrimaryKey(eid);
		mav.addObject("notice", notice);
		mav.addObject("currMenu0", "notice");
		mav.addObject("currMenu1", "noticemgr");
		return mav;
	}
	
	@RequestMapping("updatenotice")
	public String updateNotice(HttpSession session, Notice notice) {
		noticeMapper.updateByPrimaryKeySelective(notice);
		return "redirect:noticemgr";
	}
	
	@RequestMapping("deletenotice")
	public String deleteNotice(Integer eid) {
		noticeMapper.deleteByPrimaryKey(eid);
		return "redirect:noticemgr";
	}
	
}
