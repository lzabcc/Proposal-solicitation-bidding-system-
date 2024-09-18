package com.example.demo.dao.mapper;

import com.example.demo.dao.model.Tender;
import com.example.demo.utils.MyMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Mapper
public interface TenderMapper extends MyMapper<Tender> {
	
	Integer insertTender(Tender ten);
	
	List<Tender> selectConfirmTenders(@Param("params") Map<String, Object> params);
	
	List<Tender> selectTendersDay(@Param("sdate") Date sdate, @Param("edate") Date edate);
	
	List<Tender> searchTenders(@Param("params") Map<String, Object> params);
	
	Integer searchTendersCount(@Param("params") Map<String, Object> params);
}