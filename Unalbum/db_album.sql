/*
SQLyog Ultimate v12.5.0 (64 bit)
MySQL - 5.7.21-log : Database - db_album
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_album` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db_album`;

/*Table structure for table `td_gallery` */

DROP TABLE IF EXISTS `td_gallery`;

CREATE TABLE `td_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户相册ID',
  `galleryName` varchar(255) DEFAULT NULL COMMENT '相册名称',
  `user` int(11) DEFAULT NULL COMMENT '相册所属用户',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `pagePicture` int(11) DEFAULT NULL COMMENT '封面图片',
  `isShare` tinyint(1) DEFAULT NULL COMMENT '相册是否分享',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `td_gallery` */

insert  into `td_gallery`(`id`,`galleryName`,`user`,`createDate`,`pagePicture`,`isShare`) values 
(1,'默认相册',1,'2018-03-23 16:52:40',44,1),
(2,'ta的收藏',1,'2018-03-23 16:53:31',8,1),
(3,'相册一',1,'2018-03-26 13:01:08',42,1),
(4,'默认相册',2,'2018-03-26 13:02:23',1,1),
(5,'ta的收藏',2,'2018-03-26 13:02:36',1,1),
(6,'相册二',1,'2018-03-26 18:04:29',44,1),
(8,'相册三',1,'2018-03-27 13:44:38',1,1),
(9,'默认相册',3,'2018-03-27 14:49:20',47,1),
(10,'ta的收藏',3,'2018-03-27 14:49:20',1,1);

/*Table structure for table `td_gallery_picture` */

DROP TABLE IF EXISTS `td_gallery_picture`;

CREATE TABLE `td_gallery_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '相册图片表ID',
  `gallery` int(11) DEFAULT NULL COMMENT '相册表ID',
  `pictureId` int(11) DEFAULT NULL COMMENT '相册包含图片ID',
  `createDate` date DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

/*Data for the table `td_gallery_picture` */

insert  into `td_gallery_picture`(`id`,`gallery`,`pictureId`,`createDate`) values 
(1,1,45,'2018-03-23'),
(2,1,46,'2018-03-23'),
(3,1,3,'2018-03-23'),
(4,1,4,'2018-03-23'),
(5,1,5,'2018-03-23'),
(6,1,6,'2018-03-23'),
(7,1,7,'2018-03-23'),
(8,1,8,'2018-03-23'),
(9,1,9,'2018-03-23'),
(10,1,10,'2018-03-23'),
(11,1,11,'2018-03-23'),
(12,1,12,'2018-03-23'),
(13,1,13,'2018-03-23'),
(14,1,14,'2018-03-23'),
(15,1,15,'2018-03-23'),
(16,1,16,'2018-03-23'),
(17,1,17,'2018-03-23'),
(19,1,19,'2018-03-23'),
(20,1,20,'2018-03-23'),
(21,1,21,'2018-03-23'),
(22,1,22,'2018-03-23'),
(23,1,23,'2018-03-23'),
(24,1,24,'2018-03-23'),
(25,1,25,'2018-03-23'),
(26,1,26,'2018-03-23'),
(27,1,27,'2018-03-23'),
(28,1,28,'2018-03-23'),
(29,1,29,'2018-03-23'),
(30,1,30,'2018-03-23'),
(31,1,37,'2018-03-23'),
(32,1,38,'2018-03-23'),
(33,1,39,'2018-03-23'),
(34,2,16,'2018-03-25'),
(35,2,40,'2018-03-25'),
(36,1,43,'2018-03-25'),
(37,2,8,'2018-03-26'),
(38,3,42,'2018-03-26'),
(39,3,43,'2018-03-26'),
(40,3,40,'2018-03-26'),
(41,1,44,'2018-03-26'),
(43,6,44,'2018-03-26'),
(46,9,47,'2018-03-27');

/*Table structure for table `td_picture` */

