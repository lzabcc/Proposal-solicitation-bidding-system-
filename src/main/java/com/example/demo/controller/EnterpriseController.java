package com.example.demo.controller;

import com.example.demo.controller.vo.InviteVo;
import com.example.demo.controller.vo.TenderVo;
import com.example.demo.dao.mapper.*;
import com.example.demo.dao.model.*;
import com.example.demo.service.TenderService;
import com.example.demo.utils.MD5Util;
import com.example.demo.utils.page.PageView;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 征集方企业控制器
 * @author
 *
 */
@Controller
@RequestMapping("/ent")
public class EnterpriseController {
	
	@Autowired
	private TenderMapper tenderMapper;
	@Autowired
	private EnterpriseMapper entMapper;
	@Autowired
	private SysMsgMapper msgMapper;
	@Autowired
	private TenderHistoryMapper thMapper;
	@Autowired
	private SupplierMapper supMapper;
	@Autowired
	private ExpertMapper expMapper;
	@Autowired
	private AssessInviteMapper aiMapper;
	@Autowired
	private NoticeMapper noticeMapper;
	@Autowired
	private AssessMapper assMapper;
	@Autowired
	private TenderService tenderService;

	@InitBinder
    public void initBinder(WebDataBinder binder, WebRequest request) {
        //转换日期格式
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        //注册自定义的编辑器
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	
	@RequestMapping("login")
	public String login() {
		return "ent/login";
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.removeAttribute("currEnt");
		return "redirect:/index";
	}
	
	@RequestMapping("regist")
	public String reg() {
		return "ent/regist";
	}
	
	
	@RequestMapping("loginform")
	public String loginform(HttpSession session, HttpServletRequest req, String username, String pwd) {
		String code=req.getParameter("vercode");
		if (!(code.equalsIgnoreCase(session.getAttribute("code").toString()))) {  //忽略验证码大小写  
			req.setAttribute("msg", "验证码不正确！");
			return "ent/login";
		}
		Enterprise record = new Enterprise();
		record.setUserName(username);
		record.setPwd(MD5Util.md5Encrypt32Upper(pwd));
		List<Enterprise> ents = entMapper.select(record );
		if(ents != null && ents.size() > 0) {
			if(ents.get(0).getStatus() == -1) {
				req.setAttribute("msg", "账号未激活，请耐心等待管理员审核。");
				return "ent/login";
			}else {
				session.setAttribute("currEnt", ents.get(0));
				return "redirect:home";
			}
		}else {
			req.setAttribute("msg", "用户名或密码错误");
			return "ent/login";
		}
	}
	
	@RequestMapping("checkuser")
	public void checkuser(String username, PrintWriter pw) {
		Enterprise record = new Enterprise();
		record.setUserName(username);
		List<Enterprise> ret = entMapper.select(record);
		if(ret != null && ret.size()>0) {
			pw.write("-1");
		}else {
			pw.write("0");
		}
	}
	
	@RequestMapping("regform")
	public String regform(HttpServletRequest request, @RequestParam("file") MultipartFile file, Enterprise ent) {
		if(file != null && file.getSize() > 0) {
			//保存文件
			System.out.println("上传的文件名："+file.getOriginalFilename());
			String uuid = UUID.randomUUID().toString();
			String folder = request.getSession().getServletContext().getRealPath("/upload")+File.separator;
			System.out.println("存储的文件路径："+folder);
			String filePath = folder+uuid+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
			System.out.println(filePath);
			InputStream is = null;// 附件输入流
			DataOutputStream out = null;
			try {
				out = new DataOutputStream(new FileOutputStream(filePath));// 存放文件的绝对路径
				is = file.getInputStream();
				byte[] b = new byte[is.available()];
				is.read(b);
				out.write(b);
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (is != null) {
					try {
						is.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (out != null) {
					try {
						out.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				ent.setAttachment(uuid+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")));
			}
			ent.setStatus(-1);
			ent.setPwd(MD5Util.md5Encrypt32Upper(ent.getPwd()));
			entMapper.insertEnterprise(ent);
			SysMsg msg = new SysMsg();
			msg.setAlink("/ssm/admin/ent-detail?tid="+ent.getEntId());
			msg.setContent("新注册征集方："+ent.getEnterpriseName()+"，请前往激活！");
			msg.setIsRead(-1);
			msg.setMsgTime(new Date());
			msg.setMsgType("NEW_REGIST_ENT");
			msg.setReviever(-1);
			msg.setRemark(ent.getEntId()+"");
			msgMapper.insertSelective(msg);
		}
		request.setAttribute("msg", "99");
		return "login";
	}
	
	@RequestMapping("home")
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView("ent/home");
		
		return mav;
	}
	
	@RequestMapping("toaddtender")
	public String toAddTender(HttpServletRequest req) {
		req.setAttribute("currMenu0", "tender");
		req.setAttribute("currMenu1", "tenderadd");
		return "ent/tender-add";
	}
	
	/**
	 * 发布征集
	 * @param session
	 * @param request
	 * @param file
	 * @param tender
	 * @return
	 */
	@RequestMapping("savetender")
	public String saveTender(HttpSession session, HttpServletRequest request, @RequestParam("file") MultipartFile file, Tender tender) {
		Enterprise ent = (Enterprise) session.getAttribute("currEnt");
		if(file != null && file.getSize() > 0) {
			//保存文件
			System.out.println("上传的文件名："+file.getOriginalFilename());
			String uuid = UUID.randomUUID().toString();
			String folder = request.getSession().getServletContext().getRealPath("/upload")+File.separator;
			System.out.println("存储的文件路径："+folder);
			String filePath = folder+uuid+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
			System.out.println(filePath);
			InputStream is = null;// 附件输入流
			DataOutputStream out = null;
			try {
				out = new DataOutputStream(new FileOutputStream(filePath));// 存放文件的绝对路径
				is = file.getInputStream();
				byte[] b = new byte[is.available()];
				is.read(b);
				out.write(b);
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (is != null) {
					try {
						is.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (out != null) {
					try {
						out.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				tender.setAttachement(uuid+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")));
			}
		}
		//根据时间截生成项目编号
		tender.setTenderNo(System.currentTimeMillis()+"");
		tender.setTenderee(ent.getEntId());
		tender.setStatus(0);
		tender.setPublishTime(new Date());
//		tenderMapper.insertSelective(tender);
		tenderMapper.insertTender(tender);
		SysMsg msg = new SysMsg();
		msg.setAlink("/ssm/admin/tender-detail?tid="+tender.getTenderId());
		msg.setContent("收到新征集申请：《"+tender.getProjectName()+"》，请前往审核！");
		msg.setIsRead(-1);
		msg.setMsgTime(new Date());
		msg.setMsgType("NEW_TENDER");
		msg.setReviever(-1);
		msg.setRemark(tender.getTenderId()+"");
		msgMapper.insertSelective(msg);
		return "redirect:tendermgr";
	}
	
	/**
	 * 我提交的所有征集
	 * @param session
	 * @param page
	 * @return
	 */
	@RequestMapping("tendermgr")
	public ModelAndView tenderMgr(HttpSession session, PageView<Tender> page,
                                  @RequestParam(value = "kw", required = false) String kw, @RequestParam(value = "type", required = false) String type,
                                  @RequestParam(value = "status", required = false) String status) {
		ModelAndView mav = new ModelAndView("ent/tender-list");
		Enterprise ent = (Enterprise) session.getAttribute("currEnt");
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "tendermgr");
		Map<String, Object> params = new HashMap<>();
		params.put("start", page.getFirstResult());
		params.put("end", page.getMaxresult());
		if(kw != null) {
			params.put("kw", kw);	
		}
		if(type != null && !type.equals("-1")) {
			params.put("type", type);
		}
		if(status != null && !status.equals("-100")&&!status.equals("99")) {
			params.put("status", status);
		}
		params.put("tenderee", ent.getEntId());
		List<Tender> list = tenderMapper.searchTenders(params);//.selectByRowBounds(record, new RowBounds(page.getFirstResult(), page.getMaxresult()));
		Date today = new Date();
		if(status != null && status.equals("99")) {
			Iterator<Tender> itr = list.iterator();
			while(itr.hasNext()) {
				Tender curr = itr.next();
				if(curr.getEndTime().after(today)) {
					itr.remove();
				}else {
					curr.setStatus(99);
				}
			}
			page.setTotalrecord(list.size());
		}else {
			Iterator<Tender> itr = list.iterator();
			while(itr.hasNext()) {
				Tender curr = itr.next();
				if(curr.getEndTime().before(today)) {//截止日期在今天之前
					if(status == null || status.equals("-100")) {//-100表示前端页面的查询条件中的状态为“所有状态”
						curr.setStatus(99);//使用99状态码表示已截止
					}else {
						itr.remove();//如果查询条件中的状态不是“所有状态”，则移除当前迭代到的项目
					}
				}
			}
			page.setTotalrecord(tenderMapper.searchTendersCount(params));
		}
		page.setRecords(list);
		System.out.println(page.getTotalpage());
		mav.addObject("page", page);
		mav.addObject("kw", kw);
		mav.addObject("type", type);
		mav.addObject("status", status);
		return mav;
	}
	
	/**
	 * 征集项目详情
	 * @param tid
	 * @return
	 */
	@RequestMapping("tender-detail")
	public ModelAndView tenderDetail(Integer tid) {
		ModelAndView mav = new ModelAndView("ent/tender-detail");
		Tender tender = tenderMapper.selectByPrimaryKey(tid);
		Date today = new Date();
		if(tender.getEndTime().after(today)) {
		}else {
			tender.setStatus(99);
		}
		mav.addObject("tender", tender);
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "tendermgr");
		return mav;
	}
	
	/**
	 * 收到的所有标书，包括未截止与已截止的项目
	 * @param session
	 * @param page
	 * @return
	 */
	@RequestMapping("receivedapp")
	public ModelAndView receivedApp(HttpSession session) {
		ModelAndView mav = new ModelAndView("ent/received-list");
		Enterprise ent = (Enterprise) session.getAttribute("currEnt");
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "receivedapp");
		TenderHistory record = new TenderHistory();
		record.setTenderee(ent.getEntId());
		//收到的标书
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
				vo.setSup(supMapper.selectByPrimaryKey(th.getBidder()));
				vo.setTh(th);
				vo.setTen(tenderMapper.selectByPrimaryKey(th.getTendering()));
				vos.add(vo);
		}
		mav.addObject("list", vos);
		return mav;
	}
	
	/**
	 * 供应商的征集详情
	 * @param session
	 * @param thid
	 * @return
	 */
	@RequestMapping("receivedetail")
	public ModelAndView receiveDetail(HttpSession session, Integer thid) {
		ModelAndView mav = new ModelAndView("ent/received-detail");
		TenderHistory th = thMapper.selectByPrimaryKey(thid);
		System.out.println(th.getStatus());
		TenderVo vo = new TenderVo();
		vo.setSup(supMapper.selectByPrimaryKey(th.getBidder()));
		vo.setTh(th);
		vo.setTen(tenderMapper.selectByPrimaryKey(th.getTendering()));
		mav.addObject("vo", vo);
		return mav;
	}
	
	/**
	 * 定标管理列表，查找所有已过了截止期的项目
	 * @param session
	 * @return
	 */
	@RequestMapping("confirmtender")
	public ModelAndView tenderConfirmMgr(HttpSession session,
                                         @RequestParam(value = "kw", required = false) String kw, @RequestParam(value = "type", required = false) String type) {
		ModelAndView mav = new ModelAndView("ent/tender-confirm");
		Enterprise ent = (Enterprise) session.getAttribute("currEnt");
		Map<String, Object> params = new HashMap<>();
		params.put("entid", ent.getEntId());
		params.put("now", new Date());
		if(kw != null) {
			params.put("kw", kw);	
		}
		if(type != null && !type.equals("-1")) {
			params.put("type", type);	
		}
		List<Tender> list = tenderMapper.selectConfirmTenders(params);
		for (Tender tender : list) {
			AssessInvite ai = new AssessInvite();
			ai.setTender(tender.getTenderId());
			int aicount = aiMapper.selectCount(ai);//查询这个征集项目是否已经邀请过专家
			if(aicount > 0) {//邀请过
				tender.setWinner(-99);
			}else if(aicount == 0 && tender.getStatus() == 1){
			//未诉请过且该项目在征集中
					tender.setWinner(-100);
			}

			else{
				tender.setStatus(99);
			}

		}
		mav.addObject("kw", kw);
		mav.addObject("list", list);
		mav.addObject("type", type);
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "confirmtender");
		return mav;
	}
	
	/**
	 * 进入某个项目的定标页面，显示所有收到的标书
	 * @param session
	 * @param tid 征集ID
	 * @return
	 */
	@RequestMapping("toconfirmpage")
	public ModelAndView toComfirmPage(HttpSession session, Integer tid) {
		ModelAndView mav = new ModelAndView("ent/received-list2");
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "tendermgr");
		TenderHistory record = new TenderHistory();
		record.setTendering(tid);
		//收到的标书
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
				vo.setSup(supMapper.selectByPrimaryKey(th.getBidder()));
				vo.setTh(th);
				vo.setTen(tenderMapper.selectByPrimaryKey(th.getTendering()));
				vos.add(vo);
		}
		mav.addObject("vos", vos);
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "tendermgr");
		return mav;
	}
	
	@RequestMapping("sup-detail")
	public ModelAndView supDetail(Integer tid) {
		ModelAndView mav = new ModelAndView("ent/sup-detail");
		Supplier sup = supMapper.selectByPrimaryKey(tid);
		mav.addObject("sup", sup);
		mav.addObject("currMenu0", "ent");
		mav.addObject("currMenu1", "supmgr");
		return mav;
	}
	
	/**
	 * 查看专家评估
	 * @param tid
	 * @param page
	 * @return
	 */
	@RequestMapping("expassess")
	public ModelAndView expAssess(Integer tid, PageView<InviteVo> page) {
		ModelAndView mav = new ModelAndView("ent/assess-list");
		Tender tender = tenderMapper.selectByPrimaryKey(tid);
		Assess record = new Assess();
		record.setTender(tid);
		List<Assess> list = assMapper.select(record);
		List<InviteVo> vos = new ArrayList<>();
		for (Assess assess : list) {
			InviteVo vo = new InviteVo();
			vo.setAss(assess);
			vo.setExp(expMapper.selectByPrimaryKey(assess.getExpert()));
			vo.setWinner(supMapper.selectByPrimaryKey(assess.getWinner()));
			vos.add(vo);
		}
		page.setRecords(vos);
		page.setTotalrecord(assMapper.selectCount(record));
		mav.addObject("tender", tender);
		mav.addObject("page", page);
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "confirmtender");
		return mav;
	}
	
	/**
	 * 定标，向各个征集人发送通知，自动发出中标公告
	 * @param tid
	 * @param thid
	 * @return
	 */
	@RequestMapping("confirm")
	public String confirmTender(Integer tid, Integer thid) {
		TenderHistory th = thMapper.selectByPrimaryKey(thid);
		Tender tender = tenderMapper.selectByPrimaryKey(tid);
		th.setStatus(2);
		thMapper.updateByPrimaryKeySelective(th);
		Tender ten =tenderMapper.selectByPrimaryKey(tid);
		ten.setStatus(2);
		tenderMapper.updateByPrimaryKeySelective(ten);
		Supplier luckySup = supMapper.selectByPrimaryKey(th.getBidder());//中标供应商
		saveUnbindMsg2(tender.getProjectName(), tid, luckySup.getSupplierId());//插入中标通知消息
		TenderHistory record = new TenderHistory();
		record.setTendering(tid);
		List<TenderHistory> allHistory = thMapper.select(record);
		for (TenderHistory th2 : allHistory) {
			if(th2.getBidder().equals(luckySup.getSupplierId())) {
				continue;
			}
			th2.setStatus(3);//将其它征集记录做“未中标”记录
			thMapper.updateByPrimaryKeySelective(th2);
			saveUnbindMsg(tender.getProjectName(), tid, th2.getBidder());
		}
		//发中标公告
		Notice notice = new Notice();
		notice.setContent("中标单位："+luckySup.getEntName());
		notice.setNoticeType("中标公告");
		notice.setPublishTime(new Date());
		notice.setSender(entMapper.selectByPrimaryKey(tender.getTenderee()).getEnterpriseName());
		notice.setTitle("《"+tender.getProjectName()+"》中标公告");
		noticeMapper.insertSelective(notice);
		//修改征集项目状态
		tender.setStatus(2);
		tenderMapper.updateByPrimaryKeySelective(tender);
		return "redirect:tender-detail?tid="+tid;
	}
	
	/**
	 * 流标
	 * @param tid
	 * @param thid
	 * @return
	 */
	@RequestMapping("tenderfaild")
	public String tenderFaild(Integer tid) {
		Tender ten =tenderMapper.selectByPrimaryKey(tid);
		ten.setStatus(3);
		tenderMapper.updateByPrimaryKeySelective(ten);
		return "redirect:tender-detail?tid="+tid;
	}
	
	private void saveUnbindMsg(String projectName, Integer tid, Integer supId) {
		SysMsg msg = new SysMsg();
		msg.setAlink("");
		msg.setContent("您征集的项目：《"+projectName+"》，已定标，很遗憾贵司未能中标！");
		msg.setIsRead(-1);
		msg.setMsgTime(new Date());
		msg.setMsgType("TENDER_FAILD");
		msg.setReviever(supId);
		msg.setRemark(tid+"");
		msgMapper.insertSelective(msg);
	}
	
	private void saveUnbindMsg2(String projectName, Integer tid, Integer supId) {
		SysMsg msg = new SysMsg();
		msg.setAlink("");
		msg.setContent("恭喜，您征集的项目：《"+projectName+"》，已中标！");
		msg.setIsRead(-1);
		msg.setMsgTime(new Date());
		msg.setMsgType("TENDER_SUCCESS");
		msg.setReviever(supId);
		msg.setRemark(tid+"");
		msgMapper.insertSelective(msg);
	}
	
	/**
	 * 进入邀请专家页面
	 * @param tid
	 * @return
	 */
	@RequestMapping("inviteexpert")
	public ModelAndView inviteExpertPage(Integer tid) {
		ModelAndView mav = new ModelAndView("ent/expert-list");
		Tender tender = tenderMapper.selectByPrimaryKey(tid);
		AssessInvite ai = new AssessInvite();
		ai.setTender(tid);
		int aicount = aiMapper.selectCount(ai);
		if(aicount == 0) {
			String type = tender.getProjectType();
			Expert record = new Expert();
			record.setExpertType(type);
			List<Expert> list = expMapper.select(record );
			mav.addObject("list", list);
		}
		mav.addObject("aicount", aicount);
		mav.addObject("tender", tender);
		return mav;
	}
	
	@RequestMapping("expdetail")
	public ModelAndView expdetail(Integer eid) {
		ModelAndView mav = new ModelAndView("ent/expert-detail");
		Expert exp = expMapper.selectByPrimaryKey(eid);
		mav.addObject("expert", exp);
		return mav;
	}
	
	/**
	 * 提交邀请表单
	 * @param req
	 * @param tid
	 * @return
	 */
	@RequestMapping("inviteform")
	public String inviteExpert(HttpServletRequest req, Integer tid) {
		Tender tender = tenderMapper.selectByPrimaryKey(tid);
		String[] exps = req.getParameterValues("exps");
		for (String exp : exps) {
			System.out.println("######"+exp);
			AssessInvite ai = new AssessInvite();
			ai.setStatus(0);
			int expid = Integer.valueOf(exp);
			ai.setExpert(expid);
			ai.setTender(tid);
			aiMapper.insertAssessInvite(ai);
			saveAssessMsg(tender.getProjectName(), expid, ai.getAssessInviteId(), tid);
		}
		return "redirect:assessret?tid="+tid;
	}
	
	/**
	 * 进入供应商邀请页面
	 * @param tid
	 * @return
	 */
	@RequestMapping("invitesup")
	public ModelAndView inviteSupPage(Integer tid) {
		ModelAndView mav = new ModelAndView("ent/sup-list");
		Tender tender = tenderMapper.selectByPrimaryKey(tid);
		List<Supplier> list = supMapper.selectAll();
		mav.addObject("tender", tender);
		mav.addObject("list", list);
		return mav;
	}
	
	private void saveAssessMsg(String projectName, Integer exp, Integer iid, Integer tid) {
		SysMsg msg = new SysMsg();
		msg.setAlink("/ssm/exp/toassess?iid="+iid+"&tid="+tid);
		msg.setContent("您好，征集单位邀请您对《"+projectName+"》项目进行征集评估，请查看。");
		msg.setIsRead(-1);
		msg.setMsgTime(new Date());
		msg.setMsgType("ASSESS_INVITE");
		msg.setReviever(exp);
		msg.setRemark(iid+"");
		msgMapper.insertSelective(msg);
	}
	
	/**
	 * 邀请结果
	 * @param req
	 * @param tid
	 * @return
	 */
	@RequestMapping("assessret")
	public ModelAndView assessResult(HttpServletRequest req, Integer tid) {
		ModelAndView mav = new ModelAndView("ent/expert-assess");
		Tender tender = tenderMapper.selectByPrimaryKey(tid);
		AssessInvite record = new AssessInvite();
		record.setTender(tid);
		List<AssessInvite> list = aiMapper.select(record);
		List<Expert> exps = new ArrayList<>();
		for (AssessInvite ai : list) {
			exps.add(expMapper.selectByPrimaryKey(ai.getExpert()));
		}
		mav.addObject("list", exps);
		mav.addObject("tender", tender);
		return mav;
	}
	
	/**
	 * 提交供应商征集邀请表单
	 * @param req
	 * @param tid
	 * @return
	 */
	@RequestMapping("invitesupform")
	public String inviteSupForm(HttpServletRequest req, Integer tid) {
		Tender tender = tenderMapper.selectByPrimaryKey(tid);
		String[] sups = req.getParameterValues("sups");
		List<Integer> ids = new ArrayList<>();
		for (String sup : sups) {
			System.out.println("######"+sup);
			ids.add(Integer.valueOf(sup));
		}
		tenderService.sendTenderInvite(tender, ids);
		return "redirect:assessupsret?tid="+tid;
	}
	
	/**
	 * 邀请供应商征集结果
	 * @param req
	 * @param tid
	 * @return
	 */
	@RequestMapping("assessupsret")
	public ModelAndView assesSupsRet(HttpServletRequest req, Integer tid) {
		ModelAndView mav = new ModelAndView("ent/expert-assess2");
		
		return mav;
	}
	
	@RequestMapping("profile")
	public ModelAndView profile(HttpSession session) {
		ModelAndView mav = new ModelAndView("ent/profile");
		Enterprise ent = (Enterprise) session.getAttribute("currEnt");
		mav.addObject("ent", ent);
		mav.addObject("currMenu0", "profile");
		mav.addObject("currMenu1", "userinfo");
		return mav;
	}
	
	@RequestMapping("tomdfprofile")
	public ModelAndView toMdfProfile(HttpSession session) {
		ModelAndView mav = new ModelAndView("ent/mdfprofile");
		Enterprise ent = (Enterprise) session.getAttribute("currEnt");
		mav.addObject("ent", ent);
		mav.addObject("currMenu0", "profile");
		mav.addObject("currMenu1", "mdfpwd");
		return mav;
	}
	
	@RequestMapping("tomdfpwd")
	public ModelAndView toMdfPwd(HttpSession session) {
		ModelAndView mav = new ModelAndView("ent/mdfpwd");
		Enterprise ent = (Enterprise) session.getAttribute("currEnt");
		mav.addObject("ent", ent);
		mav.addObject("currMenu0", "profile");
		mav.addObject("currMenu1", "mdfpwd");
		return mav;
	}
	
	@RequestMapping("updatepwd")
	public String updatepwd(HttpSession session, String pwd) {
		Enterprise ent = (Enterprise) session.getAttribute("currEnt");
//		ent.setPwd(pwd);
		ent.setPwd(MD5Util.md5Encrypt32Upper(pwd));
		entMapper.updateByPrimaryKeySelective(ent);
		session.setAttribute("currEnt", ent);
		return "redirect:profile";
	}
	
	@RequestMapping("updateent")
	public String updatepwd(HttpSession session, Enterprise ent) {
		entMapper.updateByPrimaryKeySelective(ent);
		session.setAttribute("currEnt", ent);
		return "redirect:profile";
	}
	
	@RequestMapping("noticemgr")
	public ModelAndView noticeMgr(HttpSession session, PageView<Notice> page) {
		ModelAndView mav = new ModelAndView("ent/notice-list");
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
		ModelAndView mav = new ModelAndView("ent/notice-detail");
		Notice notice = noticeMapper.selectByPrimaryKey(tid);
		mav.addObject("notice", notice);
		mav.addObject("currMenu0", "notice");
		mav.addObject("currMenu1", "noticemgr");
		return mav;
	}
	
	@RequestMapping("supdetail")
	public ModelAndView supdetail(Integer eid) {
		ModelAndView mav = new ModelAndView("ent/sup-detail");
		Supplier sup = supMapper.selectByPrimaryKey(eid);
		mav.addObject("sup", sup);
		return mav;
	}
}
