package com.rycf.gjb.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.FurnitureTypeDao;
import com.rycf.gjb.dao.FurnitureZoneToTypeDao;
import com.rycf.gjb.dto.FurnitureTypeDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.FurnitureType;
import com.rycf.gjb.entity.FurnitureZoneToType;
import com.rycf.gjb.service.FurnitureTypeService;
import com.rycf.gjb.util.UuidUtils;
@Service
public class FurnitureTypeServiceImpl implements FurnitureTypeService{
	@Resource
	private FurnitureTypeDao furnitureTypeDao;
	@Resource
	private FurnitureZoneToTypeDao furnitureZoneToTypeDao;
	@Override
	public void saveType(FurnitureType furnitureType) {
		furnitureType.setTypeId(UuidUtils.getObjectUUID("type"));
		String zoneIds=furnitureType.getZoneIds();
		
		if(zoneIds!=null){//存属于的家具品格
			String[] zids=zoneIds.split(",");
			for(String id:zids){
				FurnitureZoneToType furnitureZoneToType=new FurnitureZoneToType();
				furnitureZoneToType.setZoneId(id);
				furnitureZoneToType.setStatus("1");
				furnitureZoneToType.setTypeId(furnitureType.getTypeId());
				furnitureZoneToType.setZoneToTypeId(UuidUtils.getObjectUUID("zzt"));
				furnitureZoneToTypeDao.saveZoneToType(furnitureZoneToType);
			}
		}
		furnitureTypeDao.saveType(furnitureType);
	}

	@Override
	public void updateType(FurnitureType furnitureType) {
		//查询所有所属的功能区域
		FurnitureZoneToType oldZoneToType=new FurnitureZoneToType();
		oldZoneToType.setTypeId(furnitureType.getTypeId());
		List<FurnitureZoneToType> oldResult=furnitureZoneToTypeDao.getByParam(oldZoneToType);//获取原来的
		String zoneIds=furnitureType.getZoneIds();
		if(zoneIds!=null){
			String[] zids=zoneIds.split(",");
			List<FurnitureZoneToType> newResult=new ArrayList<FurnitureZoneToType>();//需要处理的
			
			//找出变化的
			for(FurnitureZoneToType old:oldResult){
				for(int i=0;i<zids.length;i++){
					if(zids[i].equals(old.getZoneId())){//已经在，不需要处理
						if(old.getStatus().equals("0")){
							old.setStatus("1");
							newResult.add(old);
						}
						break;
					}
					if(i==zids.length-1){//如果到了最后一位，则说明已经被删除,
						old.setStatus("0");
						newResult.add(old);
					}
				}
			}
			//找出新增的
			for(int i=0;i<zids.length;i++){
				boolean newtag=true;
				for(int inner=0;inner<oldResult.size();inner++){
					FurnitureZoneToType old=oldResult.get(inner);
					if(zids[i].equals(old.getZoneId())){//已经在，不是新增
						newtag=false;
						break;
					}
				}
				if(newtag){
					FurnitureZoneToType furnitureZoneToType=new FurnitureZoneToType();
					furnitureZoneToType.setStatus("1");
					furnitureZoneToType.setTypeId(furnitureType.getTypeId());
					furnitureZoneToType.setZoneId(zids[i]);
					newResult.add(furnitureZoneToType);
				}
			}
			for(FurnitureZoneToType zoneToType:newResult){
				if(zoneToType.getZoneToTypeId()!=null){//更新
					furnitureZoneToTypeDao.updateZoneToType(zoneToType);
				}else{//新增
					zoneToType.setZoneToTypeId(UuidUtils.getObjectUUID("zzt"));
					furnitureZoneToTypeDao.saveZoneToType(zoneToType);
				}
			}
		}else{//删除所有
			for(FurnitureZoneToType zoneToType:oldResult){
				zoneToType.setStatus("0");
				furnitureZoneToTypeDao.updateZoneToType(zoneToType);
			}
		}
		furnitureTypeDao.updateType(furnitureType);
	}

	@Override
	public FurnitureTypeDTO getTypeById(String id) {
		return furnitureTypeDao.getTypeById(id);
	}

	@Override
	public List<FurnitureTypeDTO> getTypeByPageAndParam(
			PageDTO<FurnitureType> page) {
		return furnitureTypeDao.getTypeByPageAndParam(page);
	}

	@Override
	public int getCountByParam(FurnitureType furnitureType) {
		return furnitureTypeDao.getCountByParam(furnitureType);
	}

	@Override
	public List<FurnitureTypeDTO> getAllType() {
		return furnitureTypeDao.getAllType();
	}

	@Override
	public List<FurnitureTypeDTO> getTypeByZone(String zoneId) {
		return furnitureTypeDao.getTypeByZone(zoneId);
	}

}