DROP TABLE IF EXISTS `td_picture`;

CREATE TABLE `td_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图片ID',
  `picName` varchar(20) DEFAULT NULL COMMENT '图片名称',
  `picCategory` int(11) DEFAULT NULL COMMENT '图片分类ID',
  `picURL` varchar(100) DEFAULT NULL COMMENT '图片URL',
  `createDate` datetime DEFAULT NULL COMMENT '图片上传时间',
  `picLikes` int(11) DEFAULT NULL COMMENT '图片收获喜欢数',
  `picCollection` int(11) DEFAULT NULL COMMENT '图片收获收藏数',
  `user` int(11) DEFAULT NULL COMMENT '图片上传用户',
  `picProfile` varchar(250) DEFAULT NULL COMMENT '图片简介',
  `isShare` tinyint(1) DEFAULT NULL COMMENT '图片是否分享',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

/*Data for the table `td_picture` */

insert  into `td_picture`(`id`,`picName`,`picCategory`,`picURL`,`createDate`,`picLikes`,`picCollection`,`user`,`picProfile`,`isShare`) values 
(1,'默认相册封面',0,NULL,'2018-03-27 11:38:49',0,0,0,'这是一个默认相册封面图片',0),
(2,'用户默认头像',0,'img/user-default-photo.jpg','2018-03-27 14:55:30',NULL,NULL,NULL,NULL,0),
(3,'third',2,'picture/user/people1.jpg','2018-03-18 08:42:08',3,0,1,'人物11111111',1),
(4,'forth',3,'picture/user/nature1.jpg','2018-03-18 08:42:50',0,0,1,'自然111111111',1),
(5,'fifth',4,'picture/user/traffic1.jpg','2018-03-19 08:43:59',4,0,1,NULL,1),
(6,'sixth',5,'picture/user/building1.jpg','2018-03-19 08:44:31',0,0,1,NULL,1),
(7,'seventh',6,'picture/user/travel1.jpg','2018-03-18 20:35:31',0,0,1,'旅行',1),
(8,'eighth',7,'picture/user/sign1.jpg','2018-03-19 08:44:34',0,1,1,NULL,1),
(9,'ninth',8,'picture/user/city1.jpg','2018-03-19 08:44:36',0,0,1,NULL,1),
(10,'tenth',9,'picture/user/food1.jpg','2018-03-19 08:44:37',0,0,1,NULL,1),
(11,'eleventh',1,'picture/user/landscape3.jpg','2018-03-19 13:04:31',7,0,1,'风景33333',1),
(12,'1',1,'picture/user/landscape4.jpg','2018-03-19 15:33:47',0,0,1,'风景44444',1),
(13,'2',1,'picture/user/landscape5.jpg','2018-03-19 15:34:03',0,0,1,'风景5555555',1),
(14,'3',1,'picture/user/landscape6.jpg','2018-03-19 15:35:08',0,0,1,'风景666666666',1),
(15,'4',1,'picture/user/landscape7.jpg','2018-03-19 15:35:10',3,0,1,'风景7777777777',1),
(16,'5',1,'picture/user/landscape8.jpg','2018-03-19 15:35:12',4,1,1,'风景888888',1),
(17,'6',1,'picture/user/landscape9.jpg','2018-03-19 15:35:13',2,0,1,'风景9999999999',1),
(19,'7',1,'picture/user/landscape10.jpg','2018-03-19 15:35:15',0,0,1,'风景100101010',1),
(20,'8',1,'picture/user/landscape11.jpg','2018-03-19 15:35:16',0,0,1,'风景11111111',1),
(21,'9',1,'picture/user/landscape12.jpg','2018-03-19 17:21:01',2,0,1,'风景12121212',1),
(22,'10',1,'picture/user/landscape13.jpg','2018-03-19 17:21:03',1,0,1,'风景13131313',1),
(23,'11',1,'picture/user/landscape14.jpg','2018-03-19 17:21:07',0,0,1,NULL,1),
(24,'12',1,'picture/user/landscape15.jpg','2018-03-19 17:21:04',0,0,1,NULL,1),
(25,'13',1,'picture/user/landscape16.jpg','2018-03-19 17:21:09',0,0,1,NULL,1),
(26,'14',1,'picture/user/landscape17.jpg','2018-03-19 17:21:13',0,0,1,NULL,1),
(27,'15',1,'picture/user/landscape18.jpg','2018-03-19 17:21:15',0,0,1,NULL,1),
(28,'16',1,'picture/user/landscape19.jpg','2018-03-19 17:21:17',0,0,1,NULL,1),
(29,'17',1,'picture/user/landscape20.jpg','2018-03-19 17:21:18',0,0,1,NULL,1),
(30,'18',1,'picture/user/landscape21.jpg','2018-03-19 17:21:20',0,0,1,NULL,1),
(37,'file',1,'picture/user/af81f57eae6244c28498a1215907d71f.jpeg','2018-03-21 14:06:58',0,0,1,'',1),
(38,'file',2,'picture/user/59bcd6ebafea408db55e2d12a6745f45.jpeg','2018-03-21 14:09:52',0,0,1,'',1),
(39,'人物',2,'picture/user/50af54fbe017445abb4b6b4b95288caf.jpeg','2018-03-21 14:17:08',1,0,1,'',1),
(40,'花语花',1,'picture/number2/landscape22.jpg','2018-03-25 17:36:02',0,1,2,NULL,1),
(41,'花花花',1,'picture/user/5aff5de920a94f6ba3b725cf7fe5d96e.jpeg','2018-03-25 23:06:56',0,0,1,'',1),
(42,'落日长空',1,'picture/user/cbf5b63420a547d9b2f11c9629c7fa0f.jpeg','2018-03-25 23:18:04',0,0,1,'',1),
(43,'俯瞰夜城',1,'picture/user/1eaacc1c624647f4a3511c4c28717689.jpeg','2018-03-25 23:34:29',0,0,1,'',1),
(44,'向下望',8,'picture/user/582c9529b482419f82a1a2a4dded93bc.jpeg','2018-03-26 14:52:18',0,0,1,'',1),
(45,'first',1,'picture/user/landscape2.jpg','2018-03-18 20:35:31',17,0,1,'风景2222',1),
(46,'second',1,'picture/user/landscape1.jpg','2018-03-18 08:34:08',3,0,1,'风景1111111',1),
(47,'精致食物',9,'picture/mwh/e77f12796aca4941b52de17e2571a88b.jpeg','2018-03-27 15:52:13',0,0,3,'Ice cream Yumie.',1);

/*Table structure for table `td_picture_category` */

DROP TABLE IF EXISTS `td_picture_category`;

CREATE TABLE `td_picture_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图片分类ID',
  `categoryName` varchar(20) DEFAULT NULL COMMENT '图片分类名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `td_picture_category` */

