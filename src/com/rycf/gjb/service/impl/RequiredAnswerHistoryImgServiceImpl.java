package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.RequiredAnswerHistoryImgDao;
import com.rycf.gjb.entity.RequiredAnswerHistoryImg;
import com.rycf.gjb.service.RequiredAnswerHistoryImgService;
import com.rycf.gjb.util.UuidUtils;

@Service
public class RequiredAnswerHistoryImgServiceImpl implements RequiredAnswerHistoryImgService {
	@Resource
	private RequiredAnswerHistoryImgDao historyImgDao;

	@Override
	public void saveHistoryImg(RequiredAnswerHistoryImg historyImg) {
		historyImg.setHistoryImgId(UuidUtils.getImgUUID());
		historyImgDao.saveHistoryImg(historyImg);
	}

	@Override
	public List<RequiredAnswerHistoryImg> getHistoryByUserId(String userId) {
		return historyImgDao.getHistoryByUserId(userId);
	}

	@Override
	public void updateHistoryImg(RequiredAnswerHistoryImg historyImg) {
		historyImgDao.updateHistoryImg(historyImg);
	}
}
