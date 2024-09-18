package com.example.demo.dao.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.util.Date;

public class Message {
    @Id
    @Column(name = "msg_id")
    private Integer msgId;

    @Column(name = "send_time")
    private Date sendTime;

    @Column(name = "msg_type")
    private String msgType;

    private Integer sender;

    private Integer receiver;

    @Column(name = "is_read")
    private Integer isRead;

    private String content;

    /**
     * @return msg_id
     */
    public Integer getMsgId() {
        return msgId;
    }

    /**
     * @param msgId
     */
    public void setMsgId(Integer msgId) {
        this.msgId = msgId;
    }

    /**
     * @return send_time
     */
    public Date getSendTime() {
        return sendTime;
    }

    /**
     * @param sendTime
     */
    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
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
     * @return sender
     */
    public Integer getSender() {
        return sender;
    }

    /**
     * @param sender
     */
    public void setSender(Integer sender) {
        this.sender = sender;
    }

    /**
     * @return receiver
     */
    public Integer getReceiver() {
        return receiver;
    }

    /**
     * @param receiver
     */
    public void setReceiver(Integer receiver) {
        this.receiver = receiver;
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
}