package com.example.demo.dao.mapper;

import com.example.demo.dao.model.SysMsg;
import com.example.demo.utils.MyMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SysMsgMapper extends MyMapper<SysMsg> {
	
	List<SysMsg> selectAdminMsg(@Param("msgType") String msgType, @Param("start") Integer start, @Param("end") Integer end);
	
	List<SysMsg> selectMsg(@Param("msgType") String msgType, @Param("uid") Integer uid, @Param("start") Integer start, @Param("end") Integer end);
	
	List<SysMsg> selectTenderResult(@Param("uid") Integer uid, @Param("start") Integer start, @Param("end") Integer end);
	
	Integer selectTenderResultCount(@Param("uid") Integer uid);
}