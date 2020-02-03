/*
Navicat MySQL Data Transfer

Source Server         : 我的阿里云高配
Source Server Version : 50726
Source Host           : 47.98.233.163:3306
Source Database       : personal_dose

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2019-11-18 22:59:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admins`
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nickname` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `signature` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '个性签名',
  `email` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录地区',
  `ip` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录IP',
  `headimgurl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户头像',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `admins_name_unique` (`name`) USING BTREE,
  UNIQUE KEY `admins_email_unique` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES ('1', 'admin', 'admin', '我是超级管理员', '616877020@qq.com', '$2y$10$dIp9wyKf1X89deHJgLvzJ.c0XATIz1769hq/cY.bvQFsoQ0S/DwGC', 'Jk6cYwxx2ll7QWI0R4kqC8pBRlyXrvFSBp8mx8TQVM3WmnI7tB40etS8x235', '北京北京XX・联通', '222.131.38.188', 'admin/YzwMq1kdnjOBfqW3kNgMLrl2EJfSHL74SrSTWKsl.jpeg', '2018-08-10 21:18:05', '2019-11-18 22:34:32');
INSERT INTO `admins` VALUES ('5', 'sun_admin', null, null, '9829384@qq.com', '$2y$10$5HlVhxhLDBhO2SNk6jKslOfCGkUfN7XPVHkyC2uQRv3nRwWbTv0WW', 'kfXdmGodAP7C3njCqoqIdpituSMuXtGpTKve9wCglzvBNWUbL0Z0iBCkDDZS', 'unknown', '106.92.117.66', 'admin/default.png', '2019-11-14 10:31:36', '2019-11-18 22:27:48');

-- ----------------------------
-- Table structure for `check_logs`
-- ----------------------------
DROP TABLE IF EXISTS `check_logs`;
CREATE TABLE `check_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `plan_id` int(10) NOT NULL DEFAULT '0' COMMENT '计划id',
  `label_id` int(10) NOT NULL DEFAULT '0' COMMENT 'RFID标签id',
  `company_id` int(10) NOT NULL DEFAULT '0' COMMENT '单位id',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0未送样，1已送样',
  `admin_name` varchar(100) NOT NULL DEFAULT '' COMMENT '审核员',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of check_logs
-- ----------------------------

-- ----------------------------
-- Table structure for `company`
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '名称',
  `number` varchar(100) NOT NULL DEFAULT '',
  `contact` varchar(100) NOT NULL DEFAULT '' COMMENT '联系人',
  `mobile` varchar(50) NOT NULL DEFAULT '' COMMENT '联系电话',
  `region_id` int(10) NOT NULL DEFAULT '0' COMMENT '区域id',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态，0禁用，1正常',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of company
-- ----------------------------

-- ----------------------------
-- Table structure for `data`
-- ----------------------------
DROP TABLE IF EXISTS `data`;
CREATE TABLE `data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(255) DEFAULT NULL,
  `test_at` varchar(100) DEFAULT NULL,
  `accept_number` varchar(100) DEFAULT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `data1` varchar(100) DEFAULT NULL,
  `data2` varchar(100) DEFAULT NULL,
  `data3` varchar(100) DEFAULT NULL,
  `data4` varchar(100) DEFAULT NULL,
  `data5` varchar(100) DEFAULT NULL,
  `data6` varchar(100) DEFAULT NULL,
  `data7` varchar(100) DEFAULT NULL,
  `data8` varchar(100) DEFAULT NULL,
  `created_at` int(10) NOT NULL DEFAULT '0',
  `updated_at` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data
-- ----------------------------

-- ----------------------------
-- Table structure for `label_logs`
-- ----------------------------
DROP TABLE IF EXISTS `label_logs`;
CREATE TABLE `label_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `label_id` int(10) NOT NULL DEFAULT '0' COMMENT 'RFID标签id',
  `plan_id` int(10) NOT NULL DEFAULT '0' COMMENT '计划id',
  `company_id` int(10) NOT NULL DEFAULT '0' COMMENT '单位id',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0发放，1回收，2报废',
  `admin_name` varchar(100) NOT NULL DEFAULT '' COMMENT '审核员',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of label_logs
-- ----------------------------

-- ----------------------------
-- Table structure for `labels`
-- ----------------------------
DROP TABLE IF EXISTS `labels`;
CREATE TABLE `labels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL COMMENT '编号',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '区域id',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态，0未发放，1已发放，2已回收，3报废',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `send_at` int(10) NOT NULL DEFAULT '0' COMMENT '发放时间',
  `bind_at` int(10) NOT NULL DEFAULT '0' COMMENT '绑定时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of labels
-- ----------------------------

-- ----------------------------
-- Table structure for `login_logs`
-- ----------------------------
DROP TABLE IF EXISTS `login_logs`;
CREATE TABLE `login_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `ip` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '登录IP',
  `location` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '登录地区',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '登录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of login_logs
-- ----------------------------

-- ----------------------------
-- Table structure for `menus`
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '资源名称',
  `link` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '资源链接',
  `permission` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '资源权限',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父级资源ID',
  `icon` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '资源图标',
  `sort` smallint(3) unsigned DEFAULT '0' COMMENT '排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `menus_name_unique` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO `menus` VALUES ('10', '系统主页', '-', '-', '0', 'fa-dashboard', '20', '2017-10-10 22:04:03', '2019-11-07 21:55:27');
INSERT INTO `menus` VALUES ('11', '权限管理', '-', '-', '0', 'fa-key', '19', '2017-10-10 22:05:12', '2018-08-18 23:17:20');
INSERT INTO `menus` VALUES ('12', '系统首页', 'index/index', 'index.index', '10', '-', '0', '2017-10-10 22:06:56', '2017-10-10 22:08:34');
INSERT INTO `menus` VALUES ('14', '管理员列表', 'admin/index', 'admin.index', '11', '-', '0', '2017-10-10 22:09:33', '2017-10-10 22:09:33');
INSERT INTO `menus` VALUES ('15', '角色列表', 'role/index', 'role.index', '11', '-', '0', '2017-10-10 22:10:08', '2017-10-10 22:10:08');
INSERT INTO `menus` VALUES ('19', '日志管理', '-', '-', '0', 'fa-file', '0', '2017-10-10 22:28:56', '2017-10-10 22:28:56');
INSERT INTO `menus` VALUES ('34', '登录日志', 'log/index', 'log.index', '19', '-', '0', '2017-10-26 13:45:04', '2017-10-26 13:52:17');
INSERT INTO `menus` VALUES ('176', '单位管理', '-', '-', '0', 'fa-building', '1', '2019-10-11 16:07:58', '2019-10-11 16:08:54');
INSERT INTO `menus` VALUES ('177', '单位列表', 'company/index', 'company.index', '176', '-', '0', '2019-10-11 16:10:02', '2019-10-11 16:10:02');
INSERT INTO `menus` VALUES ('178', '职业列表', 'vocation/index', 'vocation.index', '176', '-', '0', '2019-10-11 16:32:25', '2019-10-11 16:32:25');
INSERT INTO `menus` VALUES ('179', '区域列表', 'region/index', 'region.index', '176', '-', '1', '2019-10-13 16:29:22', '2019-11-13 11:58:29');
INSERT INTO `menus` VALUES ('180', '个人信息管理', '-', '-', '0', 'fa-user', '0', '2019-10-15 15:49:46', '2019-10-15 15:49:46');
INSERT INTO `menus` VALUES ('181', '个人信息列表', 'user/index', 'user.index', '180', '-', '0', '2019-10-15 15:50:10', '2019-10-15 15:50:10');
INSERT INTO `menus` VALUES ('182', '号牌管理', '-', '-', '0', 'fa-barcode', '0', '2019-10-15 22:14:38', '2019-10-15 22:14:38');
INSERT INTO `menus` VALUES ('183', '号牌列表', 'number/index', 'number.index', '182', '-', '0', '2019-10-15 22:15:07', '2019-10-15 22:15:07');
INSERT INTO `menus` VALUES ('184', '剂量牌标签管理', '-', '-', '0', 'fa-credit-card', '0', '2019-10-17 14:58:42', '2019-11-07 21:51:03');
INSERT INTO `menus` VALUES ('185', '剂量牌标签列表', 'label/index', 'label.index', '184', '-', '0', '2019-10-17 14:59:17', '2019-11-07 21:51:32');
INSERT INTO `menus` VALUES ('186', '样品回收管理', '-', '-', '0', 'fa-flask', '0', '2019-10-19 11:39:04', '2019-10-19 11:39:04');
INSERT INTO `menus` VALUES ('187', '剂量采集计划', 'plan/index', 'plan.index', '194', '-', '0', '2019-10-19 11:39:24', '2019-10-29 09:34:57');
INSERT INTO `menus` VALUES ('188', '样品审核', 'recovery/index', 'recovery.index', '186', '-', '0', '2019-10-20 22:45:51', '2019-10-20 22:45:51');
INSERT INTO `menus` VALUES ('189', '样品审核记录', 'check_log/index', 'check_log.index', '186', '-', '0', '2019-10-23 12:47:45', '2019-10-23 12:47:45');
INSERT INTO `menus` VALUES ('190', '数据分析', '-', '-', '0', 'fa-database', '0', '2019-10-25 15:32:31', '2019-10-25 15:32:31');
INSERT INTO `menus` VALUES ('191', '数据列表', 'data/index', 'data.index', '190', '-', '0', '2019-10-25 15:33:02', '2019-10-25 15:33:02');
INSERT INTO `menus` VALUES ('192', '剂量牌管理', '-', '-', '0', 'fa-tag', '0', '2019-10-26 11:24:48', '2019-10-26 11:26:17');
INSERT INTO `menus` VALUES ('193', '剂量牌列表', 'grant/index', 'grant.index', '192', '-', '0', '2019-10-26 11:26:51', '2019-10-26 11:26:51');
INSERT INTO `menus` VALUES ('194', '计划管理', '-', '-', '0', 'fa-calendar-o', '0', '2019-10-29 09:32:37', '2019-10-29 09:32:37');
INSERT INTO `menus` VALUES ('195', '样品审核记录统计', 'check_report/index', 'check_report.index', '186', '-', '0', '2019-10-29 10:59:40', '2019-10-29 10:59:40');

-- ----------------------------
-- Table structure for `migrations`
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES ('1', '2014_10_12_100000_create_password_resets_table', '1');
INSERT INTO `migrations` VALUES ('2', '2017_09_17_153225_create_admins_table', '1');
INSERT INTO `migrations` VALUES ('3', '2017_09_17_160633_entrust_setup_tables', '1');
INSERT INTO `migrations` VALUES ('4', '2017_09_20_223546_create_menus_table', '1');
INSERT INTO `migrations` VALUES ('5', '2017_10_29_224620_create_login_logs_table', '1');
INSERT INTO `migrations` VALUES ('6', '2017_10_31_225435_create_system_config_table', '1');

-- ----------------------------
-- Table structure for `numbers`
-- ----------------------------
DROP TABLE IF EXISTS `numbers`;
CREATE TABLE `numbers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL COMMENT '编号',
  `region_id` int(10) NOT NULL DEFAULT '0' COMMENT '区域id',
  `company_id` int(10) NOT NULL DEFAULT '0' COMMENT '单位id',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态，0禁用，1正常',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(10) unsigned zerofill NOT NULL DEFAULT '0000000000' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of numbers
-- ----------------------------

-- ----------------------------
-- Table structure for `password_resets`
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for `permission_role`
-- ----------------------------
DROP TABLE IF EXISTS `permission_role`;
CREATE TABLE `permission_role` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`) USING BTREE,
  KEY `permission_role_role_id_foreign` (`role_id`) USING BTREE,
  CONSTRAINT `permission_role_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permission_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of permission_role
-- ----------------------------
INSERT INTO `permission_role` VALUES ('1', '1');
INSERT INTO `permission_role` VALUES ('2', '1');
INSERT INTO `permission_role` VALUES ('4', '1');
INSERT INTO `permission_role` VALUES ('6', '1');
INSERT INTO `permission_role` VALUES ('7', '1');
INSERT INTO `permission_role` VALUES ('8', '1');
INSERT INTO `permission_role` VALUES ('9', '1');
INSERT INTO `permission_role` VALUES ('11', '1');
INSERT INTO `permission_role` VALUES ('13', '1');
INSERT INTO `permission_role` VALUES ('14', '1');
INSERT INTO `permission_role` VALUES ('15', '1');
INSERT INTO `permission_role` VALUES ('16', '1');
INSERT INTO `permission_role` VALUES ('18', '1');
INSERT INTO `permission_role` VALUES ('20', '1');
INSERT INTO `permission_role` VALUES ('22', '1');
INSERT INTO `permission_role` VALUES ('23', '1');
INSERT INTO `permission_role` VALUES ('24', '1');
INSERT INTO `permission_role` VALUES ('26', '1');
INSERT INTO `permission_role` VALUES ('28', '1');
INSERT INTO `permission_role` VALUES ('29', '1');
INSERT INTO `permission_role` VALUES ('30', '1');
INSERT INTO `permission_role` VALUES ('31', '1');
INSERT INTO `permission_role` VALUES ('38', '1');
INSERT INTO `permission_role` VALUES ('60', '1');
INSERT INTO `permission_role` VALUES ('66', '1');
INSERT INTO `permission_role` VALUES ('67', '1');
INSERT INTO `permission_role` VALUES ('83', '1');
INSERT INTO `permission_role` VALUES ('84', '1');
INSERT INTO `permission_role` VALUES ('1', '2');
INSERT INTO `permission_role` VALUES ('83', '2');
INSERT INTO `permission_role` VALUES ('84', '2');
INSERT INTO `permission_role` VALUES ('1', '3');
INSERT INTO `permission_role` VALUES ('66', '3');
INSERT INTO `permission_role` VALUES ('67', '3');
INSERT INTO `permission_role` VALUES ('83', '3');
INSERT INTO `permission_role` VALUES ('84', '3');
INSERT INTO `permission_role` VALUES ('1', '4');
INSERT INTO `permission_role` VALUES ('31', '4');
INSERT INTO `permission_role` VALUES ('66', '4');
INSERT INTO `permission_role` VALUES ('83', '4');
INSERT INTO `permission_role` VALUES ('84', '4');
INSERT INTO `permission_role` VALUES ('85', '4');

-- ----------------------------
-- Table structure for `permissions`
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `permissions_name_unique` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES ('1', 'index.index', '后台首页', '后台起始页包含统计信息', '2017-09-21 23:51:17', '2017-09-21 23:51:17');
INSERT INTO `permissions` VALUES ('2', 'admin.index', '管理员列表', '展示管理员列表信息', '2017-09-21 23:52:53', '2017-09-21 23:52:53');
INSERT INTO `permissions` VALUES ('4', 'admin.store', '添加管理员', '添加管理员', '2017-09-21 23:54:56', '2019-03-11 17:51:08');
INSERT INTO `permissions` VALUES ('6', 'admin.edit', '编辑管理员', '编辑管理员', '2017-09-22 00:06:01', '2017-09-22 00:06:01');
INSERT INTO `permissions` VALUES ('7', 'admin.update', '更新管理员', '更新管理员', '2017-09-22 00:06:22', '2017-09-22 00:06:22');
INSERT INTO `permissions` VALUES ('8', 'admin.destroy', '删除管理员', '删除管理员', '2017-09-22 00:06:47', '2017-09-22 00:06:47');
INSERT INTO `permissions` VALUES ('9', 'permission.index', '权限列表', '权限列表', '2017-09-22 00:08:15', '2017-09-22 00:08:15');
INSERT INTO `permissions` VALUES ('11', 'permission.store', '添加权限', '添加权限', '2017-09-22 00:10:09', '2017-09-22 00:10:09');
INSERT INTO `permissions` VALUES ('13', 'permission.edit', '编辑权限', '编辑权限', '2017-09-22 00:11:17', '2017-09-22 00:11:17');
INSERT INTO `permissions` VALUES ('14', 'permission.update', '更新权限', '更新权限', '2017-09-22 00:11:36', '2017-09-22 00:11:36');
INSERT INTO `permissions` VALUES ('15', 'permission.destroy', '删除权限', '删除权限', '2017-09-22 00:12:23', '2017-09-22 00:12:23');
INSERT INTO `permissions` VALUES ('16', 'role.index', '角色列表', '角色列表', '2017-09-22 00:16:10', '2017-09-22 00:16:10');
INSERT INTO `permissions` VALUES ('18', 'role.store', '添加角色', '添加角色', '2017-09-22 00:17:11', '2017-09-22 00:17:11');
INSERT INTO `permissions` VALUES ('20', 'role.edit', '编辑权限', '编辑权限', '2017-09-22 00:18:04', '2017-09-22 00:18:04');
INSERT INTO `permissions` VALUES ('22', 'role.update', '更新角色', '更新角色', '2017-09-22 00:19:13', '2017-09-22 00:19:13');
INSERT INTO `permissions` VALUES ('23', 'role.destroy', '删除角色', '删除角色', '2017-09-22 00:19:45', '2017-09-22 00:19:45');
INSERT INTO `permissions` VALUES ('24', 'menu.index', '资源列表', '资源列表', '2017-09-22 00:22:25', '2017-09-22 00:22:25');
INSERT INTO `permissions` VALUES ('26', 'menu.store', '添加资源', '添加资源', '2017-09-22 00:23:52', '2017-09-22 00:23:52');
INSERT INTO `permissions` VALUES ('28', 'menu.edit', '编辑资源', '编辑资源', '2017-09-22 00:24:55', '2017-09-22 00:24:55');
INSERT INTO `permissions` VALUES ('29', 'menu.update', '更新资源', '更新资源', '2017-09-22 00:26:06', '2017-09-22 00:26:06');
INSERT INTO `permissions` VALUES ('30', 'menu.destroy', '删除资源', '删除资源', '2017-09-22 00:26:42', '2017-09-22 00:26:42');
INSERT INTO `permissions` VALUES ('31', 'system.index', '系统设置', '系统设置', '2017-09-22 00:29:52', '2017-10-11 10:20:43');
INSERT INTO `permissions` VALUES ('38', 'system.update', '更新系统设置', '更新系统设置', '2017-10-26 13:56:46', '2017-10-26 13:56:46');
INSERT INTO `permissions` VALUES ('60', 'index.flush', '清除缓存', '清除缓存', '2017-10-26 15:44:23', '2017-10-26 15:44:23');
INSERT INTO `permissions` VALUES ('66', 'log.index', '登录日志列表', '登录日志列表', '2017-10-26 15:47:19', '2017-10-26 15:47:19');
INSERT INTO `permissions` VALUES ('67', 'log.destroy', '删除登录日志', '删除登录日志', '2017-10-26 15:47:47', '2017-10-26 15:47:47');
INSERT INTO `permissions` VALUES ('83', 'index.profile', '个人设置', '个人设置', '2017-11-02 22:33:08', '2017-11-02 22:33:08');
INSERT INTO `permissions` VALUES ('84', 'index.update_profile', '更新个人设置', '更新个人设置', '2017-11-02 22:33:34', '2017-11-02 22:33:34');
INSERT INTO `permissions` VALUES ('85', 'user.index', '个人信息列表', '个人信息列表', '2019-11-18 22:16:40', '2019-11-18 22:16:40');
INSERT INTO `permissions` VALUES ('86', 'user.store', '新增个人信息', '新增个人信息', '2019-11-18 22:17:57', '2019-11-18 22:18:46');
INSERT INTO `permissions` VALUES ('87', 'user.edit', '编辑个人信息', '编辑个人信息', '2019-11-18 22:19:27', '2019-11-18 22:19:27');
INSERT INTO `permissions` VALUES ('88', 'user.update', '更新个人信息', '更新个人信息', '2019-11-18 22:19:46', '2019-11-18 22:19:46');
INSERT INTO `permissions` VALUES ('89', 'user.destroy', '删除个人信息', '删除个人信息', '2019-11-18 22:20:08', '2019-11-18 22:20:08');
INSERT INTO `permissions` VALUES ('90', 'user.import', 'Excel导入个人信息', 'Excel导入个人信息', '2019-11-18 22:20:34', '2019-11-18 22:37:12');
INSERT INTO `permissions` VALUES ('91', 'user.print_number', '打印号牌', '打印号牌', '2019-11-18 22:20:49', '2019-11-18 22:20:49');
INSERT INTO `permissions` VALUES ('92', 'upload.index', '文件上传框', '文件上传框', '2019-11-18 22:23:13', '2019-11-18 22:23:13');
INSERT INTO `permissions` VALUES ('93', 'upload.imageUp', '文件上传', '文件上传', '2019-11-18 22:23:31', '2019-11-18 22:23:31');
INSERT INTO `permissions` VALUES ('94', 'company.index', '单位列表', '单位列表', '2019-11-18 22:23:48', '2019-11-18 22:23:48');
INSERT INTO `permissions` VALUES ('95', 'company.store', '新增单位', '新增单位', '2019-11-18 22:24:05', '2019-11-18 22:24:05');
INSERT INTO `permissions` VALUES ('96', 'company.edit', '编辑单位', '编辑单位', '2019-11-18 22:24:19', '2019-11-18 22:24:19');
INSERT INTO `permissions` VALUES ('97', 'company.update', '更新单位', '更新单位', '2019-11-18 22:24:41', '2019-11-18 22:24:41');
INSERT INTO `permissions` VALUES ('98', 'company.destroy', '删除单位', '删除单位', '2019-11-18 22:24:54', '2019-11-18 22:24:54');
INSERT INTO `permissions` VALUES ('99', 'company.import', 'Excel导入单位', 'Excel导入单位', '2019-11-18 22:36:55', '2019-11-18 22:36:55');
INSERT INTO `permissions` VALUES ('100', 'vocation.index', '职位列表', '职位列表', '2019-11-18 22:37:34', '2019-11-18 22:37:34');
INSERT INTO `permissions` VALUES ('101', 'vocation.store', '新增职位', '新增职位', '2019-11-18 22:37:46', '2019-11-18 22:37:46');
INSERT INTO `permissions` VALUES ('102', 'vocation.edit', '编辑职位', '编辑职位', '2019-11-18 22:38:00', '2019-11-18 22:38:00');
INSERT INTO `permissions` VALUES ('103', 'vocation.update', '更新职位', '更新职位', '2019-11-18 22:38:14', '2019-11-18 22:38:14');
INSERT INTO `permissions` VALUES ('104', 'vocation.destroy', '删除职位', '删除职位', '2019-11-18 22:38:27', '2019-11-18 22:38:27');
INSERT INTO `permissions` VALUES ('105', 'region.index', '区域列表', '区域列表', '2019-11-18 22:38:41', '2019-11-18 22:39:00');
INSERT INTO `permissions` VALUES ('106', 'region.store', '新增区域', '新增区域', '2019-11-18 22:39:13', '2019-11-18 22:39:13');
INSERT INTO `permissions` VALUES ('107', 'region.edit', '编辑区域', '编辑区域', '2019-11-18 22:39:28', '2019-11-18 22:39:28');
INSERT INTO `permissions` VALUES ('108', 'region.update', '更新区域', '更新区域', '2019-11-18 22:39:46', '2019-11-18 22:39:46');
INSERT INTO `permissions` VALUES ('109', 'region.destroy', '删除区域', '删除区域', '2019-11-18 22:39:57', '2019-11-18 22:39:57');
INSERT INTO `permissions` VALUES ('110', 'number.index', '号牌列表', '号牌列表', '2019-11-18 22:41:33', '2019-11-18 22:41:54');
INSERT INTO `permissions` VALUES ('111', 'number.store', '新增号牌', '新增号牌', '2019-11-18 22:42:10', '2019-11-18 22:42:10');
INSERT INTO `permissions` VALUES ('112', 'number.edit', '编辑号牌', '编辑号牌', '2019-11-18 22:42:24', '2019-11-18 22:42:24');
INSERT INTO `permissions` VALUES ('113', 'number.update', '更新号牌', '更新号牌', '2019-11-18 22:42:37', '2019-11-18 22:42:37');
INSERT INTO `permissions` VALUES ('114', 'number.destroy', '删除号牌', '删除号牌', '2019-11-18 22:42:53', '2019-11-18 22:42:53');
INSERT INTO `permissions` VALUES ('115', 'number.import', 'Excel导入号牌', 'Excel导入号牌', '2019-11-18 22:43:12', '2019-11-18 22:43:12');
INSERT INTO `permissions` VALUES ('116', 'label.index', '剂量牌标签列表', '剂量牌标签列表', '2019-11-18 22:43:36', '2019-11-18 22:43:36');
INSERT INTO `permissions` VALUES ('117', 'label.destroy', '删除剂量牌标签', '删除剂量牌标签', '2019-11-18 22:44:19', '2019-11-18 22:44:19');
INSERT INTO `permissions` VALUES ('118', 'user_label.index', '个人标签列表', '个人标签列表', '2019-11-18 22:44:52', '2019-11-18 22:44:52');
INSERT INTO `permissions` VALUES ('119', 'user_label.store', '绑定标签', '绑定标签', '2019-11-18 22:45:24', '2019-11-18 22:45:24');
INSERT INTO `permissions` VALUES ('120', 'user_label.destroy', '解绑标签', '解绑标签', '2019-11-18 22:45:38', '2019-11-18 22:45:38');
INSERT INTO `permissions` VALUES ('121', 'user_label.scrap', '报废标签', '报废标签', '2019-11-18 22:46:01', '2019-11-18 22:46:01');
INSERT INTO `permissions` VALUES ('122', 'plan.index', '计划列表', '计划列表', '2019-11-18 22:46:22', '2019-11-18 22:46:22');
INSERT INTO `permissions` VALUES ('123', 'plan.store', '新增计划', '新增计划', '2019-11-18 22:46:45', '2019-11-18 22:46:45');
INSERT INTO `permissions` VALUES ('124', 'plan.exit', '编辑计划', '编辑计划', '2019-11-18 22:47:11', '2019-11-18 22:47:11');
INSERT INTO `permissions` VALUES ('125', 'plan.update', '更新计划', '更新计划', '2019-11-18 22:47:25', '2019-11-18 22:47:25');
INSERT INTO `permissions` VALUES ('126', 'plan.destroy', '删除计划', '删除计划', '2019-11-18 22:47:47', '2019-11-18 22:47:47');
INSERT INTO `permissions` VALUES ('127', 'recovery.index', '样品审核列表', '样品审核列表', '2019-11-18 22:48:15', '2019-11-18 22:48:15');
INSERT INTO `permissions` VALUES ('128', 'recovery.check', '样品审核', '样品审核', '2019-11-18 22:48:40', '2019-11-18 22:48:40');
INSERT INTO `permissions` VALUES ('129', 'recovery.check_all', '样品批量审核', '样品批量审核', '2019-11-18 22:49:02', '2019-11-18 22:49:02');
INSERT INTO `permissions` VALUES ('130', 'recovery.remark', '样品审核备注', '样品审核备注', '2019-11-18 22:49:49', '2019-11-18 22:49:49');
INSERT INTO `permissions` VALUES ('131', 'recovery.store', '样品审核备注提交', '样品审核备注提交', '2019-11-18 22:51:12', '2019-11-18 22:51:12');
INSERT INTO `permissions` VALUES ('132', 'check_log.index', '样品审核记录列表', '样品审核记录列表', '2019-11-18 22:51:30', '2019-11-18 22:51:30');
INSERT INTO `permissions` VALUES ('133', 'check_log.show', '审核备注查看', '审核备注查看', '2019-11-18 22:52:21', '2019-11-18 22:52:21');
INSERT INTO `permissions` VALUES ('134', 'data.index', '数据分析列表', '数据分析列表', '2019-11-18 22:52:40', '2019-11-18 22:52:40');
INSERT INTO `permissions` VALUES ('135', 'data.import', 'Excel导入数据', 'Excel导入数据', '2019-11-18 22:52:57', '2019-11-18 22:52:57');
INSERT INTO `permissions` VALUES ('136', 'data.edit', '查看数据详情', '查看数据详情', '2019-11-18 22:53:18', '2019-11-18 22:53:18');
INSERT INTO `permissions` VALUES ('137', 'data.destroy', '删除数据', '删除数据', '2019-11-18 22:53:39', '2019-11-18 22:53:39');
INSERT INTO `permissions` VALUES ('138', 'grant.index', '剂量牌列表', '剂量牌列表', '2019-11-18 22:54:13', '2019-11-18 22:54:13');
INSERT INTO `permissions` VALUES ('139', 'grant.label_log', '查看记录牌记录', '查看剂量牌记录', '2019-11-18 22:54:43', '2019-11-18 22:54:43');
INSERT INTO `permissions` VALUES ('140', 'grant.grant_all', '批量发放剂量牌', '批量发放剂量牌', '2019-11-18 22:55:01', '2019-11-18 22:55:01');
INSERT INTO `permissions` VALUES ('141', 'check_report.index', '样品审核记录统计列表', '样品审核记录统计列表', '2019-11-18 22:55:22', '2019-11-18 22:55:22');
INSERT INTO `permissions` VALUES ('142', 'check_report.company_list', '单位样品审核统计', '单位样品审核统计', '2019-11-18 22:55:42', '2019-11-18 22:57:00');

-- ----------------------------
-- Table structure for `plans`
-- ----------------------------
DROP TABLE IF EXISTS `plans`;
CREATE TABLE `plans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '名称',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态，1开启，2关闭',
  `step` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0发放阶段，1回收阶段',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `end_at` int(10) NOT NULL DEFAULT '0' COMMENT '关闭时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of plans
-- ----------------------------

-- ----------------------------
-- Table structure for `recovery`
-- ----------------------------
DROP TABLE IF EXISTS `recovery`;
CREATE TABLE `recovery` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plan_id` int(10) NOT NULL DEFAULT '0' COMMENT '计划id',
  `number` varchar(100) NOT NULL,
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0未审核，1已审核',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=443 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of recovery
-- ----------------------------

-- ----------------------------
-- Table structure for `region`
-- ----------------------------
DROP TABLE IF EXISTS `region`;
CREATE TABLE `region` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '名称',
  `pid` int(10) NOT NULL DEFAULT '0' COMMENT '上级id',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态，0禁用，1正常',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of region
-- ----------------------------

-- ----------------------------
-- Table structure for `regions`
-- ----------------------------
DROP TABLE IF EXISTS `regions`;
CREATE TABLE `regions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` mediumint(8) unsigned NOT NULL,
  `parent_code` mediumint(8) unsigned DEFAULT '0',
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `letter` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '字母索引',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3316 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of regions
-- ----------------------------
INSERT INTO `regions` VALUES ('1', '110000', '86', '北京市', 'B');
INSERT INTO `regions` VALUES ('2', '120000', '86', '天津市', 'T');
INSERT INTO `regions` VALUES ('3', '130000', '86', '河北省', 'H');
INSERT INTO `regions` VALUES ('4', '140000', '86', '山西省', 'S');
INSERT INTO `regions` VALUES ('5', '150000', '86', '内蒙古自', 'N');
INSERT INTO `regions` VALUES ('6', '210000', '86', '辽宁省', 'L');
INSERT INTO `regions` VALUES ('7', '220000', '86', '吉林省', 'J');
INSERT INTO `regions` VALUES ('8', '230000', '86', '黑龙江省', 'H');
INSERT INTO `regions` VALUES ('9', '310000', '86', '上海市', 'S');
INSERT INTO `regions` VALUES ('10', '320000', '86', '江苏省', 'J');
INSERT INTO `regions` VALUES ('11', '330000', '86', '浙江省', 'Z');
INSERT INTO `regions` VALUES ('12', '340000', '86', '安徽省', 'A');
INSERT INTO `regions` VALUES ('13', '350000', '86', '福建省', 'F');
INSERT INTO `regions` VALUES ('14', '360000', '86', '江西省', 'J');
INSERT INTO `regions` VALUES ('15', '370000', '86', '山东省', 'S');
INSERT INTO `regions` VALUES ('16', '410000', '86', '河南省', 'H');
INSERT INTO `regions` VALUES ('17', '420000', '86', '湖北省', 'H');
INSERT INTO `regions` VALUES ('18', '430000', '86', '湖南省', 'H');
INSERT INTO `regions` VALUES ('19', '440000', '86', '广东省', 'G');
INSERT INTO `regions` VALUES ('20', '450000', '86', '广西壮族自治区', 'G');
INSERT INTO `regions` VALUES ('21', '460000', '86', '海南省', 'H');
INSERT INTO `regions` VALUES ('22', '500000', '86', '重庆市', 'C');
INSERT INTO `regions` VALUES ('23', '510000', '86', '四川省', 'S');
INSERT INTO `regions` VALUES ('24', '520000', '86', '贵州省', 'G');
INSERT INTO `regions` VALUES ('25', '530000', '86', '云南省', 'Y');
INSERT INTO `regions` VALUES ('26', '540000', '86', '西藏自治区', 'X');
INSERT INTO `regions` VALUES ('27', '610000', '86', '陕西省', 'S');
INSERT INTO `regions` VALUES ('28', '620000', '86', '甘肃省', 'G');
INSERT INTO `regions` VALUES ('29', '630000', '86', '青海省', 'Q');
INSERT INTO `regions` VALUES ('30', '640000', '86', '宁夏回族自治区', 'N');
INSERT INTO `regions` VALUES ('31', '650000', '86', '新疆维吾尔自治区', 'X');
INSERT INTO `regions` VALUES ('32', '710000', '86', '台湾省', 'T');
INSERT INTO `regions` VALUES ('33', '810000', '86', '香港特别行政区', 'X');
INSERT INTO `regions` VALUES ('34', '820000', '86', '澳门特别行政区', 'A');
INSERT INTO `regions` VALUES ('35', '110100', '110000', '北京城区', null);
INSERT INTO `regions` VALUES ('36', '110101', '110100', '东城区', null);
INSERT INTO `regions` VALUES ('37', '110102', '110100', '西城区', null);
INSERT INTO `regions` VALUES ('38', '110105', '110100', '朝阳区', null);
INSERT INTO `regions` VALUES ('39', '110106', '110100', '丰台区', null);
INSERT INTO `regions` VALUES ('40', '110107', '110100', '石景山区', null);
INSERT INTO `regions` VALUES ('41', '110108', '110100', '海淀区', null);
INSERT INTO `regions` VALUES ('42', '110109', '110100', '门头沟区', null);
INSERT INTO `regions` VALUES ('43', '110111', '110100', '房山区', null);
INSERT INTO `regions` VALUES ('44', '110112', '110100', '通州区', null);
INSERT INTO `regions` VALUES ('45', '110113', '110100', '顺义区', null);
INSERT INTO `regions` VALUES ('46', '110114', '110100', '昌平区', null);
INSERT INTO `regions` VALUES ('47', '110115', '110100', '大兴区', null);
INSERT INTO `regions` VALUES ('48', '110116', '110100', '怀柔区', null);
INSERT INTO `regions` VALUES ('49', '110117', '110100', '平谷区', null);
INSERT INTO `regions` VALUES ('50', '110118', '110100', '密云区', null);
INSERT INTO `regions` VALUES ('51', '110119', '110100', '延庆区', null);
INSERT INTO `regions` VALUES ('52', '120100', '120000', '天津城区', null);
INSERT INTO `regions` VALUES ('53', '120101', '120100', '和平区', null);
INSERT INTO `regions` VALUES ('54', '120102', '120100', '河东区', null);
INSERT INTO `regions` VALUES ('55', '120103', '120100', '河西区', null);
INSERT INTO `regions` VALUES ('56', '120104', '120100', '南开区', null);
INSERT INTO `regions` VALUES ('57', '120105', '120100', '河北区', null);
INSERT INTO `regions` VALUES ('58', '120106', '120100', '红桥区', null);
INSERT INTO `regions` VALUES ('59', '120110', '120100', '东丽区', null);
INSERT INTO `regions` VALUES ('60', '120111', '120100', '西青区', null);
INSERT INTO `regions` VALUES ('61', '120112', '120100', '津南区', null);
INSERT INTO `regions` VALUES ('62', '120113', '120100', '北辰区', null);
INSERT INTO `regions` VALUES ('63', '120114', '120100', '武清区', null);
INSERT INTO `regions` VALUES ('64', '120115', '120100', '宝坻区', null);
INSERT INTO `regions` VALUES ('65', '120116', '120100', '滨海新区', null);
INSERT INTO `regions` VALUES ('66', '120117', '120100', '宁河区', null);
INSERT INTO `regions` VALUES ('67', '120118', '120100', '静海区', null);
INSERT INTO `regions` VALUES ('68', '120119', '120100', '蓟州区', null);
INSERT INTO `regions` VALUES ('69', '130100', '130000', '石家庄市', null);
INSERT INTO `regions` VALUES ('70', '130200', '130000', '唐山市', null);
INSERT INTO `regions` VALUES ('71', '130300', '130000', '秦皇岛市', null);
INSERT INTO `regions` VALUES ('72', '130400', '130000', '邯郸市', null);
INSERT INTO `regions` VALUES ('73', '130500', '130000', '邢台市', null);
INSERT INTO `regions` VALUES ('74', '130600', '130000', '保定市', null);
INSERT INTO `regions` VALUES ('75', '130700', '130000', '张家口市', null);
INSERT INTO `regions` VALUES ('76', '130800', '130000', '承德市', null);
INSERT INTO `regions` VALUES ('77', '130900', '130000', '沧州市', null);
INSERT INTO `regions` VALUES ('78', '131000', '130000', '廊坊市', null);
INSERT INTO `regions` VALUES ('79', '131100', '130000', '衡水市', null);
INSERT INTO `regions` VALUES ('80', '130102', '130100', '长安区', null);
INSERT INTO `regions` VALUES ('81', '130104', '130100', '桥西区', null);
INSERT INTO `regions` VALUES ('82', '130105', '130100', '新华区', null);
INSERT INTO `regions` VALUES ('83', '130107', '130100', '井陉矿区', null);
INSERT INTO `regions` VALUES ('84', '130108', '130100', '裕华区', null);
INSERT INTO `regions` VALUES ('85', '130109', '130100', '藁城区', null);
INSERT INTO `regions` VALUES ('86', '130110', '130100', '鹿泉区', null);
INSERT INTO `regions` VALUES ('87', '130111', '130100', '栾城区', null);
INSERT INTO `regions` VALUES ('88', '130121', '130100', '井陉县', null);
INSERT INTO `regions` VALUES ('89', '130123', '130100', '正定县', null);
INSERT INTO `regions` VALUES ('90', '130125', '130100', '行唐县', null);
INSERT INTO `regions` VALUES ('91', '130126', '130100', '灵寿县', null);
INSERT INTO `regions` VALUES ('92', '130127', '130100', '高邑县', null);
INSERT INTO `regions` VALUES ('93', '130128', '130100', '深泽县', null);
INSERT INTO `regions` VALUES ('94', '130129', '130100', '赞皇县', null);
INSERT INTO `regions` VALUES ('95', '130130', '130100', '无极县', null);
INSERT INTO `regions` VALUES ('96', '130131', '130100', '平山县', null);
INSERT INTO `regions` VALUES ('97', '130132', '130100', '元氏县', null);
INSERT INTO `regions` VALUES ('98', '130133', '130100', '赵县', null);
INSERT INTO `regions` VALUES ('99', '130181', '130100', '辛集市', null);
INSERT INTO `regions` VALUES ('100', '130183', '130100', '晋州市', null);
INSERT INTO `regions` VALUES ('101', '130184', '130100', '新乐市', null);
INSERT INTO `regions` VALUES ('102', '130202', '130200', '路南区', null);
INSERT INTO `regions` VALUES ('103', '130203', '130200', '路北区', null);
INSERT INTO `regions` VALUES ('104', '130204', '130200', '古冶区', null);
INSERT INTO `regions` VALUES ('105', '130205', '130200', '开平区', null);
INSERT INTO `regions` VALUES ('106', '130207', '130200', '丰南区', null);
INSERT INTO `regions` VALUES ('107', '130208', '130200', '丰润区', null);
INSERT INTO `regions` VALUES ('108', '130209', '130200', '曹妃甸区', null);
INSERT INTO `regions` VALUES ('109', '130223', '130200', '滦县', null);
INSERT INTO `regions` VALUES ('110', '130224', '130200', '滦南县', null);
INSERT INTO `regions` VALUES ('111', '130225', '130200', '乐亭县', null);
INSERT INTO `regions` VALUES ('112', '130227', '130200', '迁西县', null);
INSERT INTO `regions` VALUES ('113', '130229', '130200', '玉田县', null);
INSERT INTO `regions` VALUES ('114', '130281', '130200', '遵化市', null);
INSERT INTO `regions` VALUES ('115', '130283', '130200', '迁安市', null);
INSERT INTO `regions` VALUES ('116', '130302', '130300', '海港区', null);
INSERT INTO `regions` VALUES ('117', '130303', '130300', '山海关区', null);
INSERT INTO `regions` VALUES ('118', '130304', '130300', '北戴河区', null);
INSERT INTO `regions` VALUES ('119', '130306', '130300', '抚宁区', null);
INSERT INTO `regions` VALUES ('120', '130321', '130300', '青龙满族自治县', null);
INSERT INTO `regions` VALUES ('121', '130322', '130300', '昌黎县', null);
INSERT INTO `regions` VALUES ('122', '130324', '130300', '卢龙县', null);
INSERT INTO `regions` VALUES ('123', '130402', '130400', '邯山区', null);
INSERT INTO `regions` VALUES ('124', '130403', '130400', '丛台区', null);
INSERT INTO `regions` VALUES ('125', '130404', '130400', '复兴区', null);
INSERT INTO `regions` VALUES ('126', '130406', '130400', '峰峰矿区', null);
INSERT INTO `regions` VALUES ('127', '130407', '130400', '肥乡区', null);
INSERT INTO `regions` VALUES ('128', '130408', '130400', '永年区', null);
INSERT INTO `regions` VALUES ('129', '130423', '130400', '临漳县', null);
INSERT INTO `regions` VALUES ('130', '130424', '130400', '成安县', null);
INSERT INTO `regions` VALUES ('131', '130425', '130400', '大名县', null);
INSERT INTO `regions` VALUES ('132', '130426', '130400', '涉县', null);
INSERT INTO `regions` VALUES ('133', '130427', '130400', '磁县', null);
INSERT INTO `regions` VALUES ('134', '130430', '130400', '邱县', null);
INSERT INTO `regions` VALUES ('135', '130431', '130400', '鸡泽县', null);
INSERT INTO `regions` VALUES ('136', '130432', '130400', '广平县', null);
INSERT INTO `regions` VALUES ('137', '130433', '130400', '馆陶县', null);
INSERT INTO `regions` VALUES ('138', '130434', '130400', '魏县', null);
INSERT INTO `regions` VALUES ('139', '130435', '130400', '曲周县', null);
INSERT INTO `regions` VALUES ('140', '130481', '130400', '武安市', null);
INSERT INTO `regions` VALUES ('141', '130502', '130500', '桥东区', null);
INSERT INTO `regions` VALUES ('142', '130503', '130500', '桥西区', null);
INSERT INTO `regions` VALUES ('143', '130521', '130500', '邢台县', null);
INSERT INTO `regions` VALUES ('144', '130522', '130500', '临城县', null);
INSERT INTO `regions` VALUES ('145', '130523', '130500', '内丘县', null);
INSERT INTO `regions` VALUES ('146', '130524', '130500', '柏乡县', null);
INSERT INTO `regions` VALUES ('147', '130525', '130500', '隆尧县', null);
INSERT INTO `regions` VALUES ('148', '130526', '130500', '任县', null);
INSERT INTO `regions` VALUES ('149', '130527', '130500', '南和县', null);
INSERT INTO `regions` VALUES ('150', '130528', '130500', '宁晋县', null);
INSERT INTO `regions` VALUES ('151', '130529', '130500', '巨鹿县', null);
INSERT INTO `regions` VALUES ('152', '130530', '130500', '新河县', null);
INSERT INTO `regions` VALUES ('153', '130531', '130500', '广宗县', null);
INSERT INTO `regions` VALUES ('154', '130532', '130500', '平乡县', null);
INSERT INTO `regions` VALUES ('155', '130533', '130500', '威县', null);
INSERT INTO `regions` VALUES ('156', '130534', '130500', '清河县', null);
INSERT INTO `regions` VALUES ('157', '130535', '130500', '临西县', null);
INSERT INTO `regions` VALUES ('158', '130581', '130500', '南宫市', null);
INSERT INTO `regions` VALUES ('159', '130582', '130500', '沙河市', null);
INSERT INTO `regions` VALUES ('160', '130602', '130600', '竞秀区', null);
INSERT INTO `regions` VALUES ('161', '130606', '130600', '莲池区', null);
INSERT INTO `regions` VALUES ('162', '130607', '130600', '满城区', null);
INSERT INTO `regions` VALUES ('163', '130608', '130600', '清苑区', null);
INSERT INTO `regions` VALUES ('164', '130609', '130600', '徐水区', null);
INSERT INTO `regions` VALUES ('165', '130623', '130600', '涞水县', null);
INSERT INTO `regions` VALUES ('166', '130624', '130600', '阜平县', null);
INSERT INTO `regions` VALUES ('167', '130626', '130600', '定兴县', null);
INSERT INTO `regions` VALUES ('168', '130627', '130600', '唐县', null);
INSERT INTO `regions` VALUES ('169', '130628', '130600', '高阳县', null);
INSERT INTO `regions` VALUES ('170', '130629', '130600', '容城县', null);
INSERT INTO `regions` VALUES ('171', '130630', '130600', '涞源县', null);
INSERT INTO `regions` VALUES ('172', '130631', '130600', '望都县', null);
INSERT INTO `regions` VALUES ('173', '130632', '130600', '安新县', null);
INSERT INTO `regions` VALUES ('174', '130633', '130600', '易县', null);
INSERT INTO `regions` VALUES ('175', '130634', '130600', '曲阳县', null);
INSERT INTO `regions` VALUES ('176', '130635', '130600', '蠡县', null);
INSERT INTO `regions` VALUES ('177', '130636', '130600', '顺平县', null);
INSERT INTO `regions` VALUES ('178', '130637', '130600', '博野县', null);
INSERT INTO `regions` VALUES ('179', '130638', '130600', '雄县', null);
INSERT INTO `regions` VALUES ('180', '130681', '130600', '涿州市', null);
INSERT INTO `regions` VALUES ('181', '130682', '130600', '定州市', null);
INSERT INTO `regions` VALUES ('182', '130683', '130600', '安国市', null);
INSERT INTO `regions` VALUES ('183', '130684', '130600', '高碑店市', null);
INSERT INTO `regions` VALUES ('184', '130702', '130700', '桥东区', null);
INSERT INTO `regions` VALUES ('185', '130703', '130700', '桥西区', null);
INSERT INTO `regions` VALUES ('186', '130705', '130700', '宣化区', null);
INSERT INTO `regions` VALUES ('187', '130706', '130700', '下花园区', null);
INSERT INTO `regions` VALUES ('188', '130708', '130700', '万全区', null);
INSERT INTO `regions` VALUES ('189', '130709', '130700', '崇礼区', null);
INSERT INTO `regions` VALUES ('190', '130722', '130700', '张北县', null);
INSERT INTO `regions` VALUES ('191', '130723', '130700', '康保县', null);
INSERT INTO `regions` VALUES ('192', '130724', '130700', '沽源县', null);
INSERT INTO `regions` VALUES ('193', '130725', '130700', '尚义县', null);
INSERT INTO `regions` VALUES ('194', '130726', '130700', '蔚县', null);
INSERT INTO `regions` VALUES ('195', '130727', '130700', '阳原县', null);
INSERT INTO `regions` VALUES ('196', '130728', '130700', '怀安县', null);
INSERT INTO `regions` VALUES ('197', '130730', '130700', '怀来县', null);
INSERT INTO `regions` VALUES ('198', '130731', '130700', '涿鹿县', null);
INSERT INTO `regions` VALUES ('199', '130732', '130700', '赤城县', null);
INSERT INTO `regions` VALUES ('200', '130802', '130800', '双桥区', null);
INSERT INTO `regions` VALUES ('201', '130803', '130800', '双滦区', null);
INSERT INTO `regions` VALUES ('202', '130804', '130800', '鹰手营子矿区', null);
INSERT INTO `regions` VALUES ('203', '130821', '130800', '承德县', null);
INSERT INTO `regions` VALUES ('204', '130822', '130800', '兴隆县', null);
INSERT INTO `regions` VALUES ('205', '130824', '130800', '滦平县', null);
INSERT INTO `regions` VALUES ('206', '130825', '130800', '隆化县', null);
INSERT INTO `regions` VALUES ('207', '130826', '130800', '丰宁满族自治县', null);
INSERT INTO `regions` VALUES ('208', '130827', '130800', '宽城满族自治县', null);
INSERT INTO `regions` VALUES ('209', '130828', '130800', '围场满族蒙古族自治县', null);
INSERT INTO `regions` VALUES ('210', '130881', '130800', '平泉市', null);
INSERT INTO `regions` VALUES ('211', '130902', '130900', '新华区', null);
INSERT INTO `regions` VALUES ('212', '130903', '130900', '运河区', null);
INSERT INTO `regions` VALUES ('213', '130921', '130900', '沧县', null);
INSERT INTO `regions` VALUES ('214', '130922', '130900', '青县', null);
INSERT INTO `regions` VALUES ('215', '130923', '130900', '东光县', null);
INSERT INTO `regions` VALUES ('216', '130924', '130900', '海兴县', null);
INSERT INTO `regions` VALUES ('217', '130925', '130900', '盐山县', null);
INSERT INTO `regions` VALUES ('218', '130926', '130900', '肃宁县', null);
INSERT INTO `regions` VALUES ('219', '130927', '130900', '南皮县', null);
INSERT INTO `regions` VALUES ('220', '130928', '130900', '吴桥县', null);
INSERT INTO `regions` VALUES ('221', '130929', '130900', '献县', null);
INSERT INTO `regions` VALUES ('222', '130930', '130900', '孟村回族自治县', null);
INSERT INTO `regions` VALUES ('223', '130981', '130900', '泊头市', null);
INSERT INTO `regions` VALUES ('224', '130982', '130900', '任丘市', null);
INSERT INTO `regions` VALUES ('225', '130983', '130900', '黄骅市', null);
INSERT INTO `regions` VALUES ('226', '130984', '130900', '河间市', null);
INSERT INTO `regions` VALUES ('227', '131002', '131000', '安次区', null);
INSERT INTO `regions` VALUES ('228', '131003', '131000', '广阳区', null);
INSERT INTO `regions` VALUES ('229', '131022', '131000', '固安县', null);
INSERT INTO `regions` VALUES ('230', '131023', '131000', '永清县', null);
INSERT INTO `regions` VALUES ('231', '131024', '131000', '香河县', null);
INSERT INTO `regions` VALUES ('232', '131025', '131000', '大城县', null);
INSERT INTO `regions` VALUES ('233', '131026', '131000', '文安县', null);
INSERT INTO `regions` VALUES ('234', '131028', '131000', '大厂回族自治县', null);
INSERT INTO `regions` VALUES ('235', '131081', '131000', '霸州市', null);
INSERT INTO `regions` VALUES ('236', '131082', '131000', '三河市', null);
INSERT INTO `regions` VALUES ('237', '131102', '131100', '桃城区', null);
INSERT INTO `regions` VALUES ('238', '131103', '131100', '冀州区', null);
INSERT INTO `regions` VALUES ('239', '131121', '131100', '枣强县', null);
INSERT INTO `regions` VALUES ('240', '131122', '131100', '武邑县', null);
INSERT INTO `regions` VALUES ('241', '131123', '131100', '武强县', null);
INSERT INTO `regions` VALUES ('242', '131124', '131100', '饶阳县', null);
INSERT INTO `regions` VALUES ('243', '131125', '131100', '安平县', null);
INSERT INTO `regions` VALUES ('244', '131126', '131100', '故城县', null);
INSERT INTO `regions` VALUES ('245', '131127', '131100', '景县', null);
INSERT INTO `regions` VALUES ('246', '131128', '131100', '阜城县', null);
INSERT INTO `regions` VALUES ('247', '131182', '131100', '深州市', null);
INSERT INTO `regions` VALUES ('248', '140100', '140000', '太原市', null);
INSERT INTO `regions` VALUES ('249', '140200', '140000', '大同市', null);
INSERT INTO `regions` VALUES ('250', '140300', '140000', '阳泉市', null);
INSERT INTO `regions` VALUES ('251', '140400', '140000', '长治市', null);
INSERT INTO `regions` VALUES ('252', '140500', '140000', '晋城市', null);
INSERT INTO `regions` VALUES ('253', '140600', '140000', '朔州市', null);
INSERT INTO `regions` VALUES ('254', '140700', '140000', '晋中市', null);
INSERT INTO `regions` VALUES ('255', '140800', '140000', '运城市', null);
INSERT INTO `regions` VALUES ('256', '140900', '140000', '忻州市', null);
INSERT INTO `regions` VALUES ('257', '141000', '140000', '临汾市', null);
INSERT INTO `regions` VALUES ('258', '141100', '140000', '吕梁市', null);
INSERT INTO `regions` VALUES ('259', '140105', '140100', '小店区', null);
INSERT INTO `regions` VALUES ('260', '140106', '140100', '迎泽区', null);
INSERT INTO `regions` VALUES ('261', '140107', '140100', '杏花岭区', null);
INSERT INTO `regions` VALUES ('262', '140108', '140100', '尖草坪区', null);
INSERT INTO `regions` VALUES ('263', '140109', '140100', '万柏林区', null);
INSERT INTO `regions` VALUES ('264', '140110', '140100', '晋源区', null);
INSERT INTO `regions` VALUES ('265', '140121', '140100', '清徐县', null);
INSERT INTO `regions` VALUES ('266', '140122', '140100', '阳曲县', null);
INSERT INTO `regions` VALUES ('267', '140123', '140100', '娄烦县', null);
INSERT INTO `regions` VALUES ('268', '140181', '140100', '古交市', null);
INSERT INTO `regions` VALUES ('269', '140202', '140200', '城区', null);
INSERT INTO `regions` VALUES ('270', '140203', '140200', '矿区', null);
INSERT INTO `regions` VALUES ('271', '140211', '140200', '南郊区', null);
INSERT INTO `regions` VALUES ('272', '140212', '140200', '新荣区', null);
INSERT INTO `regions` VALUES ('273', '140221', '140200', '阳高县', null);
INSERT INTO `regions` VALUES ('274', '140222', '140200', '天镇县', null);
INSERT INTO `regions` VALUES ('275', '140223', '140200', '广灵县', null);
INSERT INTO `regions` VALUES ('276', '140224', '140200', '灵丘县', null);
INSERT INTO `regions` VALUES ('277', '140225', '140200', '浑源县', null);
INSERT INTO `regions` VALUES ('278', '140226', '140200', '左云县', null);
INSERT INTO `regions` VALUES ('279', '140227', '140200', '大同县', null);
INSERT INTO `regions` VALUES ('280', '140302', '140300', '城区', null);
INSERT INTO `regions` VALUES ('281', '140303', '140300', '矿区', null);
INSERT INTO `regions` VALUES ('282', '140311', '140300', '郊区', null);
INSERT INTO `regions` VALUES ('283', '140321', '140300', '平定县', null);
INSERT INTO `regions` VALUES ('284', '140322', '140300', '盂县', null);
INSERT INTO `regions` VALUES ('285', '140402', '140400', '城区', null);
INSERT INTO `regions` VALUES ('286', '140411', '140400', '郊区', null);
INSERT INTO `regions` VALUES ('287', '140421', '140400', '长治县', null);
INSERT INTO `regions` VALUES ('288', '140423', '140400', '襄垣县', null);
INSERT INTO `regions` VALUES ('289', '140424', '140400', '屯留县', null);
INSERT INTO `regions` VALUES ('290', '140425', '140400', '平顺县', null);
INSERT INTO `regions` VALUES ('291', '140426', '140400', '黎城县', null);
INSERT INTO `regions` VALUES ('292', '140427', '140400', '壶关县', null);
INSERT INTO `regions` VALUES ('293', '140428', '140400', '长子县', null);
INSERT INTO `regions` VALUES ('294', '140429', '140400', '武乡县', null);
INSERT INTO `regions` VALUES ('295', '140430', '140400', '沁县', null);
INSERT INTO `regions` VALUES ('296', '140431', '140400', '沁源县', null);
INSERT INTO `regions` VALUES ('297', '140481', '140400', '潞城市', null);
INSERT INTO `regions` VALUES ('298', '140502', '140500', '城区', null);
INSERT INTO `regions` VALUES ('299', '140521', '140500', '沁水县', null);
INSERT INTO `regions` VALUES ('300', '140522', '140500', '阳城县', null);
INSERT INTO `regions` VALUES ('301', '140524', '140500', '陵川县', null);
INSERT INTO `regions` VALUES ('302', '140525', '140500', '泽州县', null);
INSERT INTO `regions` VALUES ('303', '140581', '140500', '高平市', null);
INSERT INTO `regions` VALUES ('304', '140602', '140600', '朔城区', null);
INSERT INTO `regions` VALUES ('305', '140603', '140600', '平鲁区', null);
INSERT INTO `regions` VALUES ('306', '140621', '140600', '山阴县', null);
INSERT INTO `regions` VALUES ('307', '140622', '140600', '应县', null);
INSERT INTO `regions` VALUES ('308', '140623', '140600', '右玉县', null);
INSERT INTO `regions` VALUES ('309', '140624', '140600', '怀仁县', null);
INSERT INTO `regions` VALUES ('310', '140702', '140700', '榆次区', null);
INSERT INTO `regions` VALUES ('311', '140721', '140700', '榆社县', null);
INSERT INTO `regions` VALUES ('312', '140722', '140700', '左权县', null);
INSERT INTO `regions` VALUES ('313', '140723', '140700', '和顺县', null);
INSERT INTO `regions` VALUES ('314', '140724', '140700', '昔阳县', null);
INSERT INTO `regions` VALUES ('315', '140725', '140700', '寿阳县', null);
INSERT INTO `regions` VALUES ('316', '140726', '140700', '太谷县', null);
INSERT INTO `regions` VALUES ('317', '140727', '140700', '祁县', null);
INSERT INTO `regions` VALUES ('318', '140728', '140700', '平遥县', null);
INSERT INTO `regions` VALUES ('319', '140729', '140700', '灵石县', null);
INSERT INTO `regions` VALUES ('320', '140781', '140700', '介休市', null);
INSERT INTO `regions` VALUES ('321', '140802', '140800', '盐湖区', null);
INSERT INTO `regions` VALUES ('322', '140821', '140800', '临猗县', null);
INSERT INTO `regions` VALUES ('323', '140822', '140800', '万荣县', null);
INSERT INTO `regions` VALUES ('324', '140823', '140800', '闻喜县', null);
INSERT INTO `regions` VALUES ('325', '140824', '140800', '稷山县', null);
INSERT INTO `regions` VALUES ('326', '140825', '140800', '新绛县', null);
INSERT INTO `regions` VALUES ('327', '140826', '140800', '绛县', null);
INSERT INTO `regions` VALUES ('328', '140827', '140800', '垣曲县', null);
INSERT INTO `regions` VALUES ('329', '140828', '140800', '夏县', null);
INSERT INTO `regions` VALUES ('330', '140829', '140800', '平陆县', null);
INSERT INTO `regions` VALUES ('331', '140830', '140800', '芮城县', null);
INSERT INTO `regions` VALUES ('332', '140881', '140800', '永济市', null);
INSERT INTO `regions` VALUES ('333', '140882', '140800', '河津市', null);
INSERT INTO `regions` VALUES ('334', '140902', '140900', '忻府区', null);
INSERT INTO `regions` VALUES ('335', '140921', '140900', '定襄县', null);
INSERT INTO `regions` VALUES ('336', '140922', '140900', '五台县', null);
INSERT INTO `regions` VALUES ('337', '140923', '140900', '代县', null);
INSERT INTO `regions` VALUES ('338', '140924', '140900', '繁峙县', null);
INSERT INTO `regions` VALUES ('339', '140925', '140900', '宁武县', null);
INSERT INTO `regions` VALUES ('340', '140926', '140900', '静乐县', null);
INSERT INTO `regions` VALUES ('341', '140927', '140900', '神池县', null);
INSERT INTO `regions` VALUES ('342', '140928', '140900', '五寨县', null);
INSERT INTO `regions` VALUES ('343', '140929', '140900', '岢岚县', null);
INSERT INTO `regions` VALUES ('344', '140930', '140900', '河曲县', null);
INSERT INTO `regions` VALUES ('345', '140931', '140900', '保德县', null);
INSERT INTO `regions` VALUES ('346', '140932', '140900', '偏关县', null);
INSERT INTO `regions` VALUES ('347', '140981', '140900', '原平市', null);
INSERT INTO `regions` VALUES ('348', '141002', '141000', '尧都区', null);
INSERT INTO `regions` VALUES ('349', '141021', '141000', '曲沃县', null);
INSERT INTO `regions` VALUES ('350', '141022', '141000', '翼城县', null);
INSERT INTO `regions` VALUES ('351', '141023', '141000', '襄汾县', null);
INSERT INTO `regions` VALUES ('352', '141024', '141000', '洪洞县', null);
INSERT INTO `regions` VALUES ('353', '141025', '141000', '古县', null);
INSERT INTO `regions` VALUES ('354', '141026', '141000', '安泽县', null);
INSERT INTO `regions` VALUES ('355', '141027', '141000', '浮山县', null);
INSERT INTO `regions` VALUES ('356', '141028', '141000', '吉县', null);
INSERT INTO `regions` VALUES ('357', '141029', '141000', '乡宁县', null);
INSERT INTO `regions` VALUES ('358', '141030', '141000', '大宁县', null);
INSERT INTO `regions` VALUES ('359', '141031', '141000', '隰县', null);
INSERT INTO `regions` VALUES ('360', '141032', '141000', '永和县', null);
INSERT INTO `regions` VALUES ('361', '141033', '141000', '蒲县', null);
INSERT INTO `regions` VALUES ('362', '141034', '141000', '汾西县', null);
INSERT INTO `regions` VALUES ('363', '141081', '141000', '侯马市', null);
INSERT INTO `regions` VALUES ('364', '141082', '141000', '霍州市', null);
INSERT INTO `regions` VALUES ('365', '141102', '141100', '离石区', null);
INSERT INTO `regions` VALUES ('366', '141121', '141100', '文水县', null);
INSERT INTO `regions` VALUES ('367', '141122', '141100', '交城县', null);
INSERT INTO `regions` VALUES ('368', '141123', '141100', '兴县', null);
INSERT INTO `regions` VALUES ('369', '141124', '141100', '临县', null);
INSERT INTO `regions` VALUES ('370', '141125', '141100', '柳林县', null);
INSERT INTO `regions` VALUES ('371', '141126', '141100', '石楼县', null);
INSERT INTO `regions` VALUES ('372', '141127', '141100', '岚县', null);
INSERT INTO `regions` VALUES ('373', '141128', '141100', '方山县', null);
INSERT INTO `regions` VALUES ('374', '141129', '141100', '中阳县', null);
INSERT INTO `regions` VALUES ('375', '141130', '141100', '交口县', null);
INSERT INTO `regions` VALUES ('376', '141181', '141100', '孝义市', null);
INSERT INTO `regions` VALUES ('377', '141182', '141100', '汾阳市', null);
INSERT INTO `regions` VALUES ('378', '150100', '150000', '呼和浩特市', null);
INSERT INTO `regions` VALUES ('379', '150200', '150000', '包头市', null);
INSERT INTO `regions` VALUES ('380', '150300', '150000', '乌海市', null);
INSERT INTO `regions` VALUES ('381', '150400', '150000', '赤峰市', null);
INSERT INTO `regions` VALUES ('382', '150500', '150000', '通辽市', null);
INSERT INTO `regions` VALUES ('383', '150600', '150000', '鄂尔多斯市', null);
INSERT INTO `regions` VALUES ('384', '150700', '150000', '呼伦贝尔市', null);
INSERT INTO `regions` VALUES ('385', '150800', '150000', '巴彦淖尔市', null);
INSERT INTO `regions` VALUES ('386', '150900', '150000', '乌兰察布市', null);
INSERT INTO `regions` VALUES ('387', '152200', '150000', '兴安盟', null);
INSERT INTO `regions` VALUES ('388', '152500', '150000', '锡林郭勒盟', null);
INSERT INTO `regions` VALUES ('389', '152900', '150000', '阿拉善盟', null);
INSERT INTO `regions` VALUES ('390', '150102', '150100', '新城区', null);
INSERT INTO `regions` VALUES ('391', '150103', '150100', '回民区', null);
INSERT INTO `regions` VALUES ('392', '150104', '150100', '玉泉区', null);
INSERT INTO `regions` VALUES ('393', '150105', '150100', '赛罕区', null);
INSERT INTO `regions` VALUES ('394', '150121', '150100', '土默特左旗', null);
INSERT INTO `regions` VALUES ('395', '150122', '150100', '托克托县', null);
INSERT INTO `regions` VALUES ('396', '150123', '150100', '和林格尔县', null);
INSERT INTO `regions` VALUES ('397', '150124', '150100', '清水河县', null);
INSERT INTO `regions` VALUES ('398', '150125', '150100', '武川县', null);
INSERT INTO `regions` VALUES ('399', '150202', '150200', '东河区', null);
INSERT INTO `regions` VALUES ('400', '150203', '150200', '昆都仑区', null);
INSERT INTO `regions` VALUES ('401', '150204', '150200', '青山区', null);
INSERT INTO `regions` VALUES ('402', '150205', '150200', '石拐区', null);
INSERT INTO `regions` VALUES ('403', '150206', '150200', '白云鄂博矿区', null);
INSERT INTO `regions` VALUES ('404', '150207', '150200', '九原区', null);
INSERT INTO `regions` VALUES ('405', '150221', '150200', '土默特右旗', null);
INSERT INTO `regions` VALUES ('406', '150222', '150200', '固阳县', null);
INSERT INTO `regions` VALUES ('407', '150223', '150200', '达尔罕茂明安联合旗', null);
INSERT INTO `regions` VALUES ('408', '150302', '150300', '海勃湾区', null);
INSERT INTO `regions` VALUES ('409', '150303', '150300', '海南区', null);
INSERT INTO `regions` VALUES ('410', '150304', '150300', '乌达区', null);
INSERT INTO `regions` VALUES ('411', '150402', '150400', '红山区', null);
INSERT INTO `regions` VALUES ('412', '150403', '150400', '元宝山区', null);
INSERT INTO `regions` VALUES ('413', '150404', '150400', '松山区', null);
INSERT INTO `regions` VALUES ('414', '150421', '150400', '阿鲁科尔沁旗', null);
INSERT INTO `regions` VALUES ('415', '150422', '150400', '巴林左旗', null);
INSERT INTO `regions` VALUES ('416', '150423', '150400', '巴林右旗', null);
INSERT INTO `regions` VALUES ('417', '150424', '150400', '林西县', null);
INSERT INTO `regions` VALUES ('418', '150425', '150400', '克什克腾旗', null);
INSERT INTO `regions` VALUES ('419', '150426', '150400', '翁牛特旗', null);
INSERT INTO `regions` VALUES ('420', '150428', '150400', '喀喇沁旗', null);
INSERT INTO `regions` VALUES ('421', '150429', '150400', '宁城县', null);
INSERT INTO `regions` VALUES ('422', '150430', '150400', '敖汉旗', null);
INSERT INTO `regions` VALUES ('423', '150502', '150500', '科尔沁区', null);
INSERT INTO `regions` VALUES ('424', '150521', '150500', '科尔沁左翼中旗', null);
INSERT INTO `regions` VALUES ('425', '150522', '150500', '科尔沁左翼后旗', null);
INSERT INTO `regions` VALUES ('426', '150523', '150500', '开鲁县', null);
INSERT INTO `regions` VALUES ('427', '150524', '150500', '库伦旗', null);
INSERT INTO `regions` VALUES ('428', '150525', '150500', '奈曼旗', null);
INSERT INTO `regions` VALUES ('429', '150526', '150500', '扎鲁特旗', null);
INSERT INTO `regions` VALUES ('430', '150581', '150500', '霍林郭勒市', null);
INSERT INTO `regions` VALUES ('431', '150602', '150600', '东胜区', null);
INSERT INTO `regions` VALUES ('432', '150603', '150600', '康巴什区', null);
INSERT INTO `regions` VALUES ('433', '150621', '150600', '达拉特旗', null);
INSERT INTO `regions` VALUES ('434', '150622', '150600', '准格尔旗', null);
INSERT INTO `regions` VALUES ('435', '150623', '150600', '鄂托克前旗', null);
INSERT INTO `regions` VALUES ('436', '150624', '150600', '鄂托克旗', null);
INSERT INTO `regions` VALUES ('437', '150625', '150600', '杭锦旗', null);
INSERT INTO `regions` VALUES ('438', '150626', '150600', '乌审旗', null);
INSERT INTO `regions` VALUES ('439', '150627', '150600', '伊金霍洛旗', null);
INSERT INTO `regions` VALUES ('440', '150702', '150700', '海拉尔区', null);
INSERT INTO `regions` VALUES ('441', '150703', '150700', '扎赉诺尔区', null);
INSERT INTO `regions` VALUES ('442', '150721', '150700', '阿荣旗', null);
INSERT INTO `regions` VALUES ('443', '150722', '150700', '莫力达瓦达斡尔族自治旗', null);
INSERT INTO `regions` VALUES ('444', '150723', '150700', '鄂伦春自治旗', null);
INSERT INTO `regions` VALUES ('445', '150724', '150700', '鄂温克族自治旗', null);
INSERT INTO `regions` VALUES ('446', '150725', '150700', '陈巴尔虎旗', null);
INSERT INTO `regions` VALUES ('447', '150726', '150700', '新巴尔虎左旗', null);
INSERT INTO `regions` VALUES ('448', '150727', '150700', '新巴尔虎右旗', null);
INSERT INTO `regions` VALUES ('449', '150781', '150700', '满洲里市', null);
INSERT INTO `regions` VALUES ('450', '150782', '150700', '牙克石市', null);
INSERT INTO `regions` VALUES ('451', '150783', '150700', '扎兰屯市', null);
INSERT INTO `regions` VALUES ('452', '150784', '150700', '额尔古纳市', null);
INSERT INTO `regions` VALUES ('453', '150785', '150700', '根河市', null);
INSERT INTO `regions` VALUES ('454', '150802', '150800', '临河区', null);
INSERT INTO `regions` VALUES ('455', '150821', '150800', '五原县', null);
INSERT INTO `regions` VALUES ('456', '150822', '150800', '磴口县', null);
INSERT INTO `regions` VALUES ('457', '150823', '150800', '乌拉特前旗', null);
INSERT INTO `regions` VALUES ('458', '150824', '150800', '乌拉特中旗', null);
INSERT INTO `regions` VALUES ('459', '150825', '150800', '乌拉特后旗', null);
INSERT INTO `regions` VALUES ('460', '150826', '150800', '杭锦后旗', null);
INSERT INTO `regions` VALUES ('461', '150902', '150900', '集宁区', null);
INSERT INTO `regions` VALUES ('462', '150921', '150900', '卓资县', null);
INSERT INTO `regions` VALUES ('463', '150922', '150900', '化德县', null);
INSERT INTO `regions` VALUES ('464', '150923', '150900', '商都县', null);
INSERT INTO `regions` VALUES ('465', '150924', '150900', '兴和县', null);
INSERT INTO `regions` VALUES ('466', '150925', '150900', '凉城县', null);
INSERT INTO `regions` VALUES ('467', '150926', '150900', '察哈尔右翼前旗', null);
INSERT INTO `regions` VALUES ('468', '150927', '150900', '察哈尔右翼中旗', null);
INSERT INTO `regions` VALUES ('469', '150928', '150900', '察哈尔右翼后旗', null);
INSERT INTO `regions` VALUES ('470', '150929', '150900', '四子王旗', null);
INSERT INTO `regions` VALUES ('471', '150981', '150900', '丰镇市', null);
INSERT INTO `regions` VALUES ('472', '152201', '152200', '乌兰浩特市', null);
INSERT INTO `regions` VALUES ('473', '152202', '152200', '阿尔山市', null);
INSERT INTO `regions` VALUES ('474', '152221', '152200', '科尔沁右翼前旗', null);
INSERT INTO `regions` VALUES ('475', '152222', '152200', '科尔沁右翼中旗', null);
INSERT INTO `regions` VALUES ('476', '152223', '152200', '扎赉特旗', null);
INSERT INTO `regions` VALUES ('477', '152224', '152200', '突泉县', null);
INSERT INTO `regions` VALUES ('478', '152501', '152500', '二连浩特市', null);
INSERT INTO `regions` VALUES ('479', '152502', '152500', '锡林浩特市', null);
INSERT INTO `regions` VALUES ('480', '152522', '152500', '阿巴嘎旗', null);
INSERT INTO `regions` VALUES ('481', '152523', '152500', '苏尼特左旗', null);
INSERT INTO `regions` VALUES ('482', '152524', '152500', '苏尼特右旗', null);
INSERT INTO `regions` VALUES ('483', '152525', '152500', '东乌珠穆沁旗', null);
INSERT INTO `regions` VALUES ('484', '152526', '152500', '西乌珠穆沁旗', null);
INSERT INTO `regions` VALUES ('485', '152527', '152500', '太仆寺旗', null);
INSERT INTO `regions` VALUES ('486', '152528', '152500', '镶黄旗', null);
INSERT INTO `regions` VALUES ('487', '152529', '152500', '正镶白旗', null);
INSERT INTO `regions` VALUES ('488', '152530', '152500', '正蓝旗', null);
INSERT INTO `regions` VALUES ('489', '152531', '152500', '多伦县', null);
INSERT INTO `regions` VALUES ('490', '152921', '152900', '阿拉善左旗', null);
INSERT INTO `regions` VALUES ('491', '152922', '152900', '阿拉善右旗', null);
INSERT INTO `regions` VALUES ('492', '152923', '152900', '额济纳旗', null);
INSERT INTO `regions` VALUES ('493', '210100', '210000', '沈阳市', null);
INSERT INTO `regions` VALUES ('494', '210200', '210000', '大连市', null);
INSERT INTO `regions` VALUES ('495', '210300', '210000', '鞍山市', null);
INSERT INTO `regions` VALUES ('496', '210400', '210000', '抚顺市', null);
INSERT INTO `regions` VALUES ('497', '210500', '210000', '本溪市', null);
INSERT INTO `regions` VALUES ('498', '210600', '210000', '丹东市', null);
INSERT INTO `regions` VALUES ('499', '210700', '210000', '锦州市', null);
INSERT INTO `regions` VALUES ('500', '210800', '210000', '营口市', null);
INSERT INTO `regions` VALUES ('501', '210900', '210000', '阜新市', null);
INSERT INTO `regions` VALUES ('502', '211000', '210000', '辽阳市', null);
INSERT INTO `regions` VALUES ('503', '211100', '210000', '盘锦市', null);
INSERT INTO `regions` VALUES ('504', '211200', '210000', '铁岭市', null);
INSERT INTO `regions` VALUES ('505', '211300', '210000', '朝阳市', null);
INSERT INTO `regions` VALUES ('506', '211400', '210000', '葫芦岛市', null);
INSERT INTO `regions` VALUES ('507', '210102', '210100', '和平区', null);
INSERT INTO `regions` VALUES ('508', '210103', '210100', '沈河区', null);
INSERT INTO `regions` VALUES ('509', '210104', '210100', '大东区', null);
INSERT INTO `regions` VALUES ('510', '210105', '210100', '皇姑区', null);
INSERT INTO `regions` VALUES ('511', '210106', '210100', '铁西区', null);
INSERT INTO `regions` VALUES ('512', '210111', '210100', '苏家屯区', null);
INSERT INTO `regions` VALUES ('513', '210112', '210100', '浑南区', null);
INSERT INTO `regions` VALUES ('514', '210113', '210100', '沈北新区', null);
INSERT INTO `regions` VALUES ('515', '210114', '210100', '于洪区', null);
INSERT INTO `regions` VALUES ('516', '210115', '210100', '辽中区', null);
INSERT INTO `regions` VALUES ('517', '210123', '210100', '康平县', null);
INSERT INTO `regions` VALUES ('518', '210124', '210100', '法库县', null);
INSERT INTO `regions` VALUES ('519', '210181', '210100', '新民市', null);
INSERT INTO `regions` VALUES ('520', '210202', '210200', '中山区', null);
INSERT INTO `regions` VALUES ('521', '210203', '210200', '西岗区', null);
INSERT INTO `regions` VALUES ('522', '210204', '210200', '沙河口区', null);
INSERT INTO `regions` VALUES ('523', '210211', '210200', '甘井子区', null);
INSERT INTO `regions` VALUES ('524', '210212', '210200', '旅顺口区', null);
INSERT INTO `regions` VALUES ('525', '210213', '210200', '金州区', null);
INSERT INTO `regions` VALUES ('526', '210214', '210200', '普兰店区', null);
INSERT INTO `regions` VALUES ('527', '210224', '210200', '长海县', null);
INSERT INTO `regions` VALUES ('528', '210281', '210200', '瓦房店市', null);
INSERT INTO `regions` VALUES ('529', '210283', '210200', '庄河市', null);
INSERT INTO `regions` VALUES ('530', '210302', '210300', '铁东区', null);
INSERT INTO `regions` VALUES ('531', '210303', '210300', '铁西区', null);
INSERT INTO `regions` VALUES ('532', '210304', '210300', '立山区', null);
INSERT INTO `regions` VALUES ('533', '210311', '210300', '千山区', null);
INSERT INTO `regions` VALUES ('534', '210321', '210300', '台安县', null);
INSERT INTO `regions` VALUES ('535', '210323', '210300', '岫岩满族自治县', null);
INSERT INTO `regions` VALUES ('536', '210381', '210300', '海城市', null);
INSERT INTO `regions` VALUES ('537', '210402', '210400', '新抚区', null);
INSERT INTO `regions` VALUES ('538', '210403', '210400', '东洲区', null);
INSERT INTO `regions` VALUES ('539', '210404', '210400', '望花区', null);
INSERT INTO `regions` VALUES ('540', '210411', '210400', '顺城区', null);
INSERT INTO `regions` VALUES ('541', '210421', '210400', '抚顺县', null);
INSERT INTO `regions` VALUES ('542', '210422', '210400', '新宾满族自治县', null);
INSERT INTO `regions` VALUES ('543', '210423', '210400', '清原满族自治县', null);
INSERT INTO `regions` VALUES ('544', '210502', '210500', '平山区', null);
INSERT INTO `regions` VALUES ('545', '210503', '210500', '溪湖区', null);
INSERT INTO `regions` VALUES ('546', '210504', '210500', '明山区', null);
INSERT INTO `regions` VALUES ('547', '210505', '210500', '南芬区', null);
INSERT INTO `regions` VALUES ('548', '210521', '210500', '本溪满族自治县', null);
INSERT INTO `regions` VALUES ('549', '210522', '210500', '桓仁满族自治县', null);
INSERT INTO `regions` VALUES ('550', '210602', '210600', '元宝区', null);
INSERT INTO `regions` VALUES ('551', '210603', '210600', '振兴区', null);
INSERT INTO `regions` VALUES ('552', '210604', '210600', '振安区', null);
INSERT INTO `regions` VALUES ('553', '210624', '210600', '宽甸满族自治县', null);
INSERT INTO `regions` VALUES ('554', '210681', '210600', '东港市', null);
INSERT INTO `regions` VALUES ('555', '210682', '210600', '凤城市', null);
INSERT INTO `regions` VALUES ('556', '210702', '210700', '古塔区', null);
INSERT INTO `regions` VALUES ('557', '210703', '210700', '凌河区', null);
INSERT INTO `regions` VALUES ('558', '210711', '210700', '太和区', null);
INSERT INTO `regions` VALUES ('559', '210726', '210700', '黑山县', null);
INSERT INTO `regions` VALUES ('560', '210727', '210700', '义县', null);
INSERT INTO `regions` VALUES ('561', '210781', '210700', '凌海市', null);
INSERT INTO `regions` VALUES ('562', '210782', '210700', '北镇市', null);
INSERT INTO `regions` VALUES ('563', '210802', '210800', '站前区', null);
INSERT INTO `regions` VALUES ('564', '210803', '210800', '西市区', null);
INSERT INTO `regions` VALUES ('565', '210804', '210800', '鲅鱼圈区', null);
INSERT INTO `regions` VALUES ('566', '210811', '210800', '老边区', null);
INSERT INTO `regions` VALUES ('567', '210881', '210800', '盖州市', null);
INSERT INTO `regions` VALUES ('568', '210882', '210800', '大石桥市', null);
INSERT INTO `regions` VALUES ('569', '210902', '210900', '海州区', null);
INSERT INTO `regions` VALUES ('570', '210903', '210900', '新邱区', null);
INSERT INTO `regions` VALUES ('571', '210904', '210900', '太平区', null);
INSERT INTO `regions` VALUES ('572', '210905', '210900', '清河门区', null);
INSERT INTO `regions` VALUES ('573', '210911', '210900', '细河区', null);
INSERT INTO `regions` VALUES ('574', '210921', '210900', '阜新蒙古族自治县', null);
INSERT INTO `regions` VALUES ('575', '210922', '210900', '彰武县', null);
INSERT INTO `regions` VALUES ('576', '211002', '211000', '白塔区', null);
INSERT INTO `regions` VALUES ('577', '211003', '211000', '文圣区', null);
INSERT INTO `regions` VALUES ('578', '211004', '211000', '宏伟区', null);
INSERT INTO `regions` VALUES ('579', '211005', '211000', '弓长岭区', null);
INSERT INTO `regions` VALUES ('580', '211011', '211000', '太子河区', null);
INSERT INTO `regions` VALUES ('581', '211021', '211000', '辽阳县', null);
INSERT INTO `regions` VALUES ('582', '211081', '211000', '灯塔市', null);
INSERT INTO `regions` VALUES ('583', '211102', '211100', '双台子区', null);
INSERT INTO `regions` VALUES ('584', '211103', '211100', '兴隆台区', null);
INSERT INTO `regions` VALUES ('585', '211104', '211100', '大洼区', null);
INSERT INTO `regions` VALUES ('586', '211122', '211100', '盘山县', null);
INSERT INTO `regions` VALUES ('587', '211202', '211200', '银州区', null);
INSERT INTO `regions` VALUES ('588', '211204', '211200', '清河区', null);
INSERT INTO `regions` VALUES ('589', '211221', '211200', '铁岭县', null);
INSERT INTO `regions` VALUES ('590', '211223', '211200', '西丰县', null);
INSERT INTO `regions` VALUES ('591', '211224', '211200', '昌图县', null);
INSERT INTO `regions` VALUES ('592', '211281', '211200', '调兵山市', null);
INSERT INTO `regions` VALUES ('593', '211282', '211200', '开原市', null);
INSERT INTO `regions` VALUES ('594', '211302', '211300', '双塔区', null);
INSERT INTO `regions` VALUES ('595', '211303', '211300', '龙城区', null);
INSERT INTO `regions` VALUES ('596', '211321', '211300', '朝阳县', null);
INSERT INTO `regions` VALUES ('597', '211322', '211300', '建平县', null);
INSERT INTO `regions` VALUES ('598', '211324', '211300', '喀喇沁左翼蒙古族自治县', null);
INSERT INTO `regions` VALUES ('599', '211381', '211300', '北票市', null);
INSERT INTO `regions` VALUES ('600', '211382', '211300', '凌源市', null);
INSERT INTO `regions` VALUES ('601', '211402', '211400', '连山区', null);
INSERT INTO `regions` VALUES ('602', '211403', '211400', '龙港区', null);
INSERT INTO `regions` VALUES ('603', '211404', '211400', '南票区', null);
INSERT INTO `regions` VALUES ('604', '211421', '211400', '绥中县', null);
INSERT INTO `regions` VALUES ('605', '211422', '211400', '建昌县', null);
INSERT INTO `regions` VALUES ('606', '211481', '211400', '兴城市', null);
INSERT INTO `regions` VALUES ('607', '220100', '220000', '长春市', null);
INSERT INTO `regions` VALUES ('608', '220200', '220000', '吉林市', null);
INSERT INTO `regions` VALUES ('609', '220300', '220000', '四平市', null);
INSERT INTO `regions` VALUES ('610', '220400', '220000', '辽源市', null);
INSERT INTO `regions` VALUES ('611', '220500', '220000', '通化市', null);
INSERT INTO `regions` VALUES ('612', '220600', '220000', '白山市', null);
INSERT INTO `regions` VALUES ('613', '220700', '220000', '松原市', null);
INSERT INTO `regions` VALUES ('614', '220800', '220000', '白城市', null);
INSERT INTO `regions` VALUES ('615', '222400', '220000', '延边朝鲜族自治州', null);
INSERT INTO `regions` VALUES ('616', '220102', '220100', '南关区', null);
INSERT INTO `regions` VALUES ('617', '220103', '220100', '宽城区', null);
INSERT INTO `regions` VALUES ('618', '220104', '220100', '朝阳区', null);
INSERT INTO `regions` VALUES ('619', '220105', '220100', '二道区', null);
INSERT INTO `regions` VALUES ('620', '220106', '220100', '绿园区', null);
INSERT INTO `regions` VALUES ('621', '220112', '220100', '双阳区', null);
INSERT INTO `regions` VALUES ('622', '220113', '220100', '九台区', null);
INSERT INTO `regions` VALUES ('623', '220122', '220100', '农安县', null);
INSERT INTO `regions` VALUES ('624', '220182', '220100', '榆树市', null);
INSERT INTO `regions` VALUES ('625', '220183', '220100', '德惠市', null);
INSERT INTO `regions` VALUES ('626', '220202', '220200', '昌邑区', null);
INSERT INTO `regions` VALUES ('627', '220203', '220200', '龙潭区', null);
INSERT INTO `regions` VALUES ('628', '220204', '220200', '船营区', null);
INSERT INTO `regions` VALUES ('629', '220211', '220200', '丰满区', null);
INSERT INTO `regions` VALUES ('630', '220221', '220200', '永吉县', null);
INSERT INTO `regions` VALUES ('631', '220281', '220200', '蛟河市', null);
INSERT INTO `regions` VALUES ('632', '220282', '220200', '桦甸市', null);
INSERT INTO `regions` VALUES ('633', '220283', '220200', '舒兰市', null);
INSERT INTO `regions` VALUES ('634', '220284', '220200', '磐石市', null);
INSERT INTO `regions` VALUES ('635', '220302', '220300', '铁西区', null);
INSERT INTO `regions` VALUES ('636', '220303', '220300', '铁东区', null);
INSERT INTO `regions` VALUES ('637', '220322', '220300', '梨树县', null);
INSERT INTO `regions` VALUES ('638', '220323', '220300', '伊通满族自治县', null);
INSERT INTO `regions` VALUES ('639', '220381', '220300', '公主岭市', null);
INSERT INTO `regions` VALUES ('640', '220382', '220300', '双辽市', null);
INSERT INTO `regions` VALUES ('641', '220402', '220400', '龙山区', null);
INSERT INTO `regions` VALUES ('642', '220403', '220400', '西安区', null);
INSERT INTO `regions` VALUES ('643', '220421', '220400', '东丰县', null);
INSERT INTO `regions` VALUES ('644', '220422', '220400', '东辽县', null);
INSERT INTO `regions` VALUES ('645', '220502', '220500', '东昌区', null);
INSERT INTO `regions` VALUES ('646', '220503', '220500', '二道江区', null);
INSERT INTO `regions` VALUES ('647', '220521', '220500', '通化县', null);
INSERT INTO `regions` VALUES ('648', '220523', '220500', '辉南县', null);
INSERT INTO `regions` VALUES ('649', '220524', '220500', '柳河县', null);
INSERT INTO `regions` VALUES ('650', '220581', '220500', '梅河口市', null);
INSERT INTO `regions` VALUES ('651', '220582', '220500', '集安市', null);
INSERT INTO `regions` VALUES ('652', '220602', '220600', '浑江区', null);
INSERT INTO `regions` VALUES ('653', '220605', '220600', '江源区', null);
INSERT INTO `regions` VALUES ('654', '220621', '220600', '抚松县', null);
INSERT INTO `regions` VALUES ('655', '220622', '220600', '靖宇县', null);
INSERT INTO `regions` VALUES ('656', '220623', '220600', '长白朝鲜族自治县', null);
INSERT INTO `regions` VALUES ('657', '220681', '220600', '临江市', null);
INSERT INTO `regions` VALUES ('658', '220702', '220700', '宁江区', null);
INSERT INTO `regions` VALUES ('659', '220721', '220700', '前郭尔罗斯蒙古族自治县', null);
INSERT INTO `regions` VALUES ('660', '220722', '220700', '长岭县', null);
INSERT INTO `regions` VALUES ('661', '220723', '220700', '乾安县', null);
INSERT INTO `regions` VALUES ('662', '220781', '220700', '扶余市', null);
INSERT INTO `regions` VALUES ('663', '220802', '220800', '洮北区', null);
INSERT INTO `regions` VALUES ('664', '220821', '220800', '镇赉县', null);
INSERT INTO `regions` VALUES ('665', '220822', '220800', '通榆县', null);
INSERT INTO `regions` VALUES ('666', '220881', '220800', '洮南市', null);
INSERT INTO `regions` VALUES ('667', '220882', '220800', '大安市', null);
INSERT INTO `regions` VALUES ('668', '222401', '222400', '延吉市', null);
INSERT INTO `regions` VALUES ('669', '222402', '222400', '图们市', null);
INSERT INTO `regions` VALUES ('670', '222403', '222400', '敦化市', null);
INSERT INTO `regions` VALUES ('671', '222404', '222400', '珲春市', null);
INSERT INTO `regions` VALUES ('672', '222405', '222400', '龙井市', null);
INSERT INTO `regions` VALUES ('673', '222406', '222400', '和龙市', null);
INSERT INTO `regions` VALUES ('674', '222424', '222400', '汪清县', null);
INSERT INTO `regions` VALUES ('675', '222426', '222400', '安图县', null);
INSERT INTO `regions` VALUES ('676', '230100', '230000', '哈尔滨市', null);
INSERT INTO `regions` VALUES ('677', '230200', '230000', '齐齐哈尔市', null);
INSERT INTO `regions` VALUES ('678', '230300', '230000', '鸡西市', null);
INSERT INTO `regions` VALUES ('679', '230400', '230000', '鹤岗市', null);
INSERT INTO `regions` VALUES ('680', '230500', '230000', '双鸭山市', null);
INSERT INTO `regions` VALUES ('681', '230600', '230000', '大庆市', null);
INSERT INTO `regions` VALUES ('682', '230700', '230000', '伊春市', null);
INSERT INTO `regions` VALUES ('683', '230800', '230000', '佳木斯市', null);
INSERT INTO `regions` VALUES ('684', '230900', '230000', '七台河市', null);
INSERT INTO `regions` VALUES ('685', '231000', '230000', '牡丹江市', null);
INSERT INTO `regions` VALUES ('686', '231100', '230000', '黑河市', null);
INSERT INTO `regions` VALUES ('687', '231200', '230000', '绥化市', null);
INSERT INTO `regions` VALUES ('688', '232700', '230000', '大兴安岭地区', null);
INSERT INTO `regions` VALUES ('689', '230102', '230100', '道里区', null);
INSERT INTO `regions` VALUES ('690', '230103', '230100', '南岗区', null);
INSERT INTO `regions` VALUES ('691', '230104', '230100', '道外区', null);
INSERT INTO `regions` VALUES ('692', '230108', '230100', '平房区', null);
INSERT INTO `regions` VALUES ('693', '230109', '230100', '松北区', null);
INSERT INTO `regions` VALUES ('694', '230110', '230100', '香坊区', null);
INSERT INTO `regions` VALUES ('695', '230111', '230100', '呼兰区', null);
INSERT INTO `regions` VALUES ('696', '230112', '230100', '阿城区', null);
INSERT INTO `regions` VALUES ('697', '230113', '230100', '双城区', null);
INSERT INTO `regions` VALUES ('698', '230123', '230100', '依兰县', null);
INSERT INTO `regions` VALUES ('699', '230124', '230100', '方正县', null);
INSERT INTO `regions` VALUES ('700', '230125', '230100', '宾县', null);
INSERT INTO `regions` VALUES ('701', '230126', '230100', '巴彦县', null);
INSERT INTO `regions` VALUES ('702', '230127', '230100', '木兰县', null);
INSERT INTO `regions` VALUES ('703', '230128', '230100', '通河县', null);
INSERT INTO `regions` VALUES ('704', '230129', '230100', '延寿县', null);
INSERT INTO `regions` VALUES ('705', '230183', '230100', '尚志市', null);
INSERT INTO `regions` VALUES ('706', '230184', '230100', '五常市', null);
INSERT INTO `regions` VALUES ('707', '230202', '230200', '龙沙区', null);
INSERT INTO `regions` VALUES ('708', '230203', '230200', '建华区', null);
INSERT INTO `regions` VALUES ('709', '230204', '230200', '铁锋区', null);
INSERT INTO `regions` VALUES ('710', '230205', '230200', '昂昂溪区', null);
INSERT INTO `regions` VALUES ('711', '230206', '230200', '富拉尔基区', null);
INSERT INTO `regions` VALUES ('712', '230207', '230200', '碾子山区', null);
INSERT INTO `regions` VALUES ('713', '230208', '230200', '梅里斯达斡尔族区', null);
INSERT INTO `regions` VALUES ('714', '230221', '230200', '龙江县', null);
INSERT INTO `regions` VALUES ('715', '230223', '230200', '依安县', null);
INSERT INTO `regions` VALUES ('716', '230224', '230200', '泰来县', null);
INSERT INTO `regions` VALUES ('717', '230225', '230200', '甘南县', null);
INSERT INTO `regions` VALUES ('718', '230227', '230200', '富裕县', null);
INSERT INTO `regions` VALUES ('719', '230229', '230200', '克山县', null);
INSERT INTO `regions` VALUES ('720', '230230', '230200', '克东县', null);
INSERT INTO `regions` VALUES ('721', '230231', '230200', '拜泉县', null);
INSERT INTO `regions` VALUES ('722', '230281', '230200', '讷河市', null);
INSERT INTO `regions` VALUES ('723', '230302', '230300', '鸡冠区', null);
INSERT INTO `regions` VALUES ('724', '230303', '230300', '恒山区', null);
INSERT INTO `regions` VALUES ('725', '230304', '230300', '滴道区', null);
INSERT INTO `regions` VALUES ('726', '230305', '230300', '梨树区', null);
INSERT INTO `regions` VALUES ('727', '230306', '230300', '城子河区', null);
INSERT INTO `regions` VALUES ('728', '230307', '230300', '麻山区', null);
INSERT INTO `regions` VALUES ('729', '230321', '230300', '鸡东县', null);
INSERT INTO `regions` VALUES ('730', '230381', '230300', '虎林市', null);
INSERT INTO `regions` VALUES ('731', '230382', '230300', '密山市', null);
INSERT INTO `regions` VALUES ('732', '230402', '230400', '向阳区', null);
INSERT INTO `regions` VALUES ('733', '230403', '230400', '工农区', null);
INSERT INTO `regions` VALUES ('734', '230404', '230400', '南山区', null);
INSERT INTO `regions` VALUES ('735', '230405', '230400', '兴安区', null);
INSERT INTO `regions` VALUES ('736', '230406', '230400', '东山区', null);
INSERT INTO `regions` VALUES ('737', '230407', '230400', '兴山区', null);
INSERT INTO `regions` VALUES ('738', '230421', '230400', '萝北县', null);
INSERT INTO `regions` VALUES ('739', '230422', '230400', '绥滨县', null);
INSERT INTO `regions` VALUES ('740', '230502', '230500', '尖山区', null);
INSERT INTO `regions` VALUES ('741', '230503', '230500', '岭东区', null);
INSERT INTO `regions` VALUES ('742', '230505', '230500', '四方台区', null);
INSERT INTO `regions` VALUES ('743', '230506', '230500', '宝山区', null);
INSERT INTO `regions` VALUES ('744', '230521', '230500', '集贤县', null);
INSERT INTO `regions` VALUES ('745', '230522', '230500', '友谊县', null);
INSERT INTO `regions` VALUES ('746', '230523', '230500', '宝清县', null);
INSERT INTO `regions` VALUES ('747', '230524', '230500', '饶河县', null);
INSERT INTO `regions` VALUES ('748', '230602', '230600', '萨尔图区', null);
INSERT INTO `regions` VALUES ('749', '230603', '230600', '龙凤区', null);
INSERT INTO `regions` VALUES ('750', '230604', '230600', '让胡路区', null);
INSERT INTO `regions` VALUES ('751', '230605', '230600', '红岗区', null);
INSERT INTO `regions` VALUES ('752', '230606', '230600', '大同区', null);
INSERT INTO `regions` VALUES ('753', '230621', '230600', '肇州县', null);
INSERT INTO `regions` VALUES ('754', '230622', '230600', '肇源县', null);
INSERT INTO `regions` VALUES ('755', '230623', '230600', '林甸县', null);
INSERT INTO `regions` VALUES ('756', '230624', '230600', '杜尔伯特蒙古族自治县', null);
INSERT INTO `regions` VALUES ('757', '230702', '230700', '伊春区', null);
INSERT INTO `regions` VALUES ('758', '230703', '230700', '南岔区', null);
INSERT INTO `regions` VALUES ('759', '230704', '230700', '友好区', null);
INSERT INTO `regions` VALUES ('760', '230705', '230700', '西林区', null);
INSERT INTO `regions` VALUES ('761', '230706', '230700', '翠峦区', null);
INSERT INTO `regions` VALUES ('762', '230707', '230700', '新青区', null);
INSERT INTO `regions` VALUES ('763', '230708', '230700', '美溪区', null);
INSERT INTO `regions` VALUES ('764', '230709', '230700', '金山屯区', null);
INSERT INTO `regions` VALUES ('765', '230710', '230700', '五营区', null);
INSERT INTO `regions` VALUES ('766', '230711', '230700', '乌马河区', null);
INSERT INTO `regions` VALUES ('767', '230712', '230700', '汤旺河区', null);
INSERT INTO `regions` VALUES ('768', '230713', '230700', '带岭区', null);
INSERT INTO `regions` VALUES ('769', '230714', '230700', '乌伊岭区', null);
INSERT INTO `regions` VALUES ('770', '230715', '230700', '红星区', null);
INSERT INTO `regions` VALUES ('771', '230716', '230700', '上甘岭区', null);
INSERT INTO `regions` VALUES ('772', '230722', '230700', '嘉荫县', null);
INSERT INTO `regions` VALUES ('773', '230781', '230700', '铁力市', null);
INSERT INTO `regions` VALUES ('774', '230803', '230800', '向阳区', null);
INSERT INTO `regions` VALUES ('775', '230804', '230800', '前进区', null);
INSERT INTO `regions` VALUES ('776', '230805', '230800', '东风区', null);
INSERT INTO `regions` VALUES ('777', '230811', '230800', '郊区', null);
INSERT INTO `regions` VALUES ('778', '230822', '230800', '桦南县', null);
INSERT INTO `regions` VALUES ('779', '230826', '230800', '桦川县', null);
INSERT INTO `regions` VALUES ('780', '230828', '230800', '汤原县', null);
INSERT INTO `regions` VALUES ('781', '230881', '230800', '同江市', null);
INSERT INTO `regions` VALUES ('782', '230882', '230800', '富锦市', null);
INSERT INTO `regions` VALUES ('783', '230883', '230800', '抚远市', null);
INSERT INTO `regions` VALUES ('784', '230902', '230900', '新兴区', null);
INSERT INTO `regions` VALUES ('785', '230903', '230900', '桃山区', null);
INSERT INTO `regions` VALUES ('786', '230904', '230900', '茄子河区', null);
INSERT INTO `regions` VALUES ('787', '230921', '230900', '勃利县', null);
INSERT INTO `regions` VALUES ('788', '231002', '231000', '东安区', null);
INSERT INTO `regions` VALUES ('789', '231003', '231000', '阳明区', null);
INSERT INTO `regions` VALUES ('790', '231004', '231000', '爱民区', null);
INSERT INTO `regions` VALUES ('791', '231005', '231000', '西安区', null);
INSERT INTO `regions` VALUES ('792', '231025', '231000', '林口县', null);
INSERT INTO `regions` VALUES ('793', '231081', '231000', '绥芬河市', null);
INSERT INTO `regions` VALUES ('794', '231083', '231000', '海林市', null);
INSERT INTO `regions` VALUES ('795', '231084', '231000', '宁安市', null);
INSERT INTO `regions` VALUES ('796', '231085', '231000', '穆棱市', null);
INSERT INTO `regions` VALUES ('797', '231086', '231000', '东宁市', null);
INSERT INTO `regions` VALUES ('798', '231102', '231100', '爱辉区', null);
INSERT INTO `regions` VALUES ('799', '231121', '231100', '嫩江县', null);
INSERT INTO `regions` VALUES ('800', '231123', '231100', '逊克县', null);
INSERT INTO `regions` VALUES ('801', '231124', '231100', '孙吴县', null);
INSERT INTO `regions` VALUES ('802', '231181', '231100', '北安市', null);
INSERT INTO `regions` VALUES ('803', '231182', '231100', '五大连池市', null);
INSERT INTO `regions` VALUES ('804', '231202', '231200', '北林区', null);
INSERT INTO `regions` VALUES ('805', '231221', '231200', '望奎县', null);
INSERT INTO `regions` VALUES ('806', '231222', '231200', '兰西县', null);
INSERT INTO `regions` VALUES ('807', '231223', '231200', '青冈县', null);
INSERT INTO `regions` VALUES ('808', '231224', '231200', '庆安县', null);
INSERT INTO `regions` VALUES ('809', '231225', '231200', '明水县', null);
INSERT INTO `regions` VALUES ('810', '231226', '231200', '绥棱县', null);
INSERT INTO `regions` VALUES ('811', '231281', '231200', '安达市', null);
INSERT INTO `regions` VALUES ('812', '231282', '231200', '肇东市', null);
INSERT INTO `regions` VALUES ('813', '231283', '231200', '海伦市', null);
INSERT INTO `regions` VALUES ('814', '232701', '232700', '加格达奇区', null);
INSERT INTO `regions` VALUES ('815', '232721', '232700', '呼玛县', null);
INSERT INTO `regions` VALUES ('816', '232722', '232700', '塔河县', null);
INSERT INTO `regions` VALUES ('817', '232723', '232700', '漠河县', null);
INSERT INTO `regions` VALUES ('818', '310100', '310000', '上海城区', null);
INSERT INTO `regions` VALUES ('819', '310101', '310100', '黄浦区', null);
INSERT INTO `regions` VALUES ('820', '310104', '310100', '徐汇区', null);
INSERT INTO `regions` VALUES ('821', '310105', '310100', '长宁区', null);
INSERT INTO `regions` VALUES ('822', '310106', '310100', '静安区', null);
INSERT INTO `regions` VALUES ('823', '310107', '310100', '普陀区', null);
INSERT INTO `regions` VALUES ('824', '310109', '310100', '虹口区', null);
INSERT INTO `regions` VALUES ('825', '310110', '310100', '杨浦区', null);
INSERT INTO `regions` VALUES ('826', '310112', '310100', '闵行区', null);
INSERT INTO `regions` VALUES ('827', '310113', '310100', '宝山区', null);
INSERT INTO `regions` VALUES ('828', '310114', '310100', '嘉定区', null);
INSERT INTO `regions` VALUES ('829', '310115', '310100', '浦东新区', null);
INSERT INTO `regions` VALUES ('830', '310116', '310100', '金山区', null);
INSERT INTO `regions` VALUES ('831', '310117', '310100', '松江区', null);
INSERT INTO `regions` VALUES ('832', '310118', '310100', '青浦区', null);
INSERT INTO `regions` VALUES ('833', '310120', '310100', '奉贤区', null);
INSERT INTO `regions` VALUES ('834', '310151', '310100', '崇明区', null);
INSERT INTO `regions` VALUES ('835', '320100', '320000', '南京市', null);
INSERT INTO `regions` VALUES ('836', '320200', '320000', '无锡市', null);
INSERT INTO `regions` VALUES ('837', '320300', '320000', '徐州市', null);
INSERT INTO `regions` VALUES ('838', '320400', '320000', '常州市', null);
INSERT INTO `regions` VALUES ('839', '320500', '320000', '苏州市', null);
INSERT INTO `regions` VALUES ('840', '320600', '320000', '南通市', null);
INSERT INTO `regions` VALUES ('841', '320700', '320000', '连云港市', null);
INSERT INTO `regions` VALUES ('842', '320800', '320000', '淮安市', null);
INSERT INTO `regions` VALUES ('843', '320900', '320000', '盐城市', null);
INSERT INTO `regions` VALUES ('844', '321000', '320000', '扬州市', null);
INSERT INTO `regions` VALUES ('845', '321100', '320000', '镇江市', null);
INSERT INTO `regions` VALUES ('846', '321200', '320000', '泰州市', null);
INSERT INTO `regions` VALUES ('847', '321300', '320000', '宿迁市', null);
INSERT INTO `regions` VALUES ('848', '320102', '320100', '玄武区', null);
INSERT INTO `regions` VALUES ('849', '320104', '320100', '秦淮区', null);
INSERT INTO `regions` VALUES ('850', '320105', '320100', '建邺区', null);
INSERT INTO `regions` VALUES ('851', '320106', '320100', '鼓楼区', null);
INSERT INTO `regions` VALUES ('852', '320111', '320100', '浦口区', null);
INSERT INTO `regions` VALUES ('853', '320113', '320100', '栖霞区', null);
INSERT INTO `regions` VALUES ('854', '320114', '320100', '雨花台区', null);
INSERT INTO `regions` VALUES ('855', '320115', '320100', '江宁区', null);
INSERT INTO `regions` VALUES ('856', '320116', '320100', '六合区', null);
INSERT INTO `regions` VALUES ('857', '320117', '320100', '溧水区', null);
INSERT INTO `regions` VALUES ('858', '320118', '320100', '高淳区', null);
INSERT INTO `regions` VALUES ('859', '320205', '320200', '锡山区', null);
INSERT INTO `regions` VALUES ('860', '320206', '320200', '惠山区', null);
INSERT INTO `regions` VALUES ('861', '320211', '320200', '滨湖区', null);
INSERT INTO `regions` VALUES ('862', '320213', '320200', '梁溪区', null);
INSERT INTO `regions` VALUES ('863', '320214', '320200', '新吴区', null);
INSERT INTO `regions` VALUES ('864', '320281', '320200', '江阴市', null);
INSERT INTO `regions` VALUES ('865', '320282', '320200', '宜兴市', null);
INSERT INTO `regions` VALUES ('866', '320302', '320300', '鼓楼区', null);
INSERT INTO `regions` VALUES ('867', '320303', '320300', '云龙区', null);
INSERT INTO `regions` VALUES ('868', '320305', '320300', '贾汪区', null);
INSERT INTO `regions` VALUES ('869', '320311', '320300', '泉山区', null);
INSERT INTO `regions` VALUES ('870', '320312', '320300', '铜山区', null);
INSERT INTO `regions` VALUES ('871', '320321', '320300', '丰县', null);
INSERT INTO `regions` VALUES ('872', '320322', '320300', '沛县', null);
INSERT INTO `regions` VALUES ('873', '320324', '320300', '睢宁县', null);
INSERT INTO `regions` VALUES ('874', '320381', '320300', '新沂市', null);
INSERT INTO `regions` VALUES ('875', '320382', '320300', '邳州市', null);
INSERT INTO `regions` VALUES ('876', '320402', '320400', '天宁区', null);
INSERT INTO `regions` VALUES ('877', '320404', '320400', '钟楼区', null);
INSERT INTO `regions` VALUES ('878', '320411', '320400', '新北区', null);
INSERT INTO `regions` VALUES ('879', '320412', '320400', '武进区', null);
INSERT INTO `regions` VALUES ('880', '320413', '320400', '金坛区', null);
INSERT INTO `regions` VALUES ('881', '320481', '320400', '溧阳市', null);
INSERT INTO `regions` VALUES ('882', '320505', '320500', '虎丘区', null);
INSERT INTO `regions` VALUES ('883', '320506', '320500', '吴中区', null);
INSERT INTO `regions` VALUES ('884', '320507', '320500', '相城区', null);
INSERT INTO `regions` VALUES ('885', '320508', '320500', '姑苏区', null);
INSERT INTO `regions` VALUES ('886', '320509', '320500', '吴江区', null);
INSERT INTO `regions` VALUES ('887', '320581', '320500', '常熟市', null);
INSERT INTO `regions` VALUES ('888', '320582', '320500', '张家港市', null);
INSERT INTO `regions` VALUES ('889', '320583', '320500', '昆山市', null);
INSERT INTO `regions` VALUES ('890', '320585', '320500', '太仓市', null);
INSERT INTO `regions` VALUES ('891', '320602', '320600', '崇川区', null);
INSERT INTO `regions` VALUES ('892', '320611', '320600', '港闸区', null);
INSERT INTO `regions` VALUES ('893', '320612', '320600', '通州区', null);
INSERT INTO `regions` VALUES ('894', '320621', '320600', '海安县', null);
INSERT INTO `regions` VALUES ('895', '320623', '320600', '如东县', null);
INSERT INTO `regions` VALUES ('896', '320681', '320600', '启东市', null);
INSERT INTO `regions` VALUES ('897', '320682', '320600', '如皋市', null);
INSERT INTO `regions` VALUES ('898', '320684', '320600', '海门市', null);
INSERT INTO `regions` VALUES ('899', '320703', '320700', '连云区', null);
INSERT INTO `regions` VALUES ('900', '320706', '320700', '海州区', null);
INSERT INTO `regions` VALUES ('901', '320707', '320700', '赣榆区', null);
INSERT INTO `regions` VALUES ('902', '320722', '320700', '东海县', null);
INSERT INTO `regions` VALUES ('903', '320723', '320700', '灌云县', null);
INSERT INTO `regions` VALUES ('904', '320724', '320700', '灌南县', null);
INSERT INTO `regions` VALUES ('905', '320803', '320800', '淮安区', null);
INSERT INTO `regions` VALUES ('906', '320804', '320800', '淮阴区', null);
INSERT INTO `regions` VALUES ('907', '320812', '320800', '清江浦区', null);
INSERT INTO `regions` VALUES ('908', '320813', '320800', '洪泽区', null);
INSERT INTO `regions` VALUES ('909', '320826', '320800', '涟水县', null);
INSERT INTO `regions` VALUES ('910', '320830', '320800', '盱眙县', null);
INSERT INTO `regions` VALUES ('911', '320831', '320800', '金湖县', null);
INSERT INTO `regions` VALUES ('912', '320902', '320900', '亭湖区', null);
INSERT INTO `regions` VALUES ('913', '320903', '320900', '盐都区', null);
INSERT INTO `regions` VALUES ('914', '320904', '320900', '大丰区', null);
INSERT INTO `regions` VALUES ('915', '320921', '320900', '响水县', null);
INSERT INTO `regions` VALUES ('916', '320922', '320900', '滨海县', null);
INSERT INTO `regions` VALUES ('917', '320923', '320900', '阜宁县', null);
INSERT INTO `regions` VALUES ('918', '320924', '320900', '射阳县', null);
INSERT INTO `regions` VALUES ('919', '320925', '320900', '建湖县', null);
INSERT INTO `regions` VALUES ('920', '320981', '320900', '东台市', null);
INSERT INTO `regions` VALUES ('921', '321002', '321000', '广陵区', null);
INSERT INTO `regions` VALUES ('922', '321003', '321000', '邗江区', null);
INSERT INTO `regions` VALUES ('923', '321012', '321000', '江都区', null);
INSERT INTO `regions` VALUES ('924', '321023', '321000', '宝应县', null);
INSERT INTO `regions` VALUES ('925', '321081', '321000', '仪征市', null);
INSERT INTO `regions` VALUES ('926', '321084', '321000', '高邮市', null);
INSERT INTO `regions` VALUES ('927', '321102', '321100', '京口区', null);
INSERT INTO `regions` VALUES ('928', '321111', '321100', '润州区', null);
INSERT INTO `regions` VALUES ('929', '321112', '321100', '丹徒区', null);
INSERT INTO `regions` VALUES ('930', '321181', '321100', '丹阳市', null);
INSERT INTO `regions` VALUES ('931', '321182', '321100', '扬中市', null);
INSERT INTO `regions` VALUES ('932', '321183', '321100', '句容市', null);
INSERT INTO `regions` VALUES ('933', '321202', '321200', '海陵区', null);
INSERT INTO `regions` VALUES ('934', '321203', '321200', '高港区', null);
INSERT INTO `regions` VALUES ('935', '321204', '321200', '姜堰区', null);
INSERT INTO `regions` VALUES ('936', '321281', '321200', '兴化市', null);
INSERT INTO `regions` VALUES ('937', '321282', '321200', '靖江市', null);
INSERT INTO `regions` VALUES ('938', '321283', '321200', '泰兴市', null);
INSERT INTO `regions` VALUES ('939', '321302', '321300', '宿城区', null);
INSERT INTO `regions` VALUES ('940', '321311', '321300', '宿豫区', null);
INSERT INTO `regions` VALUES ('941', '321322', '321300', '沭阳县', null);
INSERT INTO `regions` VALUES ('942', '321323', '321300', '泗阳县', null);
INSERT INTO `regions` VALUES ('943', '321324', '321300', '泗洪县', null);
INSERT INTO `regions` VALUES ('944', '330100', '330000', '杭州市', null);
INSERT INTO `regions` VALUES ('945', '330200', '330000', '宁波市', null);
INSERT INTO `regions` VALUES ('946', '330300', '330000', '温州市', null);
INSERT INTO `regions` VALUES ('947', '330400', '330000', '嘉兴市', null);
INSERT INTO `regions` VALUES ('948', '330500', '330000', '湖州市', null);
INSERT INTO `regions` VALUES ('949', '330600', '330000', '绍兴市', null);
INSERT INTO `regions` VALUES ('950', '330700', '330000', '金华市', null);
INSERT INTO `regions` VALUES ('951', '330800', '330000', '衢州市', null);
INSERT INTO `regions` VALUES ('952', '330900', '330000', '舟山市', null);
INSERT INTO `regions` VALUES ('953', '331000', '330000', '台州市', null);
INSERT INTO `regions` VALUES ('954', '331100', '330000', '丽水市', null);
INSERT INTO `regions` VALUES ('955', '330102', '330100', '上城区', null);
INSERT INTO `regions` VALUES ('956', '330103', '330100', '下城区', null);
INSERT INTO `regions` VALUES ('957', '330104', '330100', '江干区', null);
INSERT INTO `regions` VALUES ('958', '330105', '330100', '拱墅区', null);
INSERT INTO `regions` VALUES ('959', '330106', '330100', '西湖区', null);
INSERT INTO `regions` VALUES ('960', '330108', '330100', '滨江区', null);
INSERT INTO `regions` VALUES ('961', '330109', '330100', '萧山区', null);
INSERT INTO `regions` VALUES ('962', '330110', '330100', '余杭区', null);
INSERT INTO `regions` VALUES ('963', '330111', '330100', '富阳区', null);
INSERT INTO `regions` VALUES ('964', '330112', '330100', '临安区', null);
INSERT INTO `regions` VALUES ('965', '330122', '330100', '桐庐县', null);
INSERT INTO `regions` VALUES ('966', '330127', '330100', '淳安县', null);
INSERT INTO `regions` VALUES ('967', '330182', '330100', '建德市', null);
INSERT INTO `regions` VALUES ('968', '330203', '330200', '海曙区', null);
INSERT INTO `regions` VALUES ('969', '330205', '330200', '江北区', null);
INSERT INTO `regions` VALUES ('970', '330206', '330200', '北仑区', null);
INSERT INTO `regions` VALUES ('971', '330211', '330200', '镇海区', null);
INSERT INTO `regions` VALUES ('972', '330212', '330200', '鄞州区', null);
INSERT INTO `regions` VALUES ('973', '330213', '330200', '奉化区', null);
INSERT INTO `regions` VALUES ('974', '330225', '330200', '象山县', null);
INSERT INTO `regions` VALUES ('975', '330226', '330200', '宁海县', null);
INSERT INTO `regions` VALUES ('976', '330281', '330200', '余姚市', null);
INSERT INTO `regions` VALUES ('977', '330282', '330200', '慈溪市', null);
INSERT INTO `regions` VALUES ('978', '330302', '330300', '鹿城区', null);
INSERT INTO `regions` VALUES ('979', '330303', '330300', '龙湾区', null);
INSERT INTO `regions` VALUES ('980', '330304', '330300', '瓯海区', null);
INSERT INTO `regions` VALUES ('981', '330305', '330300', '洞头区', null);
INSERT INTO `regions` VALUES ('982', '330324', '330300', '永嘉县', null);
INSERT INTO `regions` VALUES ('983', '330326', '330300', '平阳县', null);
INSERT INTO `regions` VALUES ('984', '330327', '330300', '苍南县', null);
INSERT INTO `regions` VALUES ('985', '330328', '330300', '文成县', null);
INSERT INTO `regions` VALUES ('986', '330329', '330300', '泰顺县', null);
INSERT INTO `regions` VALUES ('987', '330381', '330300', '瑞安市', null);
INSERT INTO `regions` VALUES ('988', '330382', '330300', '乐清市', null);
INSERT INTO `regions` VALUES ('989', '330402', '330400', '南湖区', null);
INSERT INTO `regions` VALUES ('990', '330411', '330400', '秀洲区', null);
INSERT INTO `regions` VALUES ('991', '330421', '330400', '嘉善县', null);
INSERT INTO `regions` VALUES ('992', '330424', '330400', '海盐县', null);
INSERT INTO `regions` VALUES ('993', '330481', '330400', '海宁市', null);
INSERT INTO `regions` VALUES ('994', '330482', '330400', '平湖市', null);
INSERT INTO `regions` VALUES ('995', '330483', '330400', '桐乡市', null);
INSERT INTO `regions` VALUES ('996', '330502', '330500', '吴兴区', null);
INSERT INTO `regions` VALUES ('997', '330503', '330500', '南浔区', null);
INSERT INTO `regions` VALUES ('998', '330521', '330500', '德清县', null);
INSERT INTO `regions` VALUES ('999', '330522', '330500', '长兴县', null);
INSERT INTO `regions` VALUES ('1000', '330523', '330500', '安吉县', null);
INSERT INTO `regions` VALUES ('1001', '330602', '330600', '越城区', null);
INSERT INTO `regions` VALUES ('1002', '330603', '330600', '柯桥区', null);
INSERT INTO `regions` VALUES ('1003', '330604', '330600', '上虞区', null);
INSERT INTO `regions` VALUES ('1004', '330624', '330600', '新昌县', null);
INSERT INTO `regions` VALUES ('1005', '330681', '330600', '诸暨市', null);
INSERT INTO `regions` VALUES ('1006', '330683', '330600', '嵊州市', null);
INSERT INTO `regions` VALUES ('1007', '330702', '330700', '婺城区', null);
INSERT INTO `regions` VALUES ('1008', '330703', '330700', '金东区', null);
INSERT INTO `regions` VALUES ('1009', '330723', '330700', '武义县', null);
INSERT INTO `regions` VALUES ('1010', '330726', '330700', '浦江县', null);
INSERT INTO `regions` VALUES ('1011', '330727', '330700', '磐安县', null);
INSERT INTO `regions` VALUES ('1012', '330781', '330700', '兰溪市', null);
INSERT INTO `regions` VALUES ('1013', '330782', '330700', '义乌市', null);
INSERT INTO `regions` VALUES ('1014', '330783', '330700', '东阳市', null);
INSERT INTO `regions` VALUES ('1015', '330784', '330700', '永康市', null);
INSERT INTO `regions` VALUES ('1016', '330802', '330800', '柯城区', null);
INSERT INTO `regions` VALUES ('1017', '330803', '330800', '衢江区', null);
INSERT INTO `regions` VALUES ('1018', '330822', '330800', '常山县', null);
INSERT INTO `regions` VALUES ('1019', '330824', '330800', '开化县', null);
INSERT INTO `regions` VALUES ('1020', '330825', '330800', '龙游县', null);
INSERT INTO `regions` VALUES ('1021', '330881', '330800', '江山市', null);
INSERT INTO `regions` VALUES ('1022', '330902', '330900', '定海区', null);
INSERT INTO `regions` VALUES ('1023', '330903', '330900', '普陀区', null);
INSERT INTO `regions` VALUES ('1024', '330921', '330900', '岱山县', null);
INSERT INTO `regions` VALUES ('1025', '330922', '330900', '嵊泗县', null);
INSERT INTO `regions` VALUES ('1026', '331002', '331000', '椒江区', null);
INSERT INTO `regions` VALUES ('1027', '331003', '331000', '黄岩区', null);
INSERT INTO `regions` VALUES ('1028', '331004', '331000', '路桥区', null);
INSERT INTO `regions` VALUES ('1029', '331022', '331000', '三门县', null);
INSERT INTO `regions` VALUES ('1030', '331023', '331000', '天台县', null);
INSERT INTO `regions` VALUES ('1031', '331024', '331000', '仙居县', null);
INSERT INTO `regions` VALUES ('1032', '331081', '331000', '温岭市', null);
INSERT INTO `regions` VALUES ('1033', '331082', '331000', '临海市', null);
INSERT INTO `regions` VALUES ('1034', '331083', '331000', '玉环市', null);
INSERT INTO `regions` VALUES ('1035', '331102', '331100', '莲都区', null);
INSERT INTO `regions` VALUES ('1036', '331121', '331100', '青田县', null);
INSERT INTO `regions` VALUES ('1037', '331122', '331100', '缙云县', null);
INSERT INTO `regions` VALUES ('1038', '331123', '331100', '遂昌县', null);
INSERT INTO `regions` VALUES ('1039', '331124', '331100', '松阳县', null);
INSERT INTO `regions` VALUES ('1040', '331125', '331100', '云和县', null);
INSERT INTO `regions` VALUES ('1041', '331126', '331100', '庆元县', null);
INSERT INTO `regions` VALUES ('1042', '331127', '331100', '景宁畲族自治县', null);
INSERT INTO `regions` VALUES ('1043', '331181', '331100', '龙泉市', null);
INSERT INTO `regions` VALUES ('1044', '340100', '340000', '合肥市', null);
INSERT INTO `regions` VALUES ('1045', '340200', '340000', '芜湖市', null);
INSERT INTO `regions` VALUES ('1046', '340300', '340000', '蚌埠市', null);
INSERT INTO `regions` VALUES ('1047', '340400', '340000', '淮南市', null);
INSERT INTO `regions` VALUES ('1048', '340500', '340000', '马鞍山市', null);
INSERT INTO `regions` VALUES ('1049', '340600', '340000', '淮北市', null);
INSERT INTO `regions` VALUES ('1050', '340700', '340000', '铜陵市', null);
INSERT INTO `regions` VALUES ('1051', '340800', '340000', '安庆市', null);
INSERT INTO `regions` VALUES ('1052', '341000', '340000', '黄山市', null);
INSERT INTO `regions` VALUES ('1053', '341100', '340000', '滁州市', null);
INSERT INTO `regions` VALUES ('1054', '341200', '340000', '阜阳市', null);
INSERT INTO `regions` VALUES ('1055', '341300', '340000', '宿州市', null);
INSERT INTO `regions` VALUES ('1056', '341500', '340000', '六安市', null);
INSERT INTO `regions` VALUES ('1057', '341600', '340000', '亳州市', null);
INSERT INTO `regions` VALUES ('1058', '341700', '340000', '池州市', null);
INSERT INTO `regions` VALUES ('1059', '341800', '340000', '宣城市', null);
INSERT INTO `regions` VALUES ('1060', '340102', '340100', '瑶海区', null);
INSERT INTO `regions` VALUES ('1061', '340103', '340100', '庐阳区', null);
INSERT INTO `regions` VALUES ('1062', '340104', '340100', '蜀山区', null);
INSERT INTO `regions` VALUES ('1063', '340111', '340100', '包河区', null);
INSERT INTO `regions` VALUES ('1064', '340121', '340100', '长丰县', null);
INSERT INTO `regions` VALUES ('1065', '340122', '340100', '肥东县', null);
INSERT INTO `regions` VALUES ('1066', '340123', '340100', '肥西县', null);
INSERT INTO `regions` VALUES ('1067', '340124', '340100', '庐江县', null);
INSERT INTO `regions` VALUES ('1068', '340181', '340100', '巢湖市', null);
INSERT INTO `regions` VALUES ('1069', '340202', '340200', '镜湖区', null);
INSERT INTO `regions` VALUES ('1070', '340203', '340200', '弋江区', null);
INSERT INTO `regions` VALUES ('1071', '340207', '340200', '鸠江区', null);
INSERT INTO `regions` VALUES ('1072', '340208', '340200', '三山区', null);
INSERT INTO `regions` VALUES ('1073', '340221', '340200', '芜湖县', null);
INSERT INTO `regions` VALUES ('1074', '340222', '340200', '繁昌县', null);
INSERT INTO `regions` VALUES ('1075', '340223', '340200', '南陵县', null);
INSERT INTO `regions` VALUES ('1076', '340225', '340200', '无为县', null);
INSERT INTO `regions` VALUES ('1077', '340302', '340300', '龙子湖区', null);
INSERT INTO `regions` VALUES ('1078', '340303', '340300', '蚌山区', null);
INSERT INTO `regions` VALUES ('1079', '340304', '340300', '禹会区', null);
INSERT INTO `regions` VALUES ('1080', '340311', '340300', '淮上区', null);
INSERT INTO `regions` VALUES ('1081', '340321', '340300', '怀远县', null);
INSERT INTO `regions` VALUES ('1082', '340322', '340300', '五河县', null);
INSERT INTO `regions` VALUES ('1083', '340323', '340300', '固镇县', null);
INSERT INTO `regions` VALUES ('1084', '340402', '340400', '大通区', null);
INSERT INTO `regions` VALUES ('1085', '340403', '340400', '田家庵区', null);
INSERT INTO `regions` VALUES ('1086', '340404', '340400', '谢家集区', null);
INSERT INTO `regions` VALUES ('1087', '340405', '340400', '八公山区', null);
INSERT INTO `regions` VALUES ('1088', '340406', '340400', '潘集区', null);
INSERT INTO `regions` VALUES ('1089', '340421', '340400', '凤台县', null);
INSERT INTO `regions` VALUES ('1090', '340422', '340400', '寿县', null);
INSERT INTO `regions` VALUES ('1091', '340503', '340500', '花山区', null);
INSERT INTO `regions` VALUES ('1092', '340504', '340500', '雨山区', null);
INSERT INTO `regions` VALUES ('1093', '340506', '340500', '博望区', null);
INSERT INTO `regions` VALUES ('1094', '340521', '340500', '当涂县', null);
INSERT INTO `regions` VALUES ('1095', '340522', '340500', '含山县', null);
INSERT INTO `regions` VALUES ('1096', '340523', '340500', '和县', null);
INSERT INTO `regions` VALUES ('1097', '340602', '340600', '杜集区', null);
INSERT INTO `regions` VALUES ('1098', '340603', '340600', '相山区', null);
INSERT INTO `regions` VALUES ('1099', '340604', '340600', '烈山区', null);
INSERT INTO `regions` VALUES ('1100', '340621', '340600', '濉溪县', null);
INSERT INTO `regions` VALUES ('1101', '340705', '340700', '铜官区', null);
INSERT INTO `regions` VALUES ('1102', '340706', '340700', '义安区', null);
INSERT INTO `regions` VALUES ('1103', '340711', '340700', '郊区', null);
INSERT INTO `regions` VALUES ('1104', '340722', '340700', '枞阳县', null);
INSERT INTO `regions` VALUES ('1105', '340802', '340800', '迎江区', null);
INSERT INTO `regions` VALUES ('1106', '340803', '340800', '大观区', null);
INSERT INTO `regions` VALUES ('1107', '340811', '340800', '宜秀区', null);
INSERT INTO `regions` VALUES ('1108', '340822', '340800', '怀宁县', null);
INSERT INTO `regions` VALUES ('1109', '340824', '340800', '潜山县', null);
INSERT INTO `regions` VALUES ('1110', '340825', '340800', '太湖县', null);
INSERT INTO `regions` VALUES ('1111', '340826', '340800', '宿松县', null);
INSERT INTO `regions` VALUES ('1112', '340827', '340800', '望江县', null);
INSERT INTO `regions` VALUES ('1113', '340828', '340800', '岳西县', null);
INSERT INTO `regions` VALUES ('1114', '340881', '340800', '桐城市', null);
INSERT INTO `regions` VALUES ('1115', '341002', '341000', '屯溪区', null);
INSERT INTO `regions` VALUES ('1116', '341003', '341000', '黄山区', null);
INSERT INTO `regions` VALUES ('1117', '341004', '341000', '徽州区', null);
INSERT INTO `regions` VALUES ('1118', '341021', '341000', '歙县', null);
INSERT INTO `regions` VALUES ('1119', '341022', '341000', '休宁县', null);
INSERT INTO `regions` VALUES ('1120', '341023', '341000', '黟县', null);
INSERT INTO `regions` VALUES ('1121', '341024', '341000', '祁门县', null);
INSERT INTO `regions` VALUES ('1122', '341102', '341100', '琅琊区', null);
INSERT INTO `regions` VALUES ('1123', '341103', '341100', '南谯区', null);
INSERT INTO `regions` VALUES ('1124', '341122', '341100', '来安县', null);
INSERT INTO `regions` VALUES ('1125', '341124', '341100', '全椒县', null);
INSERT INTO `regions` VALUES ('1126', '341125', '341100', '定远县', null);
INSERT INTO `regions` VALUES ('1127', '341126', '341100', '凤阳县', null);
INSERT INTO `regions` VALUES ('1128', '341181', '341100', '天长市', null);
INSERT INTO `regions` VALUES ('1129', '341182', '341100', '明光市', null);
INSERT INTO `regions` VALUES ('1130', '341202', '341200', '颍州区', null);
INSERT INTO `regions` VALUES ('1131', '341203', '341200', '颍东区', null);
INSERT INTO `regions` VALUES ('1132', '341204', '341200', '颍泉区', null);
INSERT INTO `regions` VALUES ('1133', '341221', '341200', '临泉县', null);
INSERT INTO `regions` VALUES ('1134', '341222', '341200', '太和县', null);
INSERT INTO `regions` VALUES ('1135', '341225', '341200', '阜南县', null);
INSERT INTO `regions` VALUES ('1136', '341226', '341200', '颍上县', null);
INSERT INTO `regions` VALUES ('1137', '341282', '341200', '界首市', null);
INSERT INTO `regions` VALUES ('1138', '341302', '341300', '埇桥区', null);
INSERT INTO `regions` VALUES ('1139', '341321', '341300', '砀山县', null);
INSERT INTO `regions` VALUES ('1140', '341322', '341300', '萧县', null);
INSERT INTO `regions` VALUES ('1141', '341323', '341300', '灵璧县', null);
INSERT INTO `regions` VALUES ('1142', '341324', '341300', '泗县', null);
INSERT INTO `regions` VALUES ('1143', '341502', '341500', '金安区', null);
INSERT INTO `regions` VALUES ('1144', '341503', '341500', '裕安区', null);
INSERT INTO `regions` VALUES ('1145', '341504', '341500', '叶集区', null);
INSERT INTO `regions` VALUES ('1146', '341522', '341500', '霍邱县', null);
INSERT INTO `regions` VALUES ('1147', '341523', '341500', '舒城县', null);
INSERT INTO `regions` VALUES ('1148', '341524', '341500', '金寨县', null);
INSERT INTO `regions` VALUES ('1149', '341525', '341500', '霍山县', null);
INSERT INTO `regions` VALUES ('1150', '341602', '341600', '谯城区', null);
INSERT INTO `regions` VALUES ('1151', '341621', '341600', '涡阳县', null);
INSERT INTO `regions` VALUES ('1152', '341622', '341600', '蒙城县', null);
INSERT INTO `regions` VALUES ('1153', '341623', '341600', '利辛县', null);
INSERT INTO `regions` VALUES ('1154', '341702', '341700', '贵池区', null);
INSERT INTO `regions` VALUES ('1155', '341721', '341700', '东至县', null);
INSERT INTO `regions` VALUES ('1156', '341722', '341700', '石台县', null);
INSERT INTO `regions` VALUES ('1157', '341723', '341700', '青阳县', null);
INSERT INTO `regions` VALUES ('1158', '341802', '341800', '宣州区', null);
INSERT INTO `regions` VALUES ('1159', '341821', '341800', '郎溪县', null);
INSERT INTO `regions` VALUES ('1160', '341822', '341800', '广德县', null);
INSERT INTO `regions` VALUES ('1161', '341823', '341800', '泾县', null);
INSERT INTO `regions` VALUES ('1162', '341824', '341800', '绩溪县', null);
INSERT INTO `regions` VALUES ('1163', '341825', '341800', '旌德县', null);
INSERT INTO `regions` VALUES ('1164', '341881', '341800', '宁国市', null);
INSERT INTO `regions` VALUES ('1165', '350100', '350000', '福州市', null);
INSERT INTO `regions` VALUES ('1166', '350200', '350000', '厦门市', null);
INSERT INTO `regions` VALUES ('1167', '350300', '350000', '莆田市', null);
INSERT INTO `regions` VALUES ('1168', '350400', '350000', '三明市', null);
INSERT INTO `regions` VALUES ('1169', '350500', '350000', '泉州市', null);
INSERT INTO `regions` VALUES ('1170', '350600', '350000', '漳州市', null);
INSERT INTO `regions` VALUES ('1171', '350700', '350000', '南平市', null);
INSERT INTO `regions` VALUES ('1172', '350800', '350000', '龙岩市', null);
INSERT INTO `regions` VALUES ('1173', '350900', '350000', '宁德市', null);
INSERT INTO `regions` VALUES ('1174', '350102', '350100', '鼓楼区', null);
INSERT INTO `regions` VALUES ('1175', '350103', '350100', '台江区', null);
INSERT INTO `regions` VALUES ('1176', '350104', '350100', '仓山区', null);
INSERT INTO `regions` VALUES ('1177', '350105', '350100', '马尾区', null);
INSERT INTO `regions` VALUES ('1178', '350111', '350100', '晋安区', null);
INSERT INTO `regions` VALUES ('1179', '350112', '350100', '长乐区', null);
INSERT INTO `regions` VALUES ('1180', '350121', '350100', '闽侯县', null);
INSERT INTO `regions` VALUES ('1181', '350122', '350100', '连江县', null);
INSERT INTO `regions` VALUES ('1182', '350123', '350100', '罗源县', null);
INSERT INTO `regions` VALUES ('1183', '350124', '350100', '闽清县', null);
INSERT INTO `regions` VALUES ('1184', '350125', '350100', '永泰县', null);
INSERT INTO `regions` VALUES ('1185', '350128', '350100', '平潭县', null);
INSERT INTO `regions` VALUES ('1186', '350181', '350100', '福清市', null);
INSERT INTO `regions` VALUES ('1187', '350203', '350200', '思明区', null);
INSERT INTO `regions` VALUES ('1188', '350205', '350200', '海沧区', null);
INSERT INTO `regions` VALUES ('1189', '350206', '350200', '湖里区', null);
INSERT INTO `regions` VALUES ('1190', '350211', '350200', '集美区', null);
INSERT INTO `regions` VALUES ('1191', '350212', '350200', '同安区', null);
INSERT INTO `regions` VALUES ('1192', '350213', '350200', '翔安区', null);
INSERT INTO `regions` VALUES ('1193', '350302', '350300', '城厢区', null);
INSERT INTO `regions` VALUES ('1194', '350303', '350300', '涵江区', null);
INSERT INTO `regions` VALUES ('1195', '350304', '350300', '荔城区', null);
INSERT INTO `regions` VALUES ('1196', '350305', '350300', '秀屿区', null);
INSERT INTO `regions` VALUES ('1197', '350322', '350300', '仙游县', null);
INSERT INTO `regions` VALUES ('1198', '350402', '350400', '梅列区', null);
INSERT INTO `regions` VALUES ('1199', '350403', '350400', '三元区', null);
INSERT INTO `regions` VALUES ('1200', '350421', '350400', '明溪县', null);
INSERT INTO `regions` VALUES ('1201', '350423', '350400', '清流县', null);
INSERT INTO `regions` VALUES ('1202', '350424', '350400', '宁化县', null);
INSERT INTO `regions` VALUES ('1203', '350425', '350400', '大田县', null);
INSERT INTO `regions` VALUES ('1204', '350426', '350400', '尤溪县', null);
INSERT INTO `regions` VALUES ('1205', '350427', '350400', '沙县', null);
INSERT INTO `regions` VALUES ('1206', '350428', '350400', '将乐县', null);
INSERT INTO `regions` VALUES ('1207', '350429', '350400', '泰宁县', null);
INSERT INTO `regions` VALUES ('1208', '350430', '350400', '建宁县', null);
INSERT INTO `regions` VALUES ('1209', '350481', '350400', '永安市', null);
INSERT INTO `regions` VALUES ('1210', '350502', '350500', '鲤城区', null);
INSERT INTO `regions` VALUES ('1211', '350503', '350500', '丰泽区', null);
INSERT INTO `regions` VALUES ('1212', '350504', '350500', '洛江区', null);
INSERT INTO `regions` VALUES ('1213', '350505', '350500', '泉港区', null);
INSERT INTO `regions` VALUES ('1214', '350521', '350500', '惠安县', null);
INSERT INTO `regions` VALUES ('1215', '350524', '350500', '安溪县', null);
INSERT INTO `regions` VALUES ('1216', '350525', '350500', '永春县', null);
INSERT INTO `regions` VALUES ('1217', '350526', '350500', '德化县', null);
INSERT INTO `regions` VALUES ('1218', '350527', '350500', '金门县', null);
INSERT INTO `regions` VALUES ('1219', '350581', '350500', '石狮市', null);
INSERT INTO `regions` VALUES ('1220', '350582', '350500', '晋江市', null);
INSERT INTO `regions` VALUES ('1221', '350583', '350500', '南安市', null);
INSERT INTO `regions` VALUES ('1222', '350602', '350600', '芗城区', null);
INSERT INTO `regions` VALUES ('1223', '350603', '350600', '龙文区', null);
INSERT INTO `regions` VALUES ('1224', '350622', '350600', '云霄县', null);
INSERT INTO `regions` VALUES ('1225', '350623', '350600', '漳浦县', null);
INSERT INTO `regions` VALUES ('1226', '350624', '350600', '诏安县', null);
INSERT INTO `regions` VALUES ('1227', '350625', '350600', '长泰县', null);
INSERT INTO `regions` VALUES ('1228', '350626', '350600', '东山县', null);
INSERT INTO `regions` VALUES ('1229', '350627', '350600', '南靖县', null);
INSERT INTO `regions` VALUES ('1230', '350628', '350600', '平和县', null);
INSERT INTO `regions` VALUES ('1231', '350629', '350600', '华安县', null);
INSERT INTO `regions` VALUES ('1232', '350681', '350600', '龙海市', null);
INSERT INTO `regions` VALUES ('1233', '350702', '350700', '延平区', null);
INSERT INTO `regions` VALUES ('1234', '350703', '350700', '建阳区', null);
INSERT INTO `regions` VALUES ('1235', '350721', '350700', '顺昌县', null);
INSERT INTO `regions` VALUES ('1236', '350722', '350700', '浦城县', null);
INSERT INTO `regions` VALUES ('1237', '350723', '350700', '光泽县', null);
INSERT INTO `regions` VALUES ('1238', '350724', '350700', '松溪县', null);
INSERT INTO `regions` VALUES ('1239', '350725', '350700', '政和县', null);
INSERT INTO `regions` VALUES ('1240', '350781', '350700', '邵武市', null);
INSERT INTO `regions` VALUES ('1241', '350782', '350700', '武夷山市', null);
INSERT INTO `regions` VALUES ('1242', '350783', '350700', '建瓯市', null);
INSERT INTO `regions` VALUES ('1243', '350802', '350800', '新罗区', null);
INSERT INTO `regions` VALUES ('1244', '350803', '350800', '永定区', null);
INSERT INTO `regions` VALUES ('1245', '350821', '350800', '长汀县', null);
INSERT INTO `regions` VALUES ('1246', '350823', '350800', '上杭县', null);
INSERT INTO `regions` VALUES ('1247', '350824', '350800', '武平县', null);
INSERT INTO `regions` VALUES ('1248', '350825', '350800', '连城县', null);
INSERT INTO `regions` VALUES ('1249', '350881', '350800', '漳平市', null);
INSERT INTO `regions` VALUES ('1250', '350902', '350900', '蕉城区', null);
INSERT INTO `regions` VALUES ('1251', '350921', '350900', '霞浦县', null);
INSERT INTO `regions` VALUES ('1252', '350922', '350900', '古田县', null);
INSERT INTO `regions` VALUES ('1253', '350923', '350900', '屏南县', null);
INSERT INTO `regions` VALUES ('1254', '350924', '350900', '寿宁县', null);
INSERT INTO `regions` VALUES ('1255', '350925', '350900', '周宁县', null);
INSERT INTO `regions` VALUES ('1256', '350926', '350900', '柘荣县', null);
INSERT INTO `regions` VALUES ('1257', '350981', '350900', '福安市', null);
INSERT INTO `regions` VALUES ('1258', '350982', '350900', '福鼎市', null);
INSERT INTO `regions` VALUES ('1259', '360100', '360000', '南昌市', null);
INSERT INTO `regions` VALUES ('1260', '360200', '360000', '景德镇市', null);
INSERT INTO `regions` VALUES ('1261', '360300', '360000', '萍乡市', null);
INSERT INTO `regions` VALUES ('1262', '360400', '360000', '九江市', null);
INSERT INTO `regions` VALUES ('1263', '360500', '360000', '新余市', null);
INSERT INTO `regions` VALUES ('1264', '360600', '360000', '鹰潭市', null);
INSERT INTO `regions` VALUES ('1265', '360700', '360000', '赣州市', null);
INSERT INTO `regions` VALUES ('1266', '360800', '360000', '吉安市', null);
INSERT INTO `regions` VALUES ('1267', '360900', '360000', '宜春市', null);
INSERT INTO `regions` VALUES ('1268', '361000', '360000', '抚州市', null);
INSERT INTO `regions` VALUES ('1269', '361100', '360000', '上饶市', null);
INSERT INTO `regions` VALUES ('1270', '360102', '360100', '东湖区', null);
INSERT INTO `regions` VALUES ('1271', '360103', '360100', '西湖区', null);
INSERT INTO `regions` VALUES ('1272', '360104', '360100', '青云谱区', null);
INSERT INTO `regions` VALUES ('1273', '360105', '360100', '湾里区', null);
INSERT INTO `regions` VALUES ('1274', '360111', '360100', '青山湖区', null);
INSERT INTO `regions` VALUES ('1275', '360112', '360100', '新建区', null);
INSERT INTO `regions` VALUES ('1276', '360121', '360100', '南昌县', null);
INSERT INTO `regions` VALUES ('1277', '360123', '360100', '安义县', null);
INSERT INTO `regions` VALUES ('1278', '360124', '360100', '进贤县', null);
INSERT INTO `regions` VALUES ('1279', '360202', '360200', '昌江区', null);
INSERT INTO `regions` VALUES ('1280', '360203', '360200', '珠山区', null);
INSERT INTO `regions` VALUES ('1281', '360222', '360200', '浮梁县', null);
INSERT INTO `regions` VALUES ('1282', '360281', '360200', '乐平市', null);
INSERT INTO `regions` VALUES ('1283', '360302', '360300', '安源区', null);
INSERT INTO `regions` VALUES ('1284', '360313', '360300', '湘东区', null);
INSERT INTO `regions` VALUES ('1285', '360321', '360300', '莲花县', null);
INSERT INTO `regions` VALUES ('1286', '360322', '360300', '上栗县', null);
INSERT INTO `regions` VALUES ('1287', '360323', '360300', '芦溪县', null);
INSERT INTO `regions` VALUES ('1288', '360402', '360400', '濂溪区', null);
INSERT INTO `regions` VALUES ('1289', '360403', '360400', '浔阳区', null);
INSERT INTO `regions` VALUES ('1290', '360404', '360400', '柴桑区', null);
INSERT INTO `regions` VALUES ('1291', '360423', '360400', '武宁县', null);
INSERT INTO `regions` VALUES ('1292', '360424', '360400', '修水县', null);
INSERT INTO `regions` VALUES ('1293', '360425', '360400', '永修县', null);
INSERT INTO `regions` VALUES ('1294', '360426', '360400', '德安县', null);
INSERT INTO `regions` VALUES ('1295', '360428', '360400', '都昌县', null);
INSERT INTO `regions` VALUES ('1296', '360429', '360400', '湖口县', null);
INSERT INTO `regions` VALUES ('1297', '360430', '360400', '彭泽县', null);
INSERT INTO `regions` VALUES ('1298', '360481', '360400', '瑞昌市', null);
INSERT INTO `regions` VALUES ('1299', '360482', '360400', '共青城市', null);
INSERT INTO `regions` VALUES ('1300', '360483', '360400', '庐山市', null);
INSERT INTO `regions` VALUES ('1301', '360502', '360500', '渝水区', null);
INSERT INTO `regions` VALUES ('1302', '360521', '360500', '分宜县', null);
INSERT INTO `regions` VALUES ('1303', '360602', '360600', '月湖区', null);
INSERT INTO `regions` VALUES ('1304', '360622', '360600', '余江县', null);
INSERT INTO `regions` VALUES ('1305', '360681', '360600', '贵溪市', null);
INSERT INTO `regions` VALUES ('1306', '360702', '360700', '章贡区', null);
INSERT INTO `regions` VALUES ('1307', '360703', '360700', '南康区', null);
INSERT INTO `regions` VALUES ('1308', '360704', '360700', '赣县区', null);
INSERT INTO `regions` VALUES ('1309', '360722', '360700', '信丰县', null);
INSERT INTO `regions` VALUES ('1310', '360723', '360700', '大余县', null);
INSERT INTO `regions` VALUES ('1311', '360724', '360700', '上犹县', null);
INSERT INTO `regions` VALUES ('1312', '360725', '360700', '崇义县', null);
INSERT INTO `regions` VALUES ('1313', '360726', '360700', '安远县', null);
INSERT INTO `regions` VALUES ('1314', '360727', '360700', '龙南县', null);
INSERT INTO `regions` VALUES ('1315', '360728', '360700', '定南县', null);
INSERT INTO `regions` VALUES ('1316', '360729', '360700', '全南县', null);
INSERT INTO `regions` VALUES ('1317', '360730', '360700', '宁都县', null);
INSERT INTO `regions` VALUES ('1318', '360731', '360700', '于都县', null);
INSERT INTO `regions` VALUES ('1319', '360732', '360700', '兴国县', null);
INSERT INTO `regions` VALUES ('1320', '360733', '360700', '会昌县', null);
INSERT INTO `regions` VALUES ('1321', '360734', '360700', '寻乌县', null);
INSERT INTO `regions` VALUES ('1322', '360735', '360700', '石城县', null);
INSERT INTO `regions` VALUES ('1323', '360781', '360700', '瑞金市', null);
INSERT INTO `regions` VALUES ('1324', '360802', '360800', '吉州区', null);
INSERT INTO `regions` VALUES ('1325', '360803', '360800', '青原区', null);
INSERT INTO `regions` VALUES ('1326', '360821', '360800', '吉安县', null);
INSERT INTO `regions` VALUES ('1327', '360822', '360800', '吉水县', null);
INSERT INTO `regions` VALUES ('1328', '360823', '360800', '峡江县', null);
INSERT INTO `regions` VALUES ('1329', '360824', '360800', '新干县', null);
INSERT INTO `regions` VALUES ('1330', '360825', '360800', '永丰县', null);
INSERT INTO `regions` VALUES ('1331', '360826', '360800', '泰和县', null);
INSERT INTO `regions` VALUES ('1332', '360827', '360800', '遂川县', null);
INSERT INTO `regions` VALUES ('1333', '360828', '360800', '万安县', null);
INSERT INTO `regions` VALUES ('1334', '360829', '360800', '安福县', null);
INSERT INTO `regions` VALUES ('1335', '360830', '360800', '永新县', null);
INSERT INTO `regions` VALUES ('1336', '360881', '360800', '井冈山市', null);
INSERT INTO `regions` VALUES ('1337', '360902', '360900', '袁州区', null);
INSERT INTO `regions` VALUES ('1338', '360921', '360900', '奉新县', null);
INSERT INTO `regions` VALUES ('1339', '360922', '360900', '万载县', null);
INSERT INTO `regions` VALUES ('1340', '360923', '360900', '上高县', null);
INSERT INTO `regions` VALUES ('1341', '360924', '360900', '宜丰县', null);
INSERT INTO `regions` VALUES ('1342', '360925', '360900', '靖安县', null);
INSERT INTO `regions` VALUES ('1343', '360926', '360900', '铜鼓县', null);
INSERT INTO `regions` VALUES ('1344', '360981', '360900', '丰城市', null);
INSERT INTO `regions` VALUES ('1345', '360982', '360900', '樟树市', null);
INSERT INTO `regions` VALUES ('1346', '360983', '360900', '高安市', null);
INSERT INTO `regions` VALUES ('1347', '361002', '361000', '临川区', null);
INSERT INTO `regions` VALUES ('1348', '361003', '361000', '东乡区', null);
INSERT INTO `regions` VALUES ('1349', '361021', '361000', '南城县', null);
INSERT INTO `regions` VALUES ('1350', '361022', '361000', '黎川县', null);
INSERT INTO `regions` VALUES ('1351', '361023', '361000', '南丰县', null);
INSERT INTO `regions` VALUES ('1352', '361024', '361000', '崇仁县', null);
INSERT INTO `regions` VALUES ('1353', '361025', '361000', '乐安县', null);
INSERT INTO `regions` VALUES ('1354', '361026', '361000', '宜黄县', null);
INSERT INTO `regions` VALUES ('1355', '361027', '361000', '金溪县', null);
INSERT INTO `regions` VALUES ('1356', '361028', '361000', '资溪县', null);
INSERT INTO `regions` VALUES ('1357', '361030', '361000', '广昌县', null);
INSERT INTO `regions` VALUES ('1358', '361102', '361100', '信州区', null);
INSERT INTO `regions` VALUES ('1359', '361103', '361100', '广丰区', null);
INSERT INTO `regions` VALUES ('1360', '361121', '361100', '广信区', null);
INSERT INTO `regions` VALUES ('1361', '361123', '361100', '玉山县', null);
INSERT INTO `regions` VALUES ('1362', '361124', '361100', '铅山县', null);
INSERT INTO `regions` VALUES ('1363', '361125', '361100', '横峰县', null);
INSERT INTO `regions` VALUES ('1364', '361126', '361100', '弋阳县', null);
INSERT INTO `regions` VALUES ('1365', '361127', '361100', '余干县', null);
INSERT INTO `regions` VALUES ('1366', '361128', '361100', '鄱阳县', null);
INSERT INTO `regions` VALUES ('1367', '361129', '361100', '万年县', null);
INSERT INTO `regions` VALUES ('1368', '361130', '361100', '婺源县', null);
INSERT INTO `regions` VALUES ('1369', '361181', '361100', '德兴市', null);
INSERT INTO `regions` VALUES ('1370', '370100', '370000', '济南市', null);
INSERT INTO `regions` VALUES ('1371', '370200', '370000', '青岛市', null);
INSERT INTO `regions` VALUES ('1372', '370300', '370000', '淄博市', null);
INSERT INTO `regions` VALUES ('1373', '370400', '370000', '枣庄市', null);
INSERT INTO `regions` VALUES ('1374', '370500', '370000', '东营市', null);
INSERT INTO `regions` VALUES ('1375', '370600', '370000', '烟台市', null);
INSERT INTO `regions` VALUES ('1376', '370700', '370000', '潍坊市', null);
INSERT INTO `regions` VALUES ('1377', '370800', '370000', '济宁市', null);
INSERT INTO `regions` VALUES ('1378', '370900', '370000', '泰安市', null);
INSERT INTO `regions` VALUES ('1379', '371000', '370000', '威海市', null);
INSERT INTO `regions` VALUES ('1380', '371100', '370000', '日照市', null);
INSERT INTO `regions` VALUES ('1381', '371200', '370000', '莱芜市', null);
INSERT INTO `regions` VALUES ('1382', '371300', '370000', '临沂市', null);
INSERT INTO `regions` VALUES ('1383', '371400', '370000', '德州市', null);
INSERT INTO `regions` VALUES ('1384', '371500', '370000', '聊城市', null);
INSERT INTO `regions` VALUES ('1385', '371600', '370000', '滨州市', null);
INSERT INTO `regions` VALUES ('1386', '371700', '370000', '菏泽市', null);
INSERT INTO `regions` VALUES ('1387', '370102', '370100', '历下区', null);
INSERT INTO `regions` VALUES ('1388', '370103', '370100', '市中区', null);
INSERT INTO `regions` VALUES ('1389', '370104', '370100', '槐荫区', null);
INSERT INTO `regions` VALUES ('1390', '370105', '370100', '天桥区', null);
INSERT INTO `regions` VALUES ('1391', '370112', '370100', '历城区', null);
INSERT INTO `regions` VALUES ('1392', '370113', '370100', '长清区', null);
INSERT INTO `regions` VALUES ('1393', '370114', '370100', '章丘区', null);
INSERT INTO `regions` VALUES ('1394', '370124', '370100', '平阴县', null);
INSERT INTO `regions` VALUES ('1395', '370125', '370100', '济阳县', null);
INSERT INTO `regions` VALUES ('1396', '370126', '370100', '商河县', null);
INSERT INTO `regions` VALUES ('1397', '370202', '370200', '市南区', null);
INSERT INTO `regions` VALUES ('1398', '370203', '370200', '市北区', null);
INSERT INTO `regions` VALUES ('1399', '370211', '370200', '黄岛区', null);
INSERT INTO `regions` VALUES ('1400', '370212', '370200', '崂山区', null);
INSERT INTO `regions` VALUES ('1401', '370213', '370200', '李沧区', null);
INSERT INTO `regions` VALUES ('1402', '370214', '370200', '城阳区', null);
INSERT INTO `regions` VALUES ('1403', '370215', '370200', '即墨区', null);
INSERT INTO `regions` VALUES ('1404', '370281', '370200', '胶州市', null);
INSERT INTO `regions` VALUES ('1405', '370283', '370200', '平度市', null);
INSERT INTO `regions` VALUES ('1406', '370285', '370200', '莱西市', null);
INSERT INTO `regions` VALUES ('1407', '370302', '370300', '淄川区', null);
INSERT INTO `regions` VALUES ('1408', '370303', '370300', '张店区', null);
INSERT INTO `regions` VALUES ('1409', '370304', '370300', '博山区', null);
INSERT INTO `regions` VALUES ('1410', '370305', '370300', '临淄区', null);
INSERT INTO `regions` VALUES ('1411', '370306', '370300', '周村区', null);
INSERT INTO `regions` VALUES ('1412', '370321', '370300', '桓台县', null);
INSERT INTO `regions` VALUES ('1413', '370322', '370300', '高青县', null);
INSERT INTO `regions` VALUES ('1414', '370323', '370300', '沂源县', null);
INSERT INTO `regions` VALUES ('1415', '370402', '370400', '市中区', null);
INSERT INTO `regions` VALUES ('1416', '370403', '370400', '薛城区', null);
INSERT INTO `regions` VALUES ('1417', '370404', '370400', '峄城区', null);
INSERT INTO `regions` VALUES ('1418', '370405', '370400', '台儿庄区', null);
INSERT INTO `regions` VALUES ('1419', '370406', '370400', '山亭区', null);
INSERT INTO `regions` VALUES ('1420', '370481', '370400', '滕州市', null);
INSERT INTO `regions` VALUES ('1421', '370502', '370500', '东营区', null);
INSERT INTO `regions` VALUES ('1422', '370503', '370500', '河口区', null);
INSERT INTO `regions` VALUES ('1423', '370505', '370500', '垦利区', null);
INSERT INTO `regions` VALUES ('1424', '370522', '370500', '利津县', null);
INSERT INTO `regions` VALUES ('1425', '370523', '370500', '广饶县', null);
INSERT INTO `regions` VALUES ('1426', '370602', '370600', '芝罘区', null);
INSERT INTO `regions` VALUES ('1427', '370611', '370600', '福山区', null);
INSERT INTO `regions` VALUES ('1428', '370612', '370600', '牟平区', null);
INSERT INTO `regions` VALUES ('1429', '370613', '370600', '莱山区', null);
INSERT INTO `regions` VALUES ('1430', '370634', '370600', '长岛县', null);
INSERT INTO `regions` VALUES ('1431', '370681', '370600', '龙口市', null);
INSERT INTO `regions` VALUES ('1432', '370682', '370600', '莱阳市', null);
INSERT INTO `regions` VALUES ('1433', '370683', '370600', '莱州市', null);
INSERT INTO `regions` VALUES ('1434', '370684', '370600', '蓬莱市', null);
INSERT INTO `regions` VALUES ('1435', '370685', '370600', '招远市', null);
INSERT INTO `regions` VALUES ('1436', '370686', '370600', '栖霞市', null);
INSERT INTO `regions` VALUES ('1437', '370687', '370600', '海阳市', null);
INSERT INTO `regions` VALUES ('1438', '370702', '370700', '潍城区', null);
INSERT INTO `regions` VALUES ('1439', '370703', '370700', '寒亭区', null);
INSERT INTO `regions` VALUES ('1440', '370704', '370700', '坊子区', null);
INSERT INTO `regions` VALUES ('1441', '370705', '370700', '奎文区', null);
INSERT INTO `regions` VALUES ('1442', '370724', '370700', '临朐县', null);
INSERT INTO `regions` VALUES ('1443', '370725', '370700', '昌乐县', null);
INSERT INTO `regions` VALUES ('1444', '370781', '370700', '青州市', null);
INSERT INTO `regions` VALUES ('1445', '370782', '370700', '诸城市', null);
INSERT INTO `regions` VALUES ('1446', '370783', '370700', '寿光市', null);
INSERT INTO `regions` VALUES ('1447', '370784', '370700', '安丘市', null);
INSERT INTO `regions` VALUES ('1448', '370785', '370700', '高密市', null);
INSERT INTO `regions` VALUES ('1449', '370786', '370700', '昌邑市', null);
INSERT INTO `regions` VALUES ('1450', '370811', '370800', '任城区', null);
INSERT INTO `regions` VALUES ('1451', '370812', '370800', '兖州区', null);
INSERT INTO `regions` VALUES ('1452', '370826', '370800', '微山县', null);
INSERT INTO `regions` VALUES ('1453', '370827', '370800', '鱼台县', null);
INSERT INTO `regions` VALUES ('1454', '370828', '370800', '金乡县', null);
INSERT INTO `regions` VALUES ('1455', '370829', '370800', '嘉祥县', null);
INSERT INTO `regions` VALUES ('1456', '370830', '370800', '汶上县', null);
INSERT INTO `regions` VALUES ('1457', '370831', '370800', '泗水县', null);
INSERT INTO `regions` VALUES ('1458', '370832', '370800', '梁山县', null);
INSERT INTO `regions` VALUES ('1459', '370881', '370800', '曲阜市', null);
INSERT INTO `regions` VALUES ('1460', '370883', '370800', '邹城市', null);
INSERT INTO `regions` VALUES ('1461', '370902', '370900', '泰山区', null);
INSERT INTO `regions` VALUES ('1462', '370911', '370900', '岱岳区', null);
INSERT INTO `regions` VALUES ('1463', '370921', '370900', '宁阳县', null);
INSERT INTO `regions` VALUES ('1464', '370923', '370900', '东平县', null);
INSERT INTO `regions` VALUES ('1465', '370982', '370900', '新泰市', null);
INSERT INTO `regions` VALUES ('1466', '370983', '370900', '肥城市', null);
INSERT INTO `regions` VALUES ('1467', '371002', '371000', '环翠区', null);
INSERT INTO `regions` VALUES ('1468', '371003', '371000', '文登区', null);
INSERT INTO `regions` VALUES ('1469', '371082', '371000', '荣成市', null);
INSERT INTO `regions` VALUES ('1470', '371083', '371000', '乳山市', null);
INSERT INTO `regions` VALUES ('1471', '371102', '371100', '东港区', null);
INSERT INTO `regions` VALUES ('1472', '371103', '371100', '岚山区', null);
INSERT INTO `regions` VALUES ('1473', '371121', '371100', '五莲县', null);
INSERT INTO `regions` VALUES ('1474', '371122', '371100', '莒县', null);
INSERT INTO `regions` VALUES ('1475', '371202', '371200', '莱城区', null);
INSERT INTO `regions` VALUES ('1476', '371203', '371200', '钢城区', null);
INSERT INTO `regions` VALUES ('1477', '371302', '371300', '兰山区', null);
INSERT INTO `regions` VALUES ('1478', '371311', '371300', '罗庄区', null);
INSERT INTO `regions` VALUES ('1479', '371312', '371300', '河东区', null);
INSERT INTO `regions` VALUES ('1480', '371321', '371300', '沂南县', null);
INSERT INTO `regions` VALUES ('1481', '371322', '371300', '郯城县', null);
INSERT INTO `regions` VALUES ('1482', '371323', '371300', '沂水县', null);
INSERT INTO `regions` VALUES ('1483', '371324', '371300', '兰陵县', null);
INSERT INTO `regions` VALUES ('1484', '371325', '371300', '费县', null);
INSERT INTO `regions` VALUES ('1485', '371326', '371300', '平邑县', null);
INSERT INTO `regions` VALUES ('1486', '371327', '371300', '莒南县', null);
INSERT INTO `regions` VALUES ('1487', '371328', '371300', '蒙阴县', null);
INSERT INTO `regions` VALUES ('1488', '371329', '371300', '临沭县', null);
INSERT INTO `regions` VALUES ('1489', '371402', '371400', '德城区', null);
INSERT INTO `regions` VALUES ('1490', '371403', '371400', '陵城区', null);
INSERT INTO `regions` VALUES ('1491', '371422', '371400', '宁津县', null);
INSERT INTO `regions` VALUES ('1492', '371423', '371400', '庆云县', null);
INSERT INTO `regions` VALUES ('1493', '371424', '371400', '临邑县', null);
INSERT INTO `regions` VALUES ('1494', '371425', '371400', '齐河县', null);
INSERT INTO `regions` VALUES ('1495', '371426', '371400', '平原县', null);
INSERT INTO `regions` VALUES ('1496', '371427', '371400', '夏津县', null);
INSERT INTO `regions` VALUES ('1497', '371428', '371400', '武城县', null);
INSERT INTO `regions` VALUES ('1498', '371481', '371400', '乐陵市', null);
INSERT INTO `regions` VALUES ('1499', '371482', '371400', '禹城市', null);
INSERT INTO `regions` VALUES ('1500', '371502', '371500', '东昌府区', null);
INSERT INTO `regions` VALUES ('1501', '371521', '371500', '阳谷县', null);
INSERT INTO `regions` VALUES ('1502', '371522', '371500', '莘县', null);
INSERT INTO `regions` VALUES ('1503', '371523', '371500', '茌平县', null);
INSERT INTO `regions` VALUES ('1504', '371524', '371500', '东阿县', null);
INSERT INTO `regions` VALUES ('1505', '371525', '371500', '冠县', null);
INSERT INTO `regions` VALUES ('1506', '371526', '371500', '高唐县', null);
INSERT INTO `regions` VALUES ('1507', '371581', '371500', '临清市', null);
INSERT INTO `regions` VALUES ('1508', '371602', '371600', '滨城区', null);
INSERT INTO `regions` VALUES ('1509', '371603', '371600', '沾化区', null);
INSERT INTO `regions` VALUES ('1510', '371621', '371600', '惠民县', null);
INSERT INTO `regions` VALUES ('1511', '371622', '371600', '阳信县', null);
INSERT INTO `regions` VALUES ('1512', '371623', '371600', '无棣县', null);
INSERT INTO `regions` VALUES ('1513', '371625', '371600', '博兴县', null);
INSERT INTO `regions` VALUES ('1514', '371626', '371600', '邹平县', null);
INSERT INTO `regions` VALUES ('1515', '371702', '371700', '牡丹区', null);
INSERT INTO `regions` VALUES ('1516', '371703', '371700', '定陶区', null);
INSERT INTO `regions` VALUES ('1517', '371721', '371700', '曹县', null);
INSERT INTO `regions` VALUES ('1518', '371722', '371700', '单县', null);
INSERT INTO `regions` VALUES ('1519', '371723', '371700', '成武县', null);
INSERT INTO `regions` VALUES ('1520', '371724', '371700', '巨野县', null);
INSERT INTO `regions` VALUES ('1521', '371725', '371700', '郓城县', null);
INSERT INTO `regions` VALUES ('1522', '371726', '371700', '鄄城县', null);
INSERT INTO `regions` VALUES ('1523', '371728', '371700', '东明县', null);
INSERT INTO `regions` VALUES ('1524', '410100', '410000', '郑州市', null);
INSERT INTO `regions` VALUES ('1525', '410200', '410000', '开封市', null);
INSERT INTO `regions` VALUES ('1526', '410300', '410000', '洛阳市', null);
INSERT INTO `regions` VALUES ('1527', '410400', '410000', '平顶山市', null);
INSERT INTO `regions` VALUES ('1528', '410500', '410000', '安阳市', null);
INSERT INTO `regions` VALUES ('1529', '410600', '410000', '鹤壁市', null);
INSERT INTO `regions` VALUES ('1530', '410700', '410000', '新乡市', null);
INSERT INTO `regions` VALUES ('1531', '410800', '410000', '焦作市', null);
INSERT INTO `regions` VALUES ('1532', '410900', '410000', '濮阳市', null);
INSERT INTO `regions` VALUES ('1533', '411000', '410000', '许昌市', null);
INSERT INTO `regions` VALUES ('1534', '411100', '410000', '漯河市', null);
INSERT INTO `regions` VALUES ('1535', '411200', '410000', '三门峡市', null);
INSERT INTO `regions` VALUES ('1536', '411300', '410000', '南阳市', null);
INSERT INTO `regions` VALUES ('1537', '411400', '410000', '商丘市', null);
INSERT INTO `regions` VALUES ('1538', '411500', '410000', '信阳市', null);
INSERT INTO `regions` VALUES ('1539', '411600', '410000', '周口市', null);
INSERT INTO `regions` VALUES ('1540', '411700', '410000', '驻马店市', null);
INSERT INTO `regions` VALUES ('1541', '419001', '410000', '济源市', null);
INSERT INTO `regions` VALUES ('1542', '410102', '410100', '中原区', null);
INSERT INTO `regions` VALUES ('1543', '410103', '410100', '二七区', null);
INSERT INTO `regions` VALUES ('1544', '410104', '410100', '管城回族区', null);
INSERT INTO `regions` VALUES ('1545', '410105', '410100', '金水区', null);
INSERT INTO `regions` VALUES ('1546', '410106', '410100', '上街区', null);
INSERT INTO `regions` VALUES ('1547', '410108', '410100', '惠济区', null);
INSERT INTO `regions` VALUES ('1548', '410122', '410100', '中牟县', null);
INSERT INTO `regions` VALUES ('1549', '410181', '410100', '巩义市', null);
INSERT INTO `regions` VALUES ('1550', '410182', '410100', '荥阳市', null);
INSERT INTO `regions` VALUES ('1551', '410183', '410100', '新密市', null);
INSERT INTO `regions` VALUES ('1552', '410184', '410100', '新郑市', null);
INSERT INTO `regions` VALUES ('1553', '410185', '410100', '登封市', null);
INSERT INTO `regions` VALUES ('1554', '410202', '410200', '龙亭区', null);
INSERT INTO `regions` VALUES ('1555', '410203', '410200', '顺河回族区', null);
INSERT INTO `regions` VALUES ('1556', '410204', '410200', '鼓楼区', null);
INSERT INTO `regions` VALUES ('1557', '410205', '410200', '禹王台区', null);
INSERT INTO `regions` VALUES ('1558', '410212', '410200', '祥符区', null);
INSERT INTO `regions` VALUES ('1559', '410221', '410200', '杞县', null);
INSERT INTO `regions` VALUES ('1560', '410222', '410200', '通许县', null);
INSERT INTO `regions` VALUES ('1561', '410223', '410200', '尉氏县', null);
INSERT INTO `regions` VALUES ('1562', '410225', '410200', '兰考县', null);
INSERT INTO `regions` VALUES ('1563', '410302', '410300', '老城区', null);
INSERT INTO `regions` VALUES ('1564', '410303', '410300', '西工区', null);
INSERT INTO `regions` VALUES ('1565', '410304', '410300', '瀍河回族区', null);
INSERT INTO `regions` VALUES ('1566', '410305', '410300', '涧西区', null);
INSERT INTO `regions` VALUES ('1567', '410306', '410300', '吉利区', null);
INSERT INTO `regions` VALUES ('1568', '410311', '410300', '洛龙区', null);
INSERT INTO `regions` VALUES ('1569', '410322', '410300', '孟津县', null);
INSERT INTO `regions` VALUES ('1570', '410323', '410300', '新安县', null);
INSERT INTO `regions` VALUES ('1571', '410324', '410300', '栾川县', null);
INSERT INTO `regions` VALUES ('1572', '410325', '410300', '嵩县', null);
INSERT INTO `regions` VALUES ('1573', '410326', '410300', '汝阳县', null);
INSERT INTO `regions` VALUES ('1574', '410327', '410300', '宜阳县', null);
INSERT INTO `regions` VALUES ('1575', '410328', '410300', '洛宁县', null);
INSERT INTO `regions` VALUES ('1576', '410329', '410300', '伊川县', null);
INSERT INTO `regions` VALUES ('1577', '410381', '410300', '偃师市', null);
INSERT INTO `regions` VALUES ('1578', '410402', '410400', '新华区', null);
INSERT INTO `regions` VALUES ('1579', '410403', '410400', '卫东区', null);
INSERT INTO `regions` VALUES ('1580', '410404', '410400', '石龙区', null);
INSERT INTO `regions` VALUES ('1581', '410411', '410400', '湛河区', null);
INSERT INTO `regions` VALUES ('1582', '410421', '410400', '宝丰县', null);
INSERT INTO `regions` VALUES ('1583', '410422', '410400', '叶县', null);
INSERT INTO `regions` VALUES ('1584', '410423', '410400', '鲁山县', null);
INSERT INTO `regions` VALUES ('1585', '410425', '410400', '郏县', null);
INSERT INTO `regions` VALUES ('1586', '410481', '410400', '舞钢市', null);
INSERT INTO `regions` VALUES ('1587', '410482', '410400', '汝州市', null);
INSERT INTO `regions` VALUES ('1588', '410502', '410500', '文峰区', null);
INSERT INTO `regions` VALUES ('1589', '410503', '410500', '北关区', null);
INSERT INTO `regions` VALUES ('1590', '410505', '410500', '殷都区', null);
INSERT INTO `regions` VALUES ('1591', '410506', '410500', '龙安区', null);
INSERT INTO `regions` VALUES ('1592', '410522', '410500', '安阳县', null);
INSERT INTO `regions` VALUES ('1593', '410523', '410500', '汤阴县', null);
INSERT INTO `regions` VALUES ('1594', '410526', '410500', '滑县', null);
INSERT INTO `regions` VALUES ('1595', '410527', '410500', '内黄县', null);
INSERT INTO `regions` VALUES ('1596', '410581', '410500', '林州市', null);
INSERT INTO `regions` VALUES ('1597', '410602', '410600', '鹤山区', null);
INSERT INTO `regions` VALUES ('1598', '410603', '410600', '山城区', null);
INSERT INTO `regions` VALUES ('1599', '410611', '410600', '淇滨区', null);
INSERT INTO `regions` VALUES ('1600', '410621', '410600', '浚县', null);
INSERT INTO `regions` VALUES ('1601', '410622', '410600', '淇县', null);
INSERT INTO `regions` VALUES ('1602', '410702', '410700', '红旗区', null);
INSERT INTO `regions` VALUES ('1603', '410703', '410700', '卫滨区', null);
INSERT INTO `regions` VALUES ('1604', '410704', '410700', '凤泉区', null);
INSERT INTO `regions` VALUES ('1605', '410711', '410700', '牧野区', null);
INSERT INTO `regions` VALUES ('1606', '410721', '410700', '新乡县', null);
INSERT INTO `regions` VALUES ('1607', '410724', '410700', '获嘉县', null);
INSERT INTO `regions` VALUES ('1608', '410725', '410700', '原阳县', null);
INSERT INTO `regions` VALUES ('1609', '410726', '410700', '延津县', null);
INSERT INTO `regions` VALUES ('1610', '410727', '410700', '封丘县', null);
INSERT INTO `regions` VALUES ('1611', '410728', '410700', '长垣县', null);
INSERT INTO `regions` VALUES ('1612', '410781', '410700', '卫辉市', null);
INSERT INTO `regions` VALUES ('1613', '410782', '410700', '辉县市', null);
INSERT INTO `regions` VALUES ('1614', '410802', '410800', '解放区', null);
INSERT INTO `regions` VALUES ('1615', '410803', '410800', '中站区', null);
INSERT INTO `regions` VALUES ('1616', '410804', '410800', '马村区', null);
INSERT INTO `regions` VALUES ('1617', '410811', '410800', '山阳区', null);
INSERT INTO `regions` VALUES ('1618', '410821', '410800', '修武县', null);
INSERT INTO `regions` VALUES ('1619', '410822', '410800', '博爱县', null);
INSERT INTO `regions` VALUES ('1620', '410823', '410800', '武陟县', null);
INSERT INTO `regions` VALUES ('1621', '410825', '410800', '温县', null);
INSERT INTO `regions` VALUES ('1622', '410882', '410800', '沁阳市', null);
INSERT INTO `regions` VALUES ('1623', '410883', '410800', '孟州市', null);
INSERT INTO `regions` VALUES ('1624', '410902', '410900', '华龙区', null);
INSERT INTO `regions` VALUES ('1625', '410922', '410900', '清丰县', null);
INSERT INTO `regions` VALUES ('1626', '410923', '410900', '南乐县', null);
INSERT INTO `regions` VALUES ('1627', '410926', '410900', '范县', null);
INSERT INTO `regions` VALUES ('1628', '410927', '410900', '台前县', null);
INSERT INTO `regions` VALUES ('1629', '410928', '410900', '濮阳县', null);
INSERT INTO `regions` VALUES ('1630', '411002', '411000', '魏都区', null);
INSERT INTO `regions` VALUES ('1631', '411003', '411000', '建安区', null);
INSERT INTO `regions` VALUES ('1632', '411024', '411000', '鄢陵县', null);
INSERT INTO `regions` VALUES ('1633', '411025', '411000', '襄城县', null);
INSERT INTO `regions` VALUES ('1634', '411081', '411000', '禹州市', null);
INSERT INTO `regions` VALUES ('1635', '411082', '411000', '长葛市', null);
INSERT INTO `regions` VALUES ('1636', '411102', '411100', '源汇区', null);
INSERT INTO `regions` VALUES ('1637', '411103', '411100', '郾城区', null);
INSERT INTO `regions` VALUES ('1638', '411104', '411100', '召陵区', null);
INSERT INTO `regions` VALUES ('1639', '411121', '411100', '舞阳县', null);
INSERT INTO `regions` VALUES ('1640', '411122', '411100', '临颍县', null);
INSERT INTO `regions` VALUES ('1641', '411202', '411200', '湖滨区', null);
INSERT INTO `regions` VALUES ('1642', '411203', '411200', '陕州区', null);
INSERT INTO `regions` VALUES ('1643', '411221', '411200', '渑池县', null);
INSERT INTO `regions` VALUES ('1644', '411224', '411200', '卢氏县', null);
INSERT INTO `regions` VALUES ('1645', '411281', '411200', '义马市', null);
INSERT INTO `regions` VALUES ('1646', '411282', '411200', '灵宝市', null);
INSERT INTO `regions` VALUES ('1647', '411302', '411300', '宛城区', null);
INSERT INTO `regions` VALUES ('1648', '411303', '411300', '卧龙区', null);
INSERT INTO `regions` VALUES ('1649', '411321', '411300', '南召县', null);
INSERT INTO `regions` VALUES ('1650', '411322', '411300', '方城县', null);
INSERT INTO `regions` VALUES ('1651', '411323', '411300', '西峡县', null);
INSERT INTO `regions` VALUES ('1652', '411324', '411300', '镇平县', null);
INSERT INTO `regions` VALUES ('1653', '411325', '411300', '内乡县', null);
INSERT INTO `regions` VALUES ('1654', '411326', '411300', '淅川县', null);
INSERT INTO `regions` VALUES ('1655', '411327', '411300', '社旗县', null);
INSERT INTO `regions` VALUES ('1656', '411328', '411300', '唐河县', null);
INSERT INTO `regions` VALUES ('1657', '411329', '411300', '新野县', null);
INSERT INTO `regions` VALUES ('1658', '411330', '411300', '桐柏县', null);
INSERT INTO `regions` VALUES ('1659', '411381', '411300', '邓州市', null);
INSERT INTO `regions` VALUES ('1660', '411402', '411400', '梁园区', null);
INSERT INTO `regions` VALUES ('1661', '411403', '411400', '睢阳区', null);
INSERT INTO `regions` VALUES ('1662', '411421', '411400', '民权县', null);
INSERT INTO `regions` VALUES ('1663', '411422', '411400', '睢县', null);
INSERT INTO `regions` VALUES ('1664', '411423', '411400', '宁陵县', null);
INSERT INTO `regions` VALUES ('1665', '411424', '411400', '柘城县', null);
INSERT INTO `regions` VALUES ('1666', '411425', '411400', '虞城县', null);
INSERT INTO `regions` VALUES ('1667', '411426', '411400', '夏邑县', null);
INSERT INTO `regions` VALUES ('1668', '411481', '411400', '永城市', null);
INSERT INTO `regions` VALUES ('1669', '411502', '411500', '浉河区', null);
INSERT INTO `regions` VALUES ('1670', '411503', '411500', '平桥区', null);
INSERT INTO `regions` VALUES ('1671', '411521', '411500', '罗山县', null);
INSERT INTO `regions` VALUES ('1672', '411522', '411500', '光山县', null);
INSERT INTO `regions` VALUES ('1673', '411523', '411500', '新县', null);
INSERT INTO `regions` VALUES ('1674', '411524', '411500', '商城县', null);
INSERT INTO `regions` VALUES ('1675', '411525', '411500', '固始县', null);
INSERT INTO `regions` VALUES ('1676', '411526', '411500', '潢川县', null);
INSERT INTO `regions` VALUES ('1677', '411527', '411500', '淮滨县', null);
INSERT INTO `regions` VALUES ('1678', '411528', '411500', '息县', null);
INSERT INTO `regions` VALUES ('1679', '411602', '411600', '川汇区', null);
INSERT INTO `regions` VALUES ('1680', '411621', '411600', '扶沟县', null);
INSERT INTO `regions` VALUES ('1681', '411622', '411600', '西华县', null);
INSERT INTO `regions` VALUES ('1682', '411623', '411600', '商水县', null);
INSERT INTO `regions` VALUES ('1683', '411624', '411600', '沈丘县', null);
INSERT INTO `regions` VALUES ('1684', '411625', '411600', '郸城县', null);
INSERT INTO `regions` VALUES ('1685', '411626', '411600', '淮阳县', null);
INSERT INTO `regions` VALUES ('1686', '411627', '411600', '太康县', null);
INSERT INTO `regions` VALUES ('1687', '411628', '411600', '鹿邑县', null);
INSERT INTO `regions` VALUES ('1688', '411681', '411600', '项城市', null);
INSERT INTO `regions` VALUES ('1689', '411702', '411700', '驿城区', null);
INSERT INTO `regions` VALUES ('1690', '411721', '411700', '西平县', null);
INSERT INTO `regions` VALUES ('1691', '411722', '411700', '上蔡县', null);
INSERT INTO `regions` VALUES ('1692', '411723', '411700', '平舆县', null);
INSERT INTO `regions` VALUES ('1693', '411724', '411700', '正阳县', null);
INSERT INTO `regions` VALUES ('1694', '411725', '411700', '确山县', null);
INSERT INTO `regions` VALUES ('1695', '411726', '411700', '泌阳县', null);
INSERT INTO `regions` VALUES ('1696', '411727', '411700', '汝南县', null);
INSERT INTO `regions` VALUES ('1697', '411728', '411700', '遂平县', null);
INSERT INTO `regions` VALUES ('1698', '411729', '411700', '新蔡县', null);
INSERT INTO `regions` VALUES ('1699', '419001', '419001', '济源市', null);
INSERT INTO `regions` VALUES ('1700', '420100', '420000', '武汉市', null);
INSERT INTO `regions` VALUES ('1701', '420200', '420000', '黄石市', null);
INSERT INTO `regions` VALUES ('1702', '420300', '420000', '十堰市', null);
INSERT INTO `regions` VALUES ('1703', '420500', '420000', '宜昌市', null);
INSERT INTO `regions` VALUES ('1704', '420600', '420000', '襄阳市', null);
INSERT INTO `regions` VALUES ('1705', '420700', '420000', '鄂州市', null);
INSERT INTO `regions` VALUES ('1706', '420800', '420000', '荆门市', null);
INSERT INTO `regions` VALUES ('1707', '420900', '420000', '孝感市', null);
INSERT INTO `regions` VALUES ('1708', '421000', '420000', '荆州市', null);
INSERT INTO `regions` VALUES ('1709', '421100', '420000', '黄冈市', null);
INSERT INTO `regions` VALUES ('1710', '421200', '420000', '咸宁市', null);
INSERT INTO `regions` VALUES ('1711', '421300', '420000', '随州市', null);
INSERT INTO `regions` VALUES ('1712', '422800', '420000', '恩施土家族苗族自治州', null);
INSERT INTO `regions` VALUES ('1713', '429004', '420000', '仙桃市', null);
INSERT INTO `regions` VALUES ('1714', '429005', '420000', '潜江市', null);
INSERT INTO `regions` VALUES ('1715', '429006', '420000', '天门市', null);
INSERT INTO `regions` VALUES ('1716', '429021', '420000', '神农架林区', null);
INSERT INTO `regions` VALUES ('1717', '420102', '420100', '江岸区', null);
INSERT INTO `regions` VALUES ('1718', '420103', '420100', '江汉区', null);
INSERT INTO `regions` VALUES ('1719', '420104', '420100', '硚口区', null);
INSERT INTO `regions` VALUES ('1720', '420105', '420100', '汉阳区', null);
INSERT INTO `regions` VALUES ('1721', '420106', '420100', '武昌区', null);
INSERT INTO `regions` VALUES ('1722', '420107', '420100', '青山区', null);
INSERT INTO `regions` VALUES ('1723', '420111', '420100', '洪山区', null);
INSERT INTO `regions` VALUES ('1724', '420112', '420100', '东西湖区', null);
INSERT INTO `regions` VALUES ('1725', '420113', '420100', '汉南区', null);
INSERT INTO `regions` VALUES ('1726', '420114', '420100', '蔡甸区', null);
INSERT INTO `regions` VALUES ('1727', '420115', '420100', '江夏区', null);
INSERT INTO `regions` VALUES ('1728', '420116', '420100', '黄陂区', null);
INSERT INTO `regions` VALUES ('1729', '420117', '420100', '新洲区', null);
INSERT INTO `regions` VALUES ('1730', '420202', '420200', '黄石港区', null);
INSERT INTO `regions` VALUES ('1731', '420203', '420200', '西塞山区', null);
INSERT INTO `regions` VALUES ('1732', '420204', '420200', '下陆区', null);
INSERT INTO `regions` VALUES ('1733', '420205', '420200', '铁山区', null);
INSERT INTO `regions` VALUES ('1734', '420222', '420200', '阳新县', null);
INSERT INTO `regions` VALUES ('1735', '420281', '420200', '大冶市', null);
INSERT INTO `regions` VALUES ('1736', '420302', '420300', '茅箭区', null);
INSERT INTO `regions` VALUES ('1737', '420303', '420300', '张湾区', null);
INSERT INTO `regions` VALUES ('1738', '420304', '420300', '郧阳区', null);
INSERT INTO `regions` VALUES ('1739', '420322', '420300', '郧西县', null);
INSERT INTO `regions` VALUES ('1740', '420323', '420300', '竹山县', null);
INSERT INTO `regions` VALUES ('1741', '420324', '420300', '竹溪县', null);
INSERT INTO `regions` VALUES ('1742', '420325', '420300', '房县', null);
INSERT INTO `regions` VALUES ('1743', '420381', '420300', '丹江口市', null);
INSERT INTO `regions` VALUES ('1744', '420502', '420500', '西陵区', null);
INSERT INTO `regions` VALUES ('1745', '420503', '420500', '伍家岗区', null);
INSERT INTO `regions` VALUES ('1746', '420504', '420500', '点军区', null);
INSERT INTO `regions` VALUES ('1747', '420505', '420500', '猇亭区', null);
INSERT INTO `regions` VALUES ('1748', '420506', '420500', '夷陵区', null);
INSERT INTO `regions` VALUES ('1749', '420525', '420500', '远安县', null);
INSERT INTO `regions` VALUES ('1750', '420526', '420500', '兴山县', null);
INSERT INTO `regions` VALUES ('1751', '420527', '420500', '秭归县', null);
INSERT INTO `regions` VALUES ('1752', '420528', '420500', '长阳土家族自治县', null);
INSERT INTO `regions` VALUES ('1753', '420529', '420500', '五峰土家族自治县', null);
INSERT INTO `regions` VALUES ('1754', '420581', '420500', '宜都市', null);
INSERT INTO `regions` VALUES ('1755', '420582', '420500', '当阳市', null);
INSERT INTO `regions` VALUES ('1756', '420583', '420500', '枝江市', null);
INSERT INTO `regions` VALUES ('1757', '420602', '420600', '襄城区', null);
INSERT INTO `regions` VALUES ('1758', '420606', '420600', '樊城区', null);
INSERT INTO `regions` VALUES ('1759', '420607', '420600', '襄州区', null);
INSERT INTO `regions` VALUES ('1760', '420624', '420600', '南漳县', null);
INSERT INTO `regions` VALUES ('1761', '420625', '420600', '谷城县', null);
INSERT INTO `regions` VALUES ('1762', '420626', '420600', '保康县', null);
INSERT INTO `regions` VALUES ('1763', '420682', '420600', '老河口市', null);
INSERT INTO `regions` VALUES ('1764', '420683', '420600', '枣阳市', null);
INSERT INTO `regions` VALUES ('1765', '420684', '420600', '宜城市', null);
INSERT INTO `regions` VALUES ('1766', '420702', '420700', '梁子湖区', null);
INSERT INTO `regions` VALUES ('1767', '420703', '420700', '华容区', null);
INSERT INTO `regions` VALUES ('1768', '420704', '420700', '鄂城区', null);
INSERT INTO `regions` VALUES ('1769', '420802', '420800', '东宝区', null);
INSERT INTO `regions` VALUES ('1770', '420804', '420800', '掇刀区', null);
INSERT INTO `regions` VALUES ('1771', '420821', '420800', '京山县', null);
INSERT INTO `regions` VALUES ('1772', '420822', '420800', '沙洋县', null);
INSERT INTO `regions` VALUES ('1773', '420881', '420800', '钟祥市', null);
INSERT INTO `regions` VALUES ('1774', '420902', '420900', '孝南区', null);
INSERT INTO `regions` VALUES ('1775', '420921', '420900', '孝昌县', null);
INSERT INTO `regions` VALUES ('1776', '420922', '420900', '大悟县', null);
INSERT INTO `regions` VALUES ('1777', '420923', '420900', '云梦县', null);
INSERT INTO `regions` VALUES ('1778', '420981', '420900', '应城市', null);
INSERT INTO `regions` VALUES ('1779', '420982', '420900', '安陆市', null);
INSERT INTO `regions` VALUES ('1780', '420984', '420900', '汉川市', null);
INSERT INTO `regions` VALUES ('1781', '421002', '421000', '沙市区', null);
INSERT INTO `regions` VALUES ('1782', '421003', '421000', '荆州区', null);
INSERT INTO `regions` VALUES ('1783', '421022', '421000', '公安县', null);
INSERT INTO `regions` VALUES ('1784', '421023', '421000', '监利县', null);
INSERT INTO `regions` VALUES ('1785', '421024', '421000', '江陵县', null);
INSERT INTO `regions` VALUES ('1786', '421081', '421000', '石首市', null);
INSERT INTO `regions` VALUES ('1787', '421083', '421000', '洪湖市', null);
INSERT INTO `regions` VALUES ('1788', '421087', '421000', '松滋市', null);
INSERT INTO `regions` VALUES ('1789', '421102', '421100', '黄州区', null);
INSERT INTO `regions` VALUES ('1790', '421121', '421100', '团风县', null);
INSERT INTO `regions` VALUES ('1791', '421122', '421100', '红安县', null);
INSERT INTO `regions` VALUES ('1792', '421123', '421100', '罗田县', null);
INSERT INTO `regions` VALUES ('1793', '421124', '421100', '英山县', null);
INSERT INTO `regions` VALUES ('1794', '421125', '421100', '浠水县', null);
INSERT INTO `regions` VALUES ('1795', '421126', '421100', '蕲春县', null);
INSERT INTO `regions` VALUES ('1796', '421127', '421100', '黄梅县', null);
INSERT INTO `regions` VALUES ('1797', '421181', '421100', '麻城市', null);
INSERT INTO `regions` VALUES ('1798', '421182', '421100', '武穴市', null);
INSERT INTO `regions` VALUES ('1799', '421202', '421200', '咸安区', null);
INSERT INTO `regions` VALUES ('1800', '421221', '421200', '嘉鱼县', null);
INSERT INTO `regions` VALUES ('1801', '421222', '421200', '通城县', null);
INSERT INTO `regions` VALUES ('1802', '421223', '421200', '崇阳县', null);
INSERT INTO `regions` VALUES ('1803', '421224', '421200', '通山县', null);
INSERT INTO `regions` VALUES ('1804', '421281', '421200', '赤壁市', null);
INSERT INTO `regions` VALUES ('1805', '421303', '421300', '曾都区', null);
INSERT INTO `regions` VALUES ('1806', '421321', '421300', '随县', null);
INSERT INTO `regions` VALUES ('1807', '421381', '421300', '广水市', null);
INSERT INTO `regions` VALUES ('1808', '422801', '422800', '恩施市', null);
INSERT INTO `regions` VALUES ('1809', '422802', '422800', '利川市', null);
INSERT INTO `regions` VALUES ('1810', '422822', '422800', '建始县', null);
INSERT INTO `regions` VALUES ('1811', '422823', '422800', '巴东县', null);
INSERT INTO `regions` VALUES ('1812', '422825', '422800', '宣恩县', null);
INSERT INTO `regions` VALUES ('1813', '422826', '422800', '咸丰县', null);
INSERT INTO `regions` VALUES ('1814', '422827', '422800', '来凤县', null);
INSERT INTO `regions` VALUES ('1815', '422828', '422800', '鹤峰县', null);
INSERT INTO `regions` VALUES ('1816', '429004', '429004', '仙桃市', null);
INSERT INTO `regions` VALUES ('1817', '429005', '429005', '潜江市', null);
INSERT INTO `regions` VALUES ('1818', '429006', '429006', '天门市', null);
INSERT INTO `regions` VALUES ('1819', '429021', '429021', '神农架林区', null);
INSERT INTO `regions` VALUES ('1820', '430100', '430000', '长沙市', null);
INSERT INTO `regions` VALUES ('1821', '430200', '430000', '株洲市', null);
INSERT INTO `regions` VALUES ('1822', '430300', '430000', '湘潭市', null);
INSERT INTO `regions` VALUES ('1823', '430400', '430000', '衡阳市', null);
INSERT INTO `regions` VALUES ('1824', '430500', '430000', '邵阳市', null);
INSERT INTO `regions` VALUES ('1825', '430600', '430000', '岳阳市', null);
INSERT INTO `regions` VALUES ('1826', '430700', '430000', '常德市', null);
INSERT INTO `regions` VALUES ('1827', '430800', '430000', '张家界市', null);
INSERT INTO `regions` VALUES ('1828', '430900', '430000', '益阳市', null);
INSERT INTO `regions` VALUES ('1829', '431000', '430000', '郴州市', null);
INSERT INTO `regions` VALUES ('1830', '431100', '430000', '永州市', null);
INSERT INTO `regions` VALUES ('1831', '431200', '430000', '怀化市', null);
INSERT INTO `regions` VALUES ('1832', '431300', '430000', '娄底市', null);
INSERT INTO `regions` VALUES ('1833', '433100', '430000', '湘西土家族苗族自治州', null);
INSERT INTO `regions` VALUES ('1834', '430102', '430100', '芙蓉区', null);
INSERT INTO `regions` VALUES ('1835', '430103', '430100', '天心区', null);
INSERT INTO `regions` VALUES ('1836', '430104', '430100', '岳麓区', null);
INSERT INTO `regions` VALUES ('1837', '430105', '430100', '开福区', null);
INSERT INTO `regions` VALUES ('1838', '430111', '430100', '雨花区', null);
INSERT INTO `regions` VALUES ('1839', '430112', '430100', '望城区', null);
INSERT INTO `regions` VALUES ('1840', '430121', '430100', '长沙县', null);
INSERT INTO `regions` VALUES ('1841', '430181', '430100', '浏阳市', null);
INSERT INTO `regions` VALUES ('1842', '430182', '430100', '宁乡市', null);
INSERT INTO `regions` VALUES ('1843', '430202', '430200', '荷塘区', null);
INSERT INTO `regions` VALUES ('1844', '430203', '430200', '芦淞区', null);
INSERT INTO `regions` VALUES ('1845', '430204', '430200', '石峰区', null);
INSERT INTO `regions` VALUES ('1846', '430211', '430200', '天元区', null);
INSERT INTO `regions` VALUES ('1847', '430221', '430200', '株洲县', null);
INSERT INTO `regions` VALUES ('1848', '430223', '430200', '攸县', null);
INSERT INTO `regions` VALUES ('1849', '430224', '430200', '茶陵县', null);
INSERT INTO `regions` VALUES ('1850', '430225', '430200', '炎陵县', null);
INSERT INTO `regions` VALUES ('1851', '430281', '430200', '醴陵市', null);
INSERT INTO `regions` VALUES ('1852', '430302', '430300', '雨湖区', null);
INSERT INTO `regions` VALUES ('1853', '430304', '430300', '岳塘区', null);
INSERT INTO `regions` VALUES ('1854', '430321', '430300', '湘潭县', null);
INSERT INTO `regions` VALUES ('1855', '430381', '430300', '湘乡市', null);
INSERT INTO `regions` VALUES ('1856', '430382', '430300', '韶山市', null);
INSERT INTO `regions` VALUES ('1857', '430405', '430400', '珠晖区', null);
INSERT INTO `regions` VALUES ('1858', '430406', '430400', '雁峰区', null);
INSERT INTO `regions` VALUES ('1859', '430407', '430400', '石鼓区', null);
INSERT INTO `regions` VALUES ('1860', '430408', '430400', '蒸湘区', null);
INSERT INTO `regions` VALUES ('1861', '430412', '430400', '南岳区', null);
INSERT INTO `regions` VALUES ('1862', '430421', '430400', '衡阳县', null);
INSERT INTO `regions` VALUES ('1863', '430422', '430400', '衡南县', null);
INSERT INTO `regions` VALUES ('1864', '430423', '430400', '衡山县', null);
INSERT INTO `regions` VALUES ('1865', '430424', '430400', '衡东县', null);
INSERT INTO `regions` VALUES ('1866', '430426', '430400', '祁东县', null);
INSERT INTO `regions` VALUES ('1867', '430481', '430400', '耒阳市', null);
INSERT INTO `regions` VALUES ('1868', '430482', '430400', '常宁市', null);
INSERT INTO `regions` VALUES ('1869', '430502', '430500', '双清区', null);
INSERT INTO `regions` VALUES ('1870', '430503', '430500', '大祥区', null);
INSERT INTO `regions` VALUES ('1871', '430511', '430500', '北塔区', null);
INSERT INTO `regions` VALUES ('1872', '430521', '430500', '邵东县', null);
INSERT INTO `regions` VALUES ('1873', '430522', '430500', '新邵县', null);
INSERT INTO `regions` VALUES ('1874', '430523', '430500', '邵阳县', null);
INSERT INTO `regions` VALUES ('1875', '430524', '430500', '隆回县', null);
INSERT INTO `regions` VALUES ('1876', '430525', '430500', '洞口县', null);
INSERT INTO `regions` VALUES ('1877', '430527', '430500', '绥宁县', null);
INSERT INTO `regions` VALUES ('1878', '430528', '430500', '新宁县', null);
INSERT INTO `regions` VALUES ('1879', '430529', '430500', '城步苗族自治县', null);
INSERT INTO `regions` VALUES ('1880', '430581', '430500', '武冈市', null);
INSERT INTO `regions` VALUES ('1881', '430602', '430600', '岳阳楼区', null);
INSERT INTO `regions` VALUES ('1882', '430603', '430600', '云溪区', null);
INSERT INTO `regions` VALUES ('1883', '430611', '430600', '君山区', null);
INSERT INTO `regions` VALUES ('1884', '430621', '430600', '岳阳县', null);
INSERT INTO `regions` VALUES ('1885', '430623', '430600', '华容县', null);
INSERT INTO `regions` VALUES ('1886', '430624', '430600', '湘阴县', null);
INSERT INTO `regions` VALUES ('1887', '430626', '430600', '平江县', null);
INSERT INTO `regions` VALUES ('1888', '430681', '430600', '汨罗市', null);
INSERT INTO `regions` VALUES ('1889', '430682', '430600', '临湘市', null);
INSERT INTO `regions` VALUES ('1890', '430702', '430700', '武陵区', null);
INSERT INTO `regions` VALUES ('1891', '430703', '430700', '鼎城区', null);
INSERT INTO `regions` VALUES ('1892', '430721', '430700', '安乡县', null);
INSERT INTO `regions` VALUES ('1893', '430722', '430700', '汉寿县', null);
INSERT INTO `regions` VALUES ('1894', '430723', '430700', '澧县', null);
INSERT INTO `regions` VALUES ('1895', '430724', '430700', '临澧县', null);
INSERT INTO `regions` VALUES ('1896', '430725', '430700', '桃源县', null);
INSERT INTO `regions` VALUES ('1897', '430726', '430700', '石门县', null);
INSERT INTO `regions` VALUES ('1898', '430781', '430700', '津市市', null);
INSERT INTO `regions` VALUES ('1899', '430802', '430800', '永定区', null);
INSERT INTO `regions` VALUES ('1900', '430811', '430800', '武陵源区', null);
INSERT INTO `regions` VALUES ('1901', '430821', '430800', '慈利县', null);
INSERT INTO `regions` VALUES ('1902', '430822', '430800', '桑植县', null);
INSERT INTO `regions` VALUES ('1903', '430902', '430900', '资阳区', null);
INSERT INTO `regions` VALUES ('1904', '430903', '430900', '赫山区', null);
INSERT INTO `regions` VALUES ('1905', '430921', '430900', '南县', null);
INSERT INTO `regions` VALUES ('1906', '430922', '430900', '桃江县', null);
INSERT INTO `regions` VALUES ('1907', '430923', '430900', '安化县', null);
INSERT INTO `regions` VALUES ('1908', '430981', '430900', '沅江市', null);
INSERT INTO `regions` VALUES ('1909', '431002', '431000', '北湖区', null);
INSERT INTO `regions` VALUES ('1910', '431003', '431000', '苏仙区', null);
INSERT INTO `regions` VALUES ('1911', '431021', '431000', '桂阳县', null);
INSERT INTO `regions` VALUES ('1912', '431022', '431000', '宜章县', null);
INSERT INTO `regions` VALUES ('1913', '431023', '431000', '永兴县', null);
INSERT INTO `regions` VALUES ('1914', '431024', '431000', '嘉禾县', null);
INSERT INTO `regions` VALUES ('1915', '431025', '431000', '临武县', null);
INSERT INTO `regions` VALUES ('1916', '431026', '431000', '汝城县', null);
INSERT INTO `regions` VALUES ('1917', '431027', '431000', '桂东县', null);
INSERT INTO `regions` VALUES ('1918', '431028', '431000', '安仁县', null);
INSERT INTO `regions` VALUES ('1919', '431081', '431000', '资兴市', null);
INSERT INTO `regions` VALUES ('1920', '431102', '431100', '零陵区', null);
INSERT INTO `regions` VALUES ('1921', '431103', '431100', '冷水滩区', null);
INSERT INTO `regions` VALUES ('1922', '431121', '431100', '祁阳县', null);
INSERT INTO `regions` VALUES ('1923', '431122', '431100', '东安县', null);
INSERT INTO `regions` VALUES ('1924', '431123', '431100', '双牌县', null);
INSERT INTO `regions` VALUES ('1925', '431124', '431100', '道县', null);
INSERT INTO `regions` VALUES ('1926', '431125', '431100', '江永县', null);
INSERT INTO `regions` VALUES ('1927', '431126', '431100', '宁远县', null);
INSERT INTO `regions` VALUES ('1928', '431127', '431100', '蓝山县', null);
INSERT INTO `regions` VALUES ('1929', '431128', '431100', '新田县', null);
INSERT INTO `regions` VALUES ('1930', '431129', '431100', '江华瑶族自治县', null);
INSERT INTO `regions` VALUES ('1931', '431202', '431200', '鹤城区', null);
INSERT INTO `regions` VALUES ('1932', '431221', '431200', '中方县', null);
INSERT INTO `regions` VALUES ('1933', '431222', '431200', '沅陵县', null);
INSERT INTO `regions` VALUES ('1934', '431223', '431200', '辰溪县', null);
INSERT INTO `regions` VALUES ('1935', '431224', '431200', '溆浦县', null);
INSERT INTO `regions` VALUES ('1936', '431225', '431200', '会同县', null);
INSERT INTO `regions` VALUES ('1937', '431226', '431200', '麻阳苗族自治县', null);
INSERT INTO `regions` VALUES ('1938', '431227', '431200', '新晃侗族自治县', null);
INSERT INTO `regions` VALUES ('1939', '431228', '431200', '芷江侗族自治县', null);
INSERT INTO `regions` VALUES ('1940', '431229', '431200', '靖州苗族侗族自治县', null);
INSERT INTO `regions` VALUES ('1941', '431230', '431200', '通道侗族自治县', null);
INSERT INTO `regions` VALUES ('1942', '431281', '431200', '洪江市', null);
INSERT INTO `regions` VALUES ('1943', '431302', '431300', '娄星区', null);
INSERT INTO `regions` VALUES ('1944', '431321', '431300', '双峰县', null);
INSERT INTO `regions` VALUES ('1945', '431322', '431300', '新化县', null);
INSERT INTO `regions` VALUES ('1946', '431381', '431300', '冷水江市', null);
INSERT INTO `regions` VALUES ('1947', '431382', '431300', '涟源市', null);
INSERT INTO `regions` VALUES ('1948', '433101', '433100', '吉首市', null);
INSERT INTO `regions` VALUES ('1949', '433122', '433100', '泸溪县', null);
INSERT INTO `regions` VALUES ('1950', '433123', '433100', '凤凰县', null);
INSERT INTO `regions` VALUES ('1951', '433124', '433100', '花垣县', null);
INSERT INTO `regions` VALUES ('1952', '433125', '433100', '保靖县', null);
INSERT INTO `regions` VALUES ('1953', '433126', '433100', '古丈县', null);
INSERT INTO `regions` VALUES ('1954', '433127', '433100', '永顺县', null);
INSERT INTO `regions` VALUES ('1955', '433130', '433100', '龙山县', null);
INSERT INTO `regions` VALUES ('1956', '440100', '440000', '广州市', null);
INSERT INTO `regions` VALUES ('1957', '440200', '440000', '韶关市', null);
INSERT INTO `regions` VALUES ('1958', '440300', '440000', '深圳市', null);
INSERT INTO `regions` VALUES ('1959', '440400', '440000', '珠海市', null);
INSERT INTO `regions` VALUES ('1960', '440500', '440000', '汕头市', null);
INSERT INTO `regions` VALUES ('1961', '440600', '440000', '佛山市', null);
INSERT INTO `regions` VALUES ('1962', '440700', '440000', '江门市', null);
INSERT INTO `regions` VALUES ('1963', '440800', '440000', '湛江市', null);
INSERT INTO `regions` VALUES ('1964', '440900', '440000', '茂名市', null);
INSERT INTO `regions` VALUES ('1965', '441200', '440000', '肇庆市', null);
INSERT INTO `regions` VALUES ('1966', '441300', '440000', '惠州市', null);
INSERT INTO `regions` VALUES ('1967', '441400', '440000', '梅州市', null);
INSERT INTO `regions` VALUES ('1968', '441500', '440000', '汕尾市', null);
INSERT INTO `regions` VALUES ('1969', '441600', '440000', '河源市', null);
INSERT INTO `regions` VALUES ('1970', '441700', '440000', '阳江市', null);
INSERT INTO `regions` VALUES ('1971', '441800', '440000', '清远市', null);
INSERT INTO `regions` VALUES ('1972', '441900', '440000', '东莞市', null);
INSERT INTO `regions` VALUES ('1973', '442000', '440000', '中山市', null);
INSERT INTO `regions` VALUES ('1974', '442100', '440000', '东沙群岛', null);
INSERT INTO `regions` VALUES ('1975', '445100', '440000', '潮州市', null);
INSERT INTO `regions` VALUES ('1976', '445200', '440000', '揭阳市', null);
INSERT INTO `regions` VALUES ('1977', '445300', '440000', '云浮市', null);
INSERT INTO `regions` VALUES ('1978', '440103', '440100', '荔湾区', null);
INSERT INTO `regions` VALUES ('1979', '440104', '440100', '越秀区', null);
INSERT INTO `regions` VALUES ('1980', '440105', '440100', '海珠区', null);
INSERT INTO `regions` VALUES ('1981', '440106', '440100', '天河区', null);
INSERT INTO `regions` VALUES ('1982', '440111', '440100', '白云区', null);
INSERT INTO `regions` VALUES ('1983', '440112', '440100', '黄埔区', null);
INSERT INTO `regions` VALUES ('1984', '440113', '440100', '番禺区', null);
INSERT INTO `regions` VALUES ('1985', '440114', '440100', '花都区', null);
INSERT INTO `regions` VALUES ('1986', '440115', '440100', '南沙区', null);
INSERT INTO `regions` VALUES ('1987', '440117', '440100', '从化区', null);
INSERT INTO `regions` VALUES ('1988', '440118', '440100', '增城区', null);
INSERT INTO `regions` VALUES ('1989', '440203', '440200', '武江区', null);
INSERT INTO `regions` VALUES ('1990', '440204', '440200', '浈江区', null);
INSERT INTO `regions` VALUES ('1991', '440205', '440200', '曲江区', null);
INSERT INTO `regions` VALUES ('1992', '440222', '440200', '始兴县', null);
INSERT INTO `regions` VALUES ('1993', '440224', '440200', '仁化县', null);
INSERT INTO `regions` VALUES ('1994', '440229', '440200', '翁源县', null);
INSERT INTO `regions` VALUES ('1995', '440232', '440200', '乳源瑶族自治县', null);
INSERT INTO `regions` VALUES ('1996', '440233', '440200', '新丰县', null);
INSERT INTO `regions` VALUES ('1997', '440281', '440200', '乐昌市', null);
INSERT INTO `regions` VALUES ('1998', '440282', '440200', '南雄市', null);
INSERT INTO `regions` VALUES ('1999', '440303', '440300', '罗湖区', null);
INSERT INTO `regions` VALUES ('2000', '440304', '440300', '福田区', null);
INSERT INTO `regions` VALUES ('2001', '440305', '440300', '南山区', null);
INSERT INTO `regions` VALUES ('2002', '440306', '440300', '宝安区', null);
INSERT INTO `regions` VALUES ('2003', '440307', '440300', '龙岗区', null);
INSERT INTO `regions` VALUES ('2004', '440308', '440300', '盐田区', null);
INSERT INTO `regions` VALUES ('2005', '440309', '440300', '龙华区', null);
INSERT INTO `regions` VALUES ('2006', '440310', '440300', '坪山区', null);
INSERT INTO `regions` VALUES ('2007', '440402', '440400', '香洲区', null);
INSERT INTO `regions` VALUES ('2008', '440403', '440400', '斗门区', null);
INSERT INTO `regions` VALUES ('2009', '440404', '440400', '金湾区', null);
INSERT INTO `regions` VALUES ('2010', '440499', '440400', '澳门大学横琴校区(由澳门管辖)', null);
INSERT INTO `regions` VALUES ('2011', '440507', '440500', '龙湖区', null);
INSERT INTO `regions` VALUES ('2012', '440511', '440500', '金平区', null);
INSERT INTO `regions` VALUES ('2013', '440512', '440500', '濠江区', null);
INSERT INTO `regions` VALUES ('2014', '440513', '440500', '潮阳区', null);
INSERT INTO `regions` VALUES ('2015', '440514', '440500', '潮南区', null);
INSERT INTO `regions` VALUES ('2016', '440515', '440500', '澄海区', null);
INSERT INTO `regions` VALUES ('2017', '440523', '440500', '南澳县', null);
INSERT INTO `regions` VALUES ('2018', '440604', '440600', '禅城区', null);
INSERT INTO `regions` VALUES ('2019', '440605', '440600', '南海区', null);
INSERT INTO `regions` VALUES ('2020', '440606', '440600', '顺德区', null);
INSERT INTO `regions` VALUES ('2021', '440607', '440600', '三水区', null);
INSERT INTO `regions` VALUES ('2022', '440608', '440600', '高明区', null);
INSERT INTO `regions` VALUES ('2023', '440703', '440700', '蓬江区', null);
INSERT INTO `regions` VALUES ('2024', '440704', '440700', '江海区', null);
INSERT INTO `regions` VALUES ('2025', '440705', '440700', '新会区', null);
INSERT INTO `regions` VALUES ('2026', '440781', '440700', '台山市', null);
INSERT INTO `regions` VALUES ('2027', '440783', '440700', '开平市', null);
INSERT INTO `regions` VALUES ('2028', '440784', '440700', '鹤山市', null);
INSERT INTO `regions` VALUES ('2029', '440785', '440700', '恩平市', null);
INSERT INTO `regions` VALUES ('2030', '440802', '440800', '赤坎区', null);
INSERT INTO `regions` VALUES ('2031', '440803', '440800', '霞山区', null);
INSERT INTO `regions` VALUES ('2032', '440804', '440800', '坡头区', null);
INSERT INTO `regions` VALUES ('2033', '440811', '440800', '麻章区', null);
INSERT INTO `regions` VALUES ('2034', '440823', '440800', '遂溪县', null);
INSERT INTO `regions` VALUES ('2035', '440825', '440800', '徐闻县', null);
INSERT INTO `regions` VALUES ('2036', '440881', '440800', '廉江市', null);
INSERT INTO `regions` VALUES ('2037', '440882', '440800', '雷州市', null);
INSERT INTO `regions` VALUES ('2038', '440883', '440800', '吴川市', null);
INSERT INTO `regions` VALUES ('2039', '440902', '440900', '茂南区', null);
INSERT INTO `regions` VALUES ('2040', '440904', '440900', '电白区', null);
INSERT INTO `regions` VALUES ('2041', '440981', '440900', '高州市', null);
INSERT INTO `regions` VALUES ('2042', '440982', '440900', '化州市', null);
INSERT INTO `regions` VALUES ('2043', '440983', '440900', '信宜市', null);
INSERT INTO `regions` VALUES ('2044', '441202', '441200', '端州区', null);
INSERT INTO `regions` VALUES ('2045', '441203', '441200', '鼎湖区', null);
INSERT INTO `regions` VALUES ('2046', '441204', '441200', '高要区', null);
INSERT INTO `regions` VALUES ('2047', '441223', '441200', '广宁县', null);
INSERT INTO `regions` VALUES ('2048', '441224', '441200', '怀集县', null);
INSERT INTO `regions` VALUES ('2049', '441225', '441200', '封开县', null);
INSERT INTO `regions` VALUES ('2050', '441226', '441200', '德庆县', null);
INSERT INTO `regions` VALUES ('2051', '441284', '441200', '四会市', null);
INSERT INTO `regions` VALUES ('2052', '441302', '441300', '惠城区', null);
INSERT INTO `regions` VALUES ('2053', '441303', '441300', '惠阳区', null);
INSERT INTO `regions` VALUES ('2054', '441322', '441300', '博罗县', null);
INSERT INTO `regions` VALUES ('2055', '441323', '441300', '惠东县', null);
INSERT INTO `regions` VALUES ('2056', '441324', '441300', '龙门县', null);
INSERT INTO `regions` VALUES ('2057', '441402', '441400', '梅江区', null);
INSERT INTO `regions` VALUES ('2058', '441403', '441400', '梅县区', null);
INSERT INTO `regions` VALUES ('2059', '441422', '441400', '大埔县', null);
INSERT INTO `regions` VALUES ('2060', '441423', '441400', '丰顺县', null);
INSERT INTO `regions` VALUES ('2061', '441424', '441400', '五华县', null);
INSERT INTO `regions` VALUES ('2062', '441426', '441400', '平远县', null);
INSERT INTO `regions` VALUES ('2063', '441427', '441400', '蕉岭县', null);
INSERT INTO `regions` VALUES ('2064', '441481', '441400', '兴宁市', null);
INSERT INTO `regions` VALUES ('2065', '441502', '441500', '城区', null);
INSERT INTO `regions` VALUES ('2066', '441521', '441500', '海丰县', null);
INSERT INTO `regions` VALUES ('2067', '441523', '441500', '陆河县', null);
INSERT INTO `regions` VALUES ('2068', '441581', '441500', '陆丰市', null);
INSERT INTO `regions` VALUES ('2069', '441602', '441600', '源城区', null);
INSERT INTO `regions` VALUES ('2070', '441621', '441600', '紫金县', null);
INSERT INTO `regions` VALUES ('2071', '441622', '441600', '龙川县', null);
INSERT INTO `regions` VALUES ('2072', '441623', '441600', '连平县', null);
INSERT INTO `regions` VALUES ('2073', '441624', '441600', '和平县', null);
INSERT INTO `regions` VALUES ('2074', '441625', '441600', '东源县', null);
INSERT INTO `regions` VALUES ('2075', '441702', '441700', '江城区', null);
INSERT INTO `regions` VALUES ('2076', '441704', '441700', '阳东区', null);
INSERT INTO `regions` VALUES ('2077', '441721', '441700', '阳西县', null);
INSERT INTO `regions` VALUES ('2078', '441781', '441700', '阳春市', null);
INSERT INTO `regions` VALUES ('2079', '441802', '441800', '清城区', null);
INSERT INTO `regions` VALUES ('2080', '441803', '441800', '清新区', null);
INSERT INTO `regions` VALUES ('2081', '441821', '441800', '佛冈县', null);
INSERT INTO `regions` VALUES ('2082', '441823', '441800', '阳山县', null);
INSERT INTO `regions` VALUES ('2083', '441825', '441800', '连山壮族瑶族自治县', null);
INSERT INTO `regions` VALUES ('2084', '441826', '441800', '连南瑶族自治县', null);
INSERT INTO `regions` VALUES ('2085', '441881', '441800', '英德市', null);
INSERT INTO `regions` VALUES ('2086', '441882', '441800', '连州市', null);
INSERT INTO `regions` VALUES ('2087', '441900', '441900', '东莞市', null);
INSERT INTO `regions` VALUES ('2088', '442000', '442000', '中山市', null);
INSERT INTO `regions` VALUES ('2089', '442100', '442100', '东沙群岛', null);
INSERT INTO `regions` VALUES ('2090', '445102', '445100', '湘桥区', null);
INSERT INTO `regions` VALUES ('2091', '445103', '445100', '潮安区', null);
INSERT INTO `regions` VALUES ('2092', '445122', '445100', '饶平县', null);
INSERT INTO `regions` VALUES ('2093', '445202', '445200', '榕城区', null);
INSERT INTO `regions` VALUES ('2094', '445203', '445200', '揭东区', null);
INSERT INTO `regions` VALUES ('2095', '445222', '445200', '揭西县', null);
INSERT INTO `regions` VALUES ('2096', '445224', '445200', '惠来县', null);
INSERT INTO `regions` VALUES ('2097', '445281', '445200', '普宁市', null);
INSERT INTO `regions` VALUES ('2098', '445302', '445300', '云城区', null);
INSERT INTO `regions` VALUES ('2099', '445303', '445300', '云安区', null);
INSERT INTO `regions` VALUES ('2100', '445321', '445300', '新兴县', null);
INSERT INTO `regions` VALUES ('2101', '445322', '445300', '郁南县', null);
INSERT INTO `regions` VALUES ('2102', '445381', '445300', '罗定市', null);
INSERT INTO `regions` VALUES ('2103', '450100', '450000', '南宁市', null);
INSERT INTO `regions` VALUES ('2104', '450200', '450000', '柳州市', null);
INSERT INTO `regions` VALUES ('2105', '450300', '450000', '桂林市', null);
INSERT INTO `regions` VALUES ('2106', '450400', '450000', '梧州市', null);
INSERT INTO `regions` VALUES ('2107', '450500', '450000', '北海市', null);
INSERT INTO `regions` VALUES ('2108', '450600', '450000', '防城港市', null);
INSERT INTO `regions` VALUES ('2109', '450700', '450000', '钦州市', null);
INSERT INTO `regions` VALUES ('2110', '450800', '450000', '贵港市', null);
INSERT INTO `regions` VALUES ('2111', '450900', '450000', '玉林市', null);
INSERT INTO `regions` VALUES ('2112', '451000', '450000', '百色市', null);
INSERT INTO `regions` VALUES ('2113', '451100', '450000', '贺州市', null);
INSERT INTO `regions` VALUES ('2114', '451200', '450000', '河池市', null);
INSERT INTO `regions` VALUES ('2115', '451300', '450000', '来宾市', null);
INSERT INTO `regions` VALUES ('2116', '451400', '450000', '崇左市', null);
INSERT INTO `regions` VALUES ('2117', '450102', '450100', '兴宁区', null);
INSERT INTO `regions` VALUES ('2118', '450103', '450100', '青秀区', null);
INSERT INTO `regions` VALUES ('2119', '450105', '450100', '江南区', null);
INSERT INTO `regions` VALUES ('2120', '450107', '450100', '西乡塘区', null);
INSERT INTO `regions` VALUES ('2121', '450108', '450100', '良庆区', null);
INSERT INTO `regions` VALUES ('2122', '450109', '450100', '邕宁区', null);
INSERT INTO `regions` VALUES ('2123', '450110', '450100', '武鸣区', null);
INSERT INTO `regions` VALUES ('2124', '450123', '450100', '隆安县', null);
INSERT INTO `regions` VALUES ('2125', '450124', '450100', '马山县', null);
INSERT INTO `regions` VALUES ('2126', '450125', '450100', '上林县', null);
INSERT INTO `regions` VALUES ('2127', '450126', '450100', '宾阳县', null);
INSERT INTO `regions` VALUES ('2128', '450127', '450100', '横县', null);
INSERT INTO `regions` VALUES ('2129', '450202', '450200', '城中区', null);
INSERT INTO `regions` VALUES ('2130', '450203', '450200', '鱼峰区', null);
INSERT INTO `regions` VALUES ('2131', '450204', '450200', '柳南区', null);
INSERT INTO `regions` VALUES ('2132', '450205', '450200', '柳北区', null);
INSERT INTO `regions` VALUES ('2133', '450206', '450200', '柳江区', null);
INSERT INTO `regions` VALUES ('2134', '450222', '450200', '柳城县', null);
INSERT INTO `regions` VALUES ('2135', '450223', '450200', '鹿寨县', null);
INSERT INTO `regions` VALUES ('2136', '450224', '450200', '融安县', null);
INSERT INTO `regions` VALUES ('2137', '450225', '450200', '融水苗族自治县', null);
INSERT INTO `regions` VALUES ('2138', '450226', '450200', '三江侗族自治县', null);
INSERT INTO `regions` VALUES ('2139', '450302', '450300', '秀峰区', null);
INSERT INTO `regions` VALUES ('2140', '450303', '450300', '叠彩区', null);
INSERT INTO `regions` VALUES ('2141', '450304', '450300', '象山区', null);
INSERT INTO `regions` VALUES ('2142', '450305', '450300', '七星区', null);
INSERT INTO `regions` VALUES ('2143', '450311', '450300', '雁山区', null);
INSERT INTO `regions` VALUES ('2144', '450312', '450300', '临桂区', null);
INSERT INTO `regions` VALUES ('2145', '450321', '450300', '阳朔县', null);
INSERT INTO `regions` VALUES ('2146', '450323', '450300', '灵川县', null);
INSERT INTO `regions` VALUES ('2147', '450324', '450300', '全州县', null);
INSERT INTO `regions` VALUES ('2148', '450325', '450300', '兴安县', null);
INSERT INTO `regions` VALUES ('2149', '450326', '450300', '永福县', null);
INSERT INTO `regions` VALUES ('2150', '450327', '450300', '灌阳县', null);
INSERT INTO `regions` VALUES ('2151', '450328', '450300', '龙胜各族自治县', null);
INSERT INTO `regions` VALUES ('2152', '450329', '450300', '资源县', null);
INSERT INTO `regions` VALUES ('2153', '450330', '450300', '平乐县', null);
INSERT INTO `regions` VALUES ('2154', '450331', '450300', '荔浦县', null);
INSERT INTO `regions` VALUES ('2155', '450332', '450300', '恭城瑶族自治县', null);
INSERT INTO `regions` VALUES ('2156', '450403', '450400', '万秀区', null);
INSERT INTO `regions` VALUES ('2157', '450405', '450400', '长洲区', null);
INSERT INTO `regions` VALUES ('2158', '450406', '450400', '龙圩区', null);
INSERT INTO `regions` VALUES ('2159', '450421', '450400', '苍梧县', null);
INSERT INTO `regions` VALUES ('2160', '450422', '450400', '藤县', null);
INSERT INTO `regions` VALUES ('2161', '450423', '450400', '蒙山县', null);
INSERT INTO `regions` VALUES ('2162', '450481', '450400', '岑溪市', null);
INSERT INTO `regions` VALUES ('2163', '450502', '450500', '海城区', null);
INSERT INTO `regions` VALUES ('2164', '450503', '450500', '银海区', null);
INSERT INTO `regions` VALUES ('2165', '450512', '450500', '铁山港区', null);
INSERT INTO `regions` VALUES ('2166', '450521', '450500', '合浦县', null);
INSERT INTO `regions` VALUES ('2167', '450602', '450600', '港口区', null);
INSERT INTO `regions` VALUES ('2168', '450603', '450600', '防城区', null);
INSERT INTO `regions` VALUES ('2169', '450621', '450600', '上思县', null);
INSERT INTO `regions` VALUES ('2170', '450681', '450600', '东兴市', null);
INSERT INTO `regions` VALUES ('2171', '450702', '450700', '钦南区', null);
INSERT INTO `regions` VALUES ('2172', '450703', '450700', '钦北区', null);
INSERT INTO `regions` VALUES ('2173', '450721', '450700', '灵山县', null);
INSERT INTO `regions` VALUES ('2174', '450722', '450700', '浦北县', null);
INSERT INTO `regions` VALUES ('2175', '450802', '450800', '港北区', null);
INSERT INTO `regions` VALUES ('2176', '450803', '450800', '港南区', null);
INSERT INTO `regions` VALUES ('2177', '450804', '450800', '覃塘区', null);
INSERT INTO `regions` VALUES ('2178', '450821', '450800', '平南县', null);
INSERT INTO `regions` VALUES ('2179', '450881', '450800', '桂平市', null);
INSERT INTO `regions` VALUES ('2180', '450902', '450900', '玉州区', null);
INSERT INTO `regions` VALUES ('2181', '450903', '450900', '福绵区', null);
INSERT INTO `regions` VALUES ('2182', '450921', '450900', '容县', null);
INSERT INTO `regions` VALUES ('2183', '450922', '450900', '陆川县', null);
INSERT INTO `regions` VALUES ('2184', '450923', '450900', '博白县', null);
INSERT INTO `regions` VALUES ('2185', '450924', '450900', '兴业县', null);
INSERT INTO `regions` VALUES ('2186', '450981', '450900', '北流市', null);
INSERT INTO `regions` VALUES ('2187', '451002', '451000', '右江区', null);
INSERT INTO `regions` VALUES ('2188', '451021', '451000', '田阳区', null);
INSERT INTO `regions` VALUES ('2189', '451022', '451000', '田东县', null);
INSERT INTO `regions` VALUES ('2190', '451023', '451000', '平果县', null);
INSERT INTO `regions` VALUES ('2191', '451024', '451000', '德保县', null);
INSERT INTO `regions` VALUES ('2192', '451026', '451000', '那坡县', null);
INSERT INTO `regions` VALUES ('2193', '451027', '451000', '凌云县', null);
INSERT INTO `regions` VALUES ('2194', '451028', '451000', '乐业县', null);
INSERT INTO `regions` VALUES ('2195', '451029', '451000', '田林县', null);
INSERT INTO `regions` VALUES ('2196', '451030', '451000', '西林县', null);
INSERT INTO `regions` VALUES ('2197', '451031', '451000', '隆林各族自治县', null);
INSERT INTO `regions` VALUES ('2198', '451081', '451000', '靖西市', null);
INSERT INTO `regions` VALUES ('2199', '451102', '451100', '八步区', null);
INSERT INTO `regions` VALUES ('2200', '451103', '451100', '平桂区', null);
INSERT INTO `regions` VALUES ('2201', '451121', '451100', '昭平县', null);
INSERT INTO `regions` VALUES ('2202', '451122', '451100', '钟山县', null);
INSERT INTO `regions` VALUES ('2203', '451123', '451100', '富川瑶族自治县', null);
INSERT INTO `regions` VALUES ('2204', '451202', '451200', '金城江区', null);
INSERT INTO `regions` VALUES ('2205', '451203', '451200', '宜州区', null);
INSERT INTO `regions` VALUES ('2206', '451221', '451200', '南丹县', null);
INSERT INTO `regions` VALUES ('2207', '451222', '451200', '天峨县', null);
INSERT INTO `regions` VALUES ('2208', '451223', '451200', '凤山县', null);
INSERT INTO `regions` VALUES ('2209', '451224', '451200', '东兰县', null);
INSERT INTO `regions` VALUES ('2210', '451225', '451200', '罗城仫佬族自治县', null);
INSERT INTO `regions` VALUES ('2211', '451226', '451200', '环江毛南族自治县', null);
INSERT INTO `regions` VALUES ('2212', '451227', '451200', '巴马瑶族自治县', null);
INSERT INTO `regions` VALUES ('2213', '451228', '451200', '都安瑶族自治县', null);
INSERT INTO `regions` VALUES ('2214', '451229', '451200', '大化瑶族自治县', null);
INSERT INTO `regions` VALUES ('2215', '451302', '451300', '兴宾区', null);
INSERT INTO `regions` VALUES ('2216', '451321', '451300', '忻城县', null);
INSERT INTO `regions` VALUES ('2217', '451322', '451300', '象州县', null);
INSERT INTO `regions` VALUES ('2218', '451323', '451300', '武宣县', null);
INSERT INTO `regions` VALUES ('2219', '451324', '451300', '金秀瑶族自治县', null);
INSERT INTO `regions` VALUES ('2220', '451381', '451300', '合山市', null);
INSERT INTO `regions` VALUES ('2221', '451402', '451400', '江州区', null);
INSERT INTO `regions` VALUES ('2222', '451421', '451400', '扶绥县', null);
INSERT INTO `regions` VALUES ('2223', '451422', '451400', '宁明县', null);
INSERT INTO `regions` VALUES ('2224', '451423', '451400', '龙州县', null);
INSERT INTO `regions` VALUES ('2225', '451424', '451400', '大新县', null);
INSERT INTO `regions` VALUES ('2226', '451425', '451400', '天等县', null);
INSERT INTO `regions` VALUES ('2227', '451481', '451400', '凭祥市', null);
INSERT INTO `regions` VALUES ('2228', '460100', '460000', '海口市', null);
INSERT INTO `regions` VALUES ('2229', '460200', '460000', '三亚市', null);
INSERT INTO `regions` VALUES ('2230', '460300', '460000', '三沙市', null);
INSERT INTO `regions` VALUES ('2231', '460400', '460000', '儋州市', null);
INSERT INTO `regions` VALUES ('2232', '469001', '460000', '五指山市', null);
INSERT INTO `regions` VALUES ('2233', '469002', '460000', '琼海市', null);
INSERT INTO `regions` VALUES ('2234', '469005', '460000', '文昌市', null);
INSERT INTO `regions` VALUES ('2235', '469006', '460000', '万宁市', null);
INSERT INTO `regions` VALUES ('2236', '469007', '460000', '东方市', null);
INSERT INTO `regions` VALUES ('2237', '469021', '460000', '定安县', null);
INSERT INTO `regions` VALUES ('2238', '469022', '460000', '屯昌县', null);
INSERT INTO `regions` VALUES ('2239', '469023', '460000', '澄迈县', null);
INSERT INTO `regions` VALUES ('2240', '469024', '460000', '临高县', null);
INSERT INTO `regions` VALUES ('2241', '469025', '460000', '白沙黎族自治县', null);
INSERT INTO `regions` VALUES ('2242', '469026', '460000', '昌江黎族自治县', null);
INSERT INTO `regions` VALUES ('2243', '469027', '460000', '乐东黎族自治县', null);
INSERT INTO `regions` VALUES ('2244', '469028', '460000', '陵水黎族自治县', null);
INSERT INTO `regions` VALUES ('2245', '469029', '460000', '保亭黎族苗族自治县', null);
INSERT INTO `regions` VALUES ('2246', '469030', '460000', '琼中黎族苗族自治县', null);
INSERT INTO `regions` VALUES ('2247', '460105', '460100', '秀英区', null);
INSERT INTO `regions` VALUES ('2248', '460106', '460100', '龙华区', null);
INSERT INTO `regions` VALUES ('2249', '460107', '460100', '琼山区', null);
INSERT INTO `regions` VALUES ('2250', '460108', '460100', '美兰区', null);
INSERT INTO `regions` VALUES ('2251', '460202', '460200', '海棠区', null);
INSERT INTO `regions` VALUES ('2252', '460203', '460200', '吉阳区', null);
INSERT INTO `regions` VALUES ('2253', '460204', '460200', '天涯区', null);
INSERT INTO `regions` VALUES ('2254', '460205', '460200', '崖州区', null);
INSERT INTO `regions` VALUES ('2255', '460321', '460300', '西沙群岛', null);
INSERT INTO `regions` VALUES ('2256', '460322', '460300', '南沙群岛', null);
INSERT INTO `regions` VALUES ('2257', '460323', '460300', '中沙群岛的岛礁及其海域', null);
INSERT INTO `regions` VALUES ('2258', '460400', '460400', '儋州市', null);
INSERT INTO `regions` VALUES ('2259', '469001', '469001', '五指山市', null);
INSERT INTO `regions` VALUES ('2260', '469002', '469002', '琼海市', null);
INSERT INTO `regions` VALUES ('2261', '469005', '469005', '文昌市', null);
INSERT INTO `regions` VALUES ('2262', '469006', '469006', '万宁市', null);
INSERT INTO `regions` VALUES ('2263', '469007', '469007', '东方市', null);
INSERT INTO `regions` VALUES ('2264', '469021', '469021', '定安县', null);
INSERT INTO `regions` VALUES ('2265', '469022', '469022', '屯昌县', null);
INSERT INTO `regions` VALUES ('2266', '469023', '469023', '澄迈县', null);
INSERT INTO `regions` VALUES ('2267', '469024', '469024', '临高县', null);
INSERT INTO `regions` VALUES ('2268', '469025', '469025', '白沙黎族自治县', null);
INSERT INTO `regions` VALUES ('2269', '469026', '469026', '昌江黎族自治县', null);
INSERT INTO `regions` VALUES ('2270', '469027', '469027', '乐东黎族自治县', null);
INSERT INTO `regions` VALUES ('2271', '469028', '469028', '陵水黎族自治县', null);
INSERT INTO `regions` VALUES ('2272', '469029', '469029', '保亭黎族苗族自治县', null);
INSERT INTO `regions` VALUES ('2273', '469030', '469030', '琼中黎族苗族自治县', null);
INSERT INTO `regions` VALUES ('2274', '500100', '500000', '重庆城区', null);
INSERT INTO `regions` VALUES ('2275', '500200', '500000', '重庆郊县', null);
INSERT INTO `regions` VALUES ('2276', '500101', '500100', '万州区', null);
INSERT INTO `regions` VALUES ('2277', '500102', '500100', '涪陵区', null);
INSERT INTO `regions` VALUES ('2278', '500103', '500100', '渝中区', null);
INSERT INTO `regions` VALUES ('2279', '500104', '500100', '大渡口区', null);
INSERT INTO `regions` VALUES ('2280', '500105', '500100', '江北区', null);
INSERT INTO `regions` VALUES ('2281', '500106', '500100', '沙坪坝区', null);
INSERT INTO `regions` VALUES ('2282', '500107', '500100', '九龙坡区', null);
INSERT INTO `regions` VALUES ('2283', '500108', '500100', '南岸区', null);
INSERT INTO `regions` VALUES ('2284', '500109', '500100', '北碚区', null);
INSERT INTO `regions` VALUES ('2285', '500110', '500100', '綦江区', null);
INSERT INTO `regions` VALUES ('2286', '500111', '500100', '大足区', null);
INSERT INTO `regions` VALUES ('2287', '500112', '500100', '渝北区', null);
INSERT INTO `regions` VALUES ('2288', '500113', '500100', '巴南区', null);
INSERT INTO `regions` VALUES ('2289', '500114', '500100', '黔江区', null);
INSERT INTO `regions` VALUES ('2290', '500115', '500100', '长寿区', null);
INSERT INTO `regions` VALUES ('2291', '500116', '500100', '江津区', null);
INSERT INTO `regions` VALUES ('2292', '500117', '500100', '合川区', null);
INSERT INTO `regions` VALUES ('2293', '500118', '500100', '永川区', null);
INSERT INTO `regions` VALUES ('2294', '500119', '500100', '南川区', null);
INSERT INTO `regions` VALUES ('2295', '500120', '500100', '璧山区', null);
INSERT INTO `regions` VALUES ('2296', '500151', '500100', '铜梁区', null);
INSERT INTO `regions` VALUES ('2297', '500152', '500100', '潼南区', null);
INSERT INTO `regions` VALUES ('2298', '500153', '500100', '荣昌区', null);
INSERT INTO `regions` VALUES ('2299', '500154', '500100', '开州区', null);
INSERT INTO `regions` VALUES ('2300', '500155', '500100', '梁平区', null);
INSERT INTO `regions` VALUES ('2301', '500156', '500100', '武隆区', null);
INSERT INTO `regions` VALUES ('2302', '500229', '500200', '城口县', null);
INSERT INTO `regions` VALUES ('2303', '500230', '500200', '丰都县', null);
INSERT INTO `regions` VALUES ('2304', '500231', '500200', '垫江县', null);
INSERT INTO `regions` VALUES ('2305', '500233', '500200', '忠县', null);
INSERT INTO `regions` VALUES ('2306', '500235', '500200', '云阳县', null);
INSERT INTO `regions` VALUES ('2307', '500236', '500200', '奉节县', null);
INSERT INTO `regions` VALUES ('2308', '500237', '500200', '巫山县', null);
INSERT INTO `regions` VALUES ('2309', '500238', '500200', '巫溪县', null);
INSERT INTO `regions` VALUES ('2310', '500240', '500200', '石柱土家族自治县', null);
INSERT INTO `regions` VALUES ('2311', '500241', '500200', '秀山土家族苗族自治县', null);
INSERT INTO `regions` VALUES ('2312', '500242', '500200', '酉阳土家族苗族自治县', null);
INSERT INTO `regions` VALUES ('2313', '500243', '500200', '彭水苗族土家族自治县', null);
INSERT INTO `regions` VALUES ('2314', '510100', '510000', '成都市', null);
INSERT INTO `regions` VALUES ('2315', '510300', '510000', '自贡市', null);
INSERT INTO `regions` VALUES ('2316', '510400', '510000', '攀枝花市', null);
INSERT INTO `regions` VALUES ('2317', '510500', '510000', '泸州市', null);
INSERT INTO `regions` VALUES ('2318', '510600', '510000', '德阳市', null);
INSERT INTO `regions` VALUES ('2319', '510700', '510000', '绵阳市', null);
INSERT INTO `regions` VALUES ('2320', '510800', '510000', '广元市', null);
INSERT INTO `regions` VALUES ('2321', '510900', '510000', '遂宁市', null);
INSERT INTO `regions` VALUES ('2322', '511000', '510000', '内江市', null);
INSERT INTO `regions` VALUES ('2323', '511100', '510000', '乐山市', null);
INSERT INTO `regions` VALUES ('2324', '511300', '510000', '南充市', null);
INSERT INTO `regions` VALUES ('2325', '511400', '510000', '眉山市', null);
INSERT INTO `regions` VALUES ('2326', '511500', '510000', '宜宾市', null);
INSERT INTO `regions` VALUES ('2327', '511600', '510000', '广安市', null);
INSERT INTO `regions` VALUES ('2328', '511700', '510000', '达州市', null);
INSERT INTO `regions` VALUES ('2329', '511800', '510000', '雅安市', null);
INSERT INTO `regions` VALUES ('2330', '511900', '510000', '巴中市', null);
INSERT INTO `regions` VALUES ('2331', '512000', '510000', '资阳市', null);
INSERT INTO `regions` VALUES ('2332', '513200', '510000', '阿坝藏族羌族自治州', null);
INSERT INTO `regions` VALUES ('2333', '513300', '510000', '甘孜藏族自治州', null);
INSERT INTO `regions` VALUES ('2334', '513400', '510000', '凉山彝族自治州', null);
INSERT INTO `regions` VALUES ('2335', '510104', '510100', '锦江区', null);
INSERT INTO `regions` VALUES ('2336', '510105', '510100', '青羊区', null);
INSERT INTO `regions` VALUES ('2337', '510106', '510100', '金牛区', null);
INSERT INTO `regions` VALUES ('2338', '510107', '510100', '武侯区', null);
INSERT INTO `regions` VALUES ('2339', '510108', '510100', '成华区', null);
INSERT INTO `regions` VALUES ('2340', '510112', '510100', '龙泉驿区', null);
INSERT INTO `regions` VALUES ('2341', '510113', '510100', '青白江区', null);
INSERT INTO `regions` VALUES ('2342', '510114', '510100', '新都区', null);
INSERT INTO `regions` VALUES ('2343', '510115', '510100', '温江区', null);
INSERT INTO `regions` VALUES ('2344', '510116', '510100', '双流区', null);
INSERT INTO `regions` VALUES ('2345', '510117', '510100', '郫都区', null);
INSERT INTO `regions` VALUES ('2346', '510121', '510100', '金堂县', null);
INSERT INTO `regions` VALUES ('2347', '510129', '510100', '大邑县', null);
INSERT INTO `regions` VALUES ('2348', '510131', '510100', '蒲江县', null);
INSERT INTO `regions` VALUES ('2349', '510132', '510100', '新津县', null);
INSERT INTO `regions` VALUES ('2350', '510181', '510100', '都江堰市', null);
INSERT INTO `regions` VALUES ('2351', '510182', '510100', '彭州市', null);
INSERT INTO `regions` VALUES ('2352', '510183', '510100', '邛崃市', null);
INSERT INTO `regions` VALUES ('2353', '510184', '510100', '崇州市', null);
INSERT INTO `regions` VALUES ('2354', '510185', '510100', '简阳市', null);
INSERT INTO `regions` VALUES ('2355', '510302', '510300', '自流井区', null);
INSERT INTO `regions` VALUES ('2356', '510303', '510300', '贡井区', null);
INSERT INTO `regions` VALUES ('2357', '510304', '510300', '大安区', null);
INSERT INTO `regions` VALUES ('2358', '510311', '510300', '沿滩区', null);
INSERT INTO `regions` VALUES ('2359', '510321', '510300', '荣县', null);
INSERT INTO `regions` VALUES ('2360', '510322', '510300', '富顺县', null);
INSERT INTO `regions` VALUES ('2361', '510402', '510400', '东区', null);
INSERT INTO `regions` VALUES ('2362', '510403', '510400', '西区', null);
INSERT INTO `regions` VALUES ('2363', '510411', '510400', '仁和区', null);
INSERT INTO `regions` VALUES ('2364', '510421', '510400', '米易县', null);
INSERT INTO `regions` VALUES ('2365', '510422', '510400', '盐边县', null);
INSERT INTO `regions` VALUES ('2366', '510502', '510500', '江阳区', null);
INSERT INTO `regions` VALUES ('2367', '510503', '510500', '纳溪区', null);
INSERT INTO `regions` VALUES ('2368', '510504', '510500', '龙马潭区', null);
INSERT INTO `regions` VALUES ('2369', '510521', '510500', '泸县', null);
INSERT INTO `regions` VALUES ('2370', '510522', '510500', '合江县', null);
INSERT INTO `regions` VALUES ('2371', '510524', '510500', '叙永县', null);
INSERT INTO `regions` VALUES ('2372', '510525', '510500', '古蔺县', null);
INSERT INTO `regions` VALUES ('2373', '510603', '510600', '旌阳区', null);
INSERT INTO `regions` VALUES ('2374', '510623', '510600', '中江县', null);
INSERT INTO `regions` VALUES ('2375', '510626', '510600', '罗江区', null);
INSERT INTO `regions` VALUES ('2376', '510681', '510600', '广汉市', null);
INSERT INTO `regions` VALUES ('2377', '510682', '510600', '什邡市', null);
INSERT INTO `regions` VALUES ('2378', '510683', '510600', '绵竹市', null);
INSERT INTO `regions` VALUES ('2379', '510703', '510700', '涪城区', null);
INSERT INTO `regions` VALUES ('2380', '510704', '510700', '游仙区', null);
INSERT INTO `regions` VALUES ('2381', '510705', '510700', '安州区', null);
INSERT INTO `regions` VALUES ('2382', '510722', '510700', '三台县', null);
INSERT INTO `regions` VALUES ('2383', '510723', '510700', '盐亭县', null);
INSERT INTO `regions` VALUES ('2384', '510725', '510700', '梓潼县', null);
INSERT INTO `regions` VALUES ('2385', '510726', '510700', '北川羌族自治县', null);
INSERT INTO `regions` VALUES ('2386', '510727', '510700', '平武县', null);
INSERT INTO `regions` VALUES ('2387', '510781', '510700', '江油市', null);
INSERT INTO `regions` VALUES ('2388', '510802', '510800', '利州区', null);
INSERT INTO `regions` VALUES ('2389', '510811', '510800', '昭化区', null);
INSERT INTO `regions` VALUES ('2390', '510812', '510800', '朝天区', null);
INSERT INTO `regions` VALUES ('2391', '510821', '510800', '旺苍县', null);
INSERT INTO `regions` VALUES ('2392', '510822', '510800', '青川县', null);
INSERT INTO `regions` VALUES ('2393', '510823', '510800', '剑阁县', null);
INSERT INTO `regions` VALUES ('2394', '510824', '510800', '苍溪县', null);
INSERT INTO `regions` VALUES ('2395', '510903', '510900', '船山区', null);
INSERT INTO `regions` VALUES ('2396', '510904', '510900', '安居区', null);
INSERT INTO `regions` VALUES ('2397', '510921', '510900', '蓬溪县', null);
INSERT INTO `regions` VALUES ('2398', '510922', '510900', '射洪县', null);
INSERT INTO `regions` VALUES ('2399', '510923', '510900', '大英县', null);
INSERT INTO `regions` VALUES ('2400', '511002', '511000', '市中区', null);
INSERT INTO `regions` VALUES ('2401', '511011', '511000', '东兴区', null);
INSERT INTO `regions` VALUES ('2402', '511024', '511000', '威远县', null);
INSERT INTO `regions` VALUES ('2403', '511025', '511000', '资中县', null);
INSERT INTO `regions` VALUES ('2404', '511083', '511000', '隆昌市', null);
INSERT INTO `regions` VALUES ('2405', '511102', '511100', '市中区', null);
INSERT INTO `regions` VALUES ('2406', '511111', '511100', '沙湾区', null);
INSERT INTO `regions` VALUES ('2407', '511112', '511100', '五通桥区', null);
INSERT INTO `regions` VALUES ('2408', '511113', '511100', '金口河区', null);
INSERT INTO `regions` VALUES ('2409', '511123', '511100', '犍为县', null);
INSERT INTO `regions` VALUES ('2410', '511124', '511100', '井研县', null);
INSERT INTO `regions` VALUES ('2411', '511126', '511100', '夹江县', null);
INSERT INTO `regions` VALUES ('2412', '511129', '511100', '沐川县', null);
INSERT INTO `regions` VALUES ('2413', '511132', '511100', '峨边彝族自治县', null);
INSERT INTO `regions` VALUES ('2414', '511133', '511100', '马边彝族自治县', null);
INSERT INTO `regions` VALUES ('2415', '511181', '511100', '峨眉山市', null);
INSERT INTO `regions` VALUES ('2416', '511302', '511300', '顺庆区', null);
INSERT INTO `regions` VALUES ('2417', '511303', '511300', '高坪区', null);
INSERT INTO `regions` VALUES ('2418', '511304', '511300', '嘉陵区', null);
INSERT INTO `regions` VALUES ('2419', '511321', '511300', '南部县', null);
INSERT INTO `regions` VALUES ('2420', '511322', '511300', '营山县', null);
INSERT INTO `regions` VALUES ('2421', '511323', '511300', '蓬安县', null);
INSERT INTO `regions` VALUES ('2422', '511324', '511300', '仪陇县', null);
INSERT INTO `regions` VALUES ('2423', '511325', '511300', '西充县', null);
INSERT INTO `regions` VALUES ('2424', '511381', '511300', '阆中市', null);
INSERT INTO `regions` VALUES ('2425', '511402', '511400', '东坡区', null);
INSERT INTO `regions` VALUES ('2426', '511403', '511400', '彭山区', null);
INSERT INTO `regions` VALUES ('2427', '511421', '511400', '仁寿县', null);
INSERT INTO `regions` VALUES ('2428', '511423', '511400', '洪雅县', null);
INSERT INTO `regions` VALUES ('2429', '511424', '511400', '丹棱县', null);
INSERT INTO `regions` VALUES ('2430', '511425', '511400', '青神县', null);
INSERT INTO `regions` VALUES ('2431', '511502', '511500', '翠屏区', null);
INSERT INTO `regions` VALUES ('2432', '511503', '511500', '南溪区', null);
INSERT INTO `regions` VALUES ('2433', '511521', '511500', '宜宾县', null);
INSERT INTO `regions` VALUES ('2434', '511523', '511500', '江安县', null);
INSERT INTO `regions` VALUES ('2435', '511524', '511500', '长宁县', null);
INSERT INTO `regions` VALUES ('2436', '511525', '511500', '高县', null);
INSERT INTO `regions` VALUES ('2437', '511526', '511500', '珙县', null);
INSERT INTO `regions` VALUES ('2438', '511527', '511500', '筠连县', null);
INSERT INTO `regions` VALUES ('2439', '511528', '511500', '兴文县', null);
INSERT INTO `regions` VALUES ('2440', '511529', '511500', '屏山县', null);
INSERT INTO `regions` VALUES ('2441', '511602', '511600', '广安区', null);
INSERT INTO `regions` VALUES ('2442', '511603', '511600', '前锋区', null);
INSERT INTO `regions` VALUES ('2443', '511621', '511600', '岳池县', null);
INSERT INTO `regions` VALUES ('2444', '511622', '511600', '武胜县', null);
INSERT INTO `regions` VALUES ('2445', '511623', '511600', '邻水县', null);
INSERT INTO `regions` VALUES ('2446', '511681', '511600', '华蓥市', null);
INSERT INTO `regions` VALUES ('2447', '511702', '511700', '通川区', null);
INSERT INTO `regions` VALUES ('2448', '511703', '511700', '达川区', null);
INSERT INTO `regions` VALUES ('2449', '511722', '511700', '宣汉县', null);
INSERT INTO `regions` VALUES ('2450', '511723', '511700', '开江县', null);
INSERT INTO `regions` VALUES ('2451', '511724', '511700', '大竹县', null);
INSERT INTO `regions` VALUES ('2452', '511725', '511700', '渠县', null);
INSERT INTO `regions` VALUES ('2453', '511781', '511700', '万源市', null);
INSERT INTO `regions` VALUES ('2454', '511802', '511800', '雨城区', null);
INSERT INTO `regions` VALUES ('2455', '511803', '511800', '名山区', null);
INSERT INTO `regions` VALUES ('2456', '511822', '511800', '荥经县', null);
INSERT INTO `regions` VALUES ('2457', '511823', '511800', '汉源县', null);
INSERT INTO `regions` VALUES ('2458', '511824', '511800', '石棉县', null);
INSERT INTO `regions` VALUES ('2459', '511825', '511800', '天全县', null);
INSERT INTO `regions` VALUES ('2460', '511826', '511800', '芦山县', null);
INSERT INTO `regions` VALUES ('2461', '511827', '511800', '宝兴县', null);
INSERT INTO `regions` VALUES ('2462', '511902', '511900', '巴州区', null);
INSERT INTO `regions` VALUES ('2463', '511903', '511900', '恩阳区', null);
INSERT INTO `regions` VALUES ('2464', '511921', '511900', '通江县', null);
INSERT INTO `regions` VALUES ('2465', '511922', '511900', '南江县', null);
INSERT INTO `regions` VALUES ('2466', '511923', '511900', '平昌县', null);
INSERT INTO `regions` VALUES ('2467', '512002', '512000', '雁江区', null);
INSERT INTO `regions` VALUES ('2468', '512021', '512000', '安岳县', null);
INSERT INTO `regions` VALUES ('2469', '512022', '512000', '乐至县', null);
INSERT INTO `regions` VALUES ('2470', '513201', '513200', '马尔康市', null);
INSERT INTO `regions` VALUES ('2471', '513221', '513200', '汶川县', null);
INSERT INTO `regions` VALUES ('2472', '513222', '513200', '理县', null);
INSERT INTO `regions` VALUES ('2473', '513223', '513200', '茂县', null);
INSERT INTO `regions` VALUES ('2474', '513224', '513200', '松潘县', null);
INSERT INTO `regions` VALUES ('2475', '513225', '513200', '九寨沟市', null);
INSERT INTO `regions` VALUES ('2476', '513226', '513200', '金川县', null);
INSERT INTO `regions` VALUES ('2477', '513227', '513200', '小金县', null);
INSERT INTO `regions` VALUES ('2478', '513228', '513200', '黑水县', null);
INSERT INTO `regions` VALUES ('2479', '513230', '513200', '壤塘县', null);
INSERT INTO `regions` VALUES ('2480', '513231', '513200', '阿坝县', null);
INSERT INTO `regions` VALUES ('2481', '513232', '513200', '若尔盖县', null);
INSERT INTO `regions` VALUES ('2482', '513233', '513200', '红原县', null);
INSERT INTO `regions` VALUES ('2483', '513301', '513300', '康定市', null);
INSERT INTO `regions` VALUES ('2484', '513322', '513300', '泸定县', null);
INSERT INTO `regions` VALUES ('2485', '513323', '513300', '丹巴县', null);
INSERT INTO `regions` VALUES ('2486', '513324', '513300', '九龙县', null);
INSERT INTO `regions` VALUES ('2487', '513325', '513300', '雅江县', null);
INSERT INTO `regions` VALUES ('2488', '513326', '513300', '道孚县', null);
INSERT INTO `regions` VALUES ('2489', '513327', '513300', '炉霍县', null);
INSERT INTO `regions` VALUES ('2490', '513328', '513300', '甘孜县', null);
INSERT INTO `regions` VALUES ('2491', '513329', '513300', '新龙县', null);
INSERT INTO `regions` VALUES ('2492', '513330', '513300', '德格县', null);
INSERT INTO `regions` VALUES ('2493', '513331', '513300', '白玉县', null);
INSERT INTO `regions` VALUES ('2494', '513332', '513300', '石渠县', null);
INSERT INTO `regions` VALUES ('2495', '513333', '513300', '色达县', null);
INSERT INTO `regions` VALUES ('2496', '513334', '513300', '理塘县', null);
INSERT INTO `regions` VALUES ('2497', '513335', '513300', '巴塘县', null);
INSERT INTO `regions` VALUES ('2498', '513336', '513300', '乡城县', null);
INSERT INTO `regions` VALUES ('2499', '513337', '513300', '稻城县', null);
INSERT INTO `regions` VALUES ('2500', '513338', '513300', '得荣县', null);
INSERT INTO `regions` VALUES ('2501', '513401', '513400', '西昌市', null);
INSERT INTO `regions` VALUES ('2502', '513422', '513400', '木里藏族自治县', null);
INSERT INTO `regions` VALUES ('2503', '513423', '513400', '盐源县', null);
INSERT INTO `regions` VALUES ('2504', '513424', '513400', '德昌县', null);
INSERT INTO `regions` VALUES ('2505', '513425', '513400', '会理县', null);
INSERT INTO `regions` VALUES ('2506', '513426', '513400', '会东县', null);
INSERT INTO `regions` VALUES ('2507', '513427', '513400', '宁南县', null);
INSERT INTO `regions` VALUES ('2508', '513428', '513400', '普格县', null);
INSERT INTO `regions` VALUES ('2509', '513429', '513400', '布拖县', null);
INSERT INTO `regions` VALUES ('2510', '513430', '513400', '金阳县', null);
INSERT INTO `regions` VALUES ('2511', '513431', '513400', '昭觉县', null);
INSERT INTO `regions` VALUES ('2512', '513432', '513400', '喜德县', null);
INSERT INTO `regions` VALUES ('2513', '513433', '513400', '冕宁县', null);
INSERT INTO `regions` VALUES ('2514', '513434', '513400', '越西县', null);
INSERT INTO `regions` VALUES ('2515', '513435', '513400', '甘洛县', null);
INSERT INTO `regions` VALUES ('2516', '513436', '513400', '美姑县', null);
INSERT INTO `regions` VALUES ('2517', '513437', '513400', '雷波县', null);
INSERT INTO `regions` VALUES ('2518', '520100', '520000', '贵阳市', null);
INSERT INTO `regions` VALUES ('2519', '520200', '520000', '六盘水市', null);
INSERT INTO `regions` VALUES ('2520', '520300', '520000', '遵义市', null);
INSERT INTO `regions` VALUES ('2521', '520400', '520000', '安顺市', null);
INSERT INTO `regions` VALUES ('2522', '520500', '520000', '毕节市', null);
INSERT INTO `regions` VALUES ('2523', '520600', '520000', '铜仁市', null);
INSERT INTO `regions` VALUES ('2524', '522300', '520000', '黔西南布依族苗族自治州', null);
INSERT INTO `regions` VALUES ('2525', '522600', '520000', '黔东南苗族侗族自治州', null);
INSERT INTO `regions` VALUES ('2526', '522700', '520000', '黔南布依族苗族自治州', null);
INSERT INTO `regions` VALUES ('2527', '520102', '520100', '南明区', null);
INSERT INTO `regions` VALUES ('2528', '520103', '520100', '云岩区', null);
INSERT INTO `regions` VALUES ('2529', '520111', '520100', '花溪区', null);
INSERT INTO `regions` VALUES ('2530', '520112', '520100', '乌当区', null);
INSERT INTO `regions` VALUES ('2531', '520113', '520100', '白云区', null);
INSERT INTO `regions` VALUES ('2532', '520115', '520100', '观山湖区', null);
INSERT INTO `regions` VALUES ('2533', '520121', '520100', '开阳县', null);
INSERT INTO `regions` VALUES ('2534', '520122', '520100', '息烽县', null);
INSERT INTO `regions` VALUES ('2535', '520123', '520100', '修文县', null);
INSERT INTO `regions` VALUES ('2536', '520181', '520100', '清镇市', null);
INSERT INTO `regions` VALUES ('2537', '520201', '520200', '钟山区', null);
INSERT INTO `regions` VALUES ('2538', '520203', '520200', '六枝特区', null);
INSERT INTO `regions` VALUES ('2539', '520221', '520200', '水城县', null);
INSERT INTO `regions` VALUES ('2540', '520281', '520200', '盘州市', null);
INSERT INTO `regions` VALUES ('2541', '520302', '520300', '红花岗区', null);
INSERT INTO `regions` VALUES ('2542', '520303', '520300', '汇川区', null);
INSERT INTO `regions` VALUES ('2543', '520304', '520300', '播州区', null);
INSERT INTO `regions` VALUES ('2544', '520322', '520300', '桐梓县', null);
INSERT INTO `regions` VALUES ('2545', '520323', '520300', '绥阳县', null);
INSERT INTO `regions` VALUES ('2546', '520324', '520300', '正安县', null);
INSERT INTO `regions` VALUES ('2547', '520325', '520300', '道真仡佬族苗族自治县', null);
INSERT INTO `regions` VALUES ('2548', '520326', '520300', '务川仡佬族苗族自治县', null);
INSERT INTO `regions` VALUES ('2549', '520327', '520300', '凤冈县', null);
INSERT INTO `regions` VALUES ('2550', '520328', '520300', '湄潭县', null);
INSERT INTO `regions` VALUES ('2551', '520329', '520300', '余庆县', null);
INSERT INTO `regions` VALUES ('2552', '520330', '520300', '习水县', null);
INSERT INTO `regions` VALUES ('2553', '520381', '520300', '赤水市', null);
INSERT INTO `regions` VALUES ('2554', '520382', '520300', '仁怀市', null);
INSERT INTO `regions` VALUES ('2555', '520402', '520400', '西秀区', null);
INSERT INTO `regions` VALUES ('2556', '520403', '520400', '平坝区', null);
INSERT INTO `regions` VALUES ('2557', '520422', '520400', '普定县', null);
INSERT INTO `regions` VALUES ('2558', '520423', '520400', '镇宁布依族苗族自治县', null);
INSERT INTO `regions` VALUES ('2559', '520424', '520400', '关岭布依族苗族自治县', null);
INSERT INTO `regions` VALUES ('2560', '520425', '520400', '紫云苗族布依族自治县', null);
INSERT INTO `regions` VALUES ('2561', '520502', '520500', '七星关区', null);
INSERT INTO `regions` VALUES ('2562', '520521', '520500', '大方县', null);
INSERT INTO `regions` VALUES ('2563', '520522', '520500', '黔西县', null);
INSERT INTO `regions` VALUES ('2564', '520523', '520500', '金沙县', null);
INSERT INTO `regions` VALUES ('2565', '520524', '520500', '织金县', null);
INSERT INTO `regions` VALUES ('2566', '520525', '520500', '纳雍县', null);
INSERT INTO `regions` VALUES ('2567', '520526', '520500', '威宁彝族回族苗族自治县', null);
INSERT INTO `regions` VALUES ('2568', '520527', '520500', '赫章县', null);
INSERT INTO `regions` VALUES ('2569', '520602', '520600', '碧江区', null);
INSERT INTO `regions` VALUES ('2570', '520603', '520600', '万山区', null);
INSERT INTO `regions` VALUES ('2571', '520621', '520600', '江口县', null);
INSERT INTO `regions` VALUES ('2572', '520622', '520600', '玉屏侗族自治县', null);
INSERT INTO `regions` VALUES ('2573', '520623', '520600', '石阡县', null);
INSERT INTO `regions` VALUES ('2574', '520624', '520600', '思南县', null);
INSERT INTO `regions` VALUES ('2575', '520625', '520600', '印江土家族苗族自治县', null);
INSERT INTO `regions` VALUES ('2576', '520626', '520600', '德江县', null);
INSERT INTO `regions` VALUES ('2577', '520627', '520600', '沿河土家族自治县', null);
INSERT INTO `regions` VALUES ('2578', '520628', '520600', '松桃苗族自治县', null);
INSERT INTO `regions` VALUES ('2579', '522301', '522300', '兴义市', null);
INSERT INTO `regions` VALUES ('2580', '522322', '522300', '兴仁县', null);
INSERT INTO `regions` VALUES ('2581', '522323', '522300', '普安县', null);
INSERT INTO `regions` VALUES ('2582', '522324', '522300', '晴隆县', null);
INSERT INTO `regions` VALUES ('2583', '522325', '522300', '贞丰县', null);
INSERT INTO `regions` VALUES ('2584', '522326', '522300', '望谟县', null);
INSERT INTO `regions` VALUES ('2585', '522327', '522300', '册亨县', null);
INSERT INTO `regions` VALUES ('2586', '522328', '522300', '安龙县', null);
INSERT INTO `regions` VALUES ('2587', '522601', '522600', '凯里市', null);
INSERT INTO `regions` VALUES ('2588', '522622', '522600', '黄平县', null);
INSERT INTO `regions` VALUES ('2589', '522623', '522600', '施秉县', null);
INSERT INTO `regions` VALUES ('2590', '522624', '522600', '三穗县', null);
INSERT INTO `regions` VALUES ('2591', '522625', '522600', '镇远县', null);
INSERT INTO `regions` VALUES ('2592', '522626', '522600', '岑巩县', null);
INSERT INTO `regions` VALUES ('2593', '522627', '522600', '天柱县', null);
INSERT INTO `regions` VALUES ('2594', '522628', '522600', '锦屏县', null);
INSERT INTO `regions` VALUES ('2595', '522629', '522600', '剑河县', null);
INSERT INTO `regions` VALUES ('2596', '522630', '522600', '台江县', null);
INSERT INTO `regions` VALUES ('2597', '522631', '522600', '黎平县', null);
INSERT INTO `regions` VALUES ('2598', '522632', '522600', '榕江县', null);
INSERT INTO `regions` VALUES ('2599', '522633', '522600', '从江县', null);
INSERT INTO `regions` VALUES ('2600', '522634', '522600', '雷山县', null);
INSERT INTO `regions` VALUES ('2601', '522635', '522600', '麻江县', null);
INSERT INTO `regions` VALUES ('2602', '522636', '522600', '丹寨县', null);
INSERT INTO `regions` VALUES ('2603', '522701', '522700', '都匀市', null);
INSERT INTO `regions` VALUES ('2604', '522702', '522700', '福泉市', null);
INSERT INTO `regions` VALUES ('2605', '522722', '522700', '荔波县', null);
INSERT INTO `regions` VALUES ('2606', '522723', '522700', '贵定县', null);
INSERT INTO `regions` VALUES ('2607', '522725', '522700', '瓮安县', null);
INSERT INTO `regions` VALUES ('2608', '522726', '522700', '独山县', null);
INSERT INTO `regions` VALUES ('2609', '522727', '522700', '平塘县', null);
INSERT INTO `regions` VALUES ('2610', '522728', '522700', '罗甸县', null);
INSERT INTO `regions` VALUES ('2611', '522729', '522700', '长顺县', null);
INSERT INTO `regions` VALUES ('2612', '522730', '522700', '龙里县', null);
INSERT INTO `regions` VALUES ('2613', '522731', '522700', '惠水县', null);
INSERT INTO `regions` VALUES ('2614', '522732', '522700', '三都水族自治县', null);
INSERT INTO `regions` VALUES ('2615', '530100', '530000', '昆明市', null);
INSERT INTO `regions` VALUES ('2616', '530300', '530000', '曲靖市', null);
INSERT INTO `regions` VALUES ('2617', '530400', '530000', '玉溪市', null);
INSERT INTO `regions` VALUES ('2618', '530500', '530000', '保山市', null);
INSERT INTO `regions` VALUES ('2619', '530600', '530000', '昭通市', null);
INSERT INTO `regions` VALUES ('2620', '530700', '530000', '丽江市', null);
INSERT INTO `regions` VALUES ('2621', '530800', '530000', '普洱市', null);
INSERT INTO `regions` VALUES ('2622', '530900', '530000', '临沧市', null);
INSERT INTO `regions` VALUES ('2623', '532300', '530000', '楚雄彝族自治州', null);
INSERT INTO `regions` VALUES ('2624', '532500', '530000', '红河哈尼族彝族自治州', null);
INSERT INTO `regions` VALUES ('2625', '532600', '530000', '文山壮族苗族自治州', null);
INSERT INTO `regions` VALUES ('2626', '532800', '530000', '西双版纳傣族自治州', null);
INSERT INTO `regions` VALUES ('2627', '532900', '530000', '大理白族自治州', null);
INSERT INTO `regions` VALUES ('2628', '533100', '530000', '德宏傣族景颇族自治州', null);
INSERT INTO `regions` VALUES ('2629', '533300', '530000', '怒江傈僳族自治州', null);
INSERT INTO `regions` VALUES ('2630', '533400', '530000', '迪庆藏族自治州', null);
INSERT INTO `regions` VALUES ('2631', '530102', '530100', '五华区', null);
INSERT INTO `regions` VALUES ('2632', '530103', '530100', '盘龙区', null);
INSERT INTO `regions` VALUES ('2633', '530111', '530100', '官渡区', null);
INSERT INTO `regions` VALUES ('2634', '530112', '530100', '西山区', null);
INSERT INTO `regions` VALUES ('2635', '530113', '530100', '东川区', null);
INSERT INTO `regions` VALUES ('2636', '530114', '530100', '呈贡区', null);
INSERT INTO `regions` VALUES ('2637', '530115', '530100', '晋宁区', null);
INSERT INTO `regions` VALUES ('2638', '530124', '530100', '富民县', null);
INSERT INTO `regions` VALUES ('2639', '530125', '530100', '宜良县', null);
INSERT INTO `regions` VALUES ('2640', '530126', '530100', '石林彝族自治县', null);
INSERT INTO `regions` VALUES ('2641', '530127', '530100', '嵩明县', null);
INSERT INTO `regions` VALUES ('2642', '530128', '530100', '禄劝彝族苗族自治县', null);
INSERT INTO `regions` VALUES ('2643', '530129', '530100', '寻甸回族彝族自治县', null);
INSERT INTO `regions` VALUES ('2644', '530181', '530100', '安宁市', null);
INSERT INTO `regions` VALUES ('2645', '530302', '530300', '麒麟区', null);
INSERT INTO `regions` VALUES ('2646', '530303', '530300', '沾益区', null);
INSERT INTO `regions` VALUES ('2647', '530321', '530300', '马龙县', null);
INSERT INTO `regions` VALUES ('2648', '530322', '530300', '陆良县', null);
INSERT INTO `regions` VALUES ('2649', '530323', '530300', '师宗县', null);
INSERT INTO `regions` VALUES ('2650', '530324', '530300', '罗平县', null);
INSERT INTO `regions` VALUES ('2651', '530325', '530300', '富源县', null);
INSERT INTO `regions` VALUES ('2652', '530326', '530300', '会泽县', null);
INSERT INTO `regions` VALUES ('2653', '530381', '530300', '宣威市', null);
INSERT INTO `regions` VALUES ('2654', '530402', '530400', '红塔区', null);
INSERT INTO `regions` VALUES ('2655', '530403', '530400', '江川区', null);
INSERT INTO `regions` VALUES ('2656', '530422', '530400', '澄江县', null);
INSERT INTO `regions` VALUES ('2657', '530423', '530400', '通海县', null);
INSERT INTO `regions` VALUES ('2658', '530424', '530400', '华宁县', null);
INSERT INTO `regions` VALUES ('2659', '530425', '530400', '易门县', null);
INSERT INTO `regions` VALUES ('2660', '530426', '530400', '峨山彝族自治县', null);
INSERT INTO `regions` VALUES ('2661', '530427', '530400', '新平彝族傣族自治县', null);
INSERT INTO `regions` VALUES ('2662', '530428', '530400', '元江哈尼族彝族傣族自治县', null);
INSERT INTO `regions` VALUES ('2663', '530502', '530500', '隆阳区', null);
INSERT INTO `regions` VALUES ('2664', '530521', '530500', '施甸县', null);
INSERT INTO `regions` VALUES ('2665', '530523', '530500', '龙陵县', null);
INSERT INTO `regions` VALUES ('2666', '530524', '530500', '昌宁县', null);
INSERT INTO `regions` VALUES ('2667', '530581', '530500', '腾冲市', null);
INSERT INTO `regions` VALUES ('2668', '530602', '530600', '昭阳区', null);
INSERT INTO `regions` VALUES ('2669', '530621', '530600', '鲁甸县', null);
INSERT INTO `regions` VALUES ('2670', '530622', '530600', '巧家县', null);
INSERT INTO `regions` VALUES ('2671', '530623', '530600', '盐津县', null);
INSERT INTO `regions` VALUES ('2672', '530624', '530600', '大关县', null);
INSERT INTO `regions` VALUES ('2673', '530625', '530600', '永善县', null);
INSERT INTO `regions` VALUES ('2674', '530626', '530600', '绥江县', null);
INSERT INTO `regions` VALUES ('2675', '530627', '530600', '镇雄县', null);
INSERT INTO `regions` VALUES ('2676', '530628', '530600', '彝良县', null);
INSERT INTO `regions` VALUES ('2677', '530629', '530600', '威信县', null);
INSERT INTO `regions` VALUES ('2678', '530630', '530600', '水富县', null);
INSERT INTO `regions` VALUES ('2679', '530702', '530700', '古城区', null);
INSERT INTO `regions` VALUES ('2680', '530721', '530700', '玉龙纳西族自治县', null);
INSERT INTO `regions` VALUES ('2681', '530722', '530700', '永胜县', null);
INSERT INTO `regions` VALUES ('2682', '530723', '530700', '华坪县', null);
INSERT INTO `regions` VALUES ('2683', '530724', '530700', '宁蒗彝族自治县', null);
INSERT INTO `regions` VALUES ('2684', '530802', '530800', '思茅区', null);
INSERT INTO `regions` VALUES ('2685', '530821', '530800', '宁洱哈尼族彝族自治县', null);
INSERT INTO `regions` VALUES ('2686', '530822', '530800', '墨江哈尼族自治县', null);
INSERT INTO `regions` VALUES ('2687', '530823', '530800', '景东彝族自治县', null);
INSERT INTO `regions` VALUES ('2688', '530824', '530800', '景谷傣族彝族自治县', null);
INSERT INTO `regions` VALUES ('2689', '530825', '530800', '镇沅彝族哈尼族拉祜族自治县', null);
INSERT INTO `regions` VALUES ('2690', '530826', '530800', '江城哈尼族彝族自治县', null);
INSERT INTO `regions` VALUES ('2691', '530827', '530800', '孟连傣族拉祜族佤族自治县', null);
INSERT INTO `regions` VALUES ('2692', '530828', '530800', '澜沧拉祜族自治县', null);
INSERT INTO `regions` VALUES ('2693', '530829', '530800', '西盟佤族自治县', null);
INSERT INTO `regions` VALUES ('2694', '530902', '530900', '临翔区', null);
INSERT INTO `regions` VALUES ('2695', '530921', '530900', '凤庆县', null);
INSERT INTO `regions` VALUES ('2696', '530922', '530900', '云县', null);
INSERT INTO `regions` VALUES ('2697', '530923', '530900', '永德县', null);
INSERT INTO `regions` VALUES ('2698', '530924', '530900', '镇康县', null);
INSERT INTO `regions` VALUES ('2699', '530925', '530900', '双江拉祜族佤族布朗族傣族自治县', null);
INSERT INTO `regions` VALUES ('2700', '530926', '530900', '耿马傣族佤族自治县', null);
INSERT INTO `regions` VALUES ('2701', '530927', '530900', '沧源佤族自治县', null);
INSERT INTO `regions` VALUES ('2702', '532301', '532300', '楚雄市', null);
INSERT INTO `regions` VALUES ('2703', '532322', '532300', '双柏县', null);
INSERT INTO `regions` VALUES ('2704', '532323', '532300', '牟定县', null);
INSERT INTO `regions` VALUES ('2705', '532324', '532300', '南华县', null);
INSERT INTO `regions` VALUES ('2706', '532325', '532300', '姚安县', null);
INSERT INTO `regions` VALUES ('2707', '532326', '532300', '大姚县', null);
INSERT INTO `regions` VALUES ('2708', '532327', '532300', '永仁县', null);
INSERT INTO `regions` VALUES ('2709', '532328', '532300', '元谋县', null);
INSERT INTO `regions` VALUES ('2710', '532329', '532300', '武定县', null);
INSERT INTO `regions` VALUES ('2711', '532331', '532300', '禄丰县', null);
INSERT INTO `regions` VALUES ('2712', '532501', '532500', '个旧市', null);
INSERT INTO `regions` VALUES ('2713', '532502', '532500', '开远市', null);
INSERT INTO `regions` VALUES ('2714', '532503', '532500', '蒙自市', null);
INSERT INTO `regions` VALUES ('2715', '532504', '532500', '弥勒市', null);
INSERT INTO `regions` VALUES ('2716', '532523', '532500', '屏边苗族自治县', null);
INSERT INTO `regions` VALUES ('2717', '532524', '532500', '建水县', null);
INSERT INTO `regions` VALUES ('2718', '532525', '532500', '石屏县', null);
INSERT INTO `regions` VALUES ('2719', '532527', '532500', '泸西县', null);
INSERT INTO `regions` VALUES ('2720', '532528', '532500', '元阳县', null);
INSERT INTO `regions` VALUES ('2721', '532529', '532500', '红河县', null);
INSERT INTO `regions` VALUES ('2722', '532530', '532500', '金平苗族瑶族傣族自治县', null);
INSERT INTO `regions` VALUES ('2723', '532531', '532500', '绿春县', null);
INSERT INTO `regions` VALUES ('2724', '532532', '532500', '河口瑶族自治县', null);
INSERT INTO `regions` VALUES ('2725', '532601', '532600', '文山市', null);
INSERT INTO `regions` VALUES ('2726', '532622', '532600', '砚山县', null);
INSERT INTO `regions` VALUES ('2727', '532623', '532600', '西畴县', null);
INSERT INTO `regions` VALUES ('2728', '532624', '532600', '麻栗坡县', null);
INSERT INTO `regions` VALUES ('2729', '532625', '532600', '马关县', null);
INSERT INTO `regions` VALUES ('2730', '532626', '532600', '丘北县', null);
INSERT INTO `regions` VALUES ('2731', '532627', '532600', '广南县', null);
INSERT INTO `regions` VALUES ('2732', '532628', '532600', '富宁县', null);
INSERT INTO `regions` VALUES ('2733', '532801', '532800', '景洪市', null);
INSERT INTO `regions` VALUES ('2734', '532822', '532800', '勐海县', null);
INSERT INTO `regions` VALUES ('2735', '532823', '532800', '勐腊县', null);
INSERT INTO `regions` VALUES ('2736', '532901', '532900', '大理市', null);
INSERT INTO `regions` VALUES ('2737', '532922', '532900', '漾濞彝族自治县', null);
INSERT INTO `regions` VALUES ('2738', '532923', '532900', '祥云县', null);
INSERT INTO `regions` VALUES ('2739', '532924', '532900', '宾川县', null);
INSERT INTO `regions` VALUES ('2740', '532925', '532900', '弥渡县', null);
INSERT INTO `regions` VALUES ('2741', '532926', '532900', '南涧彝族自治县', null);
INSERT INTO `regions` VALUES ('2742', '532927', '532900', '巍山彝族回族自治县', null);
INSERT INTO `regions` VALUES ('2743', '532928', '532900', '永平县', null);
INSERT INTO `regions` VALUES ('2744', '532929', '532900', '云龙县', null);
INSERT INTO `regions` VALUES ('2745', '532930', '532900', '洱源县', null);
INSERT INTO `regions` VALUES ('2746', '532931', '532900', '剑川县', null);
INSERT INTO `regions` VALUES ('2747', '532932', '532900', '鹤庆县', null);
INSERT INTO `regions` VALUES ('2748', '533102', '533100', '瑞丽市', null);
INSERT INTO `regions` VALUES ('2749', '533103', '533100', '芒市', null);
INSERT INTO `regions` VALUES ('2750', '533122', '533100', '梁河县', null);
INSERT INTO `regions` VALUES ('2751', '533123', '533100', '盈江县', null);
INSERT INTO `regions` VALUES ('2752', '533124', '533100', '陇川县', null);
INSERT INTO `regions` VALUES ('2753', '533301', '533300', '泸水市', null);
INSERT INTO `regions` VALUES ('2754', '533323', '533300', '福贡县', null);
INSERT INTO `regions` VALUES ('2755', '533324', '533300', '贡山独龙族怒族自治县', null);
INSERT INTO `regions` VALUES ('2756', '533325', '533300', '兰坪白族普米族自治县', null);
INSERT INTO `regions` VALUES ('2757', '533401', '533400', '香格里拉市', null);
INSERT INTO `regions` VALUES ('2758', '533422', '533400', '德钦县', null);
INSERT INTO `regions` VALUES ('2759', '533423', '533400', '维西傈僳族自治县', null);
INSERT INTO `regions` VALUES ('2760', '540100', '540000', '拉萨市', null);
INSERT INTO `regions` VALUES ('2761', '540200', '540000', '日喀则市', null);
INSERT INTO `regions` VALUES ('2762', '540300', '540000', '昌都市', null);
INSERT INTO `regions` VALUES ('2763', '540400', '540000', '林芝市', null);
INSERT INTO `regions` VALUES ('2764', '540500', '540000', '山南市', null);
INSERT INTO `regions` VALUES ('2765', '540600', '540000', '那曲市', null);
INSERT INTO `regions` VALUES ('2766', '542500', '540000', '阿里地区', null);
INSERT INTO `regions` VALUES ('2767', '540102', '540100', '城关区', null);
INSERT INTO `regions` VALUES ('2768', '540103', '540100', '堆龙德庆区', null);
INSERT INTO `regions` VALUES ('2769', '540104', '540100', '达孜区', null);
INSERT INTO `regions` VALUES ('2770', '540121', '540100', '林周县', null);
INSERT INTO `regions` VALUES ('2771', '540122', '540100', '当雄县', null);
INSERT INTO `regions` VALUES ('2772', '540123', '540100', '尼木县', null);
INSERT INTO `regions` VALUES ('2773', '540124', '540100', '曲水县', null);
INSERT INTO `regions` VALUES ('2774', '540127', '540100', '墨竹工卡县', null);
INSERT INTO `regions` VALUES ('2775', '540202', '540200', '桑珠孜区', null);
INSERT INTO `regions` VALUES ('2776', '540221', '540200', '南木林县', null);
INSERT INTO `regions` VALUES ('2777', '540222', '540200', '江孜县', null);
INSERT INTO `regions` VALUES ('2778', '540223', '540200', '定日县', null);
INSERT INTO `regions` VALUES ('2779', '540224', '540200', '萨迦县', null);
INSERT INTO `regions` VALUES ('2780', '540225', '540200', '拉孜县', null);
INSERT INTO `regions` VALUES ('2781', '540226', '540200', '昂仁县', null);
INSERT INTO `regions` VALUES ('2782', '540227', '540200', '谢通门县', null);
INSERT INTO `regions` VALUES ('2783', '540228', '540200', '白朗县', null);
INSERT INTO `regions` VALUES ('2784', '540229', '540200', '仁布县', null);
INSERT INTO `regions` VALUES ('2785', '540230', '540200', '康马县', null);
INSERT INTO `regions` VALUES ('2786', '540231', '540200', '定结县', null);
INSERT INTO `regions` VALUES ('2787', '540232', '540200', '仲巴县', null);
INSERT INTO `regions` VALUES ('2788', '540233', '540200', '亚东县', null);
INSERT INTO `regions` VALUES ('2789', '540234', '540200', '吉隆县', null);
INSERT INTO `regions` VALUES ('2790', '540235', '540200', '聂拉木县', null);
INSERT INTO `regions` VALUES ('2791', '540236', '540200', '萨嘎县', null);
INSERT INTO `regions` VALUES ('2792', '540237', '540200', '岗巴县', null);
INSERT INTO `regions` VALUES ('2793', '540302', '540300', '卡若区', null);
INSERT INTO `regions` VALUES ('2794', '540321', '540300', '江达县', null);
INSERT INTO `regions` VALUES ('2795', '540322', '540300', '贡觉县', null);
INSERT INTO `regions` VALUES ('2796', '540323', '540300', '类乌齐县', null);
INSERT INTO `regions` VALUES ('2797', '540324', '540300', '丁青县', null);
INSERT INTO `regions` VALUES ('2798', '540325', '540300', '察雅县', null);
INSERT INTO `regions` VALUES ('2799', '540326', '540300', '八宿县', null);
INSERT INTO `regions` VALUES ('2800', '540327', '540300', '左贡县', null);
INSERT INTO `regions` VALUES ('2801', '540328', '540300', '芒康县', null);
INSERT INTO `regions` VALUES ('2802', '540329', '540300', '洛隆县', null);
INSERT INTO `regions` VALUES ('2803', '540330', '540300', '边坝县', null);
INSERT INTO `regions` VALUES ('2804', '540402', '540400', '巴宜区', null);
INSERT INTO `regions` VALUES ('2805', '540421', '540400', '工布江达县', null);
INSERT INTO `regions` VALUES ('2806', '540422', '540400', '米林县', null);
INSERT INTO `regions` VALUES ('2807', '540423', '540400', '墨脱县', null);
INSERT INTO `regions` VALUES ('2808', '540424', '540400', '波密县', null);
INSERT INTO `regions` VALUES ('2809', '540425', '540400', '察隅县', null);
INSERT INTO `regions` VALUES ('2810', '540426', '540400', '朗县', null);
INSERT INTO `regions` VALUES ('2811', '540502', '540500', '乃东区', null);
INSERT INTO `regions` VALUES ('2812', '540521', '540500', '扎囊县', null);
INSERT INTO `regions` VALUES ('2813', '540522', '540500', '贡嘎县', null);
INSERT INTO `regions` VALUES ('2814', '540523', '540500', '桑日县', null);
INSERT INTO `regions` VALUES ('2815', '540524', '540500', '琼结县', null);
INSERT INTO `regions` VALUES ('2816', '540525', '540500', '曲松县', null);
INSERT INTO `regions` VALUES ('2817', '540526', '540500', '措美县', null);
INSERT INTO `regions` VALUES ('2818', '540527', '540500', '洛扎县', null);
INSERT INTO `regions` VALUES ('2819', '540528', '540500', '加查县', null);
INSERT INTO `regions` VALUES ('2820', '540529', '540500', '隆子县', null);
INSERT INTO `regions` VALUES ('2821', '540530', '540500', '错那县', null);
INSERT INTO `regions` VALUES ('2822', '540531', '540500', '浪卡子县', null);
INSERT INTO `regions` VALUES ('2823', '540602', '540600', '色尼区', null);
INSERT INTO `regions` VALUES ('2824', '540621', '540600', '嘉黎县', null);
INSERT INTO `regions` VALUES ('2825', '540622', '540600', '比如县', null);
INSERT INTO `regions` VALUES ('2826', '540623', '540600', '聂荣县', null);
INSERT INTO `regions` VALUES ('2827', '540624', '540600', '安多县', null);
INSERT INTO `regions` VALUES ('2828', '540625', '540600', '申扎县', null);
INSERT INTO `regions` VALUES ('2829', '540626', '540600', '索县', null);
INSERT INTO `regions` VALUES ('2830', '540627', '540600', '班戈县', null);
INSERT INTO `regions` VALUES ('2831', '540628', '540600', '巴青县', null);
INSERT INTO `regions` VALUES ('2832', '540629', '540600', '尼玛县', null);
INSERT INTO `regions` VALUES ('2833', '540630', '540600', '双湖县', null);
INSERT INTO `regions` VALUES ('2834', '542521', '542500', '普兰县', null);
INSERT INTO `regions` VALUES ('2835', '542522', '542500', '札达县', null);
INSERT INTO `regions` VALUES ('2836', '542523', '542500', '噶尔县', null);
INSERT INTO `regions` VALUES ('2837', '542524', '542500', '日土县', null);
INSERT INTO `regions` VALUES ('2838', '542525', '542500', '革吉县', null);
INSERT INTO `regions` VALUES ('2839', '542526', '542500', '改则县', null);
INSERT INTO `regions` VALUES ('2840', '542527', '542500', '措勤县', null);
INSERT INTO `regions` VALUES ('2841', '610100', '610000', '西安市', null);
INSERT INTO `regions` VALUES ('2842', '610200', '610000', '铜川市', null);
INSERT INTO `regions` VALUES ('2843', '610300', '610000', '宝鸡市', null);
INSERT INTO `regions` VALUES ('2844', '610400', '610000', '咸阳市', null);
INSERT INTO `regions` VALUES ('2845', '610500', '610000', '渭南市', null);
INSERT INTO `regions` VALUES ('2846', '610600', '610000', '延安市', null);
INSERT INTO `regions` VALUES ('2847', '610700', '610000', '汉中市', null);
INSERT INTO `regions` VALUES ('2848', '610800', '610000', '榆林市', null);
INSERT INTO `regions` VALUES ('2849', '610900', '610000', '安康市', null);
INSERT INTO `regions` VALUES ('2850', '611000', '610000', '商洛市', null);
INSERT INTO `regions` VALUES ('2851', '610102', '610100', '新城区', null);
INSERT INTO `regions` VALUES ('2852', '610103', '610100', '碑林区', null);
INSERT INTO `regions` VALUES ('2853', '610104', '610100', '莲湖区', null);
INSERT INTO `regions` VALUES ('2854', '610111', '610100', '灞桥区', null);
INSERT INTO `regions` VALUES ('2855', '610112', '610100', '未央区', null);
INSERT INTO `regions` VALUES ('2856', '610113', '610100', '雁塔区', null);
INSERT INTO `regions` VALUES ('2857', '610114', '610100', '阎良区', null);
INSERT INTO `regions` VALUES ('2858', '610115', '610100', '临潼区', null);
INSERT INTO `regions` VALUES ('2859', '610116', '610100', '长安区', null);
INSERT INTO `regions` VALUES ('2860', '610117', '610100', '高陵区', null);
INSERT INTO `regions` VALUES ('2861', '610118', '610100', '鄠邑区', null);
INSERT INTO `regions` VALUES ('2862', '610122', '610100', '蓝田县', null);
INSERT INTO `regions` VALUES ('2863', '610124', '610100', '周至县', null);
INSERT INTO `regions` VALUES ('2864', '610202', '610200', '王益区', null);
INSERT INTO `regions` VALUES ('2865', '610203', '610200', '印台区', null);
INSERT INTO `regions` VALUES ('2866', '610204', '610200', '耀州区', null);
INSERT INTO `regions` VALUES ('2867', '610222', '610200', '宜君县', null);
INSERT INTO `regions` VALUES ('2868', '610302', '610300', '渭滨区', null);
INSERT INTO `regions` VALUES ('2869', '610303', '610300', '金台区', null);
INSERT INTO `regions` VALUES ('2870', '610304', '610300', '陈仓区', null);
INSERT INTO `regions` VALUES ('2871', '610322', '610300', '凤翔县', null);
INSERT INTO `regions` VALUES ('2872', '610323', '610300', '岐山县', null);
INSERT INTO `regions` VALUES ('2873', '610324', '610300', '扶风县', null);
INSERT INTO `regions` VALUES ('2874', '610326', '610300', '眉县', null);
INSERT INTO `regions` VALUES ('2875', '610327', '610300', '陇县', null);
INSERT INTO `regions` VALUES ('2876', '610328', '610300', '千阳县', null);
INSERT INTO `regions` VALUES ('2877', '610329', '610300', '麟游县', null);
INSERT INTO `regions` VALUES ('2878', '610330', '610300', '凤县', null);
INSERT INTO `regions` VALUES ('2879', '610331', '610300', '太白县', null);
INSERT INTO `regions` VALUES ('2880', '610402', '610400', '秦都区', null);
INSERT INTO `regions` VALUES ('2881', '610403', '610400', '杨陵区', null);
INSERT INTO `regions` VALUES ('2882', '610404', '610400', '渭城区', null);
INSERT INTO `regions` VALUES ('2883', '610422', '610400', '三原县', null);
INSERT INTO `regions` VALUES ('2884', '610423', '610400', '泾阳县', null);
INSERT INTO `regions` VALUES ('2885', '610424', '610400', '乾县', null);
INSERT INTO `regions` VALUES ('2886', '610425', '610400', '礼泉县', null);
INSERT INTO `regions` VALUES ('2887', '610426', '610400', '永寿县', null);
INSERT INTO `regions` VALUES ('2888', '610427', '610400', '彬县', null);
INSERT INTO `regions` VALUES ('2889', '610428', '610400', '长武县', null);
INSERT INTO `regions` VALUES ('2890', '610429', '610400', '旬邑县', null);
INSERT INTO `regions` VALUES ('2891', '610430', '610400', '淳化县', null);
INSERT INTO `regions` VALUES ('2892', '610431', '610400', '武功县', null);
INSERT INTO `regions` VALUES ('2893', '610481', '610400', '兴平市', null);
INSERT INTO `regions` VALUES ('2894', '610502', '610500', '临渭区', null);
INSERT INTO `regions` VALUES ('2895', '610503', '610500', '华州区', null);
INSERT INTO `regions` VALUES ('2896', '610522', '610500', '潼关县', null);
INSERT INTO `regions` VALUES ('2897', '610523', '610500', '大荔县', null);
INSERT INTO `regions` VALUES ('2898', '610524', '610500', '合阳县', null);
INSERT INTO `regions` VALUES ('2899', '610525', '610500', '澄城县', null);
INSERT INTO `regions` VALUES ('2900', '610526', '610500', '蒲城县', null);
INSERT INTO `regions` VALUES ('2901', '610527', '610500', '白水县', null);
INSERT INTO `regions` VALUES ('2902', '610528', '610500', '富平县', null);
INSERT INTO `regions` VALUES ('2903', '610581', '610500', '韩城市', null);
INSERT INTO `regions` VALUES ('2904', '610582', '610500', '华阴市', null);
INSERT INTO `regions` VALUES ('2905', '610602', '610600', '宝塔区', null);
INSERT INTO `regions` VALUES ('2906', '610603', '610600', '安塞区', null);
INSERT INTO `regions` VALUES ('2907', '610621', '610600', '延长县', null);
INSERT INTO `regions` VALUES ('2908', '610622', '610600', '延川县', null);
INSERT INTO `regions` VALUES ('2909', '610623', '610600', '子长县', null);
INSERT INTO `regions` VALUES ('2910', '610625', '610600', '志丹县', null);
INSERT INTO `regions` VALUES ('2911', '610626', '610600', '吴起县', null);
INSERT INTO `regions` VALUES ('2912', '610627', '610600', '甘泉县', null);
INSERT INTO `regions` VALUES ('2913', '610628', '610600', '富县', null);
INSERT INTO `regions` VALUES ('2914', '610629', '610600', '洛川县', null);
INSERT INTO `regions` VALUES ('2915', '610630', '610600', '宜川县', null);
INSERT INTO `regions` VALUES ('2916', '610631', '610600', '黄龙县', null);
INSERT INTO `regions` VALUES ('2917', '610632', '610600', '黄陵县', null);
INSERT INTO `regions` VALUES ('2918', '610702', '610700', '汉台区', null);
INSERT INTO `regions` VALUES ('2919', '610703', '610700', '南郑区', null);
INSERT INTO `regions` VALUES ('2920', '610722', '610700', '城固县', null);
INSERT INTO `regions` VALUES ('2921', '610723', '610700', '洋县', null);
INSERT INTO `regions` VALUES ('2922', '610724', '610700', '西乡县', null);
INSERT INTO `regions` VALUES ('2923', '610725', '610700', '勉县', null);
INSERT INTO `regions` VALUES ('2924', '610726', '610700', '宁强县', null);
INSERT INTO `regions` VALUES ('2925', '610727', '610700', '略阳县', null);
INSERT INTO `regions` VALUES ('2926', '610728', '610700', '镇巴县', null);
INSERT INTO `regions` VALUES ('2927', '610729', '610700', '留坝县', null);
INSERT INTO `regions` VALUES ('2928', '610730', '610700', '佛坪县', null);
INSERT INTO `regions` VALUES ('2929', '610802', '610800', '榆阳区', null);
INSERT INTO `regions` VALUES ('2930', '610803', '610800', '横山区', null);
INSERT INTO `regions` VALUES ('2931', '610822', '610800', '府谷县', null);
INSERT INTO `regions` VALUES ('2932', '610824', '610800', '靖边县', null);
INSERT INTO `regions` VALUES ('2933', '610825', '610800', '定边县', null);
INSERT INTO `regions` VALUES ('2934', '610826', '610800', '绥德县', null);
INSERT INTO `regions` VALUES ('2935', '610827', '610800', '米脂县', null);
INSERT INTO `regions` VALUES ('2936', '610828', '610800', '佳县', null);
INSERT INTO `regions` VALUES ('2937', '610829', '610800', '吴堡县', null);
INSERT INTO `regions` VALUES ('2938', '610830', '610800', '清涧县', null);
INSERT INTO `regions` VALUES ('2939', '610831', '610800', '子洲县', null);
INSERT INTO `regions` VALUES ('2940', '610881', '610800', '神木市', null);
INSERT INTO `regions` VALUES ('2941', '610902', '610900', '汉滨区', null);
INSERT INTO `regions` VALUES ('2942', '610921', '610900', '汉阴县', null);
INSERT INTO `regions` VALUES ('2943', '610922', '610900', '石泉县', null);
INSERT INTO `regions` VALUES ('2944', '610923', '610900', '宁陕县', null);
INSERT INTO `regions` VALUES ('2945', '610924', '610900', '紫阳县', null);
INSERT INTO `regions` VALUES ('2946', '610925', '610900', '岚皋县', null);
INSERT INTO `regions` VALUES ('2947', '610926', '610900', '平利县', null);
INSERT INTO `regions` VALUES ('2948', '610927', '610900', '镇坪县', null);
INSERT INTO `regions` VALUES ('2949', '610928', '610900', '旬阳县', null);
INSERT INTO `regions` VALUES ('2950', '610929', '610900', '白河县', null);
INSERT INTO `regions` VALUES ('2951', '611002', '611000', '商州区', null);
INSERT INTO `regions` VALUES ('2952', '611021', '611000', '洛南县', null);
INSERT INTO `regions` VALUES ('2953', '611022', '611000', '丹凤县', null);
INSERT INTO `regions` VALUES ('2954', '611023', '611000', '商南县', null);
INSERT INTO `regions` VALUES ('2955', '611024', '611000', '山阳县', null);
INSERT INTO `regions` VALUES ('2956', '611025', '611000', '镇安县', null);
INSERT INTO `regions` VALUES ('2957', '611026', '611000', '柞水县', null);
INSERT INTO `regions` VALUES ('2958', '620100', '620000', '兰州市', null);
INSERT INTO `regions` VALUES ('2959', '620200', '620000', '嘉峪关市', null);
INSERT INTO `regions` VALUES ('2960', '620300', '620000', '金昌市', null);
INSERT INTO `regions` VALUES ('2961', '620400', '620000', '白银市', null);
INSERT INTO `regions` VALUES ('2962', '620500', '620000', '天水市', null);
INSERT INTO `regions` VALUES ('2963', '620600', '620000', '武威市', null);
INSERT INTO `regions` VALUES ('2964', '620700', '620000', '张掖市', null);
INSERT INTO `regions` VALUES ('2965', '620800', '620000', '平凉市', null);
INSERT INTO `regions` VALUES ('2966', '620900', '620000', '酒泉市', null);
INSERT INTO `regions` VALUES ('2967', '621000', '620000', '庆阳市', null);
INSERT INTO `regions` VALUES ('2968', '621100', '620000', '定西市', null);
INSERT INTO `regions` VALUES ('2969', '621200', '620000', '陇南市', null);
INSERT INTO `regions` VALUES ('2970', '622900', '620000', '临夏回族自治州', null);
INSERT INTO `regions` VALUES ('2971', '623000', '620000', '甘南藏族自治州', null);
INSERT INTO `regions` VALUES ('2972', '620102', '620100', '城关区', null);
INSERT INTO `regions` VALUES ('2973', '620103', '620100', '七里河区', null);
INSERT INTO `regions` VALUES ('2974', '620104', '620100', '西固区', null);
INSERT INTO `regions` VALUES ('2975', '620105', '620100', '安宁区', null);
INSERT INTO `regions` VALUES ('2976', '620111', '620100', '红古区', null);
INSERT INTO `regions` VALUES ('2977', '620121', '620100', '永登县', null);
INSERT INTO `regions` VALUES ('2978', '620122', '620100', '皋兰县', null);
INSERT INTO `regions` VALUES ('2979', '620123', '620100', '榆中县', null);
INSERT INTO `regions` VALUES ('2980', '620200', '620200', '嘉峪关市', null);
INSERT INTO `regions` VALUES ('2981', '620302', '620300', '金川区', null);
INSERT INTO `regions` VALUES ('2982', '620321', '620300', '永昌县', null);
INSERT INTO `regions` VALUES ('2983', '620402', '620400', '白银区', null);
INSERT INTO `regions` VALUES ('2984', '620403', '620400', '平川区', null);
INSERT INTO `regions` VALUES ('2985', '620421', '620400', '靖远县', null);
INSERT INTO `regions` VALUES ('2986', '620422', '620400', '会宁县', null);
INSERT INTO `regions` VALUES ('2987', '620423', '620400', '景泰县', null);
INSERT INTO `regions` VALUES ('2988', '620502', '620500', '秦州区', null);
INSERT INTO `regions` VALUES ('2989', '620503', '620500', '麦积区', null);
INSERT INTO `regions` VALUES ('2990', '620521', '620500', '清水县', null);
INSERT INTO `regions` VALUES ('2991', '620522', '620500', '秦安县', null);
INSERT INTO `regions` VALUES ('2992', '620523', '620500', '甘谷县', null);
INSERT INTO `regions` VALUES ('2993', '620524', '620500', '武山县', null);
INSERT INTO `regions` VALUES ('2994', '620525', '620500', '张家川回族自治县', null);
INSERT INTO `regions` VALUES ('2995', '620602', '620600', '凉州区', null);
INSERT INTO `regions` VALUES ('2996', '620621', '620600', '民勤县', null);
INSERT INTO `regions` VALUES ('2997', '620622', '620600', '古浪县', null);
INSERT INTO `regions` VALUES ('2998', '620623', '620600', '天祝藏族自治县', null);
INSERT INTO `regions` VALUES ('2999', '620702', '620700', '甘州区', null);
INSERT INTO `regions` VALUES ('3000', '620721', '620700', '肃南裕固族自治县', null);
INSERT INTO `regions` VALUES ('3001', '620722', '620700', '民乐县', null);
INSERT INTO `regions` VALUES ('3002', '620723', '620700', '临泽县', null);
INSERT INTO `regions` VALUES ('3003', '620724', '620700', '高台县', null);
INSERT INTO `regions` VALUES ('3004', '620725', '620700', '山丹县', null);
INSERT INTO `regions` VALUES ('3005', '620802', '620800', '崆峒区', null);
INSERT INTO `regions` VALUES ('3006', '620821', '620800', '泾川县', null);
INSERT INTO `regions` VALUES ('3007', '620822', '620800', '灵台县', null);
INSERT INTO `regions` VALUES ('3008', '620823', '620800', '崇信县', null);
INSERT INTO `regions` VALUES ('3009', '620824', '620800', '华亭县', null);
INSERT INTO `regions` VALUES ('3010', '620825', '620800', '庄浪县', null);
INSERT INTO `regions` VALUES ('3011', '620826', '620800', '静宁县', null);
INSERT INTO `regions` VALUES ('3012', '620902', '620900', '肃州区', null);
INSERT INTO `regions` VALUES ('3013', '620921', '620900', '金塔县', null);
INSERT INTO `regions` VALUES ('3014', '620922', '620900', '瓜州县', null);
INSERT INTO `regions` VALUES ('3015', '620923', '620900', '肃北蒙古族自治县', null);
INSERT INTO `regions` VALUES ('3016', '620924', '620900', '阿克塞哈萨克族自治县', null);
INSERT INTO `regions` VALUES ('3017', '620981', '620900', '玉门市', null);
INSERT INTO `regions` VALUES ('3018', '620982', '620900', '敦煌市', null);
INSERT INTO `regions` VALUES ('3019', '621002', '621000', '西峰区', null);
INSERT INTO `regions` VALUES ('3020', '621021', '621000', '庆城县', null);
INSERT INTO `regions` VALUES ('3021', '621022', '621000', '环县', null);
INSERT INTO `regions` VALUES ('3022', '621023', '621000', '华池县', null);
INSERT INTO `regions` VALUES ('3023', '621024', '621000', '合水县', null);
INSERT INTO `regions` VALUES ('3024', '621025', '621000', '正宁县', null);
INSERT INTO `regions` VALUES ('3025', '621026', '621000', '宁县', null);
INSERT INTO `regions` VALUES ('3026', '621027', '621000', '镇原县', null);
INSERT INTO `regions` VALUES ('3027', '621102', '621100', '安定区', null);
INSERT INTO `regions` VALUES ('3028', '621121', '621100', '通渭县', null);
INSERT INTO `regions` VALUES ('3029', '621122', '621100', '陇西县', null);
INSERT INTO `regions` VALUES ('3030', '621123', '621100', '渭源县', null);
INSERT INTO `regions` VALUES ('3031', '621124', '621100', '临洮县', null);
INSERT INTO `regions` VALUES ('3032', '621125', '621100', '漳县', null);
INSERT INTO `regions` VALUES ('3033', '621126', '621100', '岷县', null);
INSERT INTO `regions` VALUES ('3034', '621202', '621200', '武都区', null);
INSERT INTO `regions` VALUES ('3035', '621221', '621200', '成县', null);
INSERT INTO `regions` VALUES ('3036', '621222', '621200', '文县', null);
INSERT INTO `regions` VALUES ('3037', '621223', '621200', '宕昌县', null);
INSERT INTO `regions` VALUES ('3038', '621224', '621200', '康县', null);
INSERT INTO `regions` VALUES ('3039', '621225', '621200', '西和县', null);
INSERT INTO `regions` VALUES ('3040', '621226', '621200', '礼县', null);
INSERT INTO `regions` VALUES ('3041', '621227', '621200', '徽县', null);
INSERT INTO `regions` VALUES ('3042', '621228', '621200', '两当县', null);
INSERT INTO `regions` VALUES ('3043', '622901', '622900', '临夏市', null);
INSERT INTO `regions` VALUES ('3044', '622921', '622900', '临夏县', null);
INSERT INTO `regions` VALUES ('3045', '622922', '622900', '康乐县', null);
INSERT INTO `regions` VALUES ('3046', '622923', '622900', '永靖县', null);
INSERT INTO `regions` VALUES ('3047', '622924', '622900', '广河县', null);
INSERT INTO `regions` VALUES ('3048', '622925', '622900', '和政县', null);
INSERT INTO `regions` VALUES ('3049', '622926', '622900', '东乡族自治县', null);
INSERT INTO `regions` VALUES ('3050', '622927', '622900', '积石山保安族东乡族撒拉族自治县', null);
INSERT INTO `regions` VALUES ('3051', '623001', '623000', '合作市', null);
INSERT INTO `regions` VALUES ('3052', '623021', '623000', '临潭县', null);
INSERT INTO `regions` VALUES ('3053', '623022', '623000', '卓尼县', null);
INSERT INTO `regions` VALUES ('3054', '623023', '623000', '舟曲县', null);
INSERT INTO `regions` VALUES ('3055', '623024', '623000', '迭部县', null);
INSERT INTO `regions` VALUES ('3056', '623025', '623000', '玛曲县', null);
INSERT INTO `regions` VALUES ('3057', '623026', '623000', '碌曲县', null);
INSERT INTO `regions` VALUES ('3058', '623027', '623000', '夏河县', null);
INSERT INTO `regions` VALUES ('3059', '630100', '630000', '西宁市', null);
INSERT INTO `regions` VALUES ('3060', '630200', '630000', '海东市', null);
INSERT INTO `regions` VALUES ('3061', '632200', '630000', '海北藏族自治州', null);
INSERT INTO `regions` VALUES ('3062', '632300', '630000', '黄南藏族自治州', null);
INSERT INTO `regions` VALUES ('3063', '632500', '630000', '海南藏族自治州', null);
INSERT INTO `regions` VALUES ('3064', '632600', '630000', '果洛藏族自治州', null);
INSERT INTO `regions` VALUES ('3065', '632700', '630000', '玉树藏族自治州', null);
INSERT INTO `regions` VALUES ('3066', '632800', '630000', '海西蒙古族藏族自治州', null);
INSERT INTO `regions` VALUES ('3067', '630102', '630100', '城东区', null);
INSERT INTO `regions` VALUES ('3068', '630103', '630100', '城中区', null);
INSERT INTO `regions` VALUES ('3069', '630104', '630100', '城西区', null);
INSERT INTO `regions` VALUES ('3070', '630105', '630100', '城北区', null);
INSERT INTO `regions` VALUES ('3071', '630121', '630100', '大通回族土族自治县', null);
INSERT INTO `regions` VALUES ('3072', '630122', '630100', '湟中县', null);
INSERT INTO `regions` VALUES ('3073', '630123', '630100', '湟源县', null);
INSERT INTO `regions` VALUES ('3074', '630202', '630200', '乐都区', null);
INSERT INTO `regions` VALUES ('3075', '630203', '630200', '平安区', null);
INSERT INTO `regions` VALUES ('3076', '630222', '630200', '民和回族土族自治县', null);
INSERT INTO `regions` VALUES ('3077', '630223', '630200', '互助土族自治县', null);
INSERT INTO `regions` VALUES ('3078', '630224', '630200', '化隆回族自治县', null);
INSERT INTO `regions` VALUES ('3079', '630225', '630200', '循化撒拉族自治县', null);
INSERT INTO `regions` VALUES ('3080', '632221', '632200', '门源回族自治县', null);
INSERT INTO `regions` VALUES ('3081', '632222', '632200', '祁连县', null);
INSERT INTO `regions` VALUES ('3082', '632223', '632200', '海晏县', null);
INSERT INTO `regions` VALUES ('3083', '632224', '632200', '刚察县', null);
INSERT INTO `regions` VALUES ('3084', '632321', '632300', '同仁县', null);
INSERT INTO `regions` VALUES ('3085', '632322', '632300', '尖扎县', null);
INSERT INTO `regions` VALUES ('3086', '632323', '632300', '泽库县', null);
INSERT INTO `regions` VALUES ('3087', '632324', '632300', '河南蒙古族自治县', null);
INSERT INTO `regions` VALUES ('3088', '632521', '632500', '共和县', null);
INSERT INTO `regions` VALUES ('3089', '632522', '632500', '同德县', null);
INSERT INTO `regions` VALUES ('3090', '632523', '632500', '贵德县', null);
INSERT INTO `regions` VALUES ('3091', '632524', '632500', '兴海县', null);
INSERT INTO `regions` VALUES ('3092', '632525', '632500', '贵南县', null);
INSERT INTO `regions` VALUES ('3093', '632621', '632600', '玛沁县', null);
INSERT INTO `regions` VALUES ('3094', '632622', '632600', '班玛县', null);
INSERT INTO `regions` VALUES ('3095', '632623', '632600', '甘德县', null);
INSERT INTO `regions` VALUES ('3096', '632624', '632600', '达日县', null);
INSERT INTO `regions` VALUES ('3097', '632625', '632600', '久治县', null);
INSERT INTO `regions` VALUES ('3098', '632626', '632600', '玛多县', null);
INSERT INTO `regions` VALUES ('3099', '632701', '632700', '玉树市', null);
INSERT INTO `regions` VALUES ('3100', '632722', '632700', '杂多县', null);
INSERT INTO `regions` VALUES ('3101', '632723', '632700', '称多县', null);
INSERT INTO `regions` VALUES ('3102', '632724', '632700', '治多县', null);
INSERT INTO `regions` VALUES ('3103', '632725', '632700', '囊谦县', null);
INSERT INTO `regions` VALUES ('3104', '632726', '632700', '曲麻莱县', null);
INSERT INTO `regions` VALUES ('3105', '632801', '632800', '格尔木市', null);
INSERT INTO `regions` VALUES ('3106', '632802', '632800', '德令哈市', null);
INSERT INTO `regions` VALUES ('3107', '632821', '632800', '乌兰县', null);
INSERT INTO `regions` VALUES ('3108', '632822', '632800', '都兰县', null);
INSERT INTO `regions` VALUES ('3109', '632823', '632800', '天峻县', null);
INSERT INTO `regions` VALUES ('3110', '632825', '632800', '海西蒙古族藏族自治州直辖', null);
INSERT INTO `regions` VALUES ('3111', '640100', '640000', '银川市', null);
INSERT INTO `regions` VALUES ('3112', '640200', '640000', '石嘴山市', null);
INSERT INTO `regions` VALUES ('3113', '640300', '640000', '吴忠市', null);
INSERT INTO `regions` VALUES ('3114', '640400', '640000', '固原市', null);
INSERT INTO `regions` VALUES ('3115', '640500', '640000', '中卫市', null);
INSERT INTO `regions` VALUES ('3116', '640104', '640100', '兴庆区', null);
INSERT INTO `regions` VALUES ('3117', '640105', '640100', '西夏区', null);
INSERT INTO `regions` VALUES ('3118', '640106', '640100', '金凤区', null);
INSERT INTO `regions` VALUES ('3119', '640121', '640100', '永宁县', null);
INSERT INTO `regions` VALUES ('3120', '640122', '640100', '贺兰县', null);
INSERT INTO `regions` VALUES ('3121', '640181', '640100', '灵武市', null);
INSERT INTO `regions` VALUES ('3122', '640202', '640200', '大武口区', null);
INSERT INTO `regions` VALUES ('3123', '640205', '640200', '惠农区', null);
INSERT INTO `regions` VALUES ('3124', '640221', '640200', '平罗县', null);
INSERT INTO `regions` VALUES ('3125', '640302', '640300', '利通区', null);
INSERT INTO `regions` VALUES ('3126', '640303', '640300', '红寺堡区', null);
INSERT INTO `regions` VALUES ('3127', '640323', '640300', '盐池县', null);
INSERT INTO `regions` VALUES ('3128', '640324', '640300', '同心县', null);
INSERT INTO `regions` VALUES ('3129', '640381', '640300', '青铜峡市', null);
INSERT INTO `regions` VALUES ('3130', '640402', '640400', '原州区', null);
INSERT INTO `regions` VALUES ('3131', '640422', '640400', '西吉县', null);
INSERT INTO `regions` VALUES ('3132', '640423', '640400', '隆德县', null);
INSERT INTO `regions` VALUES ('3133', '640424', '640400', '泾源县', null);
INSERT INTO `regions` VALUES ('3134', '640425', '640400', '彭阳县', null);
INSERT INTO `regions` VALUES ('3135', '640502', '640500', '沙坡头区', null);
INSERT INTO `regions` VALUES ('3136', '640521', '640500', '中宁县', null);
INSERT INTO `regions` VALUES ('3137', '640522', '640500', '海原县', null);
INSERT INTO `regions` VALUES ('3138', '650100', '650000', '乌鲁木齐市', null);
INSERT INTO `regions` VALUES ('3139', '650200', '650000', '克拉玛依市', null);
INSERT INTO `regions` VALUES ('3140', '650400', '650000', '吐鲁番市', null);
INSERT INTO `regions` VALUES ('3141', '650500', '650000', '哈密市', null);
INSERT INTO `regions` VALUES ('3142', '652300', '650000', '昌吉回族自治州', null);
INSERT INTO `regions` VALUES ('3143', '652700', '650000', '博尔塔拉蒙古自治州', null);
INSERT INTO `regions` VALUES ('3144', '652800', '650000', '巴音郭楞蒙古自治州', null);
INSERT INTO `regions` VALUES ('3145', '652900', '650000', '阿克苏地区', null);
INSERT INTO `regions` VALUES ('3146', '653000', '650000', '克孜勒苏柯尔克孜自治州', null);
INSERT INTO `regions` VALUES ('3147', '653100', '650000', '喀什地区', null);
INSERT INTO `regions` VALUES ('3148', '653200', '650000', '和田地区', null);
INSERT INTO `regions` VALUES ('3149', '654000', '650000', '伊犁哈萨克自治州', null);
INSERT INTO `regions` VALUES ('3150', '654200', '650000', '塔城地区', null);
INSERT INTO `regions` VALUES ('3151', '654300', '650000', '阿勒泰地区', null);
INSERT INTO `regions` VALUES ('3152', '659001', '650000', '石河子市', null);
INSERT INTO `regions` VALUES ('3153', '659002', '650000', '阿拉尔市', null);
INSERT INTO `regions` VALUES ('3154', '659003', '650000', '图木舒克市', null);
INSERT INTO `regions` VALUES ('3155', '659004', '650000', '五家渠市', null);
INSERT INTO `regions` VALUES ('3156', '659005', '650000', '北屯市', null);
INSERT INTO `regions` VALUES ('3157', '659006', '650000', '铁门关市', null);
INSERT INTO `regions` VALUES ('3158', '659007', '650000', '双河市', null);
INSERT INTO `regions` VALUES ('3159', '659008', '650000', '可克达拉市', null);
INSERT INTO `regions` VALUES ('3160', '659009', '650000', '昆玉市', null);
INSERT INTO `regions` VALUES ('3161', '650102', '650100', '天山区', null);
INSERT INTO `regions` VALUES ('3162', '650103', '650100', '沙依巴克区', null);
INSERT INTO `regions` VALUES ('3163', '650104', '650100', '新市区', null);
INSERT INTO `regions` VALUES ('3164', '650105', '650100', '水磨沟区', null);
INSERT INTO `regions` VALUES ('3165', '650106', '650100', '头屯河区', null);
INSERT INTO `regions` VALUES ('3166', '650107', '650100', '达坂城区', null);
INSERT INTO `regions` VALUES ('3167', '650109', '650100', '米东区', null);
INSERT INTO `regions` VALUES ('3168', '650121', '650100', '乌鲁木齐县', null);
INSERT INTO `regions` VALUES ('3169', '650202', '650200', '独山子区', null);
INSERT INTO `regions` VALUES ('3170', '650203', '650200', '克拉玛依区', null);
INSERT INTO `regions` VALUES ('3171', '650204', '650200', '白碱滩区', null);
INSERT INTO `regions` VALUES ('3172', '650205', '650200', '乌尔禾区', null);
INSERT INTO `regions` VALUES ('3173', '650402', '650400', '高昌区', null);
INSERT INTO `regions` VALUES ('3174', '650421', '650400', '鄯善县', null);
INSERT INTO `regions` VALUES ('3175', '650422', '650400', '托克逊县', null);
INSERT INTO `regions` VALUES ('3176', '650502', '650500', '伊州区', null);
INSERT INTO `regions` VALUES ('3177', '650521', '650500', '巴里坤哈萨克自治县', null);
INSERT INTO `regions` VALUES ('3178', '650522', '650500', '伊吾县', null);
INSERT INTO `regions` VALUES ('3179', '652301', '652300', '昌吉市', null);
INSERT INTO `regions` VALUES ('3180', '652302', '652300', '阜康市', null);
INSERT INTO `regions` VALUES ('3181', '652323', '652300', '呼图壁县', null);
INSERT INTO `regions` VALUES ('3182', '652324', '652300', '玛纳斯县', null);
INSERT INTO `regions` VALUES ('3183', '652325', '652300', '奇台县', null);
INSERT INTO `regions` VALUES ('3184', '652327', '652300', '吉木萨尔县', null);
INSERT INTO `regions` VALUES ('3185', '652328', '652300', '木垒哈萨克自治县', null);
INSERT INTO `regions` VALUES ('3186', '652701', '652700', '博乐市', null);
INSERT INTO `regions` VALUES ('3187', '652702', '652700', '阿拉山口市', null);
INSERT INTO `regions` VALUES ('3188', '652722', '652700', '精河县', null);
INSERT INTO `regions` VALUES ('3189', '652723', '652700', '温泉县', null);
INSERT INTO `regions` VALUES ('3190', '652801', '652800', '库尔勒市', null);
INSERT INTO `regions` VALUES ('3191', '652822', '652800', '轮台县', null);
INSERT INTO `regions` VALUES ('3192', '652823', '652800', '尉犁县', null);
INSERT INTO `regions` VALUES ('3193', '652824', '652800', '若羌县', null);
INSERT INTO `regions` VALUES ('3194', '652825', '652800', '且末县', null);
INSERT INTO `regions` VALUES ('3195', '652826', '652800', '焉耆回族自治县', null);
INSERT INTO `regions` VALUES ('3196', '652827', '652800', '和静县', null);
INSERT INTO `regions` VALUES ('3197', '652828', '652800', '和硕县', null);
INSERT INTO `regions` VALUES ('3198', '652829', '652800', '博湖县', null);
INSERT INTO `regions` VALUES ('3199', '652901', '652900', '阿克苏市', null);
INSERT INTO `regions` VALUES ('3200', '652922', '652900', '温宿县', null);
INSERT INTO `regions` VALUES ('3201', '652923', '652900', '库车县', null);
INSERT INTO `regions` VALUES ('3202', '652924', '652900', '沙雅县', null);
INSERT INTO `regions` VALUES ('3203', '652925', '652900', '新和县', null);
INSERT INTO `regions` VALUES ('3204', '652926', '652900', '拜城县', null);
INSERT INTO `regions` VALUES ('3205', '652927', '652900', '乌什县', null);
INSERT INTO `regions` VALUES ('3206', '652928', '652900', '阿瓦提县', null);
INSERT INTO `regions` VALUES ('3207', '652929', '652900', '柯坪县', null);
INSERT INTO `regions` VALUES ('3208', '653001', '653000', '阿图什市', null);
INSERT INTO `regions` VALUES ('3209', '653022', '653000', '阿克陶县', null);
INSERT INTO `regions` VALUES ('3210', '653023', '653000', '阿合奇县', null);
INSERT INTO `regions` VALUES ('3211', '653024', '653000', '乌恰县', null);
INSERT INTO `regions` VALUES ('3212', '653101', '653100', '喀什市', null);
INSERT INTO `regions` VALUES ('3213', '653121', '653100', '疏附县', null);
INSERT INTO `regions` VALUES ('3214', '653122', '653100', '疏勒县', null);
INSERT INTO `regions` VALUES ('3215', '653123', '653100', '英吉沙县', null);
INSERT INTO `regions` VALUES ('3216', '653124', '653100', '泽普县', null);
INSERT INTO `regions` VALUES ('3217', '653125', '653100', '莎车县', null);
INSERT INTO `regions` VALUES ('3218', '653126', '653100', '叶城县', null);
INSERT INTO `regions` VALUES ('3219', '653127', '653100', '麦盖提县', null);
INSERT INTO `regions` VALUES ('3220', '653128', '653100', '岳普湖县', null);
INSERT INTO `regions` VALUES ('3221', '653129', '653100', '伽师县', null);
INSERT INTO `regions` VALUES ('3222', '653130', '653100', '巴楚县', null);
INSERT INTO `regions` VALUES ('3223', '653131', '653100', '塔什库尔干塔吉克自治县', null);
INSERT INTO `regions` VALUES ('3224', '653201', '653200', '和田市', null);
INSERT INTO `regions` VALUES ('3225', '653221', '653200', '和田县', null);
INSERT INTO `regions` VALUES ('3226', '653222', '653200', '墨玉县', null);
INSERT INTO `regions` VALUES ('3227', '653223', '653200', '皮山县', null);
INSERT INTO `regions` VALUES ('3228', '653224', '653200', '洛浦县', null);
INSERT INTO `regions` VALUES ('3229', '653225', '653200', '策勒县', null);
INSERT INTO `regions` VALUES ('3230', '653226', '653200', '于田县', null);
INSERT INTO `regions` VALUES ('3231', '653227', '653200', '民丰县', null);
INSERT INTO `regions` VALUES ('3232', '654002', '654000', '伊宁市', null);
INSERT INTO `regions` VALUES ('3233', '654003', '654000', '奎屯市', null);
INSERT INTO `regions` VALUES ('3234', '654004', '654000', '霍尔果斯市', null);
INSERT INTO `regions` VALUES ('3235', '654021', '654000', '伊宁县', null);
INSERT INTO `regions` VALUES ('3236', '654022', '654000', '察布查尔锡伯自治县', null);
INSERT INTO `regions` VALUES ('3237', '654023', '654000', '霍城县', null);
INSERT INTO `regions` VALUES ('3238', '654024', '654000', '巩留县', null);
INSERT INTO `regions` VALUES ('3239', '654025', '654000', '新源县', null);
INSERT INTO `regions` VALUES ('3240', '654026', '654000', '昭苏县', null);
INSERT INTO `regions` VALUES ('3241', '654027', '654000', '特克斯县', null);
INSERT INTO `regions` VALUES ('3242', '654028', '654000', '尼勒克县', null);
INSERT INTO `regions` VALUES ('3243', '654201', '654200', '塔城市', null);
INSERT INTO `regions` VALUES ('3244', '654202', '654200', '乌苏市', null);
INSERT INTO `regions` VALUES ('3245', '654221', '654200', '额敏县', null);
INSERT INTO `regions` VALUES ('3246', '654223', '654200', '沙湾县', null);
INSERT INTO `regions` VALUES ('3247', '654224', '654200', '托里县', null);
INSERT INTO `regions` VALUES ('3248', '654225', '654200', '裕民县', null);
INSERT INTO `regions` VALUES ('3249', '654226', '654200', '和布克赛尔蒙古自治县', null);
INSERT INTO `regions` VALUES ('3250', '654301', '654300', '阿勒泰市', null);
INSERT INTO `regions` VALUES ('3251', '654321', '654300', '布尔津县', null);
INSERT INTO `regions` VALUES ('3252', '654322', '654300', '富蕴县', null);
INSERT INTO `regions` VALUES ('3253', '654323', '654300', '福海县', null);
INSERT INTO `regions` VALUES ('3254', '654324', '654300', '哈巴河县', null);
INSERT INTO `regions` VALUES ('3255', '654325', '654300', '青河县', null);
INSERT INTO `regions` VALUES ('3256', '654326', '654300', '吉木乃县', null);
INSERT INTO `regions` VALUES ('3257', '659001', '659001', '石河子市', null);
INSERT INTO `regions` VALUES ('3258', '659002', '659002', '阿拉尔市', null);
INSERT INTO `regions` VALUES ('3259', '659003', '659003', '图木舒克市', null);
INSERT INTO `regions` VALUES ('3260', '659004', '659004', '五家渠市', null);
INSERT INTO `regions` VALUES ('3261', '659005', '659005', '北屯市', null);
INSERT INTO `regions` VALUES ('3262', '659006', '659006', '铁门关市', null);
INSERT INTO `regions` VALUES ('3263', '659007', '659007', '双河市', null);
INSERT INTO `regions` VALUES ('3264', '659008', '659008', '可克达拉市', null);
INSERT INTO `regions` VALUES ('3265', '659009', '659009', '昆玉市', null);
INSERT INTO `regions` VALUES ('3266', '810100', '810000', '香港城区', null);
INSERT INTO `regions` VALUES ('3267', '810101', '810100', '中西区', null);
INSERT INTO `regions` VALUES ('3268', '810102', '810100', '湾仔区', null);
INSERT INTO `regions` VALUES ('3269', '810103', '810100', '东区', null);
INSERT INTO `regions` VALUES ('3270', '810104', '810100', '南区', null);
INSERT INTO `regions` VALUES ('3271', '810105', '810100', '油尖旺区', null);
INSERT INTO `regions` VALUES ('3272', '810106', '810100', '深水埗区', null);
INSERT INTO `regions` VALUES ('3273', '810107', '810100', '九龙城区', null);
INSERT INTO `regions` VALUES ('3274', '810108', '810100', '黄大仙区', null);
INSERT INTO `regions` VALUES ('3275', '810109', '810100', '观塘区', null);
INSERT INTO `regions` VALUES ('3276', '810110', '810100', '荃湾区', null);
INSERT INTO `regions` VALUES ('3277', '810111', '810100', '屯门区', null);
INSERT INTO `regions` VALUES ('3278', '810112', '810100', '元朗区', null);
INSERT INTO `regions` VALUES ('3279', '810113', '810100', '北区', null);
INSERT INTO `regions` VALUES ('3280', '810114', '810100', '大埔区', null);
INSERT INTO `regions` VALUES ('3281', '810115', '810100', '西贡区', null);
INSERT INTO `regions` VALUES ('3282', '810116', '810100', '沙田区', null);
INSERT INTO `regions` VALUES ('3283', '810117', '810100', '葵青区', null);
INSERT INTO `regions` VALUES ('3284', '810118', '810100', '离岛区', null);
INSERT INTO `regions` VALUES ('3285', '820100', '820000', '澳门城区', null);
INSERT INTO `regions` VALUES ('3286', '820101', '820100', '花地玛堂区', null);
INSERT INTO `regions` VALUES ('3287', '820102', '820100', '花王堂区', null);
INSERT INTO `regions` VALUES ('3288', '820103', '820100', '望德堂区', null);
INSERT INTO `regions` VALUES ('3289', '820104', '820100', '大堂区', null);
INSERT INTO `regions` VALUES ('3290', '820105', '820100', '风顺堂区', null);
INSERT INTO `regions` VALUES ('3291', '820106', '820100', '嘉模堂区', null);
INSERT INTO `regions` VALUES ('3292', '820107', '820100', '路凼填海区', null);
INSERT INTO `regions` VALUES ('3293', '820108', '820100', '圣方济各堂区', null);
INSERT INTO `regions` VALUES ('3294', '710100', '710000', '台湾', null);
INSERT INTO `regions` VALUES ('3295', '710101', '710100', '金门县', null);
INSERT INTO `regions` VALUES ('3296', '710102', '710100', '连江县', null);
INSERT INTO `regions` VALUES ('3297', '710103', '710100', '苗栗县', null);
INSERT INTO `regions` VALUES ('3298', '710104', '710100', '南投县', null);
INSERT INTO `regions` VALUES ('3299', '710105', '710100', '澎湖县', null);
INSERT INTO `regions` VALUES ('3300', '710106', '710100', '屏东县', null);
INSERT INTO `regions` VALUES ('3301', '710107', '710100', '台东县', null);
INSERT INTO `regions` VALUES ('3302', '710108', '710100', '台中市', null);
INSERT INTO `regions` VALUES ('3303', '710109', '710100', '台南市', null);
INSERT INTO `regions` VALUES ('3304', '710110', '710100', '台北市', null);
INSERT INTO `regions` VALUES ('3305', '710111', '710100', '桃园市', null);
INSERT INTO `regions` VALUES ('3306', '710112', '710100', '云林县', null);
INSERT INTO `regions` VALUES ('3307', '710113', '710100', '新北市', null);
INSERT INTO `regions` VALUES ('3308', '710114', '710100', '新竹市', null);
INSERT INTO `regions` VALUES ('3309', '710115', '710100', '彰化县', null);
INSERT INTO `regions` VALUES ('3310', '710116', '710100', '嘉义县', null);
INSERT INTO `regions` VALUES ('3311', '710117', '710100', '新竹县', null);
INSERT INTO `regions` VALUES ('3312', '710118', '710100', '花莲县', null);
INSERT INTO `regions` VALUES ('3313', '710119', '710100', '宜兰县', null);
INSERT INTO `regions` VALUES ('3314', '710120', '710100', '高雄', null);
INSERT INTO `regions` VALUES ('3315', '710121', '710100', '基隆市', null);

-- ----------------------------
-- Table structure for `remarks`
-- ----------------------------
DROP TABLE IF EXISTS `remarks`;
CREATE TABLE `remarks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `plan_id` int(10) NOT NULL DEFAULT '0' COMMENT '计划id',
  `label_id` int(10) NOT NULL DEFAULT '0' COMMENT 'RFID标签id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注内容',
  `admin_name` varchar(100) NOT NULL DEFAULT '' COMMENT '备注人员',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '在职状态：0离职，1在职',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of remarks
-- ----------------------------

-- ----------------------------
-- Table structure for `role_admin`
-- ----------------------------
DROP TABLE IF EXISTS `role_admin`;
CREATE TABLE `role_admin` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `role_admin_role_id_foreign` (`role_id`) USING BTREE,
  CONSTRAINT `role_admin_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_admin_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of role_admin
-- ----------------------------
INSERT INTO `role_admin` VALUES ('1', '1');
INSERT INTO `role_admin` VALUES ('5', '4');

-- ----------------------------
-- Table structure for `roles`
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `roles_name_unique` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('1', 'SuperAdmin', '超级管理员', '拥有所有的权限', '2017-09-28 23:45:46', '2017-09-28 23:45:46');
INSERT INTO `roles` VALUES ('2', '人员信息管理', '人员管理', '管理人员信息资料', '2019-10-26 14:54:11', '2019-10-26 14:54:11');
INSERT INTO `roles` VALUES ('3', 'admin_sh', '常规管理员', '一般性管理权限', '2019-11-12 16:18:28', '2019-11-12 16:18:28');
INSERT INTO `roles` VALUES ('4', '一般管理员', '一般管理员', '一般管理员', '2019-11-12 16:37:54', '2019-11-12 16:37:54');

-- ----------------------------
-- Table structure for `system_config`
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `system_config_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of system_config
-- ----------------------------

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '等级名称',
  `region_id` int(10) NOT NULL DEFAULT '0' COMMENT '区域id',
  `company_id` int(10) NOT NULL DEFAULT '0' COMMENT '单位id',
  `number_id` int(10) NOT NULL DEFAULT '0' COMMENT '牌号id',
  `number` varchar(50) DEFAULT NULL COMMENT '证件编号',
  `vocation_id` int(10) NOT NULL DEFAULT '0',
  `sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别，0男，1女',
  `work_years` tinyint(3) NOT NULL DEFAULT '0' COMMENT '工龄',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态，0禁用，1正常',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------

-- ----------------------------
-- Table structure for `vocation`
-- ----------------------------
DROP TABLE IF EXISTS `vocation`;
CREATE TABLE `vocation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '名称',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态，0禁用，1正常',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vocation
-- ----------------------------
