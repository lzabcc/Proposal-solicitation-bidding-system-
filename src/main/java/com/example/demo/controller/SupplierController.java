package com.example.demo.controller;

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

@RequestMapping("/sup")
@Controller
public class SupplierController {

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
		return "sup/login";
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.removeAttribute("currSup");
		return "redirect:/index";
	}
	
	@RequestMapping("regist")
	public String reg() {
		return "sup/regist";
	}
	
	
	@RequestMapping("loginform")
	public String loginform(HttpSession session, HttpServletRequest req, String username, String pwd) {
		String code=req.getParameter("vercode");
		if (!(code.equalsIgnoreCase(session.getAttribute("code").toString()))) {  //忽略验证码大小写  
			req.setAttribute("msg", "验证码不正确！");
			return "sup/login";
		}
		Supplier record = new Supplier();
		record.setUserName(username);
//		record.setPwd(pwd);
		record.setPwd(MD5Util.md5Encrypt32Upper(pwd));
		List<Supplier> sups = supMapper.select(record );
		if(sups != null && sups.size() > 0) {
			if(sups.get(0).getStatus() == -1) {
				req.setAttribute("msg", "账号未激活，请耐心等待管理员审核。");
				return "sup/login";
			}else {
				session.setAttribute("currSup", sups.get(0));
				return "redirect:home";
			}
		}else {
			req.setAttribute("msg", "用户名或密码错误");
			return "sup/login";
		}
	}
	
	@RequestMapping("checkuser")
	public void checkuser(String username, PrintWriter pw) {
		Supplier record = new Supplier();
		record.setUserName(username);
		List<Supplier> ret = supMapper.select(record);
		if(ret != null && ret.size()>0) {
			pw.write("-1");
		}else {
			pw.write("0");
		}
	}
	
	@RequestMapping("regform")
	public String regform(HttpServletRequest request, @RequestParam("file") MultipartFile file, Supplier sup) {
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
				sup.setAttachment(uuid+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")));
			}
		}
		sup.setStatus(-1);
		sup.setPwd(MD5Util.md5Encrypt32Upper(sup.getPwd()));
		supMapper.insertSupplier(sup);
		SysMsg msg = new SysMsg();
		msg.setAlink("/ssm/admin/sup-detail?tid="+sup.getSupplierId());
		msg.setContent("新注册供应商："+sup.getEntName()+"，请前往激活！");
		msg.setIsRead(-1);
		msg.setMsgTime(new Date());
		msg.setMsgType("NEW_REGIST_SUP");
		msg.setReviever(-1);
		msg.setRemark(sup.getSupplierId()+"");
		msgMapper.insertSelective(msg);
		request.setAttribute("msg", "99");
		return "login";
	}
	
	@RequestMapping("home")
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView("sup/home");
		
		return mav;
	}
	
	@RequestMapping("tenderlist")
	public ModelAndView tenderList(HttpSession session, PageView<TenderVo> page,
                                   @RequestParam(value = "kw", required = false) String kw, @RequestParam(value = "type", required = false) String type) {
		ModelAndView mav = new ModelAndView("sup/tender-list");
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "tenderlist");
		Tender record = new Tender();
		record.setStatus(1);
		Map<String, Object> params = new HashMap<>();
		params.put("start", page.getFirstResult());
		params.put("end", page.getMaxresult());
		if(kw != null) {
			params.put("kw", kw);	
		}
		if(type != null) {
			params.put("type", type);
		}
		params.put("status", 1);
		List<Tender> list = tenderMapper.searchTenders(params);//selectByRowBounds(record, new RowBounds(page.getFirstResult(), page.getMaxresult()));
		List<TenderVo> vos = new ArrayList<>();
		Date today = new Date();
		Iterator<Tender> itr = list.iterator();
		while(itr.hasNext()) {
			Tender ten = itr.next();
			if(ten.getEndTime().before(today)) {
				itr.remove();
				TenderVo vo = new TenderVo();
				vo.setEnt(entMapper.selectByPrimaryKey(ten.getTenderee()));
				vo.setTen(ten);
				vos.add(vo);
			}
		}
