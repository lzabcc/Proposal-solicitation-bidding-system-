package com.example.demo.dao.model;

import javax.persistence.Column;
import javax.persistence.Id;

public class Expert {
    @Id
    @Column(name = "expert_id")
    private Integer expertId;

    @Column(name = "user_name")
    private String userName;

    private String pwd;

    @Column(name = "real_name")
    private String realName;

    @Column(name = "expert_title")
    private String expertTitle;

    @Column(name = "expert_type")
    private String expertType;

    private String major;
    
    private String mobile;
    
    private String company;
    
    private String birth;

    @Column(name = "expert_desc")
    private String expertDesc;

    /**
     * @return expert_id
     */
    public Integer getExpertId() {
        return expertId;
    }

    /**
     * @param expertId
     */
    public void setExpertId(Integer expertId) {
        this.expertId = expertId;
    }

    /**
     * @return user_name
     */
    public String getUserName() {
        return userName;
    }

    /**
     * @param userName
     */
    public void setUserName(String userName) {
        this.userName = userName;
    }

    /**
     * @return pwd
     */
    public String getPwd() {
        return pwd;
    }

    /**
     * @param pwd
     */
    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    /**
     * @return real_name
     */
    public String getRealName() {
        return realName;
    }

    /**
     * @param realName
     */
    public void setRealName(String realName) {
        this.realName = realName;
    }

    /**
     * @return expert_title
     */
    public String getExpertTitle() {
        return expertTitle;
    }

    /**
     * @param expertTitle
     */
    public void setExpertTitle(String expertTitle) {
        this.expertTitle = expertTitle;
    }

    /**
     * @return expert_type
     */
    public String getExpertType() {
        return expertType;
    }

    /**
     * @param expertType
     */
    public void setExpertType(String expertType) {
        this.expertType = expertType;
    }

    /**
     * @return major
     */
    public String getMajor() {
        return major;
    }

    /**
     * @param major
     */
    public void setMajor(String major) {
        this.major = major;
    }

    /**
     * @return expert_desc
     */
    public String getExpertDesc() {
        return expertDesc;
    }

    /**
     * @param expertDesc
     */
    public void setExpertDesc(String expertDesc) {
        this.expertDesc = expertDesc;
    }

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}
}