/*
 Navicat Premium Data Transfer

 Source Server         : qcloud_cdb-nnvepkcg.bj.tencentcdb.com
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : cdb-nnvepkcg.bj.tencentcdb.com:10196
 Source Schema         : qqmz

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 16/04/2020 15:55:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for task_qrlogin
-- ----------------------------
DROP TABLE IF EXISTS `task_qrlogin`;
CREATE TABLE `task_qrlogin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qq` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `qrsig` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_time` datetime(0) DEFAULT NULL,
  `update_time` datetime(0) DEFAULT NULL,
  `state` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0',
  `group_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `img_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for usersqq
-- ----------------------------
DROP TABLE IF EXISTS `usersqq`;
CREATE TABLE `usersqq`  (
  `uin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ptuiCB` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sid` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `skey` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `pskey` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `superkey` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `nickname` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `base64p` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `alive` int(3) DEFAULT 1,
  `user_account` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_time` datetime(0) DEFAULT NULL,
  `update_time` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`uin`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
