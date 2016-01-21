package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.entity.RequiredAnswerHistoryImg;

public interface RequiredAnswerHistoryImgDao {
	void saveHistoryImg(@Param(value="historyImg") RequiredAnswerHistoryImg historyImg);
	List<RequiredAnswerHistoryImg> getHistoryByUserId(@Param(value="userId")String userId);
	void updateHistoryImg(@Param(value="historyImg")RequiredAnswerHistoryImg historyImg);
}
