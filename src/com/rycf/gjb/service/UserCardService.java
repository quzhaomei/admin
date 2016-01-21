package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.UserCardDTO;
import com.rycf.gjb.entity.UserCard;

public interface UserCardService {
	void saveCard(UserCard card);
	UserCardDTO getCardByGetMoreId(Integer getMoreId);
	List<UserCardDTO> getListByGetMoreId(Integer getMoreId);
	void updateCard( UserCard card);
}
