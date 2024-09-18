package com.example.demo.dao.mapper;


import com.example.demo.dao.model.Admin;
import com.example.demo.utils.MyMapper;
import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface AdminMapper extends MyMapper<Admin> {
}