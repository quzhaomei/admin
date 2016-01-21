package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.UserCardDao;
import com.rycf.gjb.dto.UserCardDTO;
import com.rycf.gjb.entity.UserCard;
import com.rycf.gjb.service.UserCardService;
import com.rycf.gjb.util.UuidUtils;
@Service
public class UserCardServiceImpl implements UserCardService{
	
	@Resource
	private UserCardDao userCardDao;
	@Override
	public void saveCard(UserCard card) {
		card.setUserCardId(UuidUtils.getObjectUUID("card"));
		userCardDao.batchUpdate(card);
		userCardDao.saveCard(card);
	}

	@Override
	public UserCardDTO getCardByGetMoreId(Integer getMoreId) {
		return userCardDao.getCardByGetMoreId(getMoreId);
	}

	@Override
	public void updateCard(UserCard card) {
		userCardDao.batchUpdate(card);
		userCardDao.updateCard(card);
	}

	@Override
	public List<UserCardDTO> getListByGetMoreId(Integer getMoreId) {
		return userCardDao.getListByGetMoreId(getMoreId);
	}

}
