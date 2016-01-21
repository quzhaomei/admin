package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.entity.RequiredAnswerHistoryImg;

public interface RequiredAnswerHistoryImgService {
	void saveHistoryImg(RequiredAnswerHistoryImg historyImg);
	List<RequiredAnswerHistoryImg> getHistoryByUserId(String userId);
	void updateHistoryImg(RequiredAnswerHistoryImg historyImg);
}
