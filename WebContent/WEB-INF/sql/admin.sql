/*
*****菜单表以及初始化
*/
CREATE TABLE menu_manager (
  menuId varchar(40) NOT NULL,
  menuName varchar(30) DEFAULT NULL,
  url varchar(100) DEFAULT NULL,
  parentId varchar(40) DEFAULT NULL,
  status varchar(10) DEFAULT NULL,
  createDate datetime DEFAULT NULL,
  createUserId varchar(40) DEFAULT NULL,
  updateDate datetime DEFAULT NULL,
  updateUserId varchar(40) DEFAULT NULL,
  type varchar(10)DEFAULT NULL,
  PRIMARY KEY (menuId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO menu_manager (menuId, menuName, url, parentId, status, createDate, createUserId, updateDate, updateUserId, type) VALUES
('-1', '首页', '/menuManager.jsp', '-1', '1', NULL, NULL, '2015-06-12 11:19:46', 'xxxx', '-1'),
('0', '系统用户管理', '../user/index.html', '-1', '1', NULL, NULL, '2015-06-17 11:33:59', 'xxxx', '-1'),
('1', '系统设置', '#', '-1', '1', NULL, NULL, '2015-06-11 15:44:50', 'xxxx', '-1'),
('101', '菜单管理', '../menu/index.html', '1', '1', NULL, NULL, '2015-06-17 10:01:51', 'xxxx', '1'),
('102', '角色管理', '../role/index.html', '1', '1', NULL, NULL, '2015-06-17 10:02:03', 'xxxx', '-1'),
('1020', '查看角色', '#a', '102', '1', NULL, NULL, '2015-06-12 11:20:06', 'xxxx', '1'),
('1021', '增加角色', '#', '102', '1', NULL, NULL, '2015-06-12 11:18:26', 'xxxx', '0'),
('1022', '修改角色', '#', '102', '1', NULL, NULL, NULL, NULL, '1'),
('1023', '删除角色', '#', '102', '1', NULL, NULL, NULL, NULL, '1'),
('103', '权限管理', '../power/index.html', '1', '1', NULL, NULL, '2015-06-17 10:02:32', 'xxxx', '-1');

/*
角色表
*/
CREATE TABLE role_manager (
  roleId varchar(40) NOT NULL,
  roleName varchar(30) DEFAULT NULL,
  status varchar(10) DEFAULT NULL,
  createDate datetime DEFAULT NULL,
  createUserId varchar(40) DEFAULT NULL,
  updateDate datetime DEFAULT NULL,
  updateUserId varchar(40) DEFAULT NULL,
  PRIMARY KEY (roleId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/**
角色表数据初始化
**/
insert into role_manager(roleId,roleName,status)values('101','角色A','1');
insert into role_manager(roleId,roleName,status)values('102','角色B','1');
insert into role_manager(roleId,roleName,status)values('103','角色C','1');
insert into role_manager(roleId,roleName,status)values('104','角色D','1');
insert into role_manager(roleId,roleName,status)values('105','角色E','1');
insert into role_manager(roleId,roleName,status)values('106','角色F','1');
insert into role_manager(roleId,roleName,status)values('107','角色G','1');
insert into role_manager(roleId,roleName,status)values('108','角色H','1');
insert into role_manager(roleId,roleName,status)values('109','角色I','1');
insert into role_manager(roleId,roleName,status)values('110','角色J','1');

/**
角色权限表
**/
CREATE TABLE role_menus (
  RoleMenusId varchar(40) NOT NULL,
  roleId varchar(40) DEFAULT NULL,
  menuId varchar(40) DEFAULT NULL,
  parentId varchar(40) DEFAULT NULL,
  status varchar(10) DEFAULT NULL,
  createDate datetime DEFAULT NULL,
  createUserId varchar(40) DEFAULT NULL,
  updateDate datetime DEFAULT NULL,
  updateUserId varchar(40) DEFAULT NULL,
  PRIMARY KEY (RoleMenusId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/**
系统用户表
**/
CREATE TABLE system_User (
  systemUserId varchar(40) NOT NULL,
  userName varchar(15) DEFAULT NULL,
  loginname varchar(15) DEFAULT NULL,
  password varchar(40) DEFAULT NULL,
  phone varchar(11) DEFAULT NULL,
  email varchar(20) DEFAULT NULL,
  rolesArrStr varchar(500) DEFAULT NULL,
  description varchar(300) DEFAULT NULL,
  status varchar(5) DEFAULT NULL,
  createDate datetime DEFAULT NULL,
  createUserId varchar(40) DEFAULT NULL,
  updateDate datetime DEFAULT NULL,
  updateUserId varchar(40) DEFAULT NULL,
  PRIMARY KEY (systemUserId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/**
系统角色表初始化
**/
INSERT INTO system_user (systemUserId,userName,loginname,password,phone,email,rolesArrStr,description, status) VALUES
('user143443945579829', '瞿兆梅', 'quzhaomei','18621761401','18621761401','asfsaf@qq.com','101','I''M GOD','1');

/**
家具功能区域表
**/
CREATE TABLE furniture_zone (
  zoneId varchar(40) NOT NULL,
  zoneName varchar(40) DEFAULT NULL,
  status varchar(5) DEFAULT NULL,
  createDate datetime DEFAULT NULL,
  createUserId varchar(40) DEFAULT NULL,
  updateDate datetime DEFAULT NULL,
  updateUserId varchar(40) DEFAULT NULL,
  PRIMARY KEY (zoneId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/**
家具品类表
**/
CREATE TABLE furniture_type (
  typeId varchar(40) NOT NULL,
  typeName varchar(40) DEFAULT NULL,
  status varchar(5) DEFAULT NULL,
  createDate datetime DEFAULT NULL,
  createUserId varchar(40) DEFAULT NULL,
  updateDate datetime DEFAULT NULL,
  updateUserId varchar(40) DEFAULT NULL,
  PRIMARY KEY (typeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/**
家具功能-品类中间表
**/
CREATE TABLE furniture_zone_to_type (
  zoneToTypeId varchar(40) NOT NULL,
  zoneId varchar(40) DEFAULT NULL,
  typeId varchar(40) DEFAULT NULL,
  status varchar(5) DEFAULT NULL,
  PRIMARY KEY (zoneToTypeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/**
家具风格表
**/
CREATE TABLE furniture_style(
  styleId varchar(40) NOT NULL,
  styleName varchar(40) DEFAULT NULL,
  status varchar(5) DEFAULT NULL,
  createDate datetime DEFAULT NULL,
  createUserId varchar(40) DEFAULT NULL,
  updateDate datetime DEFAULT NULL,
  updateUserId varchar(40) DEFAULT NULL,
  PRIMARY KEY (styleId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/**
家具预算表
**/
CREATE TABLE furniture_budget(
  budgetId varchar(40) NOT NULL,
  startNum FLOAT(5,1) DEFAULT NULL,
  endNum FLOAT(5,1) DEFAULT NULL,
  status varchar(5) DEFAULT NULL,
  createDate datetime DEFAULT NULL,
  createUserId varchar(40) DEFAULT NULL,
  updateDate datetime DEFAULT NULL,
  updateUserId varchar(40) DEFAULT NULL,
  PRIMARY KEY (budgetId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**
家具需求表
**/
CREATE TABLE furniture_required(
  requiredId varchar(40) NOT NULL,
  zoneId varchar(40),
  openId varchar(40),
  budgetId varchar(40) ,
  typeIds varchar(400),
  styleIds varchar(400) ,
  description varchar(500) ,
  status varchar(10),
  createDate datetime,
  PRIMARY KEY (requiredId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**
品牌
**/
CREATE TABLE brand(
  brandId varchar(40) NOT NULL,
  brandName varchar(100) DEFAULT NULL,
  status varchar(5) DEFAULT NULL,
  imgPath varchar(40) DEFAULT NULL,
  pinying varchar(10) DEFAULT NULL,
  indexWord varchar(5) DEFAULT NULL,
  createDate datetime DEFAULT NULL,
  updateDate datetime DEFAULT NULL,
  createUserId varchar(40) DEFAULT NULL,
  updateUserId	varchar(40) DEFAULT NULL,
  PRIMARY KEY (brandId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/**
品牌浏览记录
**/
CREATE TABLE brand_scan(
  brandScanId varchar(40) NOT NULL,
  openId varchar(100) DEFAULT NULL,
  brandIds varchar(200),
  PRIMARY KEY (brandScanId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/**
门店管理
**/
CREATE TABLE store(
 	storeId varchar(40) NOT NULL,
	brandId varchar(40) DEFAULT NULL,
	businessId varchar(40) DEFAULT NULL,
	storeNum int(5) DEFAULT NULL,
	shopKeeperId varchar(40) DEFAULT NULL,
	brandKeeperId varchar(40) DEFAULT NULL,
	address varchar(100) DEFAULT NULL,
	lat double DEFAULT NULL,
	lng double DEFAULT NULL,
	storeName varchar(100) DEFAULT NULL, 
	status varchar(10) DEFAULT NULL, 
	createDate datetime DEFAULT NULL,
	createUserId varchar(40) DEFAULT NULL,
	updateDate datetime DEFAULT NULL,
	updateUserId varchar(40) DEFAULT NULL,
  	PRIMARY KEY (storeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**
订单管理
**/
CREATE TABLE fur_order(
 	orderId varchar(40) NOT NULL,
	openId varchar(40) DEFAULT NULL,
	username varchar(40) DEFAULT NULL,
	phone varchar(11) DEFAULT NULL,
	storeId varchar(40) DEFAULT NULL,
	fare float(10,2) DEFAULT NULL,
	hasPay float(10,2) DEFAULT NULL,
	orderImg varchar(40) DEFAULT NULL,
	statu varchar(5) DEFAULT NULL,
	createDate datetime DEFAULT NULL, 
	updateDate datetime DEFAULT NULL, 
	updateUserId varchar(40) DEFAULT NULL,
  	PRIMARY KEY (orderId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**
订单管理
**/
CREATE TABLE user_card(
 	userCardId varchar(40) NOT NULL,
	openId varchar(40) DEFAULT NULL,
	bankName varchar(40) DEFAULT NULL,
	accountAddr varchar(150) DEFAULT NULL,
	cardNo varchar(40) DEFAULT NULL,
	username varchar(40) DEFAULT NULL,
	createDate datetime DEFAULT NULL,
	updatedate datetime DEFAULT NULL,
	statu varchar(5) DEFAULT NULL,
  	PRIMARY KEY (userCardId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;