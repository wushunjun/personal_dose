/*
 Navicat Premium Data Transfer

 Source Server         : laradock_mysql
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : localhost:3306
 Source Schema         : nt_admin_framework

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 11/06/2019 16:13:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nickname` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `signature` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '个性签名',
  `email` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录地区',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录IP',
  `headimgurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户头像',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `admins_name_unique` (`name`) USING BTREE,
  UNIQUE KEY `admins_email_unique` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admins
-- ----------------------------
BEGIN;
INSERT INTO `admins` VALUES (1, 'admin', 'admin', '我是超级管理员', '616877020@qq.com', '$2y$10$dIp9wyKf1X89deHJgLvzJ.c0XATIz1769hq/cY.bvQFsoQ0S/DwGC', 'n9thjqpIMTN9rxzFBzENvCq6HfidcNP322qYPnTnLI1mKfq9ktRzB8O7LWBO', 'XX内网IP内网IP・内网IP', '192.168.48.1', 'admin/YzwMq1kdnjOBfqW3kNgMLrl2EJfSHL74SrSTWKsl.jpeg', '2018-08-10 21:18:05', '2019-05-30 17:20:39');
COMMIT;

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '资源名称',
  `link` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '资源链接',
  `permission` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '资源权限',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父级资源ID',
  `icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '资源图标',
  `sort` smallint(3) unsigned DEFAULT '0' COMMENT '排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `menus_name_unique` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of menus
-- ----------------------------
BEGIN;
INSERT INTO `menus` VALUES (10, '仪表盘', '-', '-', 0, 'fa-dashboard', 20, '2017-10-10 22:04:03', '2018-08-18 23:10:04');
INSERT INTO `menus` VALUES (11, '权限管理', '-', '-', 0, 'fa-key', 19, '2017-10-10 22:05:12', '2018-08-18 23:17:20');
INSERT INTO `menus` VALUES (12, '系统首页', 'index/index', 'index.index', 10, '-', 0, '2017-10-10 22:06:56', '2017-10-10 22:08:34');
INSERT INTO `menus` VALUES (14, '管理员列表', 'admin/index', 'admin.index', 11, '-', 0, '2017-10-10 22:09:33', '2017-10-10 22:09:33');
INSERT INTO `menus` VALUES (15, '角色列表', 'role/index', 'role.index', 11, '-', 0, '2017-10-10 22:10:08', '2017-10-10 22:10:08');
INSERT INTO `menus` VALUES (16, '权限列表', 'permission/index', 'permission.index', 11, '-', 0, '2017-10-10 22:10:44', '2017-10-10 22:10:44');
INSERT INTO `menus` VALUES (17, '资源列表', 'menu/index', 'menu.index', 11, '-', 0, '2017-10-10 22:14:32', '2017-10-10 22:14:32');
INSERT INTO `menus` VALUES (19, '日志管理', '-', '-', 0, 'fa-file', 0, '2017-10-10 22:28:56', '2017-10-10 22:28:56');
INSERT INTO `menus` VALUES (34, '登录日志', 'log/index', 'log.index', 19, '-', 0, '2017-10-26 13:45:04', '2017-10-26 13:52:17');
COMMIT;

-- ----------------------------
-- Table structure for permission_role
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
BEGIN;
INSERT INTO `permission_role` VALUES (1, 1);
INSERT INTO `permission_role` VALUES (2, 1);
INSERT INTO `permission_role` VALUES (4, 1);
INSERT INTO `permission_role` VALUES (6, 1);
INSERT INTO `permission_role` VALUES (7, 1);
INSERT INTO `permission_role` VALUES (8, 1);
INSERT INTO `permission_role` VALUES (9, 1);
INSERT INTO `permission_role` VALUES (11, 1);
INSERT INTO `permission_role` VALUES (13, 1);
INSERT INTO `permission_role` VALUES (14, 1);
INSERT INTO `permission_role` VALUES (15, 1);
INSERT INTO `permission_role` VALUES (16, 1);
INSERT INTO `permission_role` VALUES (18, 1);
INSERT INTO `permission_role` VALUES (20, 1);
INSERT INTO `permission_role` VALUES (22, 1);
INSERT INTO `permission_role` VALUES (23, 1);
INSERT INTO `permission_role` VALUES (24, 1);
INSERT INTO `permission_role` VALUES (26, 1);
INSERT INTO `permission_role` VALUES (28, 1);
INSERT INTO `permission_role` VALUES (29, 1);
INSERT INTO `permission_role` VALUES (30, 1);
INSERT INTO `permission_role` VALUES (31, 1);
INSERT INTO `permission_role` VALUES (38, 1);
INSERT INTO `permission_role` VALUES (60, 1);
INSERT INTO `permission_role` VALUES (66, 1);
INSERT INTO `permission_role` VALUES (67, 1);
INSERT INTO `permission_role` VALUES (83, 1);
INSERT INTO `permission_role` VALUES (84, 1);
COMMIT;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `permissions_name_unique` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=441 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of permissions
-- ----------------------------
BEGIN;
INSERT INTO `permissions` VALUES (1, 'index.index', '后台首页', '后台起始页包含统计信息', '2017-09-21 23:51:17', '2017-09-21 23:51:17');
INSERT INTO `permissions` VALUES (2, 'admin.index', '管理员列表', '展示管理员列表信息', '2017-09-21 23:52:53', '2017-09-21 23:52:53');
INSERT INTO `permissions` VALUES (4, 'admin.store', '添加管理员', '添加管理员', '2017-09-21 23:54:56', '2019-03-11 17:51:08');
INSERT INTO `permissions` VALUES (6, 'admin.edit', '编辑管理员', '编辑管理员', '2017-09-22 00:06:01', '2017-09-22 00:06:01');
INSERT INTO `permissions` VALUES (7, 'admin.update', '更新管理员', '更新管理员', '2017-09-22 00:06:22', '2017-09-22 00:06:22');
INSERT INTO `permissions` VALUES (8, 'admin.destroy', '删除管理员', '删除管理员', '2017-09-22 00:06:47', '2017-09-22 00:06:47');
INSERT INTO `permissions` VALUES (9, 'permission.index', '权限列表', '权限列表', '2017-09-22 00:08:15', '2017-09-22 00:08:15');
INSERT INTO `permissions` VALUES (11, 'permission.store', '添加权限', '添加权限', '2017-09-22 00:10:09', '2017-09-22 00:10:09');
INSERT INTO `permissions` VALUES (13, 'permission.edit', '编辑权限', '编辑权限', '2017-09-22 00:11:17', '2017-09-22 00:11:17');
INSERT INTO `permissions` VALUES (14, 'permission.update', '更新权限', '更新权限', '2017-09-22 00:11:36', '2017-09-22 00:11:36');
INSERT INTO `permissions` VALUES (15, 'permission.destroy', '删除权限', '删除权限', '2017-09-22 00:12:23', '2017-09-22 00:12:23');
INSERT INTO `permissions` VALUES (16, 'role.index', '角色列表', '角色列表', '2017-09-22 00:16:10', '2017-09-22 00:16:10');
INSERT INTO `permissions` VALUES (18, 'role.store', '添加角色', '添加角色', '2017-09-22 00:17:11', '2017-09-22 00:17:11');
INSERT INTO `permissions` VALUES (20, 'role.edit', '编辑权限', '编辑权限', '2017-09-22 00:18:04', '2017-09-22 00:18:04');
INSERT INTO `permissions` VALUES (22, 'role.update', '更新角色', '更新角色', '2017-09-22 00:19:13', '2017-09-22 00:19:13');
INSERT INTO `permissions` VALUES (23, 'role.destroy', '删除角色', '删除角色', '2017-09-22 00:19:45', '2017-09-22 00:19:45');
INSERT INTO `permissions` VALUES (24, 'menu.index', '资源列表', '资源列表', '2017-09-22 00:22:25', '2017-09-22 00:22:25');
INSERT INTO `permissions` VALUES (26, 'menu.store', '添加资源', '添加资源', '2017-09-22 00:23:52', '2017-09-22 00:23:52');
INSERT INTO `permissions` VALUES (28, 'menu.edit', '编辑资源', '编辑资源', '2017-09-22 00:24:55', '2017-09-22 00:24:55');
INSERT INTO `permissions` VALUES (29, 'menu.update', '更新资源', '更新资源', '2017-09-22 00:26:06', '2017-09-22 00:26:06');
INSERT INTO `permissions` VALUES (30, 'menu.destroy', '删除资源', '删除资源', '2017-09-22 00:26:42', '2017-09-22 00:26:42');
INSERT INTO `permissions` VALUES (31, 'system.index', '系统设置', '系统设置', '2017-09-22 00:29:52', '2017-10-11 10:20:43');
INSERT INTO `permissions` VALUES (38, 'system.update', '更新系统设置', '更新系统设置', '2017-10-26 13:56:46', '2017-10-26 13:56:46');
INSERT INTO `permissions` VALUES (60, 'index.flush', '清除缓存', '清除缓存', '2017-10-26 15:44:23', '2017-10-26 15:44:23');
INSERT INTO `permissions` VALUES (66, 'log.index', '登录日志列表', '登录日志列表', '2017-10-26 15:47:19', '2017-10-26 15:47:19');
INSERT INTO `permissions` VALUES (67, 'log.destroy', '删除登录日志', '删除登录日志', '2017-10-26 15:47:47', '2017-10-26 15:47:47');
INSERT INTO `permissions` VALUES (83, 'index.profile', '个人设置', '个人设置', '2017-11-02 22:33:08', '2017-11-02 22:33:08');
INSERT INTO `permissions` VALUES (84, 'index.update_profile', '更新个人设置', '更新个人设置', '2017-11-02 22:33:34', '2017-11-02 22:33:34');
COMMIT;

-- ----------------------------
-- Table structure for role_admin
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
BEGIN;
INSERT INTO `role_admin` VALUES (1, 1);
COMMIT;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `roles_name_unique` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO `roles` VALUES (1, 'SuperAdmin', '超级管理员', '拥有所有的权限', '2017-09-28 23:45:46', '2017-09-28 23:45:46');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