//		for (Tender ten : list) {
//			if(ten.getEndTime().before(today)) {
//				ten.setStatus(99);
//			}
//		}
		page.setRecords(vos);
		page.setTotalrecord(tenderMapper.selectCount(record));
		mav.addObject("page", page);
		mav.addObject("kw", kw);
		mav.addObject("type", type);
		return mav;
	}
	
	@RequestMapping("tender-detail")
	public ModelAndView tenderDetail(HttpSession session, Integer tid, @RequestParam(value = "msgid", required = false) Integer msgid) {
		ModelAndView mav = new ModelAndView("sup/tender-detail");
		Tender tender = tenderMapper.selectByPrimaryKey(tid);
		Date today = new Date();
		if(tender.getEndTime().before(today)) {
			tender.setStatus(99);
		}
		mav.addObject("tender", tender);
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "tendermgr");
		if(msgid != null) {
			SysMsg msg = msgMapper.selectByPrimaryKey(msgid);
			msg.setIsRead(1);
			msgMapper.updateByPrimaryKeySelective(msg);
		}
		Supplier sup = (Supplier) session.getAttribute("currSup");
		TenderHistory record = new TenderHistory();
		record.setBidder(sup.getSupplierId());
		record.setTendering(tid);
		int thcount = thMapper.selectCount(record);
		mav.addObject("thcount", thcount);
		return mav;
	}
	
	/**
	 * 进入征集页面
	 * @param session
	 * @return
	 */
	@RequestMapping("toapp")
	public ModelAndView toApplyPage(Integer tid, HttpSession session) {
		ModelAndView mav = new ModelAndView("sup/tender-app");
		Supplier sup = (Supplier) session.getAttribute("currSup");
		Tender ten = tenderMapper.selectByPrimaryKey(tid);
		TenderVo vo = new TenderVo();
		vo.setEnt(entMapper.selectByPrimaryKey(ten.getTenderee()));
		vo.setTen(ten);
		mav.addObject("vo", vo);
		mav.addObject("sup", sup);
		return mav;
	}
	
	/**
	 * 征集
	 * @param th
	 * @param session
	 * @return
	 */
	@RequestMapping("apply")
	public String applyTender(HttpServletRequest request, @RequestParam("file") MultipartFile file, TenderHistory th) {
		ModelAndView mav = new ModelAndView("sup/tender-list");
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
				th.setAttachment(uuid+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")));
			}
		}
		th.setTenderTime(new Date());
		thMapper.insertSelective(th);
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "tendermgr");
		return "redirect:myapply";
	}
	
	/**
	 * 我的征集记录
	 * @param session
	 * @return
	 */
	@RequestMapping("myapply")
	public ModelAndView myApply(HttpSession session, PageView<TenderVo> page) {
		ModelAndView mav = new ModelAndView("sup/tender-history");
		Supplier sup = (Supplier) session.getAttribute("currSup");
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "myapply");
		TenderHistory record = new TenderHistory();
		record.setBidder(sup.getSupplierId());
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
				vo.setTen(tenderMapper.selectByPrimaryKey(th.getTendering()));
				vos.add(vo);
		}
		page.setRecords(vos);
		page.setTotalrecord(thMapper.selectCount(record));
		mav.addObject("page", page);
		return mav;
	}
	
	/**
	 * 征集详情
	 * @param session
	 * @param thid
	 * @return
	 */
	@RequestMapping("appdetail")
	public ModelAndView appdetail(HttpSession session, Integer thid) {
		ModelAndView mav = new ModelAndView("sup/tender-history-detail");
		TenderHistory th = thMapper.selectByPrimaryKey(thid);
		System.out.println(th.getStatus());
		TenderVo vo = new TenderVo();
		vo.setEnt(entMapper.selectByPrimaryKey(th.getTenderee()));
		vo.setTh(th);
		vo.setTen(tenderMapper.selectByPrimaryKey(th.getTendering()));
		mav.addObject("vo", vo);
		mav.addObject("currMenu0", "tender");
		mav.addObject("currMenu1", "myapply");
		return mav;
	}
	
	@RequestMapping("updateth")
	public String updateThenderHistory(TenderHistory th) {
		thMapper.updateByPrimaryKeySelective(th);
		return "redirect:appdetail?thid="+th.getTenderHistoryId();
	}
	
	@RequestMapping("profile")
	public ModelAndView profile(HttpSession session) {
		ModelAndView mav = new ModelAndView("sup/profile");
		Supplier sup = (Supplier) session.getAttribute("currSup");
		mav.addObject("sup", sup);
		mav.addObject("currMenu0", "profile");
		mav.addObject("currMenu1", "userinfo");
		return mav;
	}
	
	@RequestMapping("tomdfpwd")
	public ModelAndView toMdfPwd(HttpSession session) {
		ModelAndView mav = new ModelAndView("sup/mdfpwd");
		Supplier sup = (Supplier) session.getAttribute("currSup");
		mav.addObject("sup", sup);
		mav.addObject("currMenu0", "profile");
		mav.addObject("currMenu1", "mdfpwd");
		return mav;
	}
	
	@RequestMapping("updatepwd")
	public String updatepwd(HttpSession session, String pwd) {
		Supplier sup = (Supplier) session.getAttribute("currSup");
//		sup.setPwd(pwd);
		sup.setPwd(MD5Util.md5Encrypt32Upper(pwd));
		supMapper.updateByPrimaryKeySelective(sup);
		session.setAttribute("currSup", sup);
		return "redirect:profile";
	}
	
	@RequestMapping("updatesup")
	public String updateSup(HttpSession session, Supplier sup) {
		supMapper.updateByPrimaryKeySelective(sup);
		session.setAttribute("currSup", sup);
		return "redirect:profile";
	}

	@RequestMapping("sysmsg")
	public ModelAndView sysmsg(HttpSession session, PageView<SysMsg> page, String msgType) {
		ModelAndView mav = new ModelAndView("sup/msg-list");
		Supplier sup = (Supplier) session.getAttribute("currSup");
		if("TENDER_RESULT".equals(msgType)) {
			List<SysMsg> msg = msgMapper.selectTenderResult(sup.getSupplierId(), page.getFirstResult(), page.getMaxresult());
			page.setRecords(msg);
			page.setTotalrecord(msgMapper.selectTenderResultCount(sup.getSupplierId()));
		}else {
			SysMsg record = new SysMsg();
			record.setMsgType(msgType);
			record.setReviever(sup.getSupplierId());
			List<SysMsg> msg = msgMapper.selectByRowBounds(record , new RowBounds(page.getFirstResult(), page.getMaxresult()));
			page.setRecords(msg);
			page.setTotalrecord(msgMapper.selectCount(record));
		}
		mav.addObject("page", page);
		return mav;
	}
	
	@RequestMapping("noticemgr")
	public ModelAndView noticeMgr(HttpSession session, PageView<Notice> page) {
		ModelAndView mav = new ModelAndView("sup/notice-list");
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
		ModelAndView mav = new ModelAndView("sup/notice-detail");
		Notice notice = noticeMapper.selectByPrimaryKey(tid);
		mav.addObject("notice", notice);
		mav.addObject("currMenu0", "notice");
		mav.addObject("currMenu1", "noticemgr");
		return mav;
	}
}