insert  into `td_picture_category`(`id`,`categoryName`) values 
(1,'风景'),
(2,'人物'),
(3,'自然'),
(4,'交通'),
(5,'建筑'),
(6,'旅行'),
(7,'标志'),
(8,'城市'),
(9,'食物');

/*Table structure for table `td_picture_tag` */

DROP TABLE IF EXISTS `td_picture_tag`;

CREATE TABLE `td_picture_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签图片表ID',
  `tagId` int(11) DEFAULT NULL COMMENT '标签ID',
  `pictureId` int(11) DEFAULT NULL COMMENT '图片ID',
  `createDate` date DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `td_picture_tag` */

insert  into `td_picture_tag`(`id`,`tagId`,`pictureId`,`createDate`) values 
(1,2,7,'2018-03-21'),
(2,1,7,'2018-03-21'),
(3,3,22,'2018-03-22'),
(4,3,26,'2018-03-22'),
(5,9,5,'2018-03-23'),
(6,11,7,'2018-03-23'),
(7,12,5,'2018-03-23'),
(8,13,5,'2018-03-23'),
(9,14,8,'2018-03-23'),
(10,15,8,'2018-03-23'),
(11,16,44,'2018-03-26'),
(12,16,47,'2018-03-27');

/*Table structure for table `td_role` */

DROP TABLE IF EXISTS `td_role`;

CREATE TABLE `td_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `roleName` varchar(255) DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `td_role` */

