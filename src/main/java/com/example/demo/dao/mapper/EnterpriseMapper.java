package com.example.demo.dao.mapper;

import com.example.demo.dao.model.Enterprise;
import com.example.demo.utils.MyMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
@Mapper
public interface EnterpriseMapper extends MyMapper<Enterprise> {
	
	Integer insertEnterprise(Enterprise ent);
	
	List<Enterprise> searchEnterprise(@Param("params") Map<String, Object> params);
}