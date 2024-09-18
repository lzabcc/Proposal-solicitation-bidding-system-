/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : fangan

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 21/08/2022 14:25:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '81DC9BDB52D04DC20036DBD8313ED055');

-- ----------------------------
-- Table structure for assess
-- ----------------------------
DROP TABLE IF EXISTS `assess`;
CREATE TABLE `assess`  (
  `assess_id` int(255) NOT NULL AUTO_INCREMENT,
  `tender` int(11) NULL DEFAULT NULL,
  `expert` int(11) NULL DEFAULT NULL,
  `winner` int(11) NULL DEFAULT NULL,
  `reason` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `assess_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `score1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `score2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `score3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `score4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`assess_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of assess
-- ----------------------------
INSERT INTO `assess` VALUES (1, 1, 2, 4, '强力推荐', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `assess` VALUES (2, 1, 3, 4, '311', NULL, '321', '321', '312', '312');

-- ----------------------------
-- Table structure for assess_invite
-- ----------------------------
DROP TABLE IF EXISTS `assess_invite`;
CREATE TABLE `assess_invite`  (
  `assess_invite_id` int(11) NOT NULL AUTO_INCREMENT,
  `tender` int(11) NULL DEFAULT NULL,
  `expert` int(11) NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`assess_invite_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of assess_invite
-- ----------------------------
INSERT INTO `assess_invite` VALUES (9, 5, 6, 0);
INSERT INTO `assess_invite` VALUES (10, 1, 1, 0);
INSERT INTO `assess_invite` VALUES (11, 1, 2, 1);
INSERT INTO `assess_invite` VALUES (12, 1, 3, 1);
INSERT INTO `assess_invite` VALUES (13, 1, 4, 0);

-- ----------------------------
-- Table structure for enterprise
-- ----------------------------
DROP TABLE IF EXISTS `enterprise`;
CREATE TABLE `enterprise`  (
  `ent_id` int(11) NOT NULL AUTO_INCREMENT,
  `enterprise_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `frdb` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tax_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reg_amount` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ent_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `attachment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of enterprise
-- ----------------------------
INSERT INTO `enterprise` VALUES (1, '广东省高速公路投资有限公司', 'test', '81DC9BDB52D04DC20036DBD8313ED055', '02099083221', 'test@126.com', '张明华', '9889800289173718', '3200万元', NULL, '这是测试的数据', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `enterprise` VALUES (2, '广东省基础工程集团有限公司', 'gdjc', '81DC9BDB52D04DC20036DBD8313ED055', '02088932221', 'contact@gdjc.net', '苏家平', '914400001903320487', '30000万人民币', NULL, '广东省基础工程集团有限公司于1980年12月29日在广东省工商行政管理局登记成立。经营范围市政公用工程、轨道交通工程、建筑工程、公路工程、水利水电工程、港口与航道工程施工总承包；地基基础工程、桥梁工程、公路路基工程、隧道工程专业承包；市政工程设计、岩土工程设计；地质灾害治理工程、土石方工程、园林绿化', '672c2294-2570-4bf0-925b-97263038ec23.docx', -1);
INSERT INTO `enterprise` VALUES (3, '广东省机场集团有限公司', 'gdap', '81DC9BDB52D04DC20036DBD8313ED055', '02037784672', 'gdap@gdap.com', '王大明', '98898399831931423', '25000万元', '广州市机场路186号', '广东省内机场的控制人', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `enterprise` VALUES (4, '广州市越秀区城市管理局', 'yxcg', '81DC9BDB52D04DC20036DBD8313ED055', '02088742232', 'yxcg@gz.gov.cn', '朱健标', '89983900211384', '2000万元', '广州市越秀区东风中路233号', '政府单位，主管市政工程', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `enterprise` VALUES (5, '深圳市罗湖客运站', 'lhky', '81DC9BDB52D04DC20036DBD8313ED055', '075787763343', 'lhky@163.com', '张彬', '57849890993198', '1000万元', '深圳市罗湖区深南大道877号', '罗湖客运站，属国资委管理下的企业', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `enterprise` VALUES (6, '东莞市民政局', 'dgmz', '81DC9BDB52D04DC20036DBD8313ED055', '075823376655', 'dgmz@gddg.gov.cn', '刘为民', '98930130898113', '0', '东莞市厚街镇北环路899号', '寻找电子政务项目服务商，软件', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `enterprise` VALUES (7, '南昌市世佳园林服务有限公司', 'shijie', '81DC9BDB52D04DC20036DBD8313ED055', '035123419002', 'sjyl@163.com', '张林林', '9083120324653', '100万元', '南昌市东城区八一路177号', '提供园林设计、室内、户外服务', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `enterprise` VALUES (8, '惠州市龙门县第一中学', 'lmyz', '81DC9BDB52D04DC20036DBD8313ED055', '07583224788', 'hzlmyz@126.com', '张国裕', '7674392729123', '500万元', '惠州市龙门县城西镇台城路121号', '惠州市龙门县第一中学', '672c2294-2570-4bf0-925b-97263038ec23.docx', -1);
INSERT INTO `enterprise` VALUES (9, '台山市华侨中学', '112341', '81DC9BDB52D04DC20036DBD8313ED055', '07505543812', 'tsqz@163.com', '容晓文', '8983030102042', '200万元', '台山市城南路12号', '台山市华侨中学', '672c2294-2570-4bf0-925b-97263038ec23.docx', -1);
INSERT INTO `enterprise` VALUES (10, 'test123', 'test123', 'CC03E747A6AFBBCBF8BE7668ACFEBEE5', '18922681389', '4343434@qq.com', 'test123', 'eqwe', '3242', 'dsadsadsa', 'dasdsa', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);

-- ----------------------------
-- Table structure for expert
-- ----------------------------
DROP TABLE IF EXISTS `expert`;
CREATE TABLE `expert`  (
  `expert_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `real_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expert_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expert_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `major` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expert_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `company` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `birth` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`expert_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of expert
-- ----------------------------
INSERT INTO `expert` VALUES (1, 'gyl', 'E10ADC3949BA59ABBE56E057F20F883E', '高岳伦', '一级建造师', '工程类', '建筑工程', '<p>1957年7月出生，浙江镇海人。1980年毕业于同济大学建筑系建筑工程专业，高级建筑师。1989年被评为建筑师，1995年通过考试成为国家一级注册建筑师，此外1984年加入中国流行色协会，1999年加入上海市建筑学会。</p><p><img src=\"http://localhost:8080/ssm/upload/202005121733500fvla.jpg\" style=\"max-width:100%;\"><br></p><p><br></p>', '上海市建筑学会', '1962年5月', '13310098877');
INSERT INTO `expert` VALUES (2, 'hst', '81DC9BDB52D04DC20036DBD8313ED055', '黄淑婷', '造价工程师', '工程类', '建筑', '<p>通过全国造价工程师执业资格统一考试或者资格认定、资格互认，取得中华人民共和国造价工程师执业资格，并按照《注册造价工程师管理办法》注册，取得中华人民共和国造价工程师注册执业证书和执业印章，从事工程造价活动的专业人员。</p><p><br></p>', '厦门市建筑设计院', '1978年3月', '13900983341');
INSERT INTO `expert` VALUES (3, 'xuzx', '81DC9BDB52D04DC20036DBD8313ED055', '许志新', '城市规划工程师', '工程类', '市政规划', '<p>经全国统一考试合格，取得《城市规划师执业资格证书》并经注册登记后，城市规划业务工作的专业技术人员。 1999 年，国家开始实施城市规划师执业资格制度。 2000 年 2 月，下发了《人事部、建设部关于印发〈注册城市规划师执业资格考试实施办法〉的通知》， 2001 年 5 月下发《关于注册城市规划师执业资格考试报名条件补充规定的通知》。</p>', NULL, NULL, NULL);
INSERT INTO `expert` VALUES (4, 'linyu', '81DC9BDB52D04DC20036DBD8313ED055', '林珏', '副教授', '工程类', '计算机软件', '<p>计算机软件专家，高校副教授</p><p><br></p>', '广州', '2001.01.13', '1892245789');
INSERT INTO `expert` VALUES (5, 'wangwei', '81DC9BDB52D04DC20036DBD8313ED055', '王威', '软件工程师', '产品类', '计算机软件', '<p>企业级软件研发工程师</p><p><br></p>', NULL, NULL, NULL);
INSERT INTO `expert` VALUES (6, 'ztf', '81DC9BDB52D04DC20036DBD8313ED055', '张庭丰', '物业经理', '服务类', '物业管理', '<p>物业服务专家</p>', NULL, NULL, NULL);
INSERT INTO `expert` VALUES (7, 'hxk', '81DC9BDB52D04DC20036DBD8313ED055', '黄晓柯', '集成专家', '产品类', '云服务', '<p>云服务技术专家</p>', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT,
  `send_time` datetime(0) NULL DEFAULT NULL,
  `msg_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sender` int(255) NULL DEFAULT NULL,
  `receiver` int(11) NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `is_read` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`msg_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `notice_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `publish_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `sender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '《罗湖客运站候车厅室内绿化工程》中标公告', '中标公告', '中标单位：美伦环境艺术有限公司', '2022-08-21 13:12:19', '深圳市罗湖客运站');
INSERT INTO `notice` VALUES (2, '什么是反商业贿赂法', '系统公告', '<p>商业贿赂行为:<br>商业贿赂是指经营者为争取交易机会，暗中给予交易对方有关人员和能够影响交易的其他相关人员以财物或其他好处的行为。<br>反不正当竞争法第8条规定，经营者不得采用财物或者其他手段进行贿赂以销售或7a686964616fe59b9ee7ad9431333332643338者购买商品。在账外暗中给予对方单位或者个人回扣的，以行贿论处；对方单位或者个人在账外暗中收受回扣的，以受贿论处。经营者销售或者购买商品，可以以明示方式给对方折扣，可以给中间人佣金。经营者给对方折扣、给中间人佣金的，必须如实入账。接受折扣、佣金的经营者必须如实入账。<br>行为要点<br>(1)行为的主体是经营者和受经营者指使的人(包括其职工)；其他主体可能构成贿赂行为，但不是商业贿赂。<br>(2)行为的目的是争取市场交易机会，而非其他目的。<br>(3)有私下暗中给予他人财物和其他好处的行为，且达到一定数额。<br>(4)该行为由行贿与受贿两方面构成。<br>法律责任<br>根据反不正当竞争法第22条的规定，经营者有商业贿赂行为的，构成犯罪，追究刑事责任；未构成犯罪的，监督检查部门可处以1万元以上20万元以下的罚款，并没收其违法所得。<br>《关于禁止商业贿赂行为的暂行规定》还就有关商业贿赂问题作了规定：<br>(一)经营者的职工采用商业贿赂手段为经营者销售或者购买商品的行为，应当认定为经营者的行为。<br>(二)回扣是指经营者销售商品时在账外暗中以现金、实物或者其他方式退给对方单位或者个人的一定比例的商品价款。<br>(三)账外暗中是指未在依法设立的反映其生产经营活动或者行政事业经费收支的财务账上按照财务会计制度规定明确如实记载，包括不记入财务账、转入其他财务账或者做假账等。<br>(四)折扣，即商品购销中的让利，是指经营者在销售商品时，以明示并如实入账的方式给予对方的价格优惠，包括支付价款时对价款总额按一定比例即时予以扣除和支付价款总额后再按一定比例退还两种形式。<br>(五)佣金是指经营者在市场交易中给予为其提供服务的具有合法经营资格的中间人的劳动报酬。<br>(六)经营者在商品交易中不得向对方单位或者其个人附赠现金或者物品。但按照商业贯例赠送小额广告礼品的除外。</p>', '2022-08-21 13:12:19', '系统管理员');
INSERT INTO `notice` VALUES (3, '《客车维修信息管理系统》中标公告', '中标公告', '中标单位：中山市星火网络科技有限公司', '2022-08-21 13:12:19', '深圳市罗湖客运站');

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ent_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `frdb` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tax_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reg_amount` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ent_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `attachment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`supplier_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES (1, 'kechen', '科晨网络信息技术有限公司', '02034478731', 'bussiness@kcwl.net', '任变化', '932098310913090382', '200万元', '广州市天河区科韵路288号5楼', '81DC9BDB52D04DC20036DBD8313ED055', '承接软件开发，网站建设，电子政务系统，小程序开发', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `supplier` VALUES (2, 'zsxh', '中山市星火网络科技有限公司', '0756-78821223', 'bizcon@126.com', '魏雪玲', '989839010-3282113', '500万元', '中山市小榄镇南环路322号', '81DC9BDB52D04DC20036DBD8313ED055', '软件企业，只要从事ERP开发，承接网站建设、软件开发', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `supplier` VALUES (3, 'szhs', '深圳恒双软件信息有限公司', '0757-30098876', 'costom@szhs.com', '周敏', '89009839080932', '230万元', '深圳市南山区八卦岭北路877号', '81DC9BDB52D04DC20036DBD8313ED055', '经营范围：软件外包、人员外包', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `supplier` VALUES (4, 'gzls', '广州市绿树园林服务有限公司', '02038897422', 'gzlsyl@126.com', '张华清', '9803802831013153', '100万元', '广州市海珠区同福路23号', '81DC9BDB52D04DC20036DBD8313ED055', '承接各种市政园林工程，道路绿化', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `supplier` VALUES (5, 'gzrx', '广州如新市政维护有限公司', '02087674453', 'gzrxse@sina.com', '张超後', '8938938991134', '100万元', '广州市增城新城大道33号二楼', '81DC9BDB52D04DC20036DBD8313ED055', '广州明日室内装修公司站位于新概念、新材料、新技术、新装备，以集成、有机、简约环保为理念，致力于有技术含量、方便业主实现使用理想的室内装修探索理论和实践。同时响应国家乡村振兴计划和青山绿水环保要求，开展以轻钢材料为骨架、竹炭纤维板为内饰的轻钢别墅建造研究。市政，园林，道路施工。', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `supplier` VALUES (6, 'mlhj', '美伦环境艺术有限公司', '02188931223', 'mlhj@sohu.com', '刘少表', '89377583287139', '350万', '上海市奉贤区滨河东路211号', '81DC9BDB52D04DC20036DBD8313ED055', '美伦环境艺术有限公司成立于2011年，是一家专注于住宅园林绿化暨装修环境项目、商业与公共环境项目、人文暨旅游环境项目、市政公用环境项目设计、施工、维护的环境建设公司', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `supplier` VALUES (7, 'jyxx', '极云信息科技有限公司', '028-22983433', 'jiyun@126.com', '李泽凯', '90930138299214', '300万元', '西安市鼓楼区学士路666号', '81DC9BDB52D04DC20036DBD8313ED055', '我们为商家和企业客户提供电子商务/企业管理/营销平台产品，让客户借助网络力量使公司在销售，营销，管理上得到提升。我们的业务包括：电商平台，移动互联网，企业管理产品，软件，外包，信息系统。', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `supplier` VALUES (8, 'xkd', '小蝌蚪众创电商科技有限公司', '075767780912', 'xkd2015@126.com', '刘朝阳', '9893928931831', '100万元', '深圳市南山区西槎路欣凯科创园4栋7楼', '81DC9BDB52D04DC20036DBD8313ED055', '公司核心团队在跨境电商行业已探索了十多年，成功孵化了多家年销量上亿的时尚类公司。软件，项目，系统。', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `supplier` VALUES (9, 'gdyd', '广东移动', '02089974353', 'gdyd@cmcc.com', '王大强', '908831983191', '25000万元', '广州市中山大道西891号', '81DC9BDB52D04DC20036DBD8313ED055', '广东移动，主营软件开发，电子通讯', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `supplier` VALUES (10, 'dbjy', '电白建筑工程有限公司', '07782344871', 'dbjz@coremail.com', '朱晓清', '64537843299834', '1500万元', '茂名市电白县城东区二环路122号', '81DC9BDB52D04DC20036DBD8313ED055', '道路工程、居民楼建筑', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);
INSERT INTO `supplier` VALUES (11, '321432', '32143214', '43214312', '432143@qq.com', '43231432', '432143214', '321432', '1342314', '81DC9BDB52D04DC20036DBD8313ED055', '14312423', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1);

-- ----------------------------
-- Table structure for sys_msg
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg`;
CREATE TABLE `sys_msg`  (
  `sys_msg_id` int(11) NOT NULL AUTO_INCREMENT,
  `msg_time` datetime(0) NULL DEFAULT NULL,
  `msg_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reviever` int(11) NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `alink` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_read` int(11) NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sys_msg_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 119 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_msg
-- ----------------------------
INSERT INTO `sys_msg` VALUES (8, '2022-08-21 13:12:19', 'NEW_REGIST_ENT', -1, '新注册招标方：广东省基础工程集团有限公司，请前往激活！', '/ssm/admin/supactive', -1, '2');
INSERT INTO `sys_msg` VALUES (9, '2022-08-21 13:12:19', 'NEW_REGIST_ENT', -1, '新注册招标方：广东省机场集团有限公司，请前往激活！', '/ssm/admin/entactive', 1, '3');
INSERT INTO `sys_msg` VALUES (10, '2022-08-21 13:12:19', 'NEW_REGIST_SUP', -1, '新注册供应商：中山市星火网络科技有限公司，请前往激活！', '/ssm/admin/supactive', 1, '3');
INSERT INTO `sys_msg` VALUES (11, '2022-08-21 13:12:19', 'NEW_REGIST_SUP', -1, '新注册供应商：深圳恒双软件信息有限公司，请前往激活！', '/ssm/admin/supactive', 1, '2');
INSERT INTO `sys_msg` VALUES (12, '2022-08-21 13:12:19', 'NEW_REGIST_SUP', -1, '新注册供应商：广州市绿树园林服务有限公司，请前往激活！', '/ssm/admin/supactive', 1, '4');
INSERT INTO `sys_msg` VALUES (13, '2022-08-21 13:12:19', 'NEW_TENDER', -1, '收到新招标申请，收到新招标申请', '/ssm/admin/tendermgr', 1, '1');
INSERT INTO `sys_msg` VALUES (14, '2022-08-21 13:12:19', 'NEW_TENDER', -1, '收到新招标申请，收到新招标申请', '/ssm/admin/tendermgr', 1, '2');
INSERT INTO `sys_msg` VALUES (15, '2022-08-21 13:12:19', 'TENDER_INVITE', 4, '收到洛溪大桥拓宽工程投标邀请，请查看。', '/ssm/sup/tender-detail?tid=1', 1, '4');
INSERT INTO `sys_msg` VALUES (16, '2022-08-21 13:12:19', 'NEW_REGIST_ENT', -1, '新注册招标方：广州市越秀区城市管理局，请前往激活！', '/ssm/admin/entactive', 1, '4');
INSERT INTO `sys_msg` VALUES (17, '2022-08-21 13:12:19', 'NEW_REGIST_ENT', -1, '新注册招标方：深圳市罗湖客运站，请前往激活！', '/ssm/admin/entactive', 1, '5');
INSERT INTO `sys_msg` VALUES (18, '2022-08-21 13:12:19', 'NEW_REGIST_SUP', -1, '新注册供应商：广州如新市政维护有限公司，请前往激活！', '/ssm/admin/supactive', 1, '5');
INSERT INTO `sys_msg` VALUES (19, '2022-08-21 13:12:19', 'NEW_REGIST_SUP', -1, '新注册供应商：美伦环境艺术有限公司，请前往激活！', '/ssm/admin/supactive', 1, '6');
INSERT INTO `sys_msg` VALUES (20, '2022-08-21 13:12:19', 'TENDER_INVITE', 1, '收到《测试标书》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=2', 1, '1');
INSERT INTO `sys_msg` VALUES (21, '2022-08-21 13:12:19', 'TENDER_INVITE', 2, '收到《测试标书》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=2', -1, '2');
INSERT INTO `sys_msg` VALUES (22, '2022-08-21 13:12:19', 'TENDER_INVITE', 3, '收到《测试标书》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=2', 1, '3');
INSERT INTO `sys_msg` VALUES (23, '2022-08-21 13:12:19', 'NEW_TENDER', -1, '收到新招标申请：《罗湖客运自助购票终端采购》，请前往审核！', '/ssm/admin/tendermgr', 1, '3');
INSERT INTO `sys_msg` VALUES (24, '2022-08-21 13:12:19', 'NEW_TENDER', -1, '收到新招标申请：《罗湖客运站候车厅室内绿化工程》，请前往审核！', '/ssm/admin/tendermgr', 1, '4');
INSERT INTO `sys_msg` VALUES (26, '2022-08-21 13:12:19', 'TENDER_INVITE', 1, '收到《罗湖客运自助购票终端采购》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=3', 1, '1');
INSERT INTO `sys_msg` VALUES (27, '2022-08-21 13:12:19', 'TENDER_INVITE', 2, '收到《罗湖客运自助购票终端采购》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=3', -1, '2');
INSERT INTO `sys_msg` VALUES (39, '2022-08-21 13:12:19', 'TENDER_SUCCESS', 6, '恭喜，您投标的项目：《罗湖客运站候车厅室内绿化工程》，已中标！', '', -1, '4');
INSERT INTO `sys_msg` VALUES (65, '2022-08-21 13:12:19', 'TENDER_FAILD', 1, '您投标的项目：《客车维修信息管理系统》，已定标，很遗憾贵司未能中标！', '', -1, '7');
INSERT INTO `sys_msg` VALUES (88, '2022-08-21 13:12:19', 'TENDER_INVITE', 1, '收到《省机场集团值班室监控大屏》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=8', 1, '1');
INSERT INTO `sys_msg` VALUES (89, '2022-08-21 13:12:19', 'TENDER_INVITE', 2, '收到《省机场集团值班室监控大屏》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=8', -1, '2');
INSERT INTO `sys_msg` VALUES (90, '2022-08-21 13:12:19', 'TENDER_INVITE', 3, '收到《省机场集团值班室监控大屏》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=8', -1, '3');
INSERT INTO `sys_msg` VALUES (91, '2022-08-21 13:12:19', 'TENDER_INVITE', 7, '收到《省机场集团值班室监控大屏》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=8', -1, '7');
INSERT INTO `sys_msg` VALUES (92, '2022-08-21 13:12:19', 'TENDER_INVITE', 8, '收到《省机场集团值班室监控大屏》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=8', -1, '8');
INSERT INTO `sys_msg` VALUES (93, '2022-08-21 13:12:19', 'TENDER_INVITE', 9, '收到《省机场集团值班室监控大屏》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=8', -1, '9');
INSERT INTO `sys_msg` VALUES (94, '2022-08-21 13:12:19', 'NEW_TENDER', -1, '收到新招标申请：《饭堂小卖部招标》，请前往审核！', '/ssm/admin/tender-detail?tid=17', 1, '17');
INSERT INTO `sys_msg` VALUES (95, '2022-08-21 13:12:19', 'TENDER_INVITE', 1, '收到《东莞市民政系统小程序》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=9', 1, '1');
INSERT INTO `sys_msg` VALUES (96, '2022-08-21 13:12:19', 'TENDER_INVITE', 2, '收到《东莞市民政系统小程序》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=9', -1, '2');
INSERT INTO `sys_msg` VALUES (97, '2022-08-21 13:12:19', 'TENDER_INVITE', 3, '收到《东莞市民政系统小程序》投标邀请，请查看。', '/ssm/sup/tender-detail?tid=9', 1, '3');
INSERT INTO `sys_msg` VALUES (98, '2022-08-21 13:12:19', 'NEW_TENDER', -1, '收到新招标申请：《tets》，请前往审核！', '/ssm/admin/tender-detail?tid=18', -1, '18');
INSERT INTO `sys_msg` VALUES (99, '2022-08-21 13:12:19', 'NEW_TENDER', -1, '收到新招标申请：《3ewqe》，请前往审核！', '/ssm/admin/tender-detail?tid=19', 1, '19');
INSERT INTO `sys_msg` VALUES (100, '2022-08-21 13:12:19', 'TENDER_INVITE', 1, '收到《洛溪大桥拓宽工程》征集邀请，请查看。', '/ssm/sup/tender-detail?tid=1', 1, '1');
INSERT INTO `sys_msg` VALUES (101, '2022-08-21 13:12:19', 'TENDER_INVITE', 11, '收到《uuuu》征集邀请，请查看。', '/ssm/sup/tender-detail?tid=16', -1, '11');
INSERT INTO `sys_msg` VALUES (102, '2022-08-21 13:12:19', 'TENDER_INVITE', 4, '收到《洛溪大桥拓宽工程》征集邀请，请查看。', '/ssm/sup/tender-detail?tid=1', -1, '4');
INSERT INTO `sys_msg` VALUES (103, '2022-08-21 13:12:19', 'TENDER_INVITE', 5, '收到《洛溪大桥拓宽工程》征集邀请，请查看。', '/ssm/sup/tender-detail?tid=1', -1, '5');
INSERT INTO `sys_msg` VALUES (104, '2022-08-21 13:12:19', 'TENDER_INVITE', 4, '收到《洛溪大桥拓宽工程》征集邀请，请查看。', '/ssm/sup/tender-detail?tid=1', -1, '4');
INSERT INTO `sys_msg` VALUES (105, '2022-08-21 13:12:19', 'TENDER_INVITE', 10, '收到《洛溪大桥拓宽工程》征集邀请，请查看。', '/ssm/sup/tender-detail?tid=1', -1, '10');
INSERT INTO `sys_msg` VALUES (106, '2022-08-21 13:12:19', 'TENDER_INVITE', 5, '收到《洛溪大桥拓宽工程》征集邀请，请查看。', '/ssm/sup/tender-detail?tid=1', -1, '5');
INSERT INTO `sys_msg` VALUES (107, '2022-08-21 13:12:19', 'TENDER_INVITE', 10, '收到《洛溪大桥拓宽工程》征集邀请，请查看。', '/ssm/sup/tender-detail?tid=1', -1, '10');
INSERT INTO `sys_msg` VALUES (108, '2022-08-21 13:12:19', 'TENDER_INVITE', 1, '收到《广东机场旅客行李查询系统》征集邀请，请查看。', '/ssm/sup/tender-detail?tid=5', 1, '1');
INSERT INTO `sys_msg` VALUES (109, '2022-08-21 13:12:19', 'TENDER_INVITE', 2, '收到《广东机场旅客行李查询系统》征集邀请，请查看。', '/ssm/sup/tender-detail?tid=5', -1, '2');
INSERT INTO `sys_msg` VALUES (110, '2022-08-21 13:12:19', 'TENDER_INVITE', 1, '收到《湛江机场失物招领系统建设》征集邀请，请查看。', '/ssm/sup/tender-detail?tid=6', -1, '1');
INSERT INTO `sys_msg` VALUES (111, '2022-08-21 13:12:19', 'TENDER_INVITE', 1, '收到《广东机场旅客行李查询系统》征集邀请，请查看。', '/ssm/sup/tender-detail?tid=5', -1, '1');
INSERT INTO `sys_msg` VALUES (112, '2022-08-21 13:12:19', 'ASSESS_INVITE', 6, '您好，征集单位邀请您对《广东机场旅客行李查询系统》项目进行征集评估，请查看。', '/ssm/exp/toassess?iid=9&tid=5', 1, '9');
INSERT INTO `sys_msg` VALUES (113, '2022-08-21 13:12:19', 'ASSESS_INVITE', 1, '您好，征集单位邀请您对《洛溪大桥拓宽工程》项目进行征集评估，请查看。', '/ssm/exp/toassess?iid=10&tid=1', -1, '10');
INSERT INTO `sys_msg` VALUES (114, '2022-08-21 13:12:19', 'ASSESS_INVITE', 2, '您好，征集单位邀请您对《洛溪大桥拓宽工程》项目进行征集评估，请查看。', '/ssm/exp/toassess?iid=11&tid=1', 1, '11');
INSERT INTO `sys_msg` VALUES (115, '2022-08-21 13:12:19', 'ASSESS_INVITE', 3, '您好，征集单位邀请您对《洛溪大桥拓宽工程》项目进行征集评估，请查看。', '/ssm/exp/toassess?iid=12&tid=1', 1, '12');
INSERT INTO `sys_msg` VALUES (116, '2022-08-21 13:12:19', 'ASSESS_INVITE', 4, '您好，征集单位邀请您对《洛溪大桥拓宽工程》项目进行征集评估，请查看。', '/ssm/exp/toassess?iid=13&tid=1', 1, '13');
INSERT INTO `sys_msg` VALUES (117, '2022-08-21 13:12:19', 'NEW_REGIST_ENT', -1, '新注册征集方：test123，请前往激活！', '/ssm/admin/ent-detail?tid=10', 1, '10');
INSERT INTO `sys_msg` VALUES (118, '2022-08-21 12:48:21', 'NEW_TENDER', -1, '收到新征集申请：《23》，请前往审核！', '/ssm/admin/tender-detail?tid=20', -1, '20');

-- ----------------------------
-- Table structure for tender
-- ----------------------------
DROP TABLE IF EXISTS `tender`;
CREATE TABLE `tender`  (
  `tender_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenderee` int(11) NULL DEFAULT NULL,
  `project_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `incharge` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `project_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `budget` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `publish_time` datetime(0) NULL DEFAULT NULL,
  `end_time` datetime(0) NULL DEFAULT NULL,
  `project_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `attachement` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  `key_words` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `winner` int(11) NULL DEFAULT NULL,
  `tender_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tender_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tender
-- ----------------------------
INSERT INTO `tender` VALUES (1, 1, '洛溪大桥拓宽工程', '林高新', '13900008888', 'limgx@126.com', '工程类', '12.38亿元', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>据洛溪大桥拓宽工程的建设单位广州市中心区交通项目领导小组办公室介绍，新桥北接广州大道，南接105国道，终点位于洛溪大桥收费站北侧，主桥设计为双塔双索面叠合梁斜拉桥，计划2021年完工。工程将在现有的洛溪大桥东、西两侧各新建一座与旧桥分离的桥梁，新桥位于旧桥两侧23米处，单向3车道，桥宽14.5米、长2018米。<br><br></p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '桥梁 道路', -100, 'SJ80292103');
INSERT INTO `tender` VALUES (2, 1, '测试系统标书', '王小明', '18900003333', '321843928@qq.com', '产品类', '120万', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<h3>这是测试信息</h3>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '软件', -100, 'DQ9022313');
INSERT INTO `tender` VALUES (3, 5, '罗湖客运自助购票终端采购', '李佳佳', '13899903333', 'lijj@outlook.com', '产品类', '320万元', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>售票自助终端系为解决目前交通系统购票困难，排队时间较长，取票时间弹性小等问题而研发的高性能人机交互产品，该产品不但具备自助打印车票功能模块，同时还具备预订票功能，银联支付购票、发票打印等功能模块，功能先进、拓展性强。通过售票自助终端不但能使旅客在网上查询和购票，从各方面方便旅客，从而大幅度提高满意度；还能使交通系统根据订单情况及时调整运力。</p><p><img src=\"http://localhost:8080/ssm/upload/20200515205838p6blh.jpg\" style=\"max-width:50%;\"><br></p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '软件 终端 设备', -100, 'SJ87987335');
INSERT INTO `tender` VALUES (4, 5, '罗湖客运站候车厅室内绿化工程', '赵宝兴', '18977783321', '183989318@qq.com', '工程类', '75万元', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>罗湖客运有三个候车厅，由于人员密集，为净化空气、优化候车环境、提高旅客出行体验，现需要对室内绿化进行全新升级改造。要求投标人必须有室内园林项目经验。</p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '绿化 园林 ', -100, 'CS13278362');
INSERT INTO `tender` VALUES (5, 3, '广东机场旅客行李查询系统', '王路', '13844432990', 'wangll@126.com', '服务类', '280万', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>提供全省范围所有机场的统一行李查询系统</p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '软件', -100, 'KJ32903202');
INSERT INTO `tender` VALUES (6, 3, '湛江机场失物招领系统建设', '何贤龙', '18900984453', '121983931@qq.com', '服务类', '170万元', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>首页、个人中心、发布物品、申领物品、发布与申领管理、搜索查询、退出等模块<br> 在首页模块实现了模糊查询、分类查询等功能<br> 用户管理模块实现了登录、注册、修改、查看信息等功能<br> 个人中心模块实现了查看、删除、修改发布物品、处理申领等功能</p><p><img style=\"max-width:100%;\" src=\"http://localhost:8080/ssm/upload/20200517200804xh633.jpg\"><b></b><i></i><u></u><sub></sub><sup></sup><strike></strike><br></p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '软件 机场', -100, 'GP3929013');
INSERT INTO `tender` VALUES (7, 5, '客车维修信息管理系统', '张标明', '13344568892', '213213213@qq.com', '服务类', '68万元', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>为罗湖客运站汽车维修提供信息管理系统，方便汽车维修申请、维修过程、保养记录等功能，可以让一线维修工人使用，方便全程的信息流跟踪。</p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '软件 APP', -100, 'SJ24532545');
INSERT INTO `tender` VALUES (8, 3, '省机场集团值班室监控大屏', '关晓桐', '13899905578', 'gxt@gdap.net', '产品类', '125万元', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>负责值班室的监控大屏软硬件开发，可以监控省内所有机场的实时数据。</p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '软件 大屏', -100, 'SJ23432100');
INSERT INTO `tender` VALUES (9, 6, '东莞市民政系统小程序', '刘青', '18977839002', 'liuqing@126.com', '服务类', '1200万元', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>开发一个微信小程序 ，可以提供东莞民政办事服务</p><p><img src=\"http://localhost:8080/ssm/upload/2020051923131139kiz.jpg\" style=\"max-width:50%;\"><br></p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '电子政务 软件', -100, 'KJ84328433');
INSERT INTO `tender` VALUES (10, 3, '员工手机打卡考勤系统', '张小明', '13899934552', '21433824@qq.com', '服务类', '28万元', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>员工手机打卡考勤系统，做成B/S架构软件，可以用手机H5以及钉钉访问</p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '软件', -100, '158988004204');
INSERT INTO `tender` VALUES (13, 6, '员工在线食堂', '陈聪', '18900094833', '21438242@qq.com', '服务类', '35万', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>3829432Fdksamflq的撒的撒dsamfewq</p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, NULL, -100, '1590675812725');
INSERT INTO `tender` VALUES (14, 3, '1111', '222', '121211432432', '32432@qq.com', '产品类', '6666', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>fwq4r32fawewq32</p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '321432', -100, '1591712804976');
INSERT INTO `tender` VALUES (15, 3, 'aaaa', 'ad232', '32413214321', 'dafe@qq.com', '服务类', '5555', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>fwafeq</p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '4r3', -100, '1591712939079');
INSERT INTO `tender` VALUES (16, 3, 'uuuu', 'dksal', '13892489321', '3241932@qq.com', '产品类', '7777', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>dafe2qf</p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '3 32', -100, '1591790853194');
INSERT INTO `tender` VALUES (17, 6, '饭堂小卖部招标', '张三', '18900001111', 'tekwl@163.com', '服务类', '10000', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>这是测试信息</p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '零售', -100, '1619438094594');
INSERT INTO `tender` VALUES (18, 1, 'tets', '321', '18922892134', '324423@qq.com', '工程类', '100', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>321321</p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 1, '2313', -100, '1660626952899');
INSERT INTO `tender` VALUES (19, 1, '3ewqe', 'qwewq', '21312312', 'ewqe', '工程类', '3213', '2022-08-16 15:46:06', '2022-08-16 09:26:10', '<p>32132</p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', -1, '323', -100, '1660626983298');
INSERT INTO `tender` VALUES (20, 1, '23', '32', '32', '323', '工程类', '32', '2022-08-21 12:48:21', '2022-08-25 00:00:00', '<p>3232</p>', '672c2294-2570-4bf0-925b-97263038ec23.docx', 0, '2332', NULL, '1661057301300');

-- ----------------------------
-- Table structure for tender_history
-- ----------------------------
DROP TABLE IF EXISTS `tender_history`;
CREATE TABLE `tender_history`  (
  `tender_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `tendering` int(11) NULL DEFAULT NULL,
  `tenderee` int(11) NULL DEFAULT NULL,
  `bidder` int(11) NULL DEFAULT NULL,
  `incharge` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contact` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `amount` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tender_time` datetime(0) NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  `attachment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tender_history_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tender_history
-- ----------------------------
INSERT INTO `tender_history` VALUES (1, 1, 1, 4, '张莉', '18900032243', 'zhangli@126.com', '85万元', '2022-08-21 13:12:19', 0, '69147731-deaa-4787-9997-98dce5d70526.zip', NULL);
INSERT INTO `tender_history` VALUES (2, 4, 5, 5, '张振南', '18900321123', 'zhangzn@126.com', '68万元', '2022-08-21 13:12:19', 3, 'ecb8034d-a8f5-477b-937d-be71cb6164cb.docx', NULL);
INSERT INTO `tender_history` VALUES (3, 4, 5, 4, '罗琛', '18878732212', '12893928@qq.com', '78万元', '2022-08-21 13:12:19', 3, '5e2713e1-43ff-4f88-977b-af2917ac8749.docx', NULL);
INSERT INTO `tender_history` VALUES (4, 4, 5, 6, '袁芳', '13788392221', '12839813@qq.com', '68万元', '2022-08-21 13:12:19', 2, '940cc3fa-5c5a-466e-ac0a-708c938588cd.docx', NULL);
INSERT INTO `tender_history` VALUES (5, 7, 5, 7, '任俊杰', '13677893443', 'rjj@jyxx.net', '55.87万元', '2022-08-21 13:12:19', 3, '2b905ea2-fd8c-4b3d-9d42-2399009f6f52.docx', NULL);
INSERT INTO `tender_history` VALUES (6, 5, 3, 7, '张静', '13677892243', 'rjj@jyxx.net', '198万元', '2022-08-21 13:12:19', 0, '8466238e-8202-43f5-b888-1f94a3ed197c.docx', NULL);
INSERT INTO `tender_history` VALUES (7, 5, 3, 3, '符汉中', '18799083345', 'fuhz@szhs.cn', '256.8万元', '2022-08-21 13:12:19', 0, NULL, NULL);
INSERT INTO `tender_history` VALUES (8, 7, 5, 2, '王柏炎', '18799087665', 'wby@zshj.net', '65万元', '2022-08-21 13:12:19', 2, 'a4346c35-0d1e-465e-aea1-3fdf86046f8d.docx', NULL);
INSERT INTO `tender_history` VALUES (9, 7, 5, 8, '刘祺', '18900385722', 'liuqi1993@126.com', '58万元', '2022-08-21 13:12:19', 3, NULL, NULL);
INSERT INTO `tender_history` VALUES (10, 7, 5, 1, '张小杰', '17988320098', '213231418@qq.com', '62万元', '2022-08-21 13:12:19', 3, NULL, NULL);
INSERT INTO `tender_history` VALUES (11, 9, 6, 7, '张云清', '18900948854', 'zyqing@126.com', '820万元', '2022-08-21 13:12:19', 0, '912876aa-c3ac-4ca4-8082-6e8b57de06f5.docx', NULL);
INSERT INTO `tender_history` VALUES (12, 1, 1, 5, '杨涛', '18900093334', 'yangt@163.com', '1900万元', '2022-08-21 13:12:19', 0, 'da8e47bd-b23e-4748-a8ff-7ee58b4d3cbd.docx', NULL);
INSERT INTO `tender_history` VALUES (13, 2, 1, 3, '李四', '17890901234', 'kdlsafasd@126.com', '30000', '2022-08-21 13:12:19', 0, '4442fe5a-8d4d-4cd8-89f6-345403515959.jpg', NULL);
INSERT INTO `tender_history` VALUES (14, 9, 6, 3, '王五', '17788884444', '34289432143@qq.com', '88888', '2022-08-21 13:12:19', 0, '14c34602-86de-446c-8703-671f54ac7007.png', NULL);
INSERT INTO `tender_history` VALUES (15, 9, 6, 1, '32', '4324', '2343', '432', '2022-08-21 13:12:19', 0, 'ff44de1b-60a2-427b-8b76-8a8ad4fc1546.docx', NULL);

SET FOREIGN_KEY_CHECKS = 1;
