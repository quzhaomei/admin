package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rycf.gjb.dao.ThirdGuideDao;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.ThirdGuideCustomDTO;
import com.rycf.gjb.dto.ThirdGuideDTO;
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

}
