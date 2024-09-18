package com.example.demo.dao.mapper;


import com.example.demo.dao.model.AssessInvite;
import com.example.demo.utils.MyMapper;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AssessInviteMapper extends MyMapper<AssessInvite> {
	
	int insertAssessInvite(AssessInvite ai);
}