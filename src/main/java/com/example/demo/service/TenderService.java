package com.example.demo.service;


import com.example.demo.dao.model.Tender;

import java.util.List;

public interface TenderService {

	/**
	 * 征集项目审核通过后，向相关供应商企业发送征集邀请
	 * @param tender
	 */
	void sendTenderInvite(Tender tender);
	
	void sendTenderInvite(Tender tender, List<Integer> supids);
}
