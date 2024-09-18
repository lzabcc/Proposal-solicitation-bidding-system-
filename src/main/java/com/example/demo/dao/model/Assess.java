package com.example.demo.dao.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.util.Date;

public class Assess {
    @Id
    @Column(name = "assess_id")
    private Integer assessId;

    private Integer tender;

    private Integer expert;

    private Integer winner;

    @Column(name = "assess_time")
    private Date assessTime;

    private String reason;

    private String score1;

    private String score2;

    private String score3;

    private String score4;



    /**
     * @return assess_id
     */
    public Integer getAssessId() {
        return assessId;
    }

    /**
     * @param assessId
     */
    public void setAssessId(Integer assessId) {
        this.assessId = assessId;
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
     * @return assess_time
     */
    public Date getAssessTime() {
        return assessTime;
    }

    /**
     * @param assessTime
     */
    public void setAssessTime(Date assessTime) {
        this.assessTime = assessTime;
    }

    /**
     * @return reason
     */
    public String getReason() {
        return reason;
    }

    /**
     * @param reason
     */
    public void setReason(String reason) {
        this.reason = reason;
    }


    public String getScore1() {
        return score1;
    }

    public void setScore1(String score1) {
        this.score1 = score1;
    }

    public String getScore2() {
        return score2;
    }

    public void setScore2(String score2) {
        this.score2 = score2;
    }

    public String getScore3() {
        return score3;
    }

    public void setScore3(String score3) {
        this.score3 = score3;
    }

    public String getScore4() {
        return score4;
    }

    public void setScore4(String score4) {
        this.score4 = score4;
    }
}