insert  into `td_role`(`id`,`roleName`) values 
(1,'管理员'),
(2,'用户');

/*Table structure for table `td_tag` */

DROP TABLE IF EXISTS `td_tag`;

CREATE TABLE `td_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `tagName` varchar(255) DEFAULT NULL COMMENT '标签名',
  `user` int(11) DEFAULT NULL COMMENT '创建标签用户ID',
  `createDate` date DEFAULT NULL COMMENT '标签创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `td_tag` */

insert  into `td_tag`(`id`,`tagName`,`user`,`createDate`) values 
(1,'人',1,'2018-03-21'),
(2,'山峰',1,'2018-03-21'),
(3,'花',1,'2018-03-22'),
(9,'车辆',1,NULL),
(11,'白云',1,NULL),
(12,'道路',1,NULL),
(13,'黑白',1,NULL),
(14,'breathe',1,NULL),
(15,'绿叶',1,NULL),
(16,'',1,NULL);

/*Table structure for table `td_user` */

DROP TABLE IF EXISTS `td_user`;

CREATE TABLE `td_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `userName` varchar(20) DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) DEFAULT NULL COMMENT '用户密码',
  `createDate` datetime DEFAULT NULL COMMENT '用户注册日期',
  `photo` varchar(100) DEFAULT NULL COMMENT '用户头像',
  `userProfile` varchar(250) DEFAULT NULL COMMENT '用户个人简介',
  `userInterests` varchar(50) DEFAULT NULL COMMENT '用户爱好',
  `role` int(11) DEFAULT NULL COMMENT '用户角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `td_user` */

insert  into `td_user`(`id`,`userName`,`password`,`createDate`,`photo`,`userProfile`,`userInterests`,`role`) values 
(1,'user','123456','2018-03-13 23:04:14','personIcon/5999f1158a6f4ecdab5d146fb88e67c6.jpeg','测试一条个人简介','城市 标志 建筑',2),
(2,'number2','123456','2018-03-25 17:32:46','personIcon/5999f1158a6f4ecdab5d146fb88e67c6.jpeg',NULL,NULL,2),
(3,'mwh','123456','2018-03-27 14:49:07','img/user-default-photo.jpg','','',2);

/*Table structure for table `td_user_like_collection` */

DROP TABLE IF EXISTS `td_user_like_collection`;

CREATE TABLE `td_user_like_collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '喜欢收藏表id',
  `user` int(11) DEFAULT NULL COMMENT '用户ID',
  `picture` int(11) DEFAULT NULL COMMENT '图片ID',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `isLike` tinyint(1) DEFAULT NULL COMMENT '是否喜欢',
  `isCollection` tinyint(1) DEFAULT NULL COMMENT '是否收藏',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `td_user_like_collection` */

insert  into `td_user_like_collection`(`id`,`user`,`picture`,`createDate`,`isLike`,`isCollection`) values 
(16,1,1,'2018-03-20 16:57:04',1,0),
(17,1,21,'2018-03-20 17:00:51',1,0),
(18,1,11,'2018-03-20 23:46:37',1,0),
(19,1,13,'2018-03-20 23:52:29',0,0),
(20,1,16,'2018-03-21 11:31:55',1,1),
(21,1,39,'2018-03-21 14:21:18',1,0),
(22,1,40,'2018-03-25 17:36:25',0,1),
(23,1,8,'2018-03-25 23:59:55',0,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
