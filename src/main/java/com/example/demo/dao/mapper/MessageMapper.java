package com.example.demo.dao.mapper;


import com.example.demo.dao.model.Message;
import com.example.demo.utils.MyMapper;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MessageMapper extends MyMapper<Message> {
}