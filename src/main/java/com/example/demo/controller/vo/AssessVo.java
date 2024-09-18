package com.example.demo.controller.vo;

import com.example.demo.dao.model.Assess;
import com.example.demo.dao.model.Expert;
import com.example.demo.dao.model.Tender;

public class AssessVo {

	private Assess ass;
	private Expert exp;
	private Tender tender;
	
	public Assess getAss() {
		return ass;
	}
	public void setAss(Assess ass) {
		this.ass = ass;
	}
	public Expert getExp() {
		return exp;
	}
	public void setExp(Expert exp) {
		this.exp = exp;
	}
	public Tender getTender() {
		return tender;
	}
	public void setTender(Tender tender) {
		this.tender = tender;
	}
	
}
