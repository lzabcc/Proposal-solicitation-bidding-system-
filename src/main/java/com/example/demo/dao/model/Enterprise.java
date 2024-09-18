package com.example.demo.dao.model;

import javax.persistence.Column;
import javax.persistence.Id;

public class Enterprise {
    @Id
    @Column(name = "ent_id")
    private Integer entId;

    @Column(name = "enterprise_name")
    private String enterpriseName;

    @Column(name = "user_name")
    private String userName;

    private String pwd;

    private String tel;

    private String email;

    private String frdb;

    @Column(name = "tax_code")
    private String taxCode;

    @Column(name = "reg_amount")
    private String regAmount;

    private String address;

    private String attachment;

    private Integer status;

    @Column(name = "ent_desc")
    private String entDesc;

    /**
     * @return ent_id
     */
    public Integer getEntId() {
        return entId;
    }

    /**
     * @param entId
     */
    public void setEntId(Integer entId) {
        this.entId = entId;
    }

    /**
     * @return enterprise_name
     */
    public String getEnterpriseName() {
        return enterpriseName;
    }

    /**
     * @param enterpriseName
     */
    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName;
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
     * @return tel
     */
    public String getTel() {
        return tel;
    }

    /**
     * @param tel
     */
    public void setTel(String tel) {
        this.tel = tel;
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
     * @return frdb
     */
    public String getFrdb() {
        return frdb;
    }

    /**
     * @param frdb
     */
    public void setFrdb(String frdb) {
        this.frdb = frdb;
    }

    /**
     * @return tax_code
     */
    public String getTaxCode() {
        return taxCode;
    }

    /**
     * @param taxCode
     */
    public void setTaxCode(String taxCode) {
        this.taxCode = taxCode;
    }

    /**
     * @return reg_amount
     */
    public String getRegAmount() {
        return regAmount;
    }

    /**
     * @param regAmount
     */
    public void setRegAmount(String regAmount) {
        this.regAmount = regAmount;
    }

    /**
     * @return address
     */
    public String getAddress() {
        return address;
    }

    /**
     * @param address
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * @return attachment
     */
    public String getAttachment() {
        return attachment;
    }

    /**
     * @param attachment
     */
    public void setAttachment(String attachment) {
        this.attachment = attachment;
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
     * @return ent_desc
     */
    public String getEntDesc() {
        return entDesc;
    }

    /**
     * @param entDesc
     */
    public void setEntDesc(String entDesc) {
        this.entDesc = entDesc;
    }
}