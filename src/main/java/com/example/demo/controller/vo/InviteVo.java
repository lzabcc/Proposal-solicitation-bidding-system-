package com.example.demo.controller.vo;


import com.example.demo.dao.model.*;

public class InviteVo {

	private AssessInvite invite;
	private Enterprise ent;
	private Tender ten;
	private Assess ass;
	private Supplier winner;
	private Expert exp;
	
	public AssessInvite getInvite() {
		return invite;
	}
	public void setInvite(AssessInvite invite) {
		this.invite = invite;
	}
	public Enterprise getEnt() {
		return ent;
	}
	public void setEnt(Enterprise ent) {
		this.ent = ent;
	}
	public Tender getTen() {
		return ten;
	}
	public void setTen(Tender ten) {
		this.ten = ten;
	}
	public Assess getAss() {
		return ass;
	}
	public void setAss(Assess ass) {
		this.ass = ass;
	}
	public Supplier getWinner() {
		return winner;
	}
	public void setWinner(Supplier winner) {
		this.winner = winner;
	}
	public Expert getExp() {
		return exp;
	}
	public void setExp(Expert exp) {
		this.exp = exp;
	}
	
}
