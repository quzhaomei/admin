package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rycf.gjb.dao.ThirdGuideDao;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.ThirdGuideCustomDTO;
import com.rycf.gjb.dto.ThirdGuideDTO;
import com.rycf.gjb.dto.ThirdGuideHistoryDTO;
import com.rycf.gjb.entity.ThirdGuide;
import com.rycf.gjb.service.ThirdGuideService;

@Service
@Transactional
public class ThirdGuideServiceImpl implements ThirdGuideService {
	@Resource
	private ThirdGuideDao guideDao;

	@Override
	public void save(ThirdGuide guide) {
		guideDao.save(guide);
	}

	@Override
	public void update(ThirdGuide guide) {
		guideDao.update(guide);
	}

	@Override
	public ThirdGuideDTO getById(Integer id) {
		return guideDao.getById(id);
	}

	@Override
	public ThirdGuideDTO getByGetMoreId(Integer getMoreId) {
		return guideDao.getByGetMoreId(getMoreId);
	}

	@Override
	public PageDTO<List<ThirdGuideDTO>> getByPageAndParam(
			PageDTO<ThirdGuide> page) {
		List<ThirdGuideDTO> resultList = guideDao.getByPageAndParam(page);
		PageDTO<List<ThirdGuideDTO>> result = new PageDTO<List<ThirdGuideDTO>>();
		result.setParam(resultList);
		result.setPageIndex(page.getPageIndex());
		result.setPageSize(page.getPageSize());
		
		
		int count = guideDao.getCountByParam(page.getParam());
		count = (count % page.getPageSize() == 0 ? count / page.getPageSize()
				: count / page.getPageSize() + 1);
		result.setTotalPage(count);
		return result;
	}

	@Override
	public List<ThirdGuideDTO> getList(ThirdGuide guide) {
		return guideDao.getListByParam(guide);
	}

	@Override
	public int getCountByParam(ThirdGuide guide) {
		return guideDao.getCountByParam(guide);
	}

	@Override
	public List<ThirdGuideCustomDTO> getCustomByGuideId(Integer guideId) {
		return guideDao.getCustomByGuideId(guideId);
	}

	@Override
	public int getCustomCountByGuideId(Integer guideId) {
		return guideDao.getCustomCountByGuideId(guideId);
	}

	@Override
	public int getTalkCountByGetMoreId(Integer getMoreId) {
		return guideDao.getTalkCountByGetMoreId(getMoreId);
	}

	@Override
	public int check(Integer getMoreId, Integer guideId) {
		return guideDao.check(getMoreId, guideId);
	}

	@Override
	public int checkByBrandId(Integer getMoreId, String brandId) {
		return guideDao.checkByBrandId(getMoreId, brandId);
	}

	@Override
	public void userSetGuide(Integer getMoreId, Integer guideId) {
		guideDao.userSetGuide(getMoreId, guideId);
	}

	@Override
	public List<ThirdGuideHistoryDTO> getHistoryGuideId(Integer getMoreId) {
		return guideDao.getHistoryGuideId(getMoreId);
	}

	@Override
	public List<ThirdGuideDTO> getGuideByUserId(Integer getmoreId) {
		return guideDao.getGuideByUserId(getmoreId);
	}

	@Override
	public int getQuestionCountByGetMoreId(Integer getMoreId) {
		return guideDao.getQuestionCountByGetMoreId(getMoreId);
	}

	@Override
	public List<ThirdGuideHistoryDTO> getHistoryGetMoreId(Integer getMoreId) {
		return guideDao.getHistoryGetMoreId(getMoreId);
	}

	@Override
	public int getUncheckTalkCountByGetMoreId(Integer getMoreId) {
		return guideDao.getUncheckTalkCountByGetMoreId(getMoreId);
	}

	@Override
	public int getUncheckQuestionCountByGetMoreId(Integer getMoreId) {
		return guideDao.getUncheckQuestionCountByGetMoreId(getMoreId);
	}

}
