package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.minisite.DesignApply;

public interface DesignApplyDao {
	void save(@Param("apply")DesignApply apply);//增
	void update(@Param("apply")DesignApply apply);//改
	DesignApply getByParam(@Param("apply")DesignApply apply);//按条件索引
	List<DesignApply> getListByPage(@Param("page")PageDTO<DesignApply> page);//查询数组
	int getCountByParam(@Param("apply")DesignApply apply);//查询数量
}
