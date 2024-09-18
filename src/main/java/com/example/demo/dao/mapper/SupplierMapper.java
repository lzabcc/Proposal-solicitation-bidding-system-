package com.example.demo.dao.mapper;

import com.example.demo.dao.model.Supplier;
import com.example.demo.utils.MyMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
@Mapper
public interface SupplierMapper extends MyMapper<Supplier> {
	
	Integer insertSupplier(Supplier sup);
	
	List<Supplier> searchSuppliers(@Param("params") Map<String, Object> params);
}