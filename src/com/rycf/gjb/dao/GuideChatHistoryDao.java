package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.GuideChatHistoryDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.GuideChatHistory;

public interface GuideChatHistoryDao {
	void save(@Param(value = "history") GuideChatHistory guide);
	void update(@Param(value = "history") GuideChatHistory guide);
	GuideChatHistoryDTO getById(@Param(value = "id") Integer id);
	/**
	 * 加载历史聊天记录 
	 */
	List<GuideChatHistoryDTO> loadByParam(@Param(value = "page")PageDTO<GuideChatHistory> page);
	int loadCountByParam(@Param(value = "history")GuideChatHistory history);
	
	int loadUncheckCountByParam(@Param(value = "history")GuideChatHistory history);
	List<GuideChatHistoryDTO> loadListByParam(@Param(value = "history")GuideChatHistory history);
	
}
