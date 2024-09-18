package com.example.demo.dao.model;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "assess_invite")
public class AssessInvite {
    @Id
    @Column(name = "assess_invite_id")
    private Integer assessInviteId;

    private Integer tender;

    private Integer expert;
    
    private Integer status;

    /**
     * @return assess_invite_id
     */
    public Integer getAssessInviteId() {
        return assessInviteId;
    }

    /**
     * @param assessInviteId
     */
    public void setAssessInviteId(Integer assessInviteId) {
        this.assessInviteId = assessInviteId;
    }

    /**
     * @return tender
     */
    public Integer getTender() {
        return tender;
    }

    /**
     * @param tender
     */
    public void setTender(Integer tender) {
        this.tender = tender;
    }

    /**
     * @return expert
     */
    public Integer getExpert() {
        return expert;
    }

    /**
     * @param expert
     */
    public void setExpert(Integer expert) {
        this.expert = expert;
    }

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
}