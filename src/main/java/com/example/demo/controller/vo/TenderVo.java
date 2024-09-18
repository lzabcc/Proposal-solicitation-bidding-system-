package com.example.demo.controller.vo;


import com.example.demo.dao.model.Enterprise;
import com.example.demo.dao.model.Supplier;
import com.example.demo.dao.model.Tender;
import com.example.demo.dao.model.TenderHistory;

public class TenderVo {

	private Tender ten;
	private TenderHistory th;
	private Enterprise ent;
	private Supplier sup;
	
	public TenderHistory getTh() {
		return th;
	}
	public void setTh(TenderHistory th) {
		this.th = th;
	}
	public Tender getTen() {
		return ten;
	}
	public void setTen(Tender ten) {
		this.ten = ten;
	}
	public Enterprise getEnt() {
		return ent;
	}
	public void setEnt(Enterprise ent) {
		this.ent = ent;
	}
	public Supplier getSup() {
		return sup;
	}
	public void setSup(Supplier sup) {
		this.sup = sup;
	}
	
}
