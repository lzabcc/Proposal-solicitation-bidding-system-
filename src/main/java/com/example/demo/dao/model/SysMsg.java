package com.example.demo.dao.model;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Table(name = "sys_msg")
public class SysMsg {
    @Id
    @Column(name = "sys_msg_id")
    private Integer sysMsgId;

    @Column(name = "msg_time")
    private Date msgTime;

    @Column(name = "msg_type")
    private String msgType;

    private Integer reviever;

    @Column(name = "is_read")
    private Integer isRead;

    private String content;
    
    private String alink;
    
    private String remark;

    /**
     * @return sys_msg_id
     */
    public Integer getSysMsgId() {
        return sysMsgId;
    }

    /**
     * @param sysMsgId
     */
    public void setSysMsgId(Integer sysMsgId) {
        this.sysMsgId = sysMsgId;
    }

    /**
     * @return msg_time
     */
    public Date getMsgTime() {
        return msgTime;
    }

    /**
     * @param msgTime
     */
    public void setMsgTime(Date msgTime) {
        this.msgTime = msgTime;
    }

    /**
     * @return msg_type
     */
    public String getMsgType() {
        return msgType;
    }

    /**
     * @param msgType
     */
    public void setMsgType(String msgType) {
        this.msgType = msgType;
    }

    /**
     * @return reviever
     */
    public Integer getReviever() {
        return reviever;
    }

    /**
     * @param reviever
     */
    public void setReviever(Integer reviever) {
        this.reviever = reviever;
    }

    /**
     * @return is_read
     */
    public Integer getIsRead() {
        return isRead;
    }

    /**
     * @param isRead
     */
    public void setIsRead(Integer isRead) {
        this.isRead = isRead;
    }

    /**
     * @return content
     */
    public String getContent() {
        return content;
    }

    /**
     * @param content
     */
    public void setContent(String content) {
        this.content = content;
    }

	public String getAlink() {
		return alink;
	}

	public void setAlink(String alink) {
		this.alink = alink;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}