package com.example.demo.dao.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.util.Date;

public class Notice {
    @Id
    @Column(name = "notice_id")
    private Integer noticeId;

    private String title;

    @Column(name = "notice_type")
    private String noticeType;

    @Column(name = "publish_time")
    private Date publishTime;

    private String sender;

    private String content;

    /**
     * @return notice_id
     */
    public Integer getNoticeId() {
        return noticeId;
    }

    /**
     * @param noticeId
     */
    public void setNoticeId(Integer noticeId) {
        this.noticeId = noticeId;
    }

    /**
     * @return title
     */
    public String getTitle() {
        return title;
    }

    /**
     * @param title
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * @return notice_type
     */
    public String getNoticeType() {
        return noticeType;
    }

    /**
     * @param noticeType
     */
    public void setNoticeType(String noticeType) {
        this.noticeType = noticeType;
    }

    /**
     * @return publish_time
     */
    public Date getPublishTime() {
        return publishTime;
    }

    /**
     * @param publishTime
     */
    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    /**
     * @return sender
     */
    public String getSender() {
        return sender;
    }

    /**
     * @param sender
     */
    public void setSender(String sender) {
        this.sender = sender;
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