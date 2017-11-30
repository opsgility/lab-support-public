-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: osticket
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ost__search`
--

DROP TABLE IF EXISTS `ost__search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost__search` (
  `object_type` varchar(8) NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `title` text,
  `content` text,
  PRIMARY KEY (`object_type`,`object_id`),
  FULLTEXT KEY `search` (`title`,`content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost__search`
--

LOCK TABLES `ost__search` WRITE;
/*!40000 ALTER TABLE `ost__search` DISABLE KEYS */;
INSERT INTO `ost__search` VALUES ('H',1,'','User reports issue with their Laptop. Need to scan for malware and update to new anti-virus software.'),('H',2,'','Hi Carola, Your ticket #519418 created on 11/29/2017 05:59:23 PM is in Maintenance department.'),('H',3,'','Customer wants to be added to the CRM tool since they are a new user and on the sales team.'),('H',4,'','Hi Dino, Your ticket #631597 created on 11/29/2017 06:01:40 PM is in Sales department.'),('H',5,'','Customer needs access to the Support Services File Share.'),('H',6,'','Hi Lyn, Your ticket #190563 created on 11/29/2017 06:03:26 PM is in Support department.'),('H',7,'','Customer walked into Helpdesk area and mentioned that the large copier on the first floor of Building 11 is not working properly.'),('H',8,'','Hi Meridith, Your ticket #727678 created on 11/29/2017 06:04:51 PM is in Maintenance department.'),('H',9,'','All Servers on the Website will be updated to the latest patch leve.'),('H',10,'','My manager advised me to contact the helpdesk to get a new laptop. My current computer is to old and slow to use anymore. Can I get a Microsoft Surface? Thanks, Hailey'),('O',1,'osTicket','420 Desoto Street Alexandria, LA 71301\n(318) 290-3674\nhttp://osticket.com\nNot only do we develop the software, we also use it to manage support for osTicket. Let us help you quickly implement and leverage the full potential of osTicket\'s features and functionality. Contact us for professional support or visit our website for documentation and community support.'),('O',2,'Contoso','One Contoso Way Redmond, WA 98058\n(425) 555-1212\nwww.contoso.com\nThis is our Biggest customer!'),('T',1,'528511',''),('T',2,'519418 Issue with Laptop','Issue with Laptop'),('T',3,'631597 CRM','CRM'),('T',4,'190563 Need access to Support File Share','Need access to Support File Share'),('T',5,'727678 Printer Issue in Build 11','Printer Issue in Build 11'),('T',6,'895037 New Laptop','New Laptop'),('U',1,'osTicket Support','support@osticket.com'),('U',2,'Bill Jones',' bjones@contoso.com'),('U',3,'Jamal Kazmierczak',' jkaz@contoso.com\njkaz@contoso.com'),('U',4,'Carola Wagoner',' cwag@contoso.com\ncwag@contoso.com'),('U',5,'Dino Aschenbrenner',' dasc@contoso.com\ndasc@contoso.com'),('U',6,'Lyn Jumper',' ljum@contoso.com\nljum@contoso.com'),('U',7,'Shayne Galbraith',' sgal@contoso.com\nsgal@contoso.com'),('U',8,'Meridith Downey',' mdow@contoso.com\nmdow@contoso.com'),('U',9,'Junko Chong',' jcho@contoso.com\njcho@contoso.com'),('U',10,'Van Borgeson',' vbor@contoso.com\nvbor@contoso.com'),('U',11,'Hailey Laber',' hlab@contoso.com\nhlab@contoso.com');
/*!40000 ALTER TABLE `ost__search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_api_key`
--

DROP TABLE IF EXISTS `ost_api_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_api_key` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) NOT NULL DEFAULT '1',
  `ipaddr` varchar(64) NOT NULL,
  `apikey` varchar(255) NOT NULL,
  `can_create_tickets` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `can_exec_cron` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `notes` text,
  `updated` datetime NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `apikey` (`apikey`),
  KEY `ipaddr` (`ipaddr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_api_key`
--

LOCK TABLES `ost_api_key` WRITE;
/*!40000 ALTER TABLE `ost_api_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_api_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_attachment`
--

DROP TABLE IF EXISTS `ost_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) unsigned NOT NULL,
  `type` char(1) NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `inline` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `lang` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `file-type` (`object_id`,`file_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_attachment`
--

LOCK TABLES `ost_attachment` WRITE;
/*!40000 ALTER TABLE `ost_attachment` DISABLE KEYS */;
INSERT INTO `ost_attachment` VALUES (1,1,'C',2,NULL,0,NULL),(2,8,'T',1,NULL,1,NULL),(3,9,'T',1,NULL,1,NULL),(4,10,'T',1,NULL,1,NULL),(5,11,'T',1,NULL,1,NULL),(6,12,'T',1,NULL,1,NULL),(7,13,'T',1,NULL,1,NULL),(8,14,'T',1,NULL,1,NULL),(9,16,'T',1,NULL,1,NULL),(10,17,'T',1,NULL,1,NULL),(11,18,'T',1,NULL,1,NULL),(12,19,'T',1,NULL,1,NULL);
/*!40000 ALTER TABLE `ost_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_canned_response`
--

DROP TABLE IF EXISTS `ost_canned_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_canned_response` (
  `canned_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `isenabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `title` varchar(255) NOT NULL DEFAULT '',
  `response` text NOT NULL,
  `lang` varchar(16) NOT NULL DEFAULT 'en_US',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`canned_id`),
  UNIQUE KEY `title` (`title`),
  KEY `dept_id` (`dept_id`),
  KEY `active` (`isenabled`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_canned_response`
--

LOCK TABLES `ost_canned_response` WRITE;
/*!40000 ALTER TABLE `ost_canned_response` DISABLE KEYS */;
INSERT INTO `ost_canned_response` VALUES (1,0,1,'What is osTicket (sample)?','osTicket is a widely-used open source support ticket system, an\nattractive alternative to higher-cost and complex customer support\nsystems - simple, lightweight, reliable, open source, web-based and easy\nto setup and use.','en_US',NULL,'2017-11-29 22:48:51','2017-11-29 22:48:51'),(2,0,1,'Sample (with variables)','Hi %{ticket.name.first},\n<br>\n<br>\nYour ticket #%{ticket.number} created on %{ticket.create_date} is in\n%{ticket.dept.name} department.','en_US',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52');
/*!40000 ALTER TABLE `ost_canned_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_config`
--

DROP TABLE IF EXISTS `ost_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `namespace` varchar(64) NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` text NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `namespace` (`namespace`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_config`
--

LOCK TABLES `ost_config` WRITE;
/*!40000 ALTER TABLE `ost_config` DISABLE KEYS */;
INSERT INTO `ost_config` VALUES (1,'core','admin_email','demouser@opsgility.com','2017-11-29 22:48:54'),(2,'core','helpdesk_url','http://52.173.78.193/','2017-11-29 22:48:54'),(3,'core','helpdesk_title','Microsoft Cloud Workshop','2017-11-29 22:48:54'),(4,'core','schema_signature','98ad7d550c26ac44340350912296e673','2017-11-29 22:48:54'),(5,'core','time_format','hh:mm a','2017-11-29 22:48:49'),(6,'core','date_format','MM/dd/y','2017-11-29 22:48:49'),(7,'core','datetime_format','MM/dd/y h:mm a','2017-11-29 22:48:49'),(8,'core','daydatetime_format','EEE, MMM d y h:mm a','2017-11-29 22:48:49'),(9,'core','default_priority_id','2','2017-11-29 22:48:49'),(10,'core','enable_daylight_saving','','2017-11-29 22:48:49'),(11,'core','reply_separator','-- reply above this line --','2017-11-29 22:48:49'),(12,'core','isonline','1','2017-11-29 22:48:49'),(13,'core','staff_ip_binding','','2017-11-29 22:48:49'),(14,'core','staff_max_logins','4','2017-11-29 22:48:49'),(15,'core','staff_login_timeout','2','2017-11-29 22:48:49'),(16,'core','staff_session_timeout','30','2017-11-29 22:48:49'),(17,'core','passwd_reset_period','','2017-11-29 22:48:49'),(18,'core','client_max_logins','4','2017-11-29 22:48:49'),(19,'core','client_login_timeout','2','2017-11-29 22:48:50'),(20,'core','client_session_timeout','30','2017-11-29 22:48:50'),(21,'core','max_page_size','25','2017-11-29 22:48:50'),(22,'core','max_open_tickets','','2017-11-29 22:48:50'),(23,'core','autolock_minutes','3','2017-11-29 22:48:50'),(24,'core','default_smtp_id','','2017-11-29 22:48:50'),(25,'core','use_email_priority','','2017-11-29 22:48:50'),(26,'core','enable_kb','','2017-11-29 22:48:50'),(27,'core','enable_premade','1','2017-11-29 22:48:50'),(28,'core','enable_captcha','','2017-11-29 22:48:50'),(29,'core','enable_auto_cron','','2017-11-29 22:48:50'),(30,'core','enable_mail_polling','','2017-11-29 22:48:50'),(31,'core','send_sys_errors','1','2017-11-29 22:48:50'),(32,'core','send_sql_errors','1','2017-11-29 22:48:50'),(33,'core','send_login_errors','1','2017-11-29 22:48:50'),(34,'core','save_email_headers','1','2017-11-29 22:48:50'),(35,'core','strip_quoted_reply','1','2017-11-29 22:48:50'),(36,'core','ticket_autoresponder','','2017-11-29 22:48:50'),(37,'core','message_autoresponder','','2017-11-29 22:48:50'),(38,'core','ticket_notice_active','1','2017-11-29 22:48:50'),(39,'core','ticket_alert_active','1','2017-11-29 22:48:50'),(40,'core','ticket_alert_admin','1','2017-11-29 22:48:50'),(41,'core','ticket_alert_dept_manager','1','2017-11-29 22:48:50'),(42,'core','ticket_alert_dept_members','','2017-11-29 22:48:50'),(43,'core','message_alert_active','1','2017-11-29 22:48:50'),(44,'core','message_alert_laststaff','1','2017-11-29 22:48:50'),(45,'core','message_alert_assigned','1','2017-11-29 22:48:50'),(46,'core','message_alert_dept_manager','','2017-11-29 22:48:50'),(47,'core','note_alert_active','','2017-11-29 22:48:50'),(48,'core','note_alert_laststaff','1','2017-11-29 22:48:50'),(49,'core','note_alert_assigned','1','2017-11-29 22:48:50'),(50,'core','note_alert_dept_manager','','2017-11-29 22:48:50'),(51,'core','transfer_alert_active','','2017-11-29 22:48:50'),(52,'core','transfer_alert_assigned','','2017-11-29 22:48:50'),(53,'core','transfer_alert_dept_manager','1','2017-11-29 22:48:50'),(54,'core','transfer_alert_dept_members','','2017-11-29 22:48:50'),(55,'core','overdue_alert_active','1','2017-11-29 22:48:50'),(56,'core','overdue_alert_assigned','1','2017-11-29 22:48:50'),(57,'core','overdue_alert_dept_manager','1','2017-11-29 22:48:50'),(58,'core','overdue_alert_dept_members','','2017-11-29 22:48:50'),(59,'core','assigned_alert_active','1','2017-11-29 22:48:51'),(60,'core','assigned_alert_staff','1','2017-11-29 22:48:51'),(61,'core','assigned_alert_team_lead','','2017-11-29 22:48:51'),(62,'core','assigned_alert_team_members','','2017-11-29 22:48:51'),(63,'core','auto_claim_tickets','1','2017-11-29 22:48:51'),(64,'core','show_related_tickets','1','2017-11-29 22:48:51'),(65,'core','show_assigned_tickets','1','2017-11-29 22:48:51'),(66,'core','show_answered_tickets','','2017-11-29 22:48:51'),(67,'core','hide_staff_name','','2017-11-29 22:48:51'),(68,'core','overlimit_notice_active','','2017-11-29 22:48:51'),(69,'core','email_attachments','1','2017-11-29 22:48:51'),(70,'core','ticket_number_format','######','2017-11-29 22:48:51'),(71,'core','ticket_sequence_id','','2017-11-29 22:48:51'),(72,'core','task_number_format','#','2017-11-29 22:48:51'),(73,'core','task_sequence_id','2','2017-11-29 22:48:51'),(74,'core','log_level','2','2017-11-29 22:48:51'),(75,'core','log_graceperiod','12','2017-11-29 22:48:51'),(76,'core','client_registration','public','2017-11-29 22:48:51'),(77,'core','max_file_size','1048576','2017-11-29 22:48:51'),(78,'core','landing_page_id','1','2017-11-29 22:48:51'),(79,'core','thank-you_page_id','2','2017-11-29 22:48:51'),(80,'core','offline_page_id','3','2017-11-29 22:48:51'),(81,'core','system_language','en_US','2017-11-29 22:48:51'),(82,'mysqlsearch','reindex','0','2017-11-29 22:53:23'),(83,'core','default_email_id','1','2017-11-29 22:48:54'),(84,'core','alert_email_id','2','2017-11-29 22:48:54'),(85,'core','default_dept_id','1','2017-11-29 22:48:54'),(86,'core','default_sla_id','1','2017-11-29 22:48:54'),(87,'core','default_template_id','1','2017-11-29 22:48:54'),(88,'core','default_timezone','America/New_York','2017-11-29 22:48:54'),(89,'staff.1','datetime_format','','2017-11-29 22:51:51'),(90,'staff.1','default_from_name','','2017-11-29 22:51:51'),(91,'staff.1','thread_view_order','','2017-11-29 22:51:51'),(92,'core','client_logo_id','','2017-11-29 23:10:41'),(93,'core','staff_logo_id','','2017-11-29 23:10:41'),(94,'core','staff_backdrop_id','','2017-11-29 23:10:41');
/*!40000 ALTER TABLE `ost_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_content`
--

DROP TABLE IF EXISTS `ost_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `type` varchar(32) NOT NULL DEFAULT 'other',
  `name` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_content`
--

LOCK TABLES `ost_content` WRITE;
/*!40000 ALTER TABLE `ost_content` DISABLE KEYS */;
INSERT INTO `ost_content` VALUES (1,1,'landing','Landing','<h1>Welcome to the Support Center</h1> <p> In order to streamline support requests and better serve you, we utilize a support ticket system. Every support request is assigned a unique ticket number which you can use to track the progress and responses online. For your reference we provide complete archives and history of all your support requests. A valid email address is required to submit a ticket. </p>','The Landing Page refers to the content of the Customer Portal\'s initial view. The template modifies the content seen above the two links <strong>Open a New Ticket</strong> and <strong>Check Ticket Status</strong>.','2017-11-29 22:48:51','2017-11-29 22:48:51'),(2,1,'thank-you','Thank You','<div>%{ticket.name},\n<br>\n<br>\nThank you for contacting us.\n<br>\n<br>\nA support ticket request has been created and a representative will be\ngetting back to you shortly if necessary.</p>\n<br>\n<br>\nSupport Team\n</div>','This template defines the content displayed on the Thank-You page after a\nClient submits a new ticket in the Client Portal.','2017-11-29 22:48:51','2017-11-29 22:48:51'),(3,1,'offline','Offline','<div><h1>\n<span style=\"font-size: medium\">Support Ticket System Offline</span>\n</h1>\n<p>Thank you for your interest in contacting us.</p>\n<p>Our helpdesk is offline at the moment, please check back at a later\ntime.</p>\n</div>','The Offline Page appears in the Customer Portal when the Help Desk is offline.','2017-11-29 22:48:51','2017-11-29 22:48:51'),(4,1,'registration-staff','Welcome to osTicket','<h3><strong>Hi %{recipient.name.first},</strong></h3> <div> We\'ve created an account for you at our help desk at %{url}.<br /> <br /> Please follow the link below to confirm your account and gain access to your tickets.<br /> <br /> <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\">Your friendly Customer Support System<br /> %{company.name}</em> </div>','This template defines the initial email (optional) sent to Agents when an account is created on their behalf.','2017-11-29 22:48:51','2017-11-29 22:48:51'),(5,1,'pwreset-staff','osTicket Staff Password Reset','<h3><strong>Hi %{staff.name.first},</strong></h3> <div> A password reset request has been submitted on your behalf for the helpdesk at %{url}.<br /> <br /> If you feel that this has been done in error, delete and disregard this email. Your account is still secure and no one has been given access to it. It is not locked and your password has not been reset. Someone could have mistakenly entered your email address.<br /> <br /> Follow the link below to login to the help desk and change your password.<br /> <br /> <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\">Your friendly Customer Support System</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width: 126px\" /> </div>','This template defines the email sent to Staff who select the <strong>Forgot My Password</strong> link on the Staff Control Panel Log In page.','2017-11-29 22:48:51','2017-11-29 22:48:51'),(6,1,'banner-staff','Authentication Required','','This is the initial message and banner shown on the Staff Log In page. The first input field refers to the red-formatted text that appears at the top. The latter textarea is for the banner content which should serve as a disclaimer.','2017-11-29 22:48:51','2017-11-29 22:48:51'),(7,1,'registration-client','Welcome to %{company.name}','<h3><strong>Hi %{recipient.name.first},</strong></h3> <div> We\'ve created an account for you at our help desk at %{url}.<br /> <br /> Please follow the link below to confirm your account and gain access to your tickets.<br /> <br /> <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\">Your friendly Customer Support System <br /> %{company.name}</em> </div>','This template defines the email sent to Clients when their account has been created in the Client Portal or by an Agent on their behalf. This email serves as an email address verification. Please use %{link} somewhere in the body.','2017-11-29 22:48:51','2017-11-29 22:48:51'),(8,1,'pwreset-client','%{company.name} Help Desk Access','<h3><strong>Hi %{user.name.first},</strong></h3> <div> A password reset request has been submitted on your behalf for the helpdesk at %{url}.<br /> <br /> If you feel that this has been done in error, delete and disregard this email. Your account is still secure and no one has been given access to it. It is not locked and your password has not been reset. Someone could have mistakenly entered your email address.<br /> <br /> Follow the link below to login to the help desk and change your password.<br /> <br /> <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\">Your friendly Customer Support System <br /> %{company.name}</em> </div>','This template defines the email sent to Clients who select the <strong>Forgot My Password</strong> link on the Client Log In page.','2017-11-29 22:48:51','2017-11-29 22:48:51'),(9,1,'banner-client','Sign in to %{company.name}','To better serve you, we encourage our Clients to register for an account.','This composes the header on the Client Log In page. It can be useful to inform your Clients about your log in and registration policies.','2017-11-29 22:48:51','2017-11-29 22:48:51'),(10,1,'registration-confirm','Account registration','<div><strong>Thanks for registering for an account.</strong><br/> <br /> We\'ve just sent you an email to the address you entered. Please follow the link in the email to confirm your account and gain access to your tickets. </div>','This templates defines the page shown to Clients after completing the registration form. The template should mention that the system is sending them an email confirmation link and what is the next step in the registration process.','2017-11-29 22:48:51','2017-11-29 22:48:51'),(11,1,'registration-thanks','Account Confirmed!','<div> <strong>Thanks for registering for an account.</strong><br /> <br /> You\'ve confirmed your email address and successfully activated your account. You may proceed to open a new ticket or manage existing tickets.<br /> <br /> <em>Your friendly support center</em><br /> %{company.name} </div>','This template defines the content displayed after Clients successfully register by confirming their account. This page should inform the user that registration is complete and that the Client can now submit a ticket or access existing tickets.','2017-11-29 22:48:51','2017-11-29 22:48:51'),(12,1,'access-link','Ticket [#%{ticket.number}] Access Link','<h3><strong>Hi %{recipient.name.first},</strong></h3> <div> An access link request for ticket #%{ticket.number} has been submitted on your behalf for the helpdesk at %{url}.<br /> <br /> Follow the link below to check the status of the ticket #%{ticket.number}.<br /> <br /> <a href=\"%{recipient.ticket_link}\">%{recipient.ticket_link}</a><br /> <br /> If you <strong>did not</strong> make the request, please delete and disregard this email. Your account is still secure and no one has been given access to the ticket. Someone could have mistakenly entered your email address.<br /> <br /> --<br /> %{company.name} </div>','This template defines the notification for Clients that an access link was sent to their email. The ticket number and email address trigger the access link.','2017-11-29 22:48:51','2017-11-29 22:48:51');
/*!40000 ALTER TABLE `ost_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_department`
--

DROP TABLE IF EXISTS `ost_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_department` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT NULL,
  `tpl_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sla_id` int(10) unsigned NOT NULL DEFAULT '0',
  `email_id` int(10) unsigned NOT NULL DEFAULT '0',
  `autoresp_email_id` int(10) unsigned NOT NULL DEFAULT '0',
  `manager_id` int(10) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  `signature` text NOT NULL,
  `ispublic` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `group_membership` tinyint(1) NOT NULL DEFAULT '0',
  `ticket_auto_response` tinyint(1) NOT NULL DEFAULT '1',
  `message_auto_response` tinyint(1) NOT NULL DEFAULT '0',
  `path` varchar(128) NOT NULL DEFAULT '/',
  `updated` datetime NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`pid`),
  KEY `manager_id` (`manager_id`),
  KEY `autoresp_email_id` (`autoresp_email_id`),
  KEY `tpl_id` (`tpl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_department`
--

LOCK TABLES `ost_department` WRITE;
/*!40000 ALTER TABLE `ost_department` DISABLE KEYS */;
INSERT INTO `ost_department` VALUES (1,NULL,0,0,0,0,0,0,'Support','Support Department',1,1,1,1,'/1/','2017-11-29 22:48:47','2017-11-29 22:48:47'),(2,NULL,0,1,0,0,0,0,'Sales','Sales and Customer Retention',1,1,1,1,'/2/','2017-11-29 22:48:47','2017-11-29 22:48:47'),(3,NULL,0,0,0,0,0,0,'Maintenance','Maintenance Department',1,0,1,1,'/3/','2017-11-29 22:48:47','2017-11-29 22:48:47');
/*!40000 ALTER TABLE `ost_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_draft`
--

DROP TABLE IF EXISTS `ost_draft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_draft` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) unsigned NOT NULL,
  `namespace` varchar(32) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `extra` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_draft`
--

LOCK TABLES `ost_draft` WRITE;
/*!40000 ALTER TABLE `ost_draft` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_draft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email`
--

DROP TABLE IF EXISTS `ost_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_email` (
  `email_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `noautoresp` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `priority_id` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `dept_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `topic_id` int(11) unsigned NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `userid` varchar(255) NOT NULL,
  `userpass` varchar(255) CHARACTER SET ascii NOT NULL,
  `mail_active` tinyint(1) NOT NULL DEFAULT '0',
  `mail_host` varchar(255) NOT NULL,
  `mail_protocol` enum('POP','IMAP') NOT NULL DEFAULT 'POP',
  `mail_encryption` enum('NONE','SSL') NOT NULL,
  `mail_port` int(6) DEFAULT NULL,
  `mail_fetchfreq` tinyint(3) NOT NULL DEFAULT '5',
  `mail_fetchmax` tinyint(4) NOT NULL DEFAULT '30',
  `mail_archivefolder` varchar(255) DEFAULT NULL,
  `mail_delete` tinyint(1) NOT NULL DEFAULT '0',
  `mail_errors` tinyint(3) NOT NULL DEFAULT '0',
  `mail_lasterror` datetime DEFAULT NULL,
  `mail_lastfetch` datetime DEFAULT NULL,
  `smtp_active` tinyint(1) DEFAULT '0',
  `smtp_host` varchar(255) NOT NULL,
  `smtp_port` int(6) DEFAULT NULL,
  `smtp_secure` tinyint(1) NOT NULL DEFAULT '1',
  `smtp_auth` tinyint(1) NOT NULL DEFAULT '1',
  `smtp_spoofing` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`email_id`),
  UNIQUE KEY `email` (`email`),
  KEY `priority_id` (`priority_id`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email`
--

LOCK TABLES `ost_email` WRITE;
/*!40000 ALTER TABLE `ost_email` DISABLE KEYS */;
INSERT INTO `ost_email` VALUES (1,0,2,1,0,'support@opsgility.com','Support','','',0,'','POP','NONE',NULL,5,30,NULL,0,0,NULL,NULL,0,'',NULL,1,1,0,NULL,'2017-11-29 22:48:54','2017-11-29 22:48:54'),(2,0,2,1,0,'alerts@opsgility.com','osTicket Alerts','','',0,'','POP','NONE',NULL,5,30,NULL,0,0,NULL,NULL,0,'',NULL,1,1,0,NULL,'2017-11-29 22:48:54','2017-11-29 22:48:54'),(3,0,2,1,0,'noreply@opsgility.com','','','',0,'','POP','NONE',NULL,5,30,NULL,0,0,NULL,NULL,0,'',NULL,1,1,0,NULL,'2017-11-29 22:48:54','2017-11-29 22:48:54');
/*!40000 ALTER TABLE `ost_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email_account`
--

DROP TABLE IF EXISTS `ost_email_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_email_account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `protocol` varchar(64) NOT NULL DEFAULT '',
  `host` varchar(128) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL,
  `username` varchar(128) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `options` varchar(512) DEFAULT NULL,
  `errors` int(11) unsigned DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `lastconnect` timestamp NULL DEFAULT NULL,
  `lasterror` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_account`
--

LOCK TABLES `ost_email_account` WRITE;
/*!40000 ALTER TABLE `ost_email_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_email_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email_template`
--

DROP TABLE IF EXISTS `ost_email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_email_template` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tpl_id` int(11) unsigned NOT NULL,
  `code_name` varchar(32) NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `template_lookup` (`tpl_id`,`code_name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_template`
--

LOCK TABLES `ost_email_template` WRITE;
/*!40000 ALTER TABLE `ost_email_template` DISABLE KEYS */;
INSERT INTO `ost_email_template` VALUES (1,1,'ticket.autoresp','Support Ticket Opened [#%{ticket.number}]','<h3><strong>Dear %{recipient.name.first},</strong></h3> <p> A request for support has been created and assigned #%{ticket.number}. A representative will follow-up with you as soon as possible. You can <a href=\"%{recipient.ticket_link}\">view this ticket\'s progress online</a>. </p> <br /> <div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team, <br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>If you wish to provide additional comments or information regarding the issue, please reply to this email or <a href=\"%{recipient.ticket_link}\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div>',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(2,1,'ticket.autoreply','Re: %{ticket.subject} [#%{ticket.number}]','<h3><strong>Dear %{recipient.name.first},</strong></h3> A request for support has been created and assigned ticket <a href=\"%{recipient.ticket_link}\">#%{ticket.number}</a> with the following automatic reply <br /> <br /> Topic: <strong>%{ticket.topic.name}</strong> <br /> Subject: <strong>%{ticket.subject}</strong> <br /> <br /> %{response} <br /> <br /> <div style=\"color:rgb(127, 127, 127)\">Your %{company.name} Team,<br /> %{signature}</div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>We hope this response has sufficiently answered your questions. If you wish to provide additional comments or informatione, please reply to this email or <a href=\"%{recipient.ticket_link}\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div>',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(3,1,'message.autoresp','Message Confirmation','<h3><strong>Dear %{recipient.name.first},</strong></h3> Your reply to support request <a href=\"%{recipient.ticket_link}\">#%{ticket.number}</a> has been noted <br /> <br /> <div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team,<br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"><em>You can view the support request progress <a href=\"%{recipient.ticket_link}\">online here</a></em> </div>',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(4,1,'ticket.notice','%{ticket.subject} [#%{ticket.number}]','<h3><strong>Dear %{recipient.name.first},</strong></h3> Our customer care team has created a ticket, <a href=\"%{recipient.ticket_link}\">#%{ticket.number}</a> on your behalf, with the following details and summary: <br /> <br /> Topic: <strong>%{ticket.topic.name}</strong> <br /> Subject: <strong>%{ticket.subject}</strong> <br /> <br /> %{message} <br /> <br /> If need be, a representative will follow-up with you as soon as possible. You can also <a href=\"%{recipient.ticket_link}\">view this ticket\'s progress online</a>. <br /> <br /> <div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team,<br /> %{signature}</div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>If you wish to provide additional comments or information regarding the issue, please reply to this email or <a href=\"%{recipient.ticket_link}\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div>',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(5,1,'ticket.overlimit','Open Tickets Limit Reached','<h3><strong>Dear %{ticket.name.first},</strong></h3> You have reached the maximum number of open tickets allowed. To be able to open another ticket, one of your pending tickets must be closed. To update or add comments to an open ticket simply <a href=\"%{url}/tickets.php?e=%{ticket.email}\">login to our helpdesk</a>. <br /> <br /> Thank you,<br /> Support Ticket System',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(6,1,'ticket.reply','Re: %{ticket.subject} [#%{ticket.number}]','<h3><strong>Dear %{recipient.name},</strong></h3> %{response} <br /> <br /> <div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team,<br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"><em>We hope this response has sufficiently answered your questions. If not, please do not send another email. Instead, reply to this email or <a href=\"%{recipient.ticket_link}\" style=\"color:rgb(84, 141, 212)\">login to your account</a> for a complete archive of all your support requests and responses.</em></div>',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(7,1,'ticket.activity.notice','Re: %{ticket.subject} [#%{ticket.number}]','<h3><strong>Dear %{recipient.name.first},</strong></h3> <div> <em>%{poster.name}</em> just logged a message to a ticket in which you participate. </div> <br /> %{message} <br /> <br /> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"> <em>You\'re getting this email because you are a collaborator on ticket <a href=\"%{recipient.ticket_link}\" style=\"color:rgb(84, 141, 212)\">#%{ticket.number}</a>. To participate, simply reply to this email or <a href=\"%{recipient.ticket_link}\" style=\"color:rgb(84, 141, 212)\">click here</a> for a complete archive of the ticket thread.</em> </div>',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(8,1,'ticket.alert','New Ticket Alert','<h2>Hi %{recipient.name},</h2> New ticket #%{ticket.number} created <br /> <br /> <table> <tbody> <tr> <td> <strong>From</strong>: </td> <td> %{ticket.name} &lt;%{ticket.email}&gt; </td> </tr> <tr> <td> <strong>Department</strong>: </td> <td> %{ticket.dept.name} </td> </tr> </tbody> </table> <br /> %{message} <br /> <br /> <hr /> <div>To view or respond to the ticket, please <a href=\"%{ticket.staff_link}\">login</a> to the support ticket system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" style=\"width:126px\" alt=\"Powered By osTicket\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a>',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(9,1,'message.alert','New Message Alert','<h3><strong>Hi %{recipient.name},</strong></h3> New message appended to ticket <a href=\"%{ticket.staff_link}\">#%{ticket.number}</a> <br /> <br /> <table> <tbody> <tr> <td> <strong>From</strong>: </td> <td> %{ticket.name} &lt;%{ticket.email}&gt; </td> </tr> <tr> <td> <strong>Department</strong>: </td> <td> %{ticket.dept.name} </td> </tr> </tbody> </table> <br /> %{message} <br /> <br /> <hr /> <div>To view or respond to the ticket, please <a href=\"%{ticket.staff_link}\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system</div> <em style=\"color:rgb(127,127,127);font-size:small\">Your friendly Customer Support System</em><br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(10,1,'note.alert','New Internal Activity Alert','<h3><strong>Hi %{recipient.name},</strong></h3> An agent has logged activity on ticket <a href=\"%{ticket.staff_link}\">#%{ticket.number}</a> <br /> <br /> <table> <tbody> <tr> <td> <strong>From</strong>: </td> <td> %{note.poster} </td> </tr> <tr> <td> <strong>Title</strong>: </td> <td> %{note.title} </td> </tr> </tbody> </table> <br /> %{note.message} <br /> <br /> <hr /> To view/respond to the ticket, please <a href=\"%{ticket.staff_link}\">login</a> to the support ticket system <br /> <br /> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(11,1,'assigned.alert','Ticket Assigned to you','<h3><strong>Hi %{assignee.name.first},</strong></h3> Ticket <a href=\"%{ticket.staff_link}\">#%{ticket.number}</a> has been assigned to you by %{assigner.name.short} <br /> <br /> <table> <tbody> <tr> <td> <strong>From</strong>: </td> <td> %{ticket.name} &lt;%{ticket.email}&gt; </td> </tr> <tr> <td> <strong>Subject</strong>: </td> <td> %{ticket.subject} </td> </tr> </tbody> </table> <br /> %{comments} <br /> <br /> <hr /> <div>To view/respond to the ticket, please <a href=\"%{ticket.staff_link}\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(12,1,'transfer.alert','Ticket #%{ticket.number} transfer - %{ticket.dept.name}','<h3>Hi %{recipient.name},</h3> Ticket <a href=\"%{ticket.staff_link}\">#%{ticket.number}</a> has been transferred to the %{ticket.dept.name} department by <strong>%{staff.name.short}</strong> <br /> <br /> <blockquote><div> %{comments} </div></blockquote> <hr /> <div>To view or respond to the ticket, please <a href=\"%{ticket.staff_link}\">login</a> to the support ticket system. </div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" alt=\"Powered By osTicket\" style=\"width:126px\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a>',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(13,1,'ticket.overdue','Stale Ticket Alert','<h3><strong>Hi %{recipient.name}</strong>,</h3> A ticket, <a href=\"%{ticket.staff_link}\">#%{ticket.number}</a> is seriously overdue. <br /> <br /> We should all work hard to guarantee that all tickets are being addressed in a timely manner. <br /> <br /> Signed,<br /> %{ticket.dept.manager.name} <hr /> <div>To view or respond to the ticket, please <a href=\"%{ticket.staff_link}\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system. You\'re receiving this notice because the ticket is assigned directly to you or to a team or department of which you\'re a member.</div> <em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" />',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(14,1,'task.alert','New Task Alert','<h2>Hi %{recipient.name},</h2> New task <a href=\"%{task.staff_link}\">#%{task.number}</a> created <br /> <br /> <table> <tbody> <tr> <td> <strong>Department</strong>: </td> <td> %{task.dept.name} </td> </tr> </tbody> </table> <br /> %{task.description} <br /> <br /> <hr /> <div>To view or respond to the ticket, please <a href=\"%{task.staff_link}\">login</a> to the support system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" style=\"width:126px\" alt=\"Powered By osTicket\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a>',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(15,1,'task.activity.notice','Re: %{task.title} [#%{task.number}]','<h3><strong>Dear %{recipient.name.first},</strong></h3> <div> <em>%{poster.name}</em> just logged a message to a task in which you participate. </div> <br /> %{message} <br /> <br /> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"> <em>You\'re getting this email because you are a collaborator on task #%{task.number}. To participate, simply reply to this email.</em> </div>',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(16,1,'task.activity.alert','Task Activity [#%{task.number}] - %{activity.title}','<h3><strong>Hi %{recipient.name},</strong></h3> Task <a href=\"%{task.staff_link}\">#%{task.number}</a> updated: %{activity.description} <br /> <br /> %{message} <br /> <br /> <hr /> <div>To view or respond to the task, please <a href=\"%{task.staff_link}\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system</div> <em style=\"color:rgb(127,127,127);font-size:small\">Your friendly Customer Support System</em><br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(17,1,'task.assignment.alert','Task Assigned to you','<h3><strong>Hi %{assignee.name.first},</strong></h3> Task <a href=\"%{task.staff_link}\">#%{task.number}</a> has been assigned to you by %{assigner.name.short} <br /> <br /> %{comments} <br /> <br /> <hr /> <div>To view/respond to the task, please <a href=\"%{task.staff_link}\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(18,1,'task.transfer.alert','Task #%{task.number} transfer - %{task.dept.name}','<h3>Hi %{recipient.name},</h3> Task <a href=\"%{task.staff_link}\">#%{task.number}</a> has been transferred to the %{task.dept.name} department by <strong>%{staff.name.short}</strong> <br /> <br /> <blockquote><div> %{comments} </div></blockquote> <hr /> <div>To view or respond to the task, please <a href=\"%{task.staff_link}\">login</a> to the support system. </div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" alt=\"Powered By osTicket\" style=\"width:126px\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a>',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52'),(19,1,'task.overdue.alert','Stale Task Alert','<h3><strong>Hi %{recipient.name}</strong>,</h3> A task, <a href=\"%{task.staff_link}\">#%{task.number}</a> is seriously overdue. <br /> <br /> We should all work hard to guarantee that all tasks are being addressed in a timely manner. <br /> <br /> Signed,<br /> %{task.dept.manager.name} <hr /> <div>To view or respond to the task, please <a href=\"%{task.staff_link}\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system. You\'re receiving this notice because the task is assigned directly to you or to a team or department of which you\'re a member.</div> <em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" />',NULL,'2017-11-29 22:48:52','2017-11-29 22:48:52');
/*!40000 ALTER TABLE `ost_email_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email_template_group`
--

DROP TABLE IF EXISTS `ost_email_template_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_email_template_group` (
  `tpl_id` int(11) NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `name` varchar(32) NOT NULL DEFAULT '',
  `lang` varchar(16) NOT NULL DEFAULT 'en_US',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tpl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_template_group`
--

LOCK TABLES `ost_email_template_group` WRITE;
/*!40000 ALTER TABLE `ost_email_template_group` DISABLE KEYS */;
INSERT INTO `ost_email_template_group` VALUES (1,1,'osTicket Default Template (HTML)','en_US','Default osTicket templates','2017-11-29 22:48:52','2017-11-29 22:48:52');
/*!40000 ALTER TABLE `ost_email_template_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_faq`
--

DROP TABLE IF EXISTS `ost_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_faq` (
  `faq_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL DEFAULT '0',
  `ispublished` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  `keywords` tinytext,
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`faq_id`),
  UNIQUE KEY `question` (`question`),
  KEY `category_id` (`category_id`),
  KEY `ispublished` (`ispublished`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_faq`
--

LOCK TABLES `ost_faq` WRITE;
/*!40000 ALTER TABLE `ost_faq` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_faq_category`
--

DROP TABLE IF EXISTS `ost_faq_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_faq_category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ispublic` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `name` varchar(125) DEFAULT NULL,
  `description` text NOT NULL,
  `notes` tinytext NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `ispublic` (`ispublic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_faq_category`
--

LOCK TABLES `ost_faq_category` WRITE;
/*!40000 ALTER TABLE `ost_faq_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_faq_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_faq_topic`
--

DROP TABLE IF EXISTS `ost_faq_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_faq_topic` (
  `faq_id` int(10) unsigned NOT NULL,
  `topic_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`faq_id`,`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_faq_topic`
--

LOCK TABLES `ost_faq_topic` WRITE;
/*!40000 ALTER TABLE `ost_faq_topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_faq_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_file`
--

DROP TABLE IF EXISTS `ost_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ft` char(1) NOT NULL DEFAULT 'T',
  `bk` char(1) NOT NULL DEFAULT 'D',
  `type` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `key` varchar(86) CHARACTER SET ascii NOT NULL,
  `signature` varchar(86) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `attrs` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ft` (`ft`),
  KEY `key` (`key`),
  KEY `signature` (`signature`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_file`
--

LOCK TABLES `ost_file` WRITE;
/*!40000 ALTER TABLE `ost_file` DISABLE KEYS */;
INSERT INTO `ost_file` VALUES (1,'T','D','image/png',9452,'b56944cb4722cc5cda9d1e23a3ea7fbc','gjMyblHhAxCQvzLfPBW3EjMUY1AmQQmz','powered-by-osticket.png',NULL,'2017-11-29 22:48:49'),(2,'T','D','text/plain',24,'TqCnhMWtx86n3ccfeGGNagoRoTDtol7o','MWtx86n3ccfeGGNafaacpitTxmJ4h3Ls','osTicket.txt',NULL,'2017-11-29 22:48:51');
/*!40000 ALTER TABLE `ost_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_file_chunk`
--

DROP TABLE IF EXISTS `ost_file_chunk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_file_chunk` (
  `file_id` int(11) NOT NULL,
  `chunk_id` int(11) NOT NULL,
  `filedata` longblob NOT NULL,
  PRIMARY KEY (`file_id`,`chunk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_file_chunk`
--

LOCK TABLES `ost_file_chunk` WRITE;
/*!40000 ALTER TABLE `ost_file_chunk` DISABLE KEYS */;
INSERT INTO `ost_file_chunk` VALUES (1,0,'âPNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\⁄\0\0\0(\0\0\0òG\‰\…\0\0\nCiCCPICC profile\0\0x⁄ùSwXì˜>\ﬂ˜eVB\ÿ±ólÅ\0\"#¨\»Y¢í\0aÑ@≈Öà\nVúHUƒÇ\’\nHùà\‚†(∏gAäàZãU\\8\Ó‹ßµ}z\Ô\Ì\Ì˚\◊˚º\Áú\Á¸\Œy\œÄ&ë\Ê¢j\09RÖ<:\ÿèOH\ƒ…ΩÄH\‡ \Ê\À\¬g\≈\0\0yx~t∞?¸Øo\0\0p\’.$\«\·ˇÉ∫P&W\0 ë\0\‡\"\ÁêR\0\».T\»\0\»\0∞S≥d\n\0î\0\0ly|B\"\0™\r\0\ÏÙI>\0ÿ©ì\‹\0ÿ¢©\0ç\0ô(G$@ª\0`UÅR,¿\¬\0†¨@\".¿ÆÄY∂2GÄΩ\0véXê@`\0ÄôB,\Ã\0 8\0C\Õ L†0“ø\‡©_pÖ∏H\0¿ÀïÕóK\“3∏ï\–\ZwÚ\‡\‚!\‚\¬l±Ba)f	\‰\"úóõ#H\ÁL\Œ\0\0\Z˘\—¡˛8?ê\Á\Ê\‰\·\Êf\Ál\ÔÙ≈¢˛ko\">!Ò\ﬂ˛ºå\0N\œ\Ô\⁄_\Â\Â\÷p\«∞uøk©[\0\⁄V\0h\ﬂ˘]3\€	†Z\n\–z˘ãy8¸@û°P\»<\n\Ì%b°Ω0\„ã>ˇ3\·o\‡ã~ˆ¸@˛\€z\0qö@ô≠¿£É˝qanvÆRé\Á\ÀB1n˜\Á#˛«Ö˝é)\—\‚4±\\,äÒXâ∏P\"M\«yπRëD!…ï\‚\È2Òñ˝	ìw\r\0¨ÜO¿N∂µ\Àl¿~\ÓãX\“v\0@~Û-å\Zë\0g42y˜\0\0ìø˘è@+\0Õó§\„\0\0º\Ë\\®îL\∆\0\0D†Å*∞A¡¨¿ú¡º¿aD@$¿<B\‰Ä\n°ñAT¿:\ÿµ∞\Z†ö\·¥¡18\r\Á\‡\\Å\Îp`û\¬ºÜ	A\»a!:àbé\ÿ\"\Œôé\"aH4íÄ§ \ÈàQ\"\≈\»r§©Bjë]H#Ú-r9ç\\@˙ê\€\» 2ä¸äºG1îÅ≤Q\‘u@π®\Zä∆†s\—t4]Äñ¢k\—\Z¥=Ä∂¢ß\—K\Ëut\0}äécÄ\—1få\Ÿa\\åáE`âX\Z&\«c\ÂX5Vè5cX7v¿ûa\Ô$ãÄ\Ï^Ñ\¬lÇêêGXLXC®%\Ï#¥∫W	ÉÑ1\¬\'\"ì®O¥%z˘\ƒxb:±êXF¨&\Ó!!û%^\'_ìH$…í\‰N\n!%ê2IIkH\€H-§S§>\“iúL&\Îêm\…\ﬁ\‰≤Ä¨ óë∑êêOí˚\…\√\‰∑:≈à\‚L	¢$R§îJ5e?\Â•ü2Bô†™QÕ©û\‘™à:üZIm†vP/Sá©4uö%ÕõCÀ§-£\’–öigi˜h/\Èt∫	›ÉEó–ó\“k\Ë\È\Á\ÈÉÙw\rÜ\rÉ\«Hb(k{ß∑/ôL¶”óô\»T0\◊2ôgòòoUX*ˆ*|ë\ ï:ïVï~ï\Á™TUsU?\’y™T´U´^V}¶FU≥P\„©	\‘´’©Uª©6Æ\ŒRwRèP\œQ_£æ_˝Ç˙c\r≤ÜÖF†ÜH£Tc∑\∆ç!\∆2eÒXB\÷rV\Î,kòMb[≤˘\ÏLv˚v/{LSCs™f¨fëfù\Êq\Õ∆±\‡9ŸúJ\Œ!\Œ\r\Œ{--?-±\÷j≠f≠~≠7\⁄z⁄æ\⁄b\Ìr\Ì\Ì\Î\⁄\Ôupù@ù,ùı:m:˜u	∫6∫Q∫Ö∫\€u\œ\Í>\”c\Îy\È	ı\ ı\È\›\—GımÙ£ı\Í\Ô\÷\Ô\—7046êl18cÃêc\Ëkòi∏\—Ñ\·®\Àh∫ë\ƒh£\—I£\'∏&\Óág\„5x>f¨ob¨4\ﬁe\‹k<abi2€§ƒ§\≈\‰æ)Õîköf∫—¥\”t\Ã\Ã\»,‹¨ÿ¨\…\Ïé9’úkûaæŸº\€¸çÖ•Eú\≈Jã6ã«ñ⁄ñ|\ÀñMñ˜¨òV>VyVıV◊¨I\÷\\\Î,\Îm\÷WlPWõõ:õÀ∂®≠õ≠\ƒvõm\ﬂ\‚è)\“)ıSn\⁄1\Ï¸\Ï\n\Ïö\Ï\Ì9ˆaˆ%ˆmˆ\œ\Ã\÷;t;|rtu\Ãvlpº\Î§\·4√©ƒ©\√\ÈWgg°sùÛ5¶Kê\ÀóvóSmßäßnüzÀï\Â\Z\Ó∫“µ\”ı£õªõ‹≠\Ÿm\‘\›\Ã=\≈}´˚M.õ\…]\√=\ÔAÙ˜X\‚q\Ã„ùßõß\¬Ûê\Á/^v^Y^˚ΩO≥ú&û\÷0m\»\€\ƒ[\‡Ω\À{`:>=e˙\Œ\È>\∆>üzüáæ¶æ\"\ﬂ=æ#~\÷~ô~¸û˚;˙\À˝è¯ø\·yÚÒN`¡\ÂΩÅ\ZÅ≥kô•5çª/>B	\rYrìo¿Ú˘c3\‹g,ö\—\ ùZ˙0\Ã&L\÷éÜ\œ\ﬂ~o¶˘L\ÈÃ∂à\‡Glà∏iô˘})*2™.\ÍQ¥Stqt˜,÷¨\‰Y˚gΩéÒè©åπ;\€j∂rvg¨jlRlcÏõ∏Ä∏™∏Åxá¯EÒót$	\Ìâ\‰\ƒ\ÿ\ƒ=â\„s\Álö3ú\‰öTñtcÆ\Â‹¢π\Ê\È\ŒÀûw<Y5Yê|8Öòó≤?\ÂÉ BP/O\ÂßnMÚÑõÖOEæ¢ç¢Q±∑∏J<í\ÊùVïˆ8\›;}C˙hÜOFu\∆3	OR+yëíπ#ÛMVD\÷ﬁ¨\œ\Ÿq\Ÿ-9îúîú£R\riñ¥+\◊0∑(∑Of++ì\r\‰y\Êm\ ìá\ ˜\‰#˘sÛ\€lÖL—£¥RÆPL/®+x[[x∏HΩHZ\‘3\ﬂf˛\Í˘#Ç|Ωê∞P∏∞≥ÿ∏xYÒ\‡\"øEª#ãSw.1]R∫dxi\“}\ÀhÀ≤ñ˝P\‚XRUÚjy\‹ÚéRÉ“••C+ÇW4ï©î\…\ÀnÆÙZπcaïdU\Ôjó\’[V*ï_¨p¨®Æ¯∞F∏\Ê\‚WN_\’|ıym\⁄\⁄\ﬁJ∑\ \Ì\ÎH\Î§\În¨˜YøØJΩjA\’–Ü\r≠Òç\Â_mJ\ﬁt°zjıéÕ¥\Õ\ \Õ5a5\Ì[Ã∂¨\€Ú°6£ˆzù]\ÀV˝≠´∑æ\Ÿ&\⁄÷ø\›w{ÛÉ;\ﬁ\ÔîÏºµ+xWkΩE}ın\“\ÓÇ›è\Zb∫ø\Ê~›∏GwO≈ûè{•{ˆE\Ô\Îjtol‹Øøø≤	mR6çH:pÂõÄo⁄õ\ÌöwµpZ*\¬A\Â¡\'ﬂ¶|{\„P\Ë°\Œ\√\‹\√\Õﬂô∑ı\ÎHy+\“:øu¨-£m†=°Ω\ÔËå£ù^Gæ∑ˇ~\Ô1\„cu\«5èWû†ù(=Ò˘‰Çì\„ßdßûùN?=‘ô\‹y˜L¸ôk]Q]ΩgCœû?t\ÓL∑_˜\…Û\ﬁ\Áè]ºpÙ\"˜b\€%∑K≠=Æ=G~p˝\·HØ[o\Îe˜\À\ÌW<ÆtÙM\Î;\—\Ô\”˙j¿\’s\◊¯\◊.]üyΩ\Ô\∆\Ï∑n&\›∏%∫ı¯vˆ\Ìw\n\ÓL\‹]zèxØ¸æ\⁄˝\Í˙\Í¥˛±e¿m\‡¯`¿`\œ\√Y\Ô	áû˛îˇ”á\·\“G\ÃG\’#F#çèù\r\ZΩÚdŒì·ß≤ß\œ\ ~Vˇy\Îs´\Á\ﬂ˝\‚˚K\œX¸\ÿ˘ãœøÆy©ÛrÔ´©Ø:\«#\«º\Œy=Ò¶¸≠\Œ\€}\Ô∏\Ô∫\ﬂ«Ωô(¸@˛PÛ\—˙c«ß\–O˜>\Á|˛¸/˜ÑÛ˚Ä9%\0\0\0tEXtSoftware\0Adobe ImageReadyq\…e<\0\0(iTXtXML:com.adobe.xmp\0\0\0\0\0<?xpacket begin=\"Ôªø\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?> <x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"Adobe XMP Core 5.6-c014 79.156797, 2014/08/20-09:53:02        \"> <rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"> <rdf:Description rdf:about=\"\" xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\" xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\" xmlns:stRef=\"http://ns.adobe.com/xap/1.0/sType/ResourceRef#\" xmp:CreatorTool=\"Adobe Photoshop CC 2014 (Macintosh)\" xmpMM:InstanceID=\"xmp.iid:6E2C95DEA67311E4BDCDDF91FAF94DA5\" xmpMM:DocumentID=\"xmp.did:6E2C95DFA67311E4BDCDDF91FAF94DA5\"> <xmpMM:DerivedFrom stRef:instanceID=\"xmp.iid:CFA74E4FA67111E4BDCDDF91FAF94DA5\" stRef:documentID=\"xmp.did:CFA74E50A67111E4BDCDDF91FAF94DA5\"/> </rdf:Description> </rdf:RDF> </x:xmpmeta> <?xpacket end=\"r\"?>ã˛ˆ\ \0\0IDATx\⁄\Ï]	úS\’\’?/{2\…dfÄaqê]67\–œ≠(*®-\nˆÛ≥∂.ı+\÷÷Ö∫ nµJ¡≠ˆSãR¥\’:VDT§,e\—2®lÇ†¨Ç\Ïã3\Ã\¬Líó˜›õ¸os\ÊNí\…Pq\Ã˘˝$ìó˜\Óª˜¸\œ˘üs\Ôª1ÜNY96§\⁄t\“\ÿ\Ó\ÔS±/Q\ƒ˝]k~K°ìÖ\Ózõ\–\Ìç>É%4ﬂ§\“5∫˙≠<≤\Ÿ,≤\ÕclmYÛ\Œ\ íÑû\'Ù\«BØhÙ∑£BÛLZ∏\ﬁM?õ§∞\0]sôG\÷>æ\◊\‚Z(4W®]h\r\"“æ&F4ô]ç˛∂?JKD$˙F>Yd-}QäZY†e\Âª)≠Ñû*tÄ\–”Ñ∂\Í\‡$ªâ\r	=(tï\–\ÈBg	=ê¡π\Ì¯_Ç¥¢—îQ\0m\∆V\Ì+≥SèvaäDõW\«gÅˆ˝êéBØ˙øBªe¯ù\ﬁBØ∫L\ËH°\“õ#tÛªB\«	˝mFWí\0;t\» _é\Ÿ\Ï@ñ\Õ—öøxÑ\ﬁ.t!ø[\Œ!#\‡\\°˜\„|\…\‰Wàí:˜\ÿ\rG≥†I≥∑9\Èâ\“* ç6ÀÅ\»≠˘Jk°SÖ˛A\ËqG¿Nçº\09ù§õEB\ÔMπ~-4?Ìôù\’~\„†Iã}\‘&∑y\ÂeY\Í\ÿ¸\Â°o\n\ÌuÑ\œ{.rªΩBk∏\÷iv?äó˙LG∑¥—îµj\»-+\ﬂëQÊï£\02%>\‰|ô\ \Ô(^\Õõí\ﬂ\n\ÍX\Ëè\∆r≥\ÊT\“\œR\«\Ê-í*ˆˇñÆ-\„\—R°ÀÖV±ø\ÀBI\À:G\ T\Ã#˛\…5i˛\ZE\"FÛîlD;\Ê\\_\‰pæ˝sj\ dÒëìıB\"tá\–B)Ù2\‰w\ﬂ\ƒ\Ôœäª˜`î\Ê≠Ù–§ï^ö∂\—MnA!ç\Ê<¨Y\À>Üºû•íÌßêˆ\n´ktıM\ÊJw%˘ªú<.ˇ\›\¬\√BøU\\GÒBI?Á¶ì]\0\Ão\∆\–Ù\Â^˝Ù•∫eFê&.˜ë\◊aë\«a5\Ô±Õö˜±#“£o>§ê=L^´\—˛]Féû\⁄\ﬂJÖN\0ÉGπ˘„ÖæVá\Z˙¢!q#!\≈ñ\€\È¿6=X\Íß9õ\\T2\»Ô≤®{´ôc\—Êç≥,–é)zak≥l¥˙@1ı\œ\ﬂ{ù°Ñ^£˝MFî°_b\’\Ê(7˝9°£≠ë+\'J´\÷{hÒón\Íê°[\\ÙhiµÛGc41\'\'±M\Î˚1∂é≥\œ>;k\·«êLõøå\ﬁ\‹›ã˙∑\ÿ$\‹|\∆~,äó›ïîx\ﬂ ∂l\⁄\‚(4W.\”\ZAj’à\¬rù\‚\„sr\…Wùµ\…M\–Wîr\›\"zµhû´>≤\Ì;ôßYîÁ™äE,è0ﬁå\\æ\\1\Ôb\Ô∫Ø\Â\"\·\'Ñæë¡x\À¸\Íu\–LY\Ã»£x9\ﬂ)¥˘^[\0õPÙXV\ÁÇNX\·•ÕªùT(\"Yè∂âuã\ﬂWêeÅvä›àRU\ÿC55AÚ\ÿCô\–GY6?ëΩˇ@\Ë´\⁄1kÑVS|Ç9ù\»I\ÓX\ \Ë£\ƒ*êrD\ \"ÄˆL°ÉÑŒé=*@4\È´=N\ wZjâ9æ%p\…ˆ\ %a\ÌÒ~è\–yBeÅñïò¯Ìµ¥¢¢\rï\Ï\ÏK\√;HT\Îo\Ë+É)æQ\…_≈∏t°\‘\ÎâcI\ÏUû»±B\"îV⁄™\»Vg>L\ vW¶S\‚1õ|ÚXª∂\Óp—∞\…y¥Ì†ùZx£rR≠\≈\'∑#†∞)˝\≈WöH™[ ‘çˆ\ ∫±	\›(#Ú=B2ä˚C°€≤@\ÀJL,H$\À›µ(ÒüN)2ö©∞\'øõ‰òÆ\Zµ\‘/*\œ\'rZüKD\‹˚Vù((\ﬂ\’g	å≤≈õ{Ä\∆Pì]aY\« πjﬂä=B≥ù\n\"4~nÄVnwR˜∂ëXéFÒUˇrQsŒêJd\‰\‹\ZzæÙ7\"\‡y°7e©cVéä∏™\È˝Ω\›\Ë\‰\‡\Í%îB˛T`\ÀÖSÚO\–;]NNy±X\ﬁz7\‚∂s¥\—}ÛÙ\‰á~j/®ﬂ¨\rn™¥∑\“F\√z\◊\–\»*à\ƒfñ€âÊ¥å5)\◊\‹Eû\Ë°EK|Ù\÷j∑4\»˘4\rI.Ú¬ñîx∂\Õ\€\ƒ.åj¿6à®GJéG_˜Ü”òëZz1`Nx\„Pä\„<8¶^˛\»$6ìv\‘hUYı\n\ÏçG∂\‰Ûjrﬁ¨/^\ÔDé•ã§a\›Sö£€öIm¬∑Lúï\Z˚^ fùùZ\ÀÜA36∫ck†\Â{,\Z9†R‹±@WµQ%†∞Z\‰dÛ∑\◊\„WmˆÜoûñ\'rKä\«JˆäˆU0\√7YﬁßD~&*Ø\ÿÚ\—ˇïá1~ˇ\ÈÖ&=PH:	\Ô\«eÅ÷∞»Å~πè|\‘d4≈ü:\Ê“á\‚\Î\n\€\„ò{é\‘≈£T«π+h≤,Ûãà\÷9ww™\Õz\‰¸X\0Øø˝\“\Â-áKÄ\ÃN/R\€\Õ\œ\Ã\Ã\r\›3-HÖÅh+üapymv+\“\ g…ß•7∑ÚE#Û∂:\È\Íí*πÚÄ\€\ÍZ;x˘\◊ŒÅw\…*âØKq®8W\‡QÄ\ÃÄ»∂<{Xû&ù“£îxPTR\œ;Pƒë ¸#úóõö≤%¬∑\'\Ì\»H/ºdÅñ¢&AÒy©¯?ôï†≤\ÂLj»á6\·ê=\"≤9°t9\Z_®ª2I$\€ı\0\ÈK\Ì,\⁄-\"\Ÿh≤û˘g.\›˛v∞∞8ﬂº\…aã=®Ÿû]MV*D-z≤c0:Úz7y\ﬂ…£GœØ(/y=ø|“ß^[π”∫∂ca\‰qÅ>—∫Qjã\–\«)æbDóØ\ŸkyÉüJ@\„˝\÷cò\Â§Kñ∑°†£leh\rKÑ\—\≈)®\„Axn˝vçF8\rìJ∂ùBww*%Gl^ÕñÃã*˘D˚LV\‹˛Ü™ ó)Q\”x¿\Ê1\◊NTÒ7o\Êù\—.\ﬂ|\ŒeßS¢V\Ï>^Ñ\—\»¸\ËB/ë\Zé“Ω\«\ÕqSE\ﬁˆ\≈>;-\ﬁ\Ó41˙tØˆ°¶iD\≈Áìç8Uî}\'\—\"ÙOB\œzùñ#Òú\Õ\≈\ﬁw¢¯ñv8;πÑ\ÏI∫F>\»:‘π≥„∞Ä\‚O4D\Â\Â≥róÇ\÷\·å\∆S\›mÚ.¶¯F!%¶8‰äõI¨Çy\"˙∫ìÜßã\·Ñe\€*H\‡NE\√f£t5\≈\ÁK#¡ÆLíõB\‚\Á\≈E¡3\„\Ÿ6Pï†\À˝$äV72ˆ\„;\‹\ËP\"1˙√ì»π†˘\‡Ú\ƒ°⁄πÉ\‘\\y®\’ \‰(™rˇ\"™W≤>ùïÉ™\›z˙SÒ}ã\Í|?Aü\»6N£¯äyŒãp9H´í\0¢≠ä\ƒ6\¬1ã6 ßP\‘Z}i\Õ\"ßç≤R7\≈%í\ﬁO\ﬁ\Ëƒç˚\Ì—ãkCU!j/@61\‡≤z	\ \'Ûâ[Ñ~•\Âw◊£˙7V\0q_Æ+ˆ}\Íòo^e4\"6∂âéΩ¬®ÙsÑ˛∂Ù!\≈\◊\\r\‚\ kûJN≠TÚó$@ìQ˜N™øÆS\…˘†•\È\Ê\Ã$yZ(_ı:\Î{\È¿\‰W,î§\r∑/Éπuπ\Zs\÷xÜ\Á—∞qh\Ë\ÿ\ÊÇ\Á´\–.ü\ﬁ}	ûäã\Ïg(æb[\Z\÷sL7\„¸RF°\‰+Ø%°(¡\ﬂG\√8\"4§rÅ\Í)\⁄5V\¬Ç6Iè\ŸFı\r:\Ô XR>9±\⁄Q;G)⁄¥\Ô\Ô¶¯¿^ñ\”L»∞R\∆#ã\Ã\”.c\‡/¬†ı¿5/d\‘Izf9π,\Áõ\Ê}Og+>{8æ≤æxq\Ô*\Í\Ó¿kπÇ^\ﬂZ`5¢\ rπu¿\‹u˙∫ †æ\Ë\"íIê\ÕE[uTã\\µ\n\—qå\»\ﬂf\Â∫-\Èœµ\‚Õ∫/I4%8¥{0\∆7\"W+k†´ºTÖåGa_\ÈdC:∂ˆ®2\Ÿ\∆\·∏\ﬂv\0\›Y\ÏÛµ\»-ª£\ﬂ{¿∂˙0«üN\Ï6V˝Ò\¬\‡˚!1˝öyàö\0@ÅLFôy\Ë@:ˆ:x\Ê:¨/+Eü√Æu.^f=0	≤W\»V\"bÖ¶K\–5¨3G†\ÌÑht∏#¿+¡ı>?˜\‡«Ω=Çˆò0é}0û\Œt†…º\◊¥u\r˛Và∂\ 9¨)åft—º~;ºûWü9Xt\»t∆ä#)\n6Ex˝9r¢Û\·8∏º\Î_KÄ\Ã•g\Ëëó\ÊD˚äú\Ï¨öø+	»∏º\nê\Ï\·Z≠Ù˛uö\Ô-@\ﬂG\›L\ Ú©¢\›M\Z\»\¬`\“Ò^NÒ\rÇ^F•»´	\«\›\»\ﬁ\œ` #∏\ŒbL\ÂFD\⁄~îx÷é@7üÑ\”:\…\€˛!lÚ1¿l\Zóï\'˛9@p)ãb\·PbN\ÊUPÆÛq¨\‚¨˜Ò˛tÄ\Ë8ùí\"ñ\'™\r\\&!¬™≤∑\„&OGG◊Çb\ﬁnf`]\ 0\Á\ËN=m?ë\œkı\¬\Î\€X\ÔF$?µ±2¸bP\n±¡ÿïp∂0ò\Î{ıEAohøå|Æ\Íd˘Y\Î∑E,\«qjQeò0\◊\ÌT`\“\ÀK|4bf.\‰D\…fãıáå\⁄o≥\ËûN\‘D¯√Å™\“˝=l,uŸÅ1π\\£§çïv\ﬂUããº\ÓP∞öw¿BÆG_˚)1ß\0ªNüo©∞Å°ñ•C\ÿ\Á\ƒ\∆\Á&“Å˚\ÿÁóÅ\Õ<Pq~ˇ6™Æ≤ùcmZòû¿\Êb>\∆	î\\£UÜÒ£ˇÇ\' ¯y¯>!‹∂Fæ\‰G¥,\ÕG\‰≤\ MO\…f \ uQ\Á\Ï¿\’\‡˝nx™©àä™HrL<\‹4ä?f/\Â†qR¶É\ÍJ øç…§%e\"£â\»2és!÷ßå!®Ø\'Û~\À\Îp\r#Je\Âπ+R=uù\À˙m£^JæÇUí|®≤\ F\ÔopìCºˆ˙(h_oI3ô\Ã]puB4˚+Æq.¢\÷Cóç∂I[\ŸIMõgTm(ã¸FÚáFúg/\"\ÍXñ∑ÆAˇ]ôØ\03#∞®)I\Œ5\„≠r\ÿ¨¿c”®} ™\„G\⁄˚Ö@©@Qæ|\0∫\¬E(àNëû\Âwî\ÿÃ•˛uD\ŒK\0ñ˛h\‘*\‰Y™C•.É1\€\‡UrX4<ûy¢\≈Ãê;≤\»˘_Bø@áD1p~mx\ﬁV\ÀﬁØ\Ëªg¥5ZeÚ+x\–\„\‡H∂\Ã\'\√P\rDÈæ¨ü\ÎÄlw≠ü˙ˆP\Õ\Ãd˘x\Ï>]h˜¸≠Bã∞õ\’Gºæ\‘GØ≠R∑¬à|\»\“`˝ú\ÈèQ\ÏÅ\Ív¢\€”†¿BøÜC,EÓ∂àRO¯g*µ˜/6Ú˚9†p™8!ƒ≠å\ÊÏîØ†q\"BZ45xH2≈¢-G:†ôI83%©æ\’$ÒÇ|ôãaY\€\0<‹¥§ZΩ\»W≥õ\ÿ0\Ï&™\—\Ê\œaTn\Õ\‡Uπ\ÿ√¢\”Ztöù¶ep™\Z\ÿ\‘i#EøôåF®6\Œ˝\È*\€\Ì\\\ÁÛoæ≠&H\'	ê=\–c6πm\"ƒ∂6®W\È\∆\‹JVQSq*Í≤®bßì¶,ÛQõ†©ûd∂±{\Œ4\“{r≤±\ u!∆≤\Ë\◊F°n£¶-Ëµí\Ãñ7aÆ\ÌL≠∏ëÉ\Í7i@\„{PûLÈñÆ%$ê\¬(\–Ù\'q˚∞c∂Ä\√w`ûî`@˘à5	¥eˆ¿∞\‘\„\Zó≤\»Ú9¿f’£°öóV%ıÆØ¢ìùM(ñ√´˙q\Œa˙\Ísæ\ﬂ˜QÄ\Ë®w^\Àìw\“\nRZ0«≤ãE\ÕO\‡tn`≈á\≈Ëó∏eY=\ﬁm.˘˜í\'2_™˝CN`∆Æä(!ñk\«˚M\–ƒç˚4uùõ∫%º4)±èH¶[¯\–/™;ı˝}\\å˛8õ*\‰X¸å\‘=Mwh\r\Zt\n\—\\\'\"\‹\n∆Ñ\ÏZ~M3µÅ-9\Ÿ8\⁄R8â§gÜ_@uWN¿\Ê4∫≤Íìöœπõ5b5\ÀÛT^RcSVhßb\‡>b\0#\‰è\ÿ5:°,˚w\ÃcTß®Pmaù\◊˘¢˙º\'¶ ˛E	e0\√X‘éBIãFx\\yæï¿U\Ïı\"≠8°ré\„ı[¸ÑE\ﬁr:!5àdIAñ\«h\Ì\'Z4Wt∞∂Å∂Øg\Œ4ÈÜ≤ˆv\‰<\«Q˝]à-Ùˇ\\\‚\ÿA(5`m,Ø	Áöå¬âíV®\Z˙XdØ\—*¶\ÁPbéı<¶B%+˚#c.V*†\È\ÌPéîò,V’ôy(:å\0∞F#\"|Fu7Üô¡™l+\0(øñ¥\Ô≈ÄÙbÛü≤Ç\Ã`x⁄óPR˝7’ù*)˘.^U(\Ë\\éŒúä˜;Ü∂ËÑ´P–ô\0Éyó\Z¿ô\Í\«Ò\Ë¸\0àj\À\Ï8ôß˝\Z\«\–Ûì\ﬁ\›y\ŸdÖQ\Êe©üÆZÛ	\∆EO¿∑˝\€h\¬u)à\–\–Óµ¥hª3∂!õ[SU\ƒ\'®\·_åàq¸¢ı\«(.˝îROØB\—bÚ∫Wõ—∂h\ÔØ‘ãG\r\»N´\÷¿)û\Œ\Ó\È|V¶F¸hˇ¡&D]\ÓÙ\ÍE4 kèy6hw\‚ı†=\ﬂ\‡\ƒ?D©Ω\'õ≥πïu¸b-\·Ts˚òGï≤îy≠yà¨`8ó¢\ﬂ\«<Ö\na+V\¬\rh˜2	Ûxö´1\◊—ñMAºÅyó)l\ﬁk$∏¸≥¨Hë\√yô7¸˝t\r¢ïj\ÀHÙ/6-\”J¿u&<}\"¢Qƒïn@{≥jK\Zµ.`-N±B⁄Ü\Èö”´hµM/^ïÇù\\ﬂÄ1vS\√/GJPî!Ω6#¢Ω£9∂:Cb˝±ˆÄ\ÊDƒçR\›_\Ã9ç¯ÜC\rã˛SU]SE4;ºÚ\–B™oØ\"¢(˘¯˜Px)\'å\ÂÃµp ≤\‘	ﬁù”ú{àP\Ô4	˛\Â0,@:\—LïçÅ\\j\’_˘g˘08Ç0\Ócã\"!\‹\Î,x77ÆÒ\Z\nùùd˚\"~Åh\‡É\Áì\Á∫˘\ﬁ~Pï9I∏˝,FS\Á\‘;km@F2?\n%˚5z|:˙∏5h\–D\Ì\€C\ÿtG\¬TETì\Â}-˛\Àqz\Á{\n•˚iI\Ó≥Qø3˛#\Ê\Ãdt˛-\∆!\ŸDWD\“#w#e&∞ö\ZÒ¿QND˚wÅïÄ›îj\Ìq≤¢\‘{p§£kõß£+‹è{gZ«´r–•l´¡\"¸lém$l\€p$I?Ä1ª`<\…¯\À:$ì\Í\ÏBi\ÊbñBìùc]ö\Œ›Äk8qç∞vçCîdíWì\ËxU\ﬁ\'πyûø¿°¨†Qí\È.à=oÖÅ3µÅVÖò %ñ˛|Fı\◊=äV\ +≠û$ãE\'^9Oı7K\Ì\œLıÉËΩ≤ZÖ\‰»´≥I\Œ4x¯áa∞\œ\¬Aï\·>\Œ\ƒgù–è∑≥≥æ\0`_c:\Z¡ò\rF¥(D\‰ù~@3—∑3)±æS:∏\ﬂ _?µÄì\\®M)\Ë¥\Ó8\÷~x/\∆\Ô¡\∆F!\’Pn\Èp/ÿΩ\Â\ÿ%h[p›ãXes,⁄æƒë¢\nieêL\”ò\…D˜ÅJKKrè\÷uîAò)J¿w\"ˆd¥±˛Ú•x^∂\Ã\‚W\»˚\np\”\…\Ê$π\∆\0D˜(¢-ã]ù]¢\”:Ühkπù\ÁiÑ¸d3˛ø™èÒ+\Ó;\ÿ\ﬂUn˛4\nK…∂P(P\«h˝\Î\◊\n;^ª∆≤î,]|ûÑXæÀ´±Tw	Vû\∆\ﬁv\0ºu™øè‡æûbS(¡\’ŸñZ?=g`xí\⁄—°5¿MY9\ZíÉ\\SÅl3®e:Y	j\ÊBn©v°J5ós˚z\“ùS\–\∆.\'\‘\“%õjhÃúÄ\0Z=_\Z¢Û•òˆh`oe[ö\‚∫\À)Ò#Ò2ßi∞\ÏùüM\…7◊ôébV˜ı´ÑN@tÚS˝_]ä\Î˝ˇwfHuÕôHe¶\„m\–\Èˇ\€Hk ZµD€Ω¯\Ó\'(òùÉäπNTª\Á|_;\Á\"¥\ÎVJLç…îiæÒÚ\À/˜Bhå†ë≥∏8\‚\"©\∆/\·!w\¬˚ö\Ï¿\Î\ F5\Â¸vT!+Q¡≠/AìFO“ò\“\Í4õCü\Zp0jCï\nJ\Ã\'6∏£Qö~\‘7vD3/\ÿB5®™\’@\€Z p\…\„\À˛_Ä\0≥‡Øòs]J˝\0\0\0\0IENDÆB`Ç'),(2,0,'Canned Attachments Rock!');
/*!40000 ALTER TABLE `ost_file_chunk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_filter`
--

DROP TABLE IF EXISTS `ost_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_filter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `execorder` int(10) unsigned NOT NULL DEFAULT '99',
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `status` int(11) unsigned NOT NULL DEFAULT '0',
  `match_all_rules` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `stop_onmatch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `target` enum('Any','Web','Email','API') NOT NULL DEFAULT 'Any',
  `email_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(32) NOT NULL DEFAULT '',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `target` (`target`),
  KEY `email_id` (`email_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_filter`
--

LOCK TABLES `ost_filter` WRITE;
/*!40000 ALTER TABLE `ost_filter` DISABLE KEYS */;
INSERT INTO `ost_filter` VALUES (1,99,1,0,0,0,'Email',0,'SYSTEM BAN LIST','Internal list for email banning. Do not remove','2017-11-29 22:48:48','2017-11-29 22:48:48');
/*!40000 ALTER TABLE `ost_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_filter_action`
--

DROP TABLE IF EXISTS `ost_filter_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_filter_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `filter_id` int(10) unsigned NOT NULL,
  `sort` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(24) NOT NULL,
  `configuration` text,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filter_id` (`filter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_filter_action`
--

LOCK TABLES `ost_filter_action` WRITE;
/*!40000 ALTER TABLE `ost_filter_action` DISABLE KEYS */;
INSERT INTO `ost_filter_action` VALUES (1,1,1,'reject','[]','2017-11-29 22:48:48');
/*!40000 ALTER TABLE `ost_filter_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_filter_rule`
--

DROP TABLE IF EXISTS `ost_filter_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_filter_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `filter_id` int(10) unsigned NOT NULL DEFAULT '0',
  `what` varchar(32) NOT NULL,
  `how` enum('equal','not_equal','contains','dn_contain','starts','ends','match','not_match') NOT NULL,
  `val` varchar(255) NOT NULL,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `notes` tinytext NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filter` (`filter_id`,`what`,`how`,`val`),
  KEY `filter_id` (`filter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_filter_rule`
--

LOCK TABLES `ost_filter_rule` WRITE;
/*!40000 ALTER TABLE `ost_filter_rule` DISABLE KEYS */;
INSERT INTO `ost_filter_rule` VALUES (1,1,'email','equal','test@example.com',1,'','2017-11-29 22:48:48','2017-11-29 22:48:48');
/*!40000 ALTER TABLE `ost_filter_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form`
--

DROP TABLE IF EXISTS `ost_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_form` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned DEFAULT NULL,
  `type` varchar(8) NOT NULL DEFAULT 'G',
  `flags` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(255) NOT NULL,
  `instructions` varchar(512) DEFAULT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form`
--

LOCK TABLES `ost_form` WRITE;
/*!40000 ALTER TABLE `ost_form` DISABLE KEYS */;
INSERT INTO `ost_form` VALUES (1,NULL,'U',1,'Contact Information',NULL,'',NULL,'2017-11-29 22:48:47','2017-11-29 22:48:47'),(2,NULL,'T',1,'Ticket Details','Please Describe Your Issue','','This form will be attached to every ticket, regardless of its source.\nYou can add any fields to this form and they will be available to all\ntickets, and will be searchable with advanced search and filterable.','2017-11-29 22:48:48','2017-11-29 22:48:48'),(3,NULL,'C',1,'Company Information','Details available in email templates','',NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(4,NULL,'O',1,'Organization Information','Details on user organization','',NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(5,NULL,'A',1,'Task Details','Please Describe The Issue','','This form is used to create a task.','2017-11-29 22:48:48','2017-11-29 22:48:48'),(6,NULL,'L1',1,'Ticket Status Properties','Properties that can be set on a ticket status.','',NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48');
/*!40000 ALTER TABLE `ost_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form_entry`
--

DROP TABLE IF EXISTS `ost_form_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_form_entry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(11) unsigned NOT NULL,
  `object_id` int(11) unsigned DEFAULT NULL,
  `object_type` char(1) NOT NULL DEFAULT 'T',
  `sort` int(11) unsigned NOT NULL DEFAULT '1',
  `extra` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_lookup` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_entry`
--

LOCK TABLES `ost_form_entry` WRITE;
/*!40000 ALTER TABLE `ost_form_entry` DISABLE KEYS */;
INSERT INTO `ost_form_entry` VALUES (1,4,1,'O',1,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(2,3,NULL,'C',1,NULL,'2017-11-29 22:48:54','2017-11-29 22:48:54'),(3,1,1,'U',1,NULL,'2017-11-29 22:48:54','2017-11-29 22:48:54'),(4,1,2,'U',1,NULL,'2017-11-29 22:52:23','2017-11-29 22:52:23'),(5,4,2,'O',1,NULL,'2017-11-29 22:53:06','2017-11-29 22:53:06'),(6,1,3,'U',1,NULL,'2017-11-29 22:54:31','2017-11-29 22:54:31'),(7,1,4,'U',1,NULL,'2017-11-29 22:55:00','2017-11-29 22:55:00'),(8,1,5,'U',1,NULL,'2017-11-29 22:55:27','2017-11-29 22:55:27'),(9,1,6,'U',1,NULL,'2017-11-29 22:55:58','2017-11-29 22:55:58'),(10,1,7,'U',1,NULL,'2017-11-29 22:56:28','2017-11-29 22:56:28'),(11,1,8,'U',1,NULL,'2017-11-29 22:56:47','2017-11-29 22:56:47'),(12,1,9,'U',1,NULL,'2017-11-29 22:57:06','2017-11-29 22:57:06'),(13,1,10,'U',1,NULL,'2017-11-29 22:57:24','2017-11-29 22:57:24'),(14,2,2,'T',0,'{\"disable\":[]}','2017-11-29 22:59:23','2017-11-29 22:59:23'),(15,2,3,'T',0,'{\"disable\":[]}','2017-11-29 23:01:41','2017-11-29 23:01:41'),(16,2,4,'T',0,'{\"disable\":[]}','2017-11-29 23:03:26','2017-11-29 23:03:26'),(17,2,5,'T',0,'{\"disable\":[]}','2017-11-29 23:04:51','2017-11-29 23:04:51'),(18,5,1,'A',1,NULL,'2017-11-29 23:07:01','2017-11-29 23:07:01'),(19,1,11,'U',1,NULL,'2017-11-29 23:09:16','2017-11-29 23:09:16'),(20,2,6,'T',0,'{\"disable\":[]}','2017-11-29 23:09:16','2017-11-29 23:09:16');
/*!40000 ALTER TABLE `ost_form_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form_entry_values`
--

DROP TABLE IF EXISTS `ost_form_entry_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_form_entry_values` (
  `entry_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `value` text,
  `value_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`entry_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_entry_values`
--

LOCK TABLES `ost_form_entry_values` WRITE;
/*!40000 ALTER TABLE `ost_form_entry_values` DISABLE KEYS */;
INSERT INTO `ost_form_entry_values` VALUES (1,28,'420 Desoto Street\nAlexandria, LA 71301',NULL),(1,29,'3182903674',NULL),(1,30,'http://osticket.com',NULL),(1,31,'Not only do we develop the software, we also use it to manage support for osTicket. Let us help you quickly implement and leverage the full potential of osTicket\'s features and functionality. Contact us for professional support or visit our website for documentation and community support.',NULL),(2,23,'Microsoft Cloud Workshop',NULL),(2,24,NULL,NULL),(2,25,'4255551212',NULL),(2,26,NULL,NULL),(3,3,NULL,NULL),(3,4,NULL,NULL),(4,3,'2125551212',NULL),(4,4,NULL,NULL),(5,28,'One Contoso Way\r\nRedmond, WA 98058',NULL),(5,29,'4255551212',NULL),(5,30,'www.contoso.com',NULL),(5,31,'This is our Biggest customer!',NULL),(6,3,'2125551212',NULL),(6,4,NULL,NULL),(7,3,'2125551212',NULL),(7,4,NULL,NULL),(8,3,'2125551212',NULL),(8,4,NULL,NULL),(9,3,'2125551212',NULL),(9,4,NULL,NULL),(10,3,'2125551212',NULL),(10,4,NULL,NULL),(11,3,'4255551212',NULL),(11,4,NULL,NULL),(12,3,'4255551212',NULL),(12,4,NULL,NULL),(13,3,'4255551212',NULL),(13,4,NULL,NULL),(14,20,'Issue with Laptop',NULL),(14,22,'High',3),(15,20,'CRM',NULL),(15,22,'Normal',2),(16,20,'Need access to Support File Share',NULL),(16,22,'Normal',2),(17,20,'Printer Issue in Build 11',NULL),(17,22,'Normal',2),(18,32,'Monthly Download Time to Update Servers',NULL),(19,3,'2125551212',NULL),(19,4,NULL,NULL),(20,20,'New Laptop',NULL),(20,22,'Normal',2);
/*!40000 ALTER TABLE `ost_form_entry_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form_field`
--

DROP TABLE IF EXISTS `ost_form_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_form_field` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(11) unsigned NOT NULL,
  `flags` int(10) unsigned DEFAULT '1',
  `type` varchar(255) NOT NULL DEFAULT 'text',
  `label` varchar(255) NOT NULL,
  `name` varchar(64) NOT NULL,
  `configuration` text,
  `sort` int(11) unsigned NOT NULL,
  `hint` varchar(512) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_field`
--

LOCK TABLES `ost_form_field` WRITE;
/*!40000 ALTER TABLE `ost_form_field` DISABLE KEYS */;
INSERT INTO `ost_form_field` VALUES (1,1,489379,'text','Email Address','email','{\"size\":40,\"length\":64,\"validator\":\"email\"}',1,NULL,'2017-11-29 22:48:47','2017-11-29 22:48:47'),(2,1,489379,'text','Full Name','name','{\"size\":40,\"length\":64}',2,NULL,'2017-11-29 22:48:47','2017-11-29 22:48:47'),(3,1,13057,'phone','Phone Number','phone',NULL,3,NULL,'2017-11-29 22:48:47','2017-11-29 22:48:47'),(4,1,12289,'memo','Internal Notes','notes','{\"rows\":4,\"cols\":40}',4,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(20,2,489249,'text','Issue Summary','subject','{\"size\":40,\"length\":50}',1,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(21,2,480547,'thread','Issue Details','message',NULL,2,'Details on the reason(s) for opening the ticket.','2017-11-29 22:48:48','2017-11-29 22:48:48'),(22,2,274609,'priority','Priority Level','priority',NULL,3,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(23,3,291233,'text','Company Name','name','{\"size\":40,\"length\":64}',1,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(24,3,12545,'text','Website','website','{\"size\":40,\"length\":64}',2,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(25,3,12545,'phone','Phone Number','phone','{\"ext\":false}',3,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(26,3,12545,'memo','Address','address','{\"rows\":2,\"cols\":40,\"html\":false,\"length\":100}',4,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(27,4,489379,'text','Name','name','{\"size\":40,\"length\":64}',1,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(28,4,13057,'memo','Address','address','{\"rows\":2,\"cols\":40,\"length\":100,\"html\":false}',2,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(29,4,13057,'phone','Phone','phone',NULL,3,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(30,4,13057,'text','Website','website','{\"size\":40,\"length\":0}',4,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(31,4,12289,'memo','Internal Notes','notes','{\"rows\":4,\"cols\":40}',5,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(32,5,290977,'text','Title','title','{\"size\":40,\"length\":50}',1,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(33,5,282867,'thread','Description','description',NULL,2,'Details on the reason(s) for creating the task.','2017-11-29 22:48:48','2017-11-29 22:48:48'),(34,6,487665,'state','State','state','{\"prompt\":\"State of a ticket\"}',1,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48'),(35,6,471073,'memo','Description','description','{\"rows\":2,\"cols\":40,\"html\":false,\"length\":100}',3,NULL,'2017-11-29 22:48:48','2017-11-29 22:48:48');
/*!40000 ALTER TABLE `ost_form_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_group`
--

DROP TABLE IF EXISTS `ost_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(11) unsigned NOT NULL,
  `flags` int(11) unsigned NOT NULL DEFAULT '1',
  `name` varchar(120) NOT NULL DEFAULT '',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_group`
--

LOCK TABLES `ost_group` WRITE;
/*!40000 ALTER TABLE `ost_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_help_topic`
--

DROP TABLE IF EXISTS `ost_help_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_help_topic` (
  `topic_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_pid` int(10) unsigned NOT NULL DEFAULT '0',
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `ispublic` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `noautoresp` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned DEFAULT '0',
  `status_id` int(10) unsigned NOT NULL DEFAULT '0',
  `priority_id` int(10) unsigned NOT NULL DEFAULT '0',
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(10) unsigned NOT NULL DEFAULT '0',
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sla_id` int(10) unsigned NOT NULL DEFAULT '0',
  `page_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sequence_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sort` int(10) unsigned NOT NULL DEFAULT '0',
  `topic` varchar(32) NOT NULL DEFAULT '',
  `number_format` varchar(32) DEFAULT NULL,
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`topic_id`),
  UNIQUE KEY `topic` (`topic`,`topic_pid`),
  KEY `topic_pid` (`topic_pid`),
  KEY `priority_id` (`priority_id`),
  KEY `dept_id` (`dept_id`),
  KEY `staff_id` (`staff_id`,`team_id`),
  KEY `sla_id` (`sla_id`),
  KEY `page_id` (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_help_topic`
--

LOCK TABLES `ost_help_topic` WRITE;
/*!40000 ALTER TABLE `ost_help_topic` DISABLE KEYS */;
INSERT INTO `ost_help_topic` VALUES (1,0,1,1,0,0,0,2,0,0,0,0,0,0,1,'General Inquiry',NULL,'Questions about products or services','2017-11-29 22:48:48','2017-11-29 22:48:48'),(2,0,1,1,0,0,0,1,0,0,0,0,0,0,0,'Feedback',NULL,'Tickets that primarily concern the sales and billing departments','2017-11-29 22:48:48','2017-11-29 22:48:48'),(10,0,1,1,0,0,0,2,3,0,0,0,0,0,0,'Report a Problem',NULL,'Product, service, or equipment related issues','2017-11-29 22:48:48','2017-11-29 22:48:48'),(11,10,1,1,0,0,0,3,0,0,0,1,0,0,1,'Access Issue',NULL,'Report an inability access a physical or virtual asset','2017-11-29 22:48:48','2017-11-29 22:48:48');
/*!40000 ALTER TABLE `ost_help_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_help_topic_form`
--

DROP TABLE IF EXISTS `ost_help_topic_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_help_topic_form` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) unsigned NOT NULL DEFAULT '0',
  `form_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sort` int(10) unsigned NOT NULL DEFAULT '1',
  `extra` text,
  PRIMARY KEY (`id`),
  KEY `topic-form` (`topic_id`,`form_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_help_topic_form`
--

LOCK TABLES `ost_help_topic_form` WRITE;
/*!40000 ALTER TABLE `ost_help_topic_form` DISABLE KEYS */;
INSERT INTO `ost_help_topic_form` VALUES (1,1,2,1,'{\"disable\":[]}'),(2,2,2,1,'{\"disable\":[]}'),(3,10,2,1,'{\"disable\":[]}'),(4,11,2,1,'{\"disable\":[]}');
/*!40000 ALTER TABLE `ost_help_topic_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_list`
--

DROP TABLE IF EXISTS `ost_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_plural` varchar(255) DEFAULT NULL,
  `sort_mode` enum('Alpha','-Alpha','SortCol') NOT NULL DEFAULT 'Alpha',
  `masks` int(11) unsigned NOT NULL DEFAULT '0',
  `type` varchar(16) DEFAULT NULL,
  `configuration` text NOT NULL,
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_list`
--

LOCK TABLES `ost_list` WRITE;
/*!40000 ALTER TABLE `ost_list` DISABLE KEYS */;
INSERT INTO `ost_list` VALUES (1,'Ticket Status','Ticket Statuses','SortCol',13,'ticket-status','{\"handler\":\"TicketStatusList\"}','Ticket statuses','2017-11-29 22:48:48','2017-11-29 22:48:48');
/*!40000 ALTER TABLE `ost_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_list_items`
--

DROP TABLE IF EXISTS `ost_list_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_list_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) DEFAULT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT '1',
  `value` varchar(255) NOT NULL,
  `extra` varchar(255) DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT '1',
  `properties` text,
  PRIMARY KEY (`id`),
  KEY `list_item_lookup` (`list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_list_items`
--

LOCK TABLES `ost_list_items` WRITE;
/*!40000 ALTER TABLE `ost_list_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_list_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_lock`
--

DROP TABLE IF EXISTS `ost_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_lock` (
  `lock_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned NOT NULL DEFAULT '0',
  `expire` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`lock_id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_lock`
--

LOCK TABLES `ost_lock` WRITE;
/*!40000 ALTER TABLE `ost_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_note`
--

DROP TABLE IF EXISTS `ost_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_note` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT NULL,
  `staff_id` int(11) unsigned NOT NULL DEFAULT '0',
  `ext_id` varchar(10) DEFAULT NULL,
  `body` text,
  `status` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ext_id` (`ext_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_note`
--

LOCK TABLES `ost_note` WRITE;
/*!40000 ALTER TABLE `ost_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_organization`
--

DROP TABLE IF EXISTS `ost_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_organization` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `manager` varchar(16) NOT NULL DEFAULT '',
  `status` int(11) unsigned NOT NULL DEFAULT '0',
  `domain` varchar(256) NOT NULL DEFAULT '',
  `extra` text,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_organization`
--

LOCK TABLES `ost_organization` WRITE;
/*!40000 ALTER TABLE `ost_organization` DISABLE KEYS */;
INSERT INTO `ost_organization` VALUES (1,'osTicket','',8,'',NULL,'2017-11-29 22:48:48',NULL),(2,'Contoso','',8,'',NULL,'2017-11-29 22:53:06','2017-11-29 22:53:06');
/*!40000 ALTER TABLE `ost_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_organization__cdata`
--

DROP TABLE IF EXISTS `ost_organization__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_organization__cdata` (
  `org_id` int(11) unsigned NOT NULL,
  `name` mediumtext,
  `address` mediumtext,
  `phone` mediumtext,
  `website` mediumtext,
  `notes` mediumtext,
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_organization__cdata`
--

LOCK TABLES `ost_organization__cdata` WRITE;
/*!40000 ALTER TABLE `ost_organization__cdata` DISABLE KEYS */;
INSERT INTO `ost_organization__cdata` VALUES (1,NULL,'420 Desoto Street\nAlexandria, LA 71301','3182903674','http://osticket.com','Not only do we develop the software, we also use it to manage support for osTicket. Let us help you quickly implement and leverage the full potential of osTicket\'s features and functionality. Contact us for professional support or visit our website for documentation and community support.'),(2,NULL,'One Contoso Way\r\nRedmond, WA 98058','4255551212','www.contoso.com','This is our Biggest customer!');
/*!40000 ALTER TABLE `ost_organization__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_plugin`
--

DROP TABLE IF EXISTS `ost_plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `install_path` varchar(60) NOT NULL,
  `isphar` tinyint(1) NOT NULL DEFAULT '0',
  `isactive` tinyint(1) NOT NULL DEFAULT '0',
  `version` varchar(64) DEFAULT NULL,
  `installed` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_plugin`
--

LOCK TABLES `ost_plugin` WRITE;
/*!40000 ALTER TABLE `ost_plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue`
--

DROP TABLE IF EXISTS `ost_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_queue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0',
  `flags` int(11) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `title` varchar(60) DEFAULT NULL,
  `config` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue`
--

LOCK TABLES `ost_queue` WRITE;
/*!40000 ALTER TABLE `ost_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_role`
--

DROP TABLE IF EXISTS `ost_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `flags` int(10) unsigned NOT NULL DEFAULT '1',
  `name` varchar(64) DEFAULT NULL,
  `permissions` text,
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_role`
--

LOCK TABLES `ost_role` WRITE;
/*!40000 ALTER TABLE `ost_role` DISABLE KEYS */;
INSERT INTO `ost_role` VALUES (1,1,'All Access','{\"ticket.create\":1,\"ticket.edit\":1,\"ticket.assign\":1,\"ticket.transfer\":1,\"ticket.reply\":1,\"ticket.close\":1,\"ticket.delete\":1,\"thread.edit\":1,\"task.create\":1,\"task.edit\":1,\"task.assign\":1,\"task.transfer\":1,\"task.reply\":1,\"task.close\":1,\"task.delete\":1,\"canned.manage\":1}','Role with unlimited access','2017-11-29 22:48:49','2017-11-29 22:48:49'),(2,1,'Expanded Access','{\"ticket.create\":1,\"ticket.edit\":1,\"ticket.assign\":1,\"ticket.transfer\":1,\"ticket.reply\":1,\"ticket.close\":1,\"task.create\":1,\"task.edit\":1,\"task.assign\":1,\"task.transfer\":1,\"task.reply\":1,\"task.close\":1,\"canned.manage\":1}','Role with expanded access','2017-11-29 22:48:49','2017-11-29 22:48:49'),(3,1,'Limited Access','{\"ticket.create\":1,\"ticket.assign\":1,\"ticket.transfer\":1,\"task.assign\":1,\"task.transfer\":1,\"task.reply\":1}','Role with limited access','2017-11-29 22:48:49','2017-11-29 22:48:49'),(4,1,'View only',NULL,'Simple role with no permissions','2017-11-29 22:48:49','2017-11-29 22:48:49');
/*!40000 ALTER TABLE `ost_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_sequence`
--

DROP TABLE IF EXISTS `ost_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_sequence` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `flags` int(10) unsigned DEFAULT NULL,
  `next` bigint(20) unsigned NOT NULL DEFAULT '1',
  `increment` int(11) DEFAULT '1',
  `padding` char(1) DEFAULT '0',
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_sequence`
--

LOCK TABLES `ost_sequence` WRITE;
/*!40000 ALTER TABLE `ost_sequence` DISABLE KEYS */;
INSERT INTO `ost_sequence` VALUES (1,'General Tickets',1,1,1,'0','0000-00-00 00:00:00'),(2,'Tasks Sequence',1,2,1,'0','2017-11-29 23:07:01');
/*!40000 ALTER TABLE `ost_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_session`
--

DROP TABLE IF EXISTS `ost_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_session` (
  `session_id` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '',
  `session_data` blob,
  `session_expire` datetime DEFAULT NULL,
  `session_updated` datetime DEFAULT NULL,
  `user_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT 'osTicket staff/client ID',
  `user_ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `updated` (`session_updated`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_session`
--

LOCK TABLES `ost_session` WRITE;
/*!40000 ALTER TABLE `ost_session` DISABLE KEYS */;
INSERT INTO `ost_session` VALUES ('f9enqms2lfvc2m9re2h22aiab4','csrf|a:2:{s:5:\"token\";s:40:\"93270d9014190662f6e554ba8bfa12fad07e49e6\";s:4:\"time\";i:1511997066;}_auth|a:1:{s:5:\"staff\";N;}','2017-11-30 23:11:06',NULL,'0','76.108.130.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'),('i5nlkqsdj715gfg6hpaqgpkhk6','csrf|a:2:{s:5:\"token\";s:40:\"c91ee56d846317b540054bd41d5a2ea8abf84a1a\";s:4:\"time\";i:1511998208;}','2017-11-30 23:30:08',NULL,'0','127.0.0.1','curl/7.47.0');
/*!40000 ALTER TABLE `ost_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_sla`
--

DROP TABLE IF EXISTS `ost_sla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_sla` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `flags` int(10) unsigned NOT NULL DEFAULT '3',
  `grace_period` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT '',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_sla`
--

LOCK TABLES `ost_sla` WRITE;
/*!40000 ALTER TABLE `ost_sla` DISABLE KEYS */;
INSERT INTO `ost_sla` VALUES (1,3,48,'Default SLA',NULL,'2017-11-29 22:48:47','2017-11-29 22:48:47');
/*!40000 ALTER TABLE `ost_sla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_staff`
--

DROP TABLE IF EXISTS `ost_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_staff` (
  `staff_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0',
  `username` varchar(32) NOT NULL DEFAULT '',
  `firstname` varchar(32) DEFAULT NULL,
  `lastname` varchar(32) DEFAULT NULL,
  `passwd` varchar(128) DEFAULT NULL,
  `backend` varchar(32) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `phone` varchar(24) NOT NULL DEFAULT '',
  `phone_ext` varchar(6) DEFAULT NULL,
  `mobile` varchar(24) NOT NULL DEFAULT '',
  `signature` text NOT NULL,
  `lang` varchar(16) DEFAULT NULL,
  `timezone` varchar(64) DEFAULT NULL,
  `locale` varchar(16) DEFAULT NULL,
  `notes` text,
  `isactive` tinyint(1) NOT NULL DEFAULT '1',
  `isadmin` tinyint(1) NOT NULL DEFAULT '0',
  `isvisible` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `onvacation` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `assigned_only` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `show_assigned_tickets` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `change_passwd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `max_page_size` int(11) unsigned NOT NULL DEFAULT '0',
  `auto_refresh_rate` int(10) unsigned NOT NULL DEFAULT '0',
  `default_signature_type` enum('none','mine','dept') NOT NULL DEFAULT 'none',
  `default_paper_size` enum('Letter','Legal','Ledger','A4','A3') NOT NULL DEFAULT 'Letter',
  `extra` text,
  `permissions` text,
  `created` datetime NOT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `passwdreset` datetime DEFAULT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `username` (`username`),
  KEY `dept_id` (`dept_id`),
  KEY `issuperuser` (`isadmin`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_staff`
--

LOCK TABLES `ost_staff` WRITE;
/*!40000 ALTER TABLE `ost_staff` DISABLE KEYS */;
INSERT INTO `ost_staff` VALUES (1,1,1,'demouser','Demo','User','$2a$08$iUB8qv9REAYmv.hNzDZyu..lGQ5h3ZG.rK29CcuAjpIxFJc96s2fq',NULL,'demouser@opsgility.com','',NULL,'(425) 555-1212','Thank you,<br />Demo User<br />\"We are here when you need us most!\"<br /><br />',NULL,NULL,NULL,NULL,1,1,1,0,0,0,0,25,0,'none','Letter','{\"browser_lang\":\"en_US\"}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1,\"emails.banlist\":1}','2017-11-29 22:48:54','2017-11-29 23:09:50','2017-11-29 22:48:54','2017-11-29 23:09:50');
/*!40000 ALTER TABLE `ost_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_staff_dept_access`
--

DROP TABLE IF EXISTS `ost_staff_dept_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_staff_dept_access` (
  `staff_id` int(10) unsigned NOT NULL DEFAULT '0',
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`staff_id`,`dept_id`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_staff_dept_access`
--

LOCK TABLES `ost_staff_dept_access` WRITE;
/*!40000 ALTER TABLE `ost_staff_dept_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_staff_dept_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_syslog`
--

DROP TABLE IF EXISTS `ost_syslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_syslog` (
  `log_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `log_type` enum('Debug','Warning','Error') NOT NULL,
  `title` varchar(255) NOT NULL,
  `log` text NOT NULL,
  `logger` varchar(64) NOT NULL,
  `ip_address` varchar(64) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `log_type` (`log_type`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_syslog`
--

LOCK TABLES `ost_syslog` WRITE;
/*!40000 ALTER TABLE `ost_syslog` DISABLE KEYS */;
INSERT INTO `ost_syslog` VALUES (1,'Error','Mailer Error','Unable to email via php mail function:demouser@opsgility.com mail() returned failure ','','76.108.130.187','2017-11-29 22:59:24','2017-11-29 22:59:24'),(2,'Error','Mailer Error','Unable to email via php mail function:\"Carola Wagoner\" mail() returned failure ','','76.108.130.187','2017-11-29 22:59:24','2017-11-29 22:59:24'),(3,'Error','Mailer Error','Unable to email via php mail function:demouser@opsgility.com mail() returned failure ','','76.108.130.187','2017-11-29 23:01:41','2017-11-29 23:01:41'),(4,'Error','Mailer Error','Unable to email via php mail function:\"Dino Aschenbrenner\" mail() returned failure ','','76.108.130.187','2017-11-29 23:01:41','2017-11-29 23:01:41'),(5,'Error','Mailer Error','Unable to email via php mail function:demouser@opsgility.com mail() returned failure ','','76.108.130.187','2017-11-29 23:03:26','2017-11-29 23:03:26'),(6,'Error','Mailer Error','Unable to email via php mail function:\"Lyn Jumper\" mail() returned failure ','','76.108.130.187','2017-11-29 23:03:27','2017-11-29 23:03:27'),(7,'Error','Mailer Error','Unable to email via php mail function:demouser@opsgility.com mail() returned failure ','','76.108.130.187','2017-11-29 23:04:52','2017-11-29 23:04:52'),(8,'Error','Mailer Error','Unable to email via php mail function:\"Meridith Downey\" mail() returned failure ','','76.108.130.187','2017-11-29 23:04:52','2017-11-29 23:04:52'),(9,'Error','Mailer Error','Unable to email via php mail function:demouser@opsgility.com mail() returned failure ','','76.108.130.187','2017-11-29 23:09:17','2017-11-29 23:09:17');
/*!40000 ALTER TABLE `ost_syslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_task`
--

DROP TABLE IF EXISTS `ost_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_task` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL DEFAULT '0',
  `object_type` char(1) NOT NULL,
  `number` varchar(20) DEFAULT NULL,
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(10) unsigned NOT NULL DEFAULT '0',
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lock_id` int(11) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `duedate` datetime DEFAULT NULL,
  `closed` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dept_id` (`dept_id`),
  KEY `staff_id` (`staff_id`),
  KEY `team_id` (`team_id`),
  KEY `created` (`created`),
  KEY `object` (`object_id`,`object_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_task`
--

LOCK TABLES `ost_task` WRITE;
/*!40000 ALTER TABLE `ost_task` DISABLE KEYS */;
INSERT INTO `ost_task` VALUES (1,0,'','1',1,1,0,0,1,'2017-11-30 23:00:00',NULL,'2017-11-29 23:07:01','2017-11-29 23:07:01');
/*!40000 ALTER TABLE `ost_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_task__cdata`
--

DROP TABLE IF EXISTS `ost_task__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_task__cdata` (
  `task_id` int(11) unsigned NOT NULL,
  `title` mediumtext,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_task__cdata`
--

LOCK TABLES `ost_task__cdata` WRITE;
/*!40000 ALTER TABLE `ost_task__cdata` DISABLE KEYS */;
INSERT INTO `ost_task__cdata` VALUES (1,'Monthly Download Time to Update Servers');
/*!40000 ALTER TABLE `ost_task__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_team`
--

DROP TABLE IF EXISTS `ost_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_team` (
  `team_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` int(10) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '1',
  `name` varchar(125) NOT NULL DEFAULT '',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`team_id`),
  UNIQUE KEY `name` (`name`),
  KEY `lead_id` (`lead_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_team`
--

LOCK TABLES `ost_team` WRITE;
/*!40000 ALTER TABLE `ost_team` DISABLE KEYS */;
INSERT INTO `ost_team` VALUES (1,0,1,'Level I Support','Tier 1 support, responsible for the initial iteraction with customers','2017-11-29 22:48:48','2017-11-29 22:48:48');
/*!40000 ALTER TABLE `ost_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_team_member`
--

DROP TABLE IF EXISTS `ost_team_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_team_member` (
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(10) unsigned NOT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`team_id`,`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_team_member`
--

LOCK TABLES `ost_team_member` WRITE;
/*!40000 ALTER TABLE `ost_team_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_team_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread`
--

DROP TABLE IF EXISTS `ost_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_thread` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) unsigned NOT NULL,
  `object_type` char(1) NOT NULL,
  `extra` text,
  `lastresponse` datetime DEFAULT NULL,
  `lastmessage` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object_id` (`object_id`),
  KEY `object_type` (`object_type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread`
--

LOCK TABLES `ost_thread` WRITE;
/*!40000 ALTER TABLE `ost_thread` DISABLE KEYS */;
INSERT INTO `ost_thread` VALUES (1,1,'T',NULL,NULL,NULL,'2017-11-29 22:48:54'),(2,2,'T',NULL,'2017-11-29 22:59:24','2017-11-29 22:59:23','2017-11-29 22:59:23'),(3,3,'T',NULL,'2017-11-29 23:01:41','2017-11-29 23:01:41','2017-11-29 23:01:41'),(4,4,'T',NULL,'2017-11-29 23:03:26','2017-11-29 23:03:26','2017-11-29 23:03:26'),(5,5,'T',NULL,'2017-11-29 23:04:52','2017-11-29 23:04:52','2017-11-29 23:04:51'),(6,1,'A',NULL,NULL,NULL,'2017-11-29 23:07:02'),(7,6,'T',NULL,NULL,'2017-11-29 23:09:17','2017-11-29 23:09:16');
/*!40000 ALTER TABLE `ost_thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_collaborator`
--

DROP TABLE IF EXISTS `ost_thread_collaborator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_thread_collaborator` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) NOT NULL DEFAULT '1',
  `thread_id` int(11) unsigned NOT NULL DEFAULT '0',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `role` char(1) NOT NULL DEFAULT 'M',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collab` (`thread_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_collaborator`
--

LOCK TABLES `ost_thread_collaborator` WRITE;
/*!40000 ALTER TABLE `ost_thread_collaborator` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_thread_collaborator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_entry`
--

DROP TABLE IF EXISTS `ost_thread_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_thread_entry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0',
  `thread_id` int(11) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(11) unsigned NOT NULL DEFAULT '0',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `type` char(1) NOT NULL DEFAULT '',
  `flags` int(11) unsigned NOT NULL DEFAULT '0',
  `poster` varchar(128) NOT NULL DEFAULT '',
  `editor` int(10) unsigned DEFAULT NULL,
  `editor_type` char(1) DEFAULT NULL,
  `source` varchar(32) NOT NULL DEFAULT '',
  `title` varchar(255) DEFAULT NULL,
  `body` text NOT NULL,
  `format` varchar(16) NOT NULL DEFAULT 'html',
  `ip_address` varchar(64) NOT NULL DEFAULT '',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `thread_id` (`thread_id`),
  KEY `staff_id` (`staff_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_entry`
--

LOCK TABLES `ost_thread_entry` WRITE;
/*!40000 ALTER TABLE `ost_thread_entry` DISABLE KEYS */;
INSERT INTO `ost_thread_entry` VALUES (1,0,2,0,4,'M',65,'Carola Wagoner',NULL,NULL,'Phone',NULL,'User reports issue with their Laptop. Need to scan for malware and update to new anti-virus software.','html','76.108.130.187','2017-11-29 22:59:23','0000-00-00 00:00:00'),(2,1,2,1,0,'R',64,'Demo User',NULL,NULL,'Phone',NULL,'Hi Carola, <br /> <br /> Your ticket #519418 created on 11/29/2017 05:59:23 PM is in Maintenance department.','html','76.108.130.187','2017-11-29 22:59:24','0000-00-00 00:00:00'),(3,0,3,0,5,'M',65,'Dino Aschenbrenner',NULL,NULL,'Email',NULL,'Customer wants to be added to the CRM tool since they are a new user and on the sales team.','html','76.108.130.187','2017-11-29 23:01:41','0000-00-00 00:00:00'),(4,3,3,1,0,'R',64,'Demo User',NULL,NULL,'Email',NULL,'Hi Dino, <br /> <br /> Your ticket #631597 created on 11/29/2017 06:01:40 PM is in Sales department.','html','76.108.130.187','2017-11-29 23:01:41','0000-00-00 00:00:00'),(5,0,4,0,6,'M',65,'Lyn Jumper',NULL,NULL,'Email',NULL,'Customer needs access to the Support Services File Share.','html','76.108.130.187','2017-11-29 23:03:26','0000-00-00 00:00:00'),(6,5,4,1,0,'R',64,'Demo User',NULL,NULL,'Email',NULL,'Hi Lyn, <br /> <br /> Your ticket #190563 created on 11/29/2017 06:03:26 PM is in Support department.','html','76.108.130.187','2017-11-29 23:03:26','0000-00-00 00:00:00'),(7,0,5,0,8,'M',65,'Meridith Downey',NULL,NULL,'Other',NULL,'Customer walked into Helpdesk area and mentioned that the large copier on the first floor of Building 11 is not working properly.','html','76.108.130.187','2017-11-29 23:04:51','0000-00-00 00:00:00'),(8,7,5,1,0,'R',64,'Demo User',NULL,NULL,'Other',NULL,'Hi Meridith, <br /> <br /> Your ticket #727678 created on 11/29/2017 06:04:51 PM is in Maintenance department.','html','76.108.130.187','2017-11-29 23:04:52','0000-00-00 00:00:00'),(9,0,6,1,0,'M',64,'Demo User',NULL,NULL,'',NULL,'All Servers on the Website will be updated to the latest patch leve.','html','76.108.130.187','2017-11-29 23:07:02','0000-00-00 00:00:00'),(10,0,7,0,11,'M',65,'Hailey Laber',NULL,NULL,'',NULL,'My manager advised me to contact the helpdesk to get a new laptop. My current computer is to old and slow to use anymore. Can I get a Microsoft Surface?<br /><br />Thanks,<br />Hailey','html','76.108.130.187','2017-11-29 23:09:16','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `ost_thread_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_entry_email`
--

DROP TABLE IF EXISTS `ost_thread_entry_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_thread_entry_email` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `thread_entry_id` int(11) unsigned NOT NULL,
  `mid` varchar(255) NOT NULL,
  `headers` text,
  PRIMARY KEY (`id`),
  KEY `thread_entry_id` (`thread_entry_id`),
  KEY `mid` (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_entry_email`
--

LOCK TABLES `ost_thread_entry_email` WRITE;
/*!40000 ALTER TABLE `ost_thread_entry_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_thread_entry_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_event`
--

DROP TABLE IF EXISTS `ost_thread_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_thread_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(11) unsigned NOT NULL,
  `team_id` int(11) unsigned NOT NULL,
  `dept_id` int(11) unsigned NOT NULL,
  `topic_id` int(11) unsigned NOT NULL,
  `state` enum('created','closed','reopened','assigned','transferred','overdue','edited','viewed','error','collab','resent') NOT NULL,
  `data` varchar(1024) DEFAULT NULL COMMENT 'Encoded differences',
  `username` varchar(128) NOT NULL DEFAULT 'SYSTEM',
  `uid` int(11) unsigned DEFAULT NULL,
  `uid_type` char(1) NOT NULL DEFAULT 'S',
  `annulled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_state` (`thread_id`,`state`,`timestamp`),
  KEY `ticket_stats` (`timestamp`,`state`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_event`
--

LOCK TABLES `ost_thread_event` WRITE;
/*!40000 ALTER TABLE `ost_thread_event` DISABLE KEYS */;
INSERT INTO `ost_thread_event` VALUES (1,2,0,0,3,10,'created',NULL,'demouser',1,'S',0,'2017-11-29 22:59:23'),(2,2,1,0,3,10,'assigned','{\"claim\":true}','demouser',1,'S',0,'2017-11-29 22:59:24'),(3,3,0,0,2,1,'created',NULL,'demouser',1,'S',0,'2017-11-29 23:01:41'),(4,3,1,0,2,1,'assigned','{\"claim\":true}','demouser',1,'S',0,'2017-11-29 23:01:41'),(5,4,0,0,1,11,'created',NULL,'demouser',1,'S',0,'2017-11-29 23:03:26'),(6,4,1,0,1,11,'assigned','{\"claim\":true}','demouser',1,'S',0,'2017-11-29 23:03:26'),(7,5,0,0,3,10,'created',NULL,'demouser',1,'S',0,'2017-11-29 23:04:51'),(8,5,1,0,3,10,'assigned','{\"claim\":true}','demouser',1,'S',0,'2017-11-29 23:04:52'),(9,6,0,0,0,0,'created',NULL,'demouser',1,'S',0,'2017-11-29 23:07:02'),(10,6,0,0,0,0,'assigned','{\"claim\":true}','demouser',1,'S',0,'2017-11-29 23:07:02'),(11,7,0,0,3,10,'created',NULL,'SYSTEM',11,'U',0,'2017-11-29 23:09:16');
/*!40000 ALTER TABLE `ost_thread_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket`
--

DROP TABLE IF EXISTS `ost_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_ticket` (
  `ticket_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(20) DEFAULT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `user_email_id` int(11) unsigned NOT NULL DEFAULT '0',
  `status_id` int(10) unsigned NOT NULL DEFAULT '0',
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sla_id` int(10) unsigned NOT NULL DEFAULT '0',
  `topic_id` int(10) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(10) unsigned NOT NULL DEFAULT '0',
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `email_id` int(11) unsigned NOT NULL DEFAULT '0',
  `lock_id` int(11) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `ip_address` varchar(64) NOT NULL DEFAULT '',
  `source` enum('Web','Email','Phone','API','Other') NOT NULL DEFAULT 'Other',
  `source_extra` varchar(40) DEFAULT NULL,
  `isoverdue` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isanswered` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `duedate` datetime DEFAULT NULL,
  `est_duedate` datetime DEFAULT NULL,
  `reopened` datetime DEFAULT NULL,
  `closed` datetime DEFAULT NULL,
  `lastupdate` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `user_id` (`user_id`),
  KEY `dept_id` (`dept_id`),
  KEY `staff_id` (`staff_id`),
  KEY `team_id` (`team_id`),
  KEY `status_id` (`status_id`),
  KEY `created` (`created`),
  KEY `closed` (`closed`),
  KEY `duedate` (`duedate`),
  KEY `topic_id` (`topic_id`),
  KEY `sla_id` (`sla_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket`
--

LOCK TABLES `ost_ticket` WRITE;
/*!40000 ALTER TABLE `ost_ticket` DISABLE KEYS */;
INSERT INTO `ost_ticket` VALUES (1,'528511',1,0,0,1,0,1,0,0,0,0,0,'76.108.130.187','Web',NULL,0,0,NULL,NULL,NULL,NULL,'2017-11-29 22:48:54','2017-11-29 22:48:54','2017-11-29 22:48:54'),(2,'519418',4,0,1,3,1,10,1,0,0,0,0,'76.108.130.187','Phone',NULL,0,1,'2018-06-16 21:00:00','2018-06-16 21:00:00',NULL,NULL,'2017-11-29 22:59:23','2017-11-29 22:59:23','2017-11-29 22:59:24'),(3,'631597',5,0,1,2,1,1,1,0,0,0,0,'76.108.130.187','Email',NULL,0,1,'2018-07-28 21:00:00','2018-07-28 21:00:00',NULL,NULL,'2017-11-29 23:01:41','2017-11-29 23:01:40','2017-11-29 23:01:41'),(4,'190563',6,0,1,1,1,11,1,0,0,0,0,'76.108.130.187','Email',NULL,0,1,'2018-07-21 21:00:00','2018-07-21 21:00:00',NULL,NULL,'2017-11-29 23:03:26','2017-11-29 23:03:26','2017-11-29 23:03:26'),(5,'727678',8,0,1,3,1,10,1,0,0,0,0,'76.108.130.187','Other',NULL,0,1,'2018-06-23 21:00:00','2018-06-23 21:00:00',NULL,NULL,'2017-11-29 23:04:52','2017-11-29 23:04:51','2017-11-29 23:04:52'),(6,'895037',11,0,1,3,1,10,0,0,0,0,0,'76.108.130.187','Web',NULL,0,0,NULL,'2017-12-01 23:09:16',NULL,NULL,'2017-11-29 23:09:17','2017-11-29 23:09:16','2017-11-29 23:09:17');
/*!40000 ALTER TABLE `ost_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket__cdata`
--

DROP TABLE IF EXISTS `ost_ticket__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_ticket__cdata` (
  `ticket_id` int(11) unsigned NOT NULL,
  `subject` mediumtext,
  `priority` mediumtext,
  PRIMARY KEY (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket__cdata`
--

LOCK TABLES `ost_ticket__cdata` WRITE;
/*!40000 ALTER TABLE `ost_ticket__cdata` DISABLE KEYS */;
INSERT INTO `ost_ticket__cdata` VALUES (2,'Issue with Laptop','3'),(3,'CRM','2'),(4,'Need access to Support File Share','2'),(5,'Printer Issue in Build 11','2'),(6,'New Laptop','2');
/*!40000 ALTER TABLE `ost_ticket__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket_priority`
--

DROP TABLE IF EXISTS `ost_ticket_priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_ticket_priority` (
  `priority_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `priority` varchar(60) NOT NULL DEFAULT '',
  `priority_desc` varchar(30) NOT NULL DEFAULT '',
  `priority_color` varchar(7) NOT NULL DEFAULT '',
  `priority_urgency` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ispublic` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`priority_id`),
  UNIQUE KEY `priority` (`priority`),
  KEY `priority_urgency` (`priority_urgency`),
  KEY `ispublic` (`ispublic`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket_priority`
--

LOCK TABLES `ost_ticket_priority` WRITE;
/*!40000 ALTER TABLE `ost_ticket_priority` DISABLE KEYS */;
INSERT INTO `ost_ticket_priority` VALUES (1,'low','Low','#DDFFDD',4,1),(2,'normal','Normal','#FFFFF0',3,1),(3,'high','High','#FEE7E7',2,1),(4,'emergency','Emergency','#FEE7E7',1,1);
/*!40000 ALTER TABLE `ost_ticket_priority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket_status`
--

DROP TABLE IF EXISTS `ost_ticket_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_ticket_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `state` varchar(16) DEFAULT NULL,
  `mode` int(11) unsigned NOT NULL DEFAULT '0',
  `flags` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `properties` text NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket_status`
--

LOCK TABLES `ost_ticket_status` WRITE;
/*!40000 ALTER TABLE `ost_ticket_status` DISABLE KEYS */;
INSERT INTO `ost_ticket_status` VALUES (1,'Open','open',3,0,1,'{\"description\":\"Open tickets.\"}','2017-11-29 22:48:49','0000-00-00 00:00:00'),(2,'Resolved','closed',1,0,2,'{\"allowreopen\":true,\"reopenstatus\":0,\"description\":\"Resolved tickets\"}','2017-11-29 22:48:49','0000-00-00 00:00:00'),(3,'Closed','closed',3,0,3,'{\"allowreopen\":true,\"reopenstatus\":0,\"description\":\"Closed tickets. Tickets will still be accessible on client and staff panels.\"}','2017-11-29 22:48:49','0000-00-00 00:00:00'),(4,'Archived','archived',3,0,4,'{\"description\":\"Tickets only adminstratively available but no longer accessible on ticket queues and client panel.\"}','2017-11-29 22:48:49','0000-00-00 00:00:00'),(5,'Deleted','deleted',3,0,5,'{\"description\":\"Tickets queued for deletion. Not accessible on ticket queues.\"}','2017-11-29 22:48:49','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `ost_ticket_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_translation`
--

DROP TABLE IF EXISTS `ost_translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_translation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `object_hash` char(16) CHARACTER SET ascii DEFAULT NULL,
  `type` enum('phrase','article','override') DEFAULT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `revision` int(11) unsigned DEFAULT NULL,
  `agent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lang` varchar(16) NOT NULL DEFAULT '',
  `text` mediumtext NOT NULL,
  `source_text` text,
  `updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `type` (`type`,`lang`),
  KEY `object_hash` (`object_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_translation`
--

LOCK TABLES `ost_translation` WRITE;
/*!40000 ALTER TABLE `ost_translation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_translation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user`
--

DROP TABLE IF EXISTS `ost_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` int(10) unsigned NOT NULL,
  `default_email_id` int(10) NOT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `org_id` (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user`
--

LOCK TABLES `ost_user` WRITE;
/*!40000 ALTER TABLE `ost_user` DISABLE KEYS */;
INSERT INTO `ost_user` VALUES (1,0,1,0,'osTicket Support','2017-11-29 22:48:54','2017-11-29 22:48:54'),(2,0,2,0,'Bill Jones','2017-11-29 22:52:23','2017-11-29 22:55:41'),(3,2,3,0,'Jamal Kazmierczak','2017-11-29 22:54:31','2017-11-29 22:54:31'),(4,2,4,0,'Carola Wagoner','2017-11-29 22:55:00','2017-11-29 22:55:00'),(5,2,5,0,'Dino Aschenbrenner','2017-11-29 22:55:27','2017-11-29 22:55:27'),(6,2,6,0,'Lyn Jumper','2017-11-29 22:55:58','2017-11-29 22:55:58'),(7,2,7,0,'Shayne Galbraith','2017-11-29 22:56:28','2017-11-29 22:56:28'),(8,2,8,0,'Meridith Downey','2017-11-29 22:56:47','2017-11-29 22:56:47'),(9,2,9,0,'Junko Chong','2017-11-29 22:57:06','2017-11-29 22:57:06'),(10,2,10,0,'Van Borgeson','2017-11-29 22:57:24','2017-11-29 22:57:25'),(11,0,11,0,'Hailey Laber','2017-11-29 23:09:16','2017-11-29 23:09:16');
/*!40000 ALTER TABLE `ost_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user__cdata`
--

DROP TABLE IF EXISTS `ost_user__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_user__cdata` (
  `user_id` int(11) unsigned NOT NULL,
  `email` mediumtext,
  `name` mediumtext,
  `phone` mediumtext,
  `notes` mediumtext,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user__cdata`
--

LOCK TABLES `ost_user__cdata` WRITE;
/*!40000 ALTER TABLE `ost_user__cdata` DISABLE KEYS */;
INSERT INTO `ost_user__cdata` VALUES (1,NULL,NULL,NULL,NULL),(2,NULL,NULL,'2125551212',''),(3,NULL,NULL,'2125551212',''),(4,NULL,NULL,'2125551212',''),(5,NULL,NULL,'2125551212',''),(6,NULL,NULL,'2125551212',''),(7,NULL,NULL,'2125551212',''),(8,NULL,NULL,'4255551212',''),(9,NULL,NULL,'4255551212',''),(10,NULL,NULL,'4255551212',''),(11,NULL,NULL,'2125551212','');
/*!40000 ALTER TABLE `ost_user__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user_account`
--

DROP TABLE IF EXISTS `ost_user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_user_account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT '0',
  `timezone` varchar(64) DEFAULT NULL,
  `lang` varchar(16) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `passwd` varchar(128) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `backend` varchar(32) DEFAULT NULL,
  `extra` text,
  `registered` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user_account`
--

LOCK TABLES `ost_user_account` WRITE;
/*!40000 ALTER TABLE `ost_user_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_user_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user_email`
--

DROP TABLE IF EXISTS `ost_user_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_user_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `address` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address` (`address`),
  KEY `user_email_lookup` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user_email`
--

LOCK TABLES `ost_user_email` WRITE;
/*!40000 ALTER TABLE `ost_user_email` DISABLE KEYS */;
INSERT INTO `ost_user_email` VALUES (1,1,0,'support@osticket.com'),(2,2,0,'bjones@contoso.com'),(3,3,0,'jkaz@contoso.com'),(4,4,0,'cwag@contoso.com'),(5,5,0,'dasc@contoso.com'),(6,6,0,'ljum@contoso.com'),(7,7,0,'sgal@contoso.com'),(8,8,0,'mdow@contoso.com'),(9,9,0,'jcho@contoso.com'),(10,10,0,'vbor@contoso.com'),(11,11,0,'hlab@contoso.com');
/*!40000 ALTER TABLE `ost_user_email` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-29 19:27:07
