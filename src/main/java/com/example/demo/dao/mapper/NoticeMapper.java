package com.example.demo.dao.mapper;

import com.example.demo.dao.model.Notice;
import com.example.demo.utils.MyMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface NoticeMapper extends MyMapper<Notice> {
	
	List<Notice> searchNotice(@Param("params") Map<String, Object> params);
}