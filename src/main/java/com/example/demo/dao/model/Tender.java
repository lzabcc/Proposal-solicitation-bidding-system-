package com.example.demo.dao.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.util.Date;

public class Tender {
    @Id
    @Column(name = "tender_id")
    private Integer tenderId;

    private Integer tenderee;

    @Column(name = "project_name")
    private String projectName;

    private String incharge;

    private String mobile;

    private String email;

    @Column(name = "project_type")
    private String projectType;

    private String budget;

    @Column(name = "end_time")
    private Date endTime;
    
    @Column(name = "publish_time")
    private Date publishTime;

    private String attachement;

    private Integer status;

    @Column(name = "key_words")
    private String keyWords;

    private Integer winner;

    @Column(name = "project_desc")
    private String projectDesc;
    
    @Column(name = "tender_no")
    private String tenderNo;

    /**
     * @return tender_id
     */
    public Integer getTenderId() {
        return tenderId;
    }

    /**
     * @param tenderId
     */
    public void setTenderId(Integer tenderId) {
        this.tenderId = tenderId;
    }

    /**
     * @return tenderee
     */
    public Integer getTenderee() {
        return tenderee;
    }

    /**
     * @param tenderee
     */
    public void setTenderee(Integer tenderee) {
        this.tenderee = tenderee;
    }

    /**
     * @return project_name
     */
    public String getProjectName() {
        return projectName;
    }

    /**
     * @param projectName
     */
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    /**
     * @return incharge
     */
    public String getIncharge() {
        return incharge;
    }

    /**
     * @param incharge
     */
    public void setIncharge(String incharge) {
        this.incharge = incharge;
    }

    /**
     * @return mobile
     */
    public String getMobile() {
        return mobile;
    }

    /**
     * @param mobile
     */
    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    /**
     * @return email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return project_type
     */
    public String getProjectType() {
        return projectType;
    }

    /**
     * @param projectType
     */
    public void setProjectType(String projectType) {
        this.projectType = projectType;
    }

    /**
     * @return budget
     */
    public String getBudget() {
        return budget;
    }

    /**
     * @param budget
     */
    public void setBudget(String budget) {
        this.budget = budget;
    }

    /**
     * @return end_time
     */
    public Date getEndTime() {
        return endTime;
    }

    /**
     * @param endTime
     */
    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    /**
     * @return attachement
     */
    public String getAttachement() {
        return attachement;
    }

    /**
     * @param attachement
     */
    public void setAttachement(String attachement) {
        this.attachement = attachement;
    }

    /**
     * @return status
     */
    public Integer getStatus() {
        return status;
    }

    /**
     * @param status
     */
    public void setStatus(Integer status) {
        this.status = status;
    }

    /**
     * @return key_words
     */
    public String getKeyWords() {
        return keyWords;
    }

    /**
     * @param keyWords
     */
    public void setKeyWords(String keyWords) {
        this.keyWords = keyWords;
    }

    /**
     * @return winner
     */
    public Integer getWinner() {
        return winner;
    }

    /**
     * @param winner
     */
    public void setWinner(Integer winner) {
        this.winner = winner;
    }

    /**
     * @return project_desc
     */
    public String getProjectDesc() {
        return projectDesc;
    }

    public Date getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(Date publishTime) {
		this.publishTime = publishTime;
	}

	/**
     * @param projectDesc
     */
    public void setProjectDesc(String projectDesc) {
        this.projectDesc = projectDesc;
    }

	public String getTenderNo() {
		return tenderNo;
	}

	public void setTenderNo(String tenderNo) {
		this.tenderNo = tenderNo;
	}
}