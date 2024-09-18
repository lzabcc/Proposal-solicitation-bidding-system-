package com.example.demo.service.impl;

import com.example.demo.dao.mapper.SupplierMapper;
import com.example.demo.dao.mapper.SysMsgMapper;
import com.example.demo.dao.model.Supplier;
import com.example.demo.dao.model.SysMsg;
import com.example.demo.dao.model.Tender;
import com.example.demo.service.TenderService;
import com.example.demo.utils.TFIDF;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;



/**
 * 征集项目审核通过后，向相关供应商企业发送征集邀请
 * @author
 *
 */
@Service
public class TenderServiceImpl implements TenderService {

	@Autowired
	private SupplierMapper supMapper;
	@Autowired
	private SysMsgMapper msgMapper;
	
	public final static String direction = "工程 市政 桥梁 道路 软件 系统 终端 物业 家政 财务 采购";
    public final static String text = "你好！请问你叫什么名字？你好你好名字";

    public static void main(String[] args) {
        List<String> dir = TFIDF.spliteBySpace(direction);
        //测试关键字
        List<String> seg = TFIDF.segmenter(dir, 
        		"员工手机打卡考勤软件系统，做成B/S架构软件，可以用手机H5以及钉钉访问的软件系统");
        List<String> key = TFIDF.getKeys(seg, 3);
        printList(key);
    }

    public static void printList(List<?> list){
        Iterator iterator = list.iterator();
        while (iterator.hasNext()){
            System.out.print(iterator.next() + ",");
        }
    }

    public static void printMap(Map<?, ?> map){
        Iterator keyIterator = map.keySet().iterator();
        Iterator valueIterator = map.values().iterator();
        while (keyIterator.hasNext()){
            System.out.println(keyIterator.next() + ":" + valueIterator.next());
        }
    }
	
	/**
	 * 征集项目审核通过后，向相关供应商企业发送征集邀请
	 */
    public void sendTenderInvite2(Tender tender) {
    	List<String> dir = TFIDF.spliteBySpace(direction);
        List<String> seg = TFIDF.segmenter(dir, tender.getProjectDesc());//传入项目描述文本进行关键词分割
        List<String> keywords = TFIDF.getKeys(seg, 2);//获取出现频率最高的两个关键词，得到关键词集合
		//从数据库读取所有供应商，准备做迭代匹配
		List<Supplier> sups = supMapper.selectAll();
		Set<Integer> checked = new HashSet<>();//防止两次循环重复发送邀请
		//外层循环：迭代所有供应商
		for (Supplier sup : sups) {
			//内层循环：迭代前面的项目关键字列表
			for (String kw : keywords) {
				System.out.println("###########关键词："+kw);
				//判断供应商简介中，是否包含有项目关键字，如果有，进入if代码块
				if(sup.getEntDesc().contains(kw)) {
					//判断一下该供应商是否已经迭代过，如果不做判断判断，可能会现现两次邀请推送
					if(checked.contains(sup.getSupplierId())) {
						//由于Set集合中，元素是不重复的，利用这一特性可以实现去重
						continue;
					}
					//开始创建系统消息实体类
					SysMsg msg = new SysMsg();
					//生成系统消息中的“查看详情”按钮对应的超链接，当供应商点
					msg.setAlink("/ssm/sup/tender-detail?tid="+tender.getTenderId());
					//消息内容
					msg.setContent("收到《"+tender.getProjectName()+"》征集邀请，请查看。");
					msg.setIsRead(-1);//设置消息为未读状态 
					msg.setMsgTime(new Date());//消息日期
					msg.setMsgType("TENDER_INVITE");//消息类型
					msg.setReviever(sup.getSupplierId());//接收者，设置为当前匹配到的供应商
					msg.setRemark(sup.getSupplierId()+"");//备注字段，设置为供应商，便于查找系统消息表时，区分于其它角色
					msgMapper.insertSelective(msg);//将系统消息插入数据库
					checked.add(sup.getSupplierId());//设置当前供应商已经迭代过
				}
			}
		}
	}
	
	public void sendTenderInvite(Tender tender) {
		//获取征集项目中的“关键字”字段，以空格作为分隔符切割成数组
		String[] kws = tender.getKeyWords().split(" ");
		//从数据库读取所有供应商，准备做迭代匹配
		List<Supplier> sups = supMapper.selectAll();
		Set<Integer> checked = new HashSet<>();//防止两次循环重复发送邀请
		//外层循环：迭代所有供应商
		for (Supplier sup : sups) {
			//内层循环：迭代前面的项目关键字列表
			for (String kw : kws) {
				//判断供应商简介中，是否包含有项目关键字，如果有，进入if代码块
				if(sup.getEntDesc().contains(kw)) {
					//判断一下该供应商是否已经迭代过，如果不做判断判断，可能会现现两次邀请推送
					if(checked.contains(sup.getSupplierId())) {
						//由于Set集合中，元素是不重复的，利用这一特性可以实现去重
						continue;
					}
					//开始创建系统消息实体类
					SysMsg msg = new SysMsg();
					//生成系统消息中的“查看详情”按钮对应的超链接，当供应商点
					msg.setAlink("/ssm/sup/tender-detail?tid="+tender.getTenderId());
					//消息内容
					msg.setContent("收到《"+tender.getProjectName()+"》征集邀请，请查看。");
					msg.setIsRead(-1);//设置消息为未读状态 
					msg.setMsgTime(new Date());//消息日期
					msg.setMsgType("TENDER_INVITE");//消息类型
					msg.setReviever(sup.getSupplierId());//接收者，设置为当前匹配到的供应商
					msg.setRemark(sup.getSupplierId()+"");//备注字段，设置为供应商，便于查找系统消息表时，区分于其它角色
					msgMapper.insertSelective(msg);//将系统消息插入数据库
					checked.add(sup.getSupplierId());//设置当前供应商已经迭代过
				}
			}
		}
	}

	@Override
	public void sendTenderInvite(Tender tender, List<Integer> supids) {
		for(Integer sid:supids) {
			Supplier sup = supMapper.selectByPrimaryKey(sid);
			SysMsg msg = new SysMsg();
			msg.setAlink("/ssm/sup/tender-detail?tid="+tender.getTenderId());
			msg.setContent("收到《"+tender.getProjectName()+"》征集邀请，请查看。");
			msg.setIsRead(-1);
			msg.setMsgTime(new Date());
			msg.setMsgType("TENDER_INVITE");
			msg.setReviever(sup.getSupplierId());
			msg.setRemark(sup.getSupplierId()+"");
			msgMapper.insertSelective(msg);
		}
	}

}
