package com.rycf.gjb.service.impl.minisite;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rycf.gjb.dao.DesignApplyDao;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.minisite.DesignApply;
import com.rycf.gjb.service.minisite.DesignApplyService;

@Service
@Transactional
public class DesignApplyServiceImpl implements DesignApplyService{
	@Resource
	private DesignApplyDao applyDao;

	@Override
	public void save(DesignApply apply) throws Exception {
		applyDao.save(apply);
	}

	@Override
	public void update(DesignApply apply) throws Exception {
		applyDao.update(apply);
	}

	@Override
	public PageDTO<List<DesignApply>> findByPage(PageDTO<DesignApply> page) {
		List<DesignApply> dateList = applyDao.getListByPage(page);
		PageDTO<List<DesignApply>> pageDate = new PageDTO<List<DesignApply>>();
		pageDate.setParam(dateList);
		pageDate.setPageIndex(page.getPageIndex());
		pageDate.setPageSize(page.getPageSize());
		Integer count = applyDao.getCountByParam(page.getParam());
		count = count % page.getPageSize() == 0 ? count / page.getPageSize()
				: count / page.getPageSize() + 1;
		pageDate.setTotalPage(count);
		return pageDate;
	}

	@Override
	public DesignApply getByParam(DesignApply apply) {
		return applyDao.getByParam(apply);
	}
	
}
