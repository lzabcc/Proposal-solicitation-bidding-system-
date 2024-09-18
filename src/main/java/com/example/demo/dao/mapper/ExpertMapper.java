package com.example.demo.dao.mapper;

import com.example.demo.dao.model.Expert;
import com.example.demo.utils.MyMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
@Mapper
public interface ExpertMapper extends MyMapper<Expert> {
	
	List<Expert> searchExperts(@Param("params") Map<String, Object> params);
}