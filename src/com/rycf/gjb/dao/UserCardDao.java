package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.UserCardDTO;
import com.rycf.gjb.entity.UserCard;

public interface UserCardDao {
	void saveCard(@Param(value="card") UserCard card);
	UserCardDTO getCardByGetMoreId(@Param(value="getMoreId")Integer getMoreId);
	void updateCard(@Param(value="card") UserCard card);
	List<UserCardDTO> getListByGetMoreId(@Param(value="getMoreId")Integer getMoreId);
	
	void batchUpdate(@Param(value="card") UserCard card);
}
