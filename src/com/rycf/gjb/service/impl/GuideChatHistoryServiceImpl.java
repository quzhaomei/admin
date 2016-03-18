package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rycf.gjb.dao.GuideChatHistoryDao;
import com.rycf.gjb.dto.GuideChatHistoryDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.GuideChatHistory;
import com.rycf.gjb.service.GuideChatHistoryService;

@Service
@Transactional
public class GuideChatHistoryServiceImpl implements GuideChatHistoryService{
	@Resource
	private GuideChatHistoryDao historyDao;
	@Override
	public void save(GuideChatHistory guide) {
		historyDao.save(guide);
	}

	@Override
	public void update(GuideChatHistory guide) {
		historyDao.update(guide);
	}

	@Override
	public GuideChatHistoryDTO getById(Integer id) {
		return historyDao.getById(id);
	}

	@Override
	public PageDTO<List<GuideChatHistoryDTO>> loadByParam(
			PageDTO<GuideChatHistory> page) {
		List<GuideChatHistoryDTO> data=historyDao.loadByParam(page);
		PageDTO<List<GuideChatHistoryDTO>> result=new PageDTO<List<GuideChatHistoryDTO>>();
		result.setPageIndex(page.getPageIndex());
		result.setParam(data);
		result.setPageSize(page.getPageSize());
		int count=historyDao.loadCountByParam(page.getParam());
		count=count%page.getPageSize()==0?count/page.getPageSize():count/page.getPageSize()+1;
		result.setTotalPage(count);
		return result;
	}

	@Override
	public List<GuideChatHistoryDTO> loadListByParam(GuideChatHistory history) {
		return historyDao.loadListByParam(history);
	}

	@Override
	public int loadCountByParam(PageDTO<GuideChatHistory> page) {
		int count=historyDao.loadCountByParam(page.getParam());
		count=count%page.getPageSize()==0?count/page.getPageSize():count/page.getPageSize()+1;
		return count;
	}

	@Override
	public int loadUncheckCountByParam(GuideChatHistory history) {
		return historyDao.loadUncheckCountByParam(history);
	}

}
