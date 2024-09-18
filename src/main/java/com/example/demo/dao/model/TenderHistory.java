package com.example.demo.dao.model;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Table(name = "tender_history")
public class TenderHistory {
    @Id
    @Column(name = "tender_history_id")
    private Integer tenderHistoryId;

    private Integer tendering;

    private Integer tenderee;

    private Integer bidder;

    private String incharge;

    private String contact;

    private String email;

    private String amount;

    @Column(name = "tender_time")
    private Date tenderTime;

    private Integer status;

    private String attachment;

    private String remark;

    /**
     * @return tender_history_id
     */
    public Integer getTenderHistoryId() {
        return tenderHistoryId;
    }

    /**
     * @param tenderHistoryId
     */
    public void setTenderHistoryId(Integer tenderHistoryId) {
        this.tenderHistoryId = tenderHistoryId;
    }

    /**
     * @return tendering
     */
    public Integer getTendering() {
        return tendering;
    }

    /**
     * @param tendering
     */
    public void setTendering(Integer tendering) {
        this.tendering = tendering;
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
     * @return bidder
     */
    public Integer getBidder() {
        return bidder;
    }

    /**
     * @param bidder
     */
    public void setBidder(Integer bidder) {
        this.bidder = bidder;
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
     * @return contact
     */
    public String getContact() {
        return contact;
    }

    /**
     * @param contact
     */
    public void setContact(String contact) {
        this.contact = contact;
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
     * @return amount
     */
    public String getAmount() {
        return amount;
    }

    /**
     * @param amount
     */
    public void setAmount(String amount) {
        this.amount = amount;
    }

    /**
     * @return tender_time
     */
    public Date getTenderTime() {
        return tenderTime;
    }

    /**
     * @param tenderTime
     */
    public void setTenderTime(Date tenderTime) {
        this.tenderTime = tenderTime;
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
     * @return remark
     */
    public String getRemark() {
        return remark;
    }

    /**
     * @param remark
     */
    public void setRemark(String remark) {
        this.remark = remark;
    }
}