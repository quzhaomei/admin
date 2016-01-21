package com.rycf.gjb.service.minisite;

import java.util.List;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.minisite.DesignApply;

public interface DesignApplyService {
	void save(DesignApply apply) throws Exception;
	void update(DesignApply apply) throws Exception;
	DesignApply getByParam(DesignApply apply);//����������
	PageDTO<List<DesignApply>> findByPage(PageDTO<DesignApply> page);
}
