package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.GuideChatHistoryDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.GuideChatHistory;

public interface GuideChatHistoryService {
	void save( GuideChatHistory guide);
	void update(GuideChatHistory guide);
	GuideChatHistoryDTO getById( Integer id);
	
	PageDTO<List<GuideChatHistoryDTO>> loadByParam(PageDTO<GuideChatHistory> page);
	int loadCountByParam(PageDTO<GuideChatHistory> page);
	
	int loadUncheckCountByParam(GuideChatHistory history);
	
	List<GuideChatHistoryDTO> loadListByParam(GuideChatHistory history);
}
