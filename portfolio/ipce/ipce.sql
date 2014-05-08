-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Май 07 2014 г., 17:10
-- Версия сервера: 5.5.35
-- Версия PHP: 5.4.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `ipce`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`loginov`@`%` PROCEDURE `GetUnitContentUnitsByRevisionId`()
    READS SQL DATA
CREATE TEMPORARY TABLE tmp_ucu
SELECT
  `unit_content_unit`.`id` AS ucu_id,
  `unit_content_unit`.`unit_revision_id` AS ucu_rev_id,
  `unit_content_unit`.`value_unit_revision_id` AS ucu_v_rev_id,
  `unit_content_unit`.`number` AS ucu_num,
  `unit_revision`.`id` AS ur_id,
  `unit_revision`.`unit_id` AS ur_unit_id,
  `unit_revision`.`revision` AS ur_revision,
  `unit_revision`.`date_create` AS ur_date_create,
  `unit`.`id` AS u_id,
  `unit`.`name` AS u_name,
  `unit`.`unit_type_id` AS u_type_id,
  `unit`.`is_del` AS u_is_del
FROM
  `unit_content_unit`, `unit_revision`, `unit`
WHERE
  `unit_content_unit`.`unit_revision_id` = 7
AND
  `unit_revision`.`id` = `unit_content_unit`.`value_unit_revision_id`
AND
  `unit_revision`.`unit_id` = `unit`.`id`$$

--
-- Функции
--
CREATE DEFINER=`loginov`@`%` FUNCTION `AAA2`(`UnitId` INT) RETURNS int(11)
    READS SQL DATA
BEGIN
RETURN (SELECT * FROM unit_revision WHERE id=1);
END$$

CREATE DEFINER=`loginov`@`%` FUNCTION `AAA5`(`UnitId` INT) RETURNS int(11)
RETURN (
  SELECT MAX( `id` )
  FROM `unit_revision`
  WHERE `unit_id` = UnitId
)


/*
CREATE DEFINER = `loginov`@`%` FUNCTION AAA4(A1 INT)
RETURNS INT(11) NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER
BEGIN
RETURN 0;
END;
*/

/*
CREATE DEFINER = `loginov`@`%` FUNCTION `GetMaxUnitRevisionId` (`UnitId` INT)
RETURNS INT( 11 ) NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER
RETURN (
  SELECT MAX( `id` )
  FROM `unit_revision`
  WHERE `unit_id` = UnitId
)
*/$$

CREATE DEFINER=`loginov`@`%` FUNCTION `AAA6`(`UnitId` INT) RETURNS int(11)
RETURN (0)


/*
CREATE DEFINER = `loginov`@`%` FUNCTION AAA4(A1 INT)
RETURNS INT(11) NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER
BEGIN
RETURN 0;
END;
*/

/*
CREATE DEFINER = `loginov`@`%` FUNCTION `GetMaxUnitRevisionId` (`UnitId` INT)
RETURNS INT( 11 ) NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER
RETURN (
  SELECT MAX( `id` )
  FROM `unit_revision`
  WHERE `unit_id` = UnitId
)
*/$$

CREATE DEFINER=`loginov`@`%` FUNCTION `AAA7`(`UnitId` INT) RETURNS int(11)
RETURN (SELECT * FROM brand)$$

CREATE DEFINER=`loginov`@`%` FUNCTION `AAA8`(`UnitId` INT) RETURNS int(11)
RETURN (SELECT id FROM brand WHERE id=1)$$

CREATE DEFINER=`loginov`@`%` FUNCTION `GetEntityTypeIdByName`(`name` VARCHAR(128) CHARSET utf8) RETURNS int(11)
    READS SQL DATA
RETURN 0$$

CREATE DEFINER=`loginov`@`%` FUNCTION `GetLatestUnitRevisionId`(`UnitId` INT) RETURNS int(11)
    READS SQL DATA
RETURN (SELECT MAX(`id`) FROM `unit_revision` WHERE `unit_id`=UnitId)$$

CREATE DEFINER=`loginov`@`%` FUNCTION `GetMaxUnitRevisionId`(`UnitId` INT) RETURNS int(11)
RETURN (SELECT MAX(`id`) FROM `unit_revision` WHERE `unit_id`=UnitId)$$

CREATE DEFINER=`loginov`@`%` FUNCTION `GetUnitsCount`() RETURNS int(11)
    NO SQL
RETURN (SELECT COUNT(*) FROM unit)$$

CREATE DEFINER=`root`@`localhost` FUNCTION `TestFunc1`() RETURNS varchar(128) CHARSET utf8 COLLATE utf8_unicode_ci
    READS SQL DATA
BEGIN
DECLARE A INT;
DECLARE U varchar(128);
SET A = 1;
/*CALL GetUnitsCount();*/
SET U = USER();
/*RETURN (SELECT COUNT(*) FROM unit);*/
RETURN U;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `TestFunc2`() RETURNS int(11)
    READS SQL DATA
BEGIN
RETURN (SELECT COUNT(*) FROM `user`);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `brand`
--

CREATE TABLE `brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Название поставщика',
  `name_long` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_del` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Признак удаления производителя',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Производитель оборудования' AUTO_INCREMENT=26 ;

-- --------------------------------------------------------

--
-- Структура таблицы `client`
--

CREATE TABLE `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Наименование заказчика',
  `is_del` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Заказчик' AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Структура таблицы `currency`
--

CREATE TABLE `currency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Наименование валюты',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Справочник валют (рубли, доллары, евро, ...)' AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Структура таблицы `item`
--

CREATE TABLE `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Код (артикул) элемента',
  `brand_id` int(11) NOT NULL COMMENT 'Идентификатор производителя',
  `is_del` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Признак удаления элемента',
  `measurement_id` int(11) NOT NULL COMMENT 'Идентификатор единицы измерения (шт, мм, мл, г, ...)',
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `code` (`code`),
  KEY `fk_item_brand_idx` (`brand_id`),
  KEY `fk_item_measurement1_idx` (`measurement_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Элементы - неделимое комплектующие изделие' AUTO_INCREMENT=62430 ;

-- --------------------------------------------------------

--
-- Структура таблицы `item_price`
--

CREATE TABLE `item_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL COMMENT 'Идентификатор элемента (детали)',
  `value` int(11) NOT NULL COMMENT 'Значение в формате xxxxyyy, где yyy - значение после запятой',
  `date_b` int(11) NOT NULL COMMENT 'Дата начала действия цены. Дата в формате unix time (от 00:00:00 UTS 01.01.1970)',
  `currency_id` int(11) NOT NULL COMMENT 'Тип валюты',
  `price_type_id` int(11) NOT NULL,
  `delivery_time` int(11) DEFAULT NULL COMMENT 'Срок поставки (может быть пустой) в днях',
  `item_price_list_id` int(11) DEFAULT NULL COMMENT 'Идентификатор прайс листа. Если NULL, то значение было введено вручную.',
  `quantity` int(11) NOT NULL DEFAULT '1',
  `is_del` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Признак удаления',
  PRIMARY KEY (`id`),
  KEY `fk_item_price_item1_idx` (`item_id`),
  KEY `fk_item_price_currency1_idx` (`currency_id`),
  KEY `fk_item_price_price_type1_idx` (`price_type_id`),
  KEY `fk_item_price_item_price_list1_idx` (`item_price_list_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Закупочная стоимость элемента' AUTO_INCREMENT=83322 ;

-- --------------------------------------------------------

--
-- Структура таблицы `item_price_line`
--

CREATE TABLE `item_price_line` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_price_list_id` int(11) NOT NULL,
  `line_value` text COLLATE utf8_unicode_ci NOT NULL,
  `line_state` int(11) NOT NULL DEFAULT '0' COMMENT 'Состояние обработки строки (0 - строка не обработана, 1 - обработано автоматически, 2- обработано в ручную)',
  `is_del` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Признак удаления',
  PRIMARY KEY (`id`),
  KEY `fk_item_price_list_lines_item_price_list1_idx` (`item_price_list_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=82255 ;

-- --------------------------------------------------------

--
-- Структура таблицы `item_price_list`
--

CREATE TABLE `item_price_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `load_date` int(11) NOT NULL COMMENT 'Дата загрузки прайс-листа. Дата в формате unix time (от 00:00:00 UTS 01.01.1970)',
  `file_name` varchar(240) COLLATE utf8_unicode_ci NOT NULL,
  `price_date_begin` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `price_type_id` int(11) NOT NULL,
  `is_del` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Признак удаления',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Прайс лист' AUTO_INCREMENT=170 ;

-- --------------------------------------------------------

--
-- Структура таблицы `journal_item`
--

CREATE TABLE `journal_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `operation_type_id` int(11) NOT NULL,
  `date_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=290 ;

--
-- Триггеры `journal_item`
--
DROP TRIGGER IF EXISTS `journal_item_bins`;
DELIMITER //
CREATE TRIGGER `journal_item_bins` BEFORE INSERT ON `journal_item`
 FOR EACH ROW BEGIN
SET new.date_time = UNIX_TIMESTAMP();
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `journal_item_value_str128`
--

CREATE TABLE `journal_item_value_str128` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journal_item_id` int(11) NOT NULL,
  `field_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `value_old` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `value_new` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `measurement`
--

CREATE TABLE `measurement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Наименование единицы измерения',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Единица измерения' AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Структура таблицы `offer`
--

CREATE TABLE `offer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL COMMENT 'УДАЛЕНО!!!',
  `code` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Номер заказа',
  `is_del` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Признак удаления',
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`code`),
  KEY `fk_offer_client1_idx` (`client_id`),
  KEY `fk_offer_project_id_idx` (`project_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Заказ/Предложение' AUTO_INCREMENT=103 ;

-- --------------------------------------------------------

--
-- Структура таблицы `offer_content_item`
--

CREATE TABLE `offer_content_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_revision_id` int(11) NOT NULL COMMENT 'Идентификатор ревизии предложения',
  `item_id` int(11) NOT NULL COMMENT 'Идентификатор элемента',
  `number` int(11) NOT NULL COMMENT 'Количество элементов',
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Наименование элемента на момент создания записи (копия из таблицы item)',
  `price` int(11) NOT NULL COMMENT 'Стоимость одного элемента на момент создания записи (копия из таблицы item_price). Значение в формате xxxxyyy, где yyy - значение после запятой',
  PRIMARY KEY (`id`),
  KEY `fk_offer_content_item_offer_revision1_idx` (`offer_revision_id`),
  KEY `fk_offer_content_item_item1_idx` (`item_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Составные элементы предложения. В эту таблицу заносятся все ' AUTO_INCREMENT=417 ;

-- --------------------------------------------------------

--
-- Структура таблицы `offer_content_unit`
--

CREATE TABLE `offer_content_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_revision_id` int(11) NOT NULL COMMENT 'Идентификатор ревизии предложения',
  `unit_revision_id` int(11) NOT NULL COMMENT 'Идентификатор составной единицы (идентификатор определенной ревизии)',
  `number` int(11) NOT NULL COMMENT 'Количество составных единиц',
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Наименование составной единицы (копия наименования из таблицы unit)',
  `price` int(11) DEFAULT NULL,
  `is_del` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `fk_offer_content_unit_offer_revision1_idx` (`offer_revision_id`),
  KEY `fk_offer_content_unit_unit_revision1_idx` (`unit_revision_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Составные единицы предложения' AUTO_INCREMENT=398 ;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `offer_content_view`
--
CREATE TABLE `offer_content_view` (
`name` varchar(272)
,`ocu_id` bigint(20)
,`offer_rev_id` bigint(20)
,`ocu_name` varchar(128)
,`ocu_number` bigint(20)
,`offer_rev_elements` bigint(20)
,`ur0_id` bigint(20)
,`ur0_is_fixed` bigint(20)
,`ur0_revision` bigint(20)
,`u0_id` bigint(20)
,`u0_name` varchar(128)
,`typ` bigint(20)
,`uc_id` bigint(20)
,`uc_number` bigint(20)
,`ur_id` bigint(20)
,`ur_revision` bigint(20)
,`u_i_id` bigint(20)
,`u_i_name` varchar(128)
);
-- --------------------------------------------------------

--
-- Структура таблицы `offer_revision`
--

CREATE TABLE `offer_revision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL COMMENT 'Идентификатор заказа',
  `client_id` int(11) NOT NULL,
  `client_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revision` int(11) NOT NULL COMMENT 'Порядковый номер ревизии',
  `date_create` int(11) NOT NULL DEFAULT '0' COMMENT 'Дата создания ревизии. Дата в формате unix time (от 00:00:00 UTS 01.01.1970)',
  `elements_unit_rev_id` int(11) NOT NULL,
  `prot_offer_rev_id` int(11) DEFAULT NULL,
  `discount` int(11) NOT NULL DEFAULT '0',
  `price` int(11) DEFAULT NULL,
  `is_fixed` bit(1) NOT NULL DEFAULT b'0',
  `is_del` bit(1) NOT NULL DEFAULT b'0',
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_offer_revision_offer1_idx` (`offer_id`),
  KEY `user_id` (`user_id`),
  KEY `elements_unit_rev_id` (`elements_unit_rev_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Ревизия предложения' AUTO_INCREMENT=152 ;

--
-- Триггеры `offer_revision`
--
DROP TRIGGER IF EXISTS `offer_revision_berore_insert`;
DELIMITER //
CREATE TRIGGER `offer_revision_berore_insert` BEFORE INSERT ON `offer_revision`
 FOR EACH ROW BEGIN
SET new.date_create = UNIX_TIMESTAMP();
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `offer_view`
--
CREATE TABLE `offer_view` (
`offer_id` int(11)
,`offer_code` varchar(64)
,`ofrev_id` int(11)
,`revision` int(11)
,`client_id` int(11)
,`client_name` varchar(128)
);
-- --------------------------------------------------------

--
-- Структура таблицы `operation_type`
--

CREATE TABLE `operation_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Структура таблицы `param_tmp`
--

CREATE TABLE `param_tmp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value_int` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `price_type`
--

CREATE TABLE `price_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Наименование',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Разновидности цен: тарифная, входная, цена продажи, с НДС / ' AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Структура таблицы `project`
--

CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) DEFAULT NULL,
  `is_del` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=48 ;

-- --------------------------------------------------------

--
-- Структура таблицы `rate`
--

CREATE TABLE `rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` int(11) NOT NULL COMMENT 'Значение в формате xxxxyyy, где yyy - значение после запятой',
  `currency_id` int(11) NOT NULL COMMENT 'Валюта',
  `date_b` int(11) NOT NULL COMMENT 'Дата начала действия курса. Дата в формате unix time (от 00:00:00 UTS 01.01.1970)',
  PRIMARY KEY (`id`),
  KEY `fk_rate_currency1_idx` (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Курс валют по отношению к рублю' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `request_content`
--

CREATE TABLE `request_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `request_revision_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_request_content_request_revision1_idx` (`request_revision_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `request_revision`
--

CREATE TABLE `request_revision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL COMMENT 'Идентификатор заказа',
  `date_create` int(11) NOT NULL DEFAULT '0' COMMENT 'Дата создания ревизии. Дата в формате unix time (от 00:00:00 UTS 01.01.1970)',
  `is_fixed` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `fk_request_revision_offer1_idx` (`offer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Ревизия заказа' AUTO_INCREMENT=3 ;

--
-- Триггеры `request_revision`
--
DROP TRIGGER IF EXISTS `request_revision_before_insert`;
DELIMITER //
CREATE TRIGGER `request_revision_before_insert` BEFORE INSERT ON `request_revision`
 FOR EACH ROW BEGIN
SET new.date_create = UNIX_TIMESTAMP();
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `sc_log`
--

CREATE TABLE `sc_log` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `inserted_date` datetime DEFAULT NULL,
  `username` varchar(90) COLLATE utf8_unicode_ci NOT NULL,
  `application` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `creator` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ip_user` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `action` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=17289 ;

-- --------------------------------------------------------

--
-- Структура таблицы `table`
--

CREATE TABLE `table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Структура таблицы `unit`
--

CREATE TABLE `unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `unit_type_id` int(11) NOT NULL,
  `is_del` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_unit_unit_type1_idx` (`unit_type_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=147 ;

--
-- Триггеры `unit`
--
DROP TRIGGER IF EXISTS `Test1`;
DELIMITER //
CREATE TRIGGER `Test1` BEFORE INSERT ON `unit`
 FOR EACH ROW begin
end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `unit_content_item`
--

CREATE TABLE `unit_content_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_revision_id` int(11) NOT NULL COMMENT 'Идентификатор данный единицы изделия',
  `item_id` int(11) NOT NULL COMMENT 'Идентификатор составляющего элемента',
  `number` int(11) NOT NULL COMMENT 'Количество единиц элементов в составе данного изделия',
  `is_del` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `fk_unit_content_item1_idx` (`item_id`),
  KEY `fk_unit_content_item_unit_revision1_idx` (`unit_revision_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Составные элементы (items) данной единицы изделия (unit)' AUTO_INCREMENT=149815 ;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `unit_content_item_view`
--
CREATE TABLE `unit_content_item_view` (
`uci_id` int(11)
,`u_name` varchar(161)
,`u_id` int(11)
,`u_type_id` int(11)
,`ur_id` int(11)
,`ur_revision` int(11)
,`item_id` int(11)
,`item_name` varchar(214)
,`item_code` varchar(64)
,`item_brand_id` int(11)
,`uci_number` int(11)
);
-- --------------------------------------------------------

--
-- Структура таблицы `unit_content_unit`
--

CREATE TABLE `unit_content_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_revision_id` int(11) NOT NULL COMMENT 'Идентификатор данного изделия (unit)',
  `value_unit_revision_id` int(11) NOT NULL COMMENT 'Идентификатор вложенного изделия в данное изделие',
  `number` int(11) NOT NULL COMMENT 'Количество единиц изделий (units) в составе данного изделия',
  `is_del` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `fk_block_content_unit_block_revision1_idx` (`unit_revision_id`),
  KEY `fk_unit_content_unit_unit_revision1_idx` (`value_unit_revision_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Составные единицы (units) данной единицы изделия (unit)' AUTO_INCREMENT=208 ;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `unit_content_unit_view`
--
CREATE TABLE `unit_content_unit_view` (
`u_id` int(11)
,`ucu_id` int(11)
,`ucu_rev_id` int(11)
,`ucu_v_rev_id` int(11)
,`ucu_num` int(11)
,`vur_unit_id` int(11)
,`vur_revision` int(11)
,`vur_date_create` int(11)
,`vu_name` varchar(128)
,`vu_type_id` int(11)
,`vu_is_del` bit(1)
);
-- --------------------------------------------------------

--
-- Дублирующая структура для представления `unit_content_view`
--
CREATE TABLE `unit_content_view` (
`name` varchar(141)
,`ucu0_id` bigint(20)
,`ucu0_number` bigint(20)
,`ur0_id` bigint(20)
,`ur0_revision` bigint(20)
,`u0_id` bigint(20)
,`u0_name` varchar(128)
,`typ` bigint(20)
,`uc_id` bigint(20)
,`uc_number` bigint(20)
,`ur_id` bigint(20)
,`ur_revision` bigint(20)
,`u_i_id` bigint(20)
,`u_i_name` varchar(128)
);
-- --------------------------------------------------------

--
-- Структура таблицы `unit_replace`
--

CREATE TABLE `unit_replace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_id_1` int(11) NOT NULL COMMENT 'Идентификатор первой единицы',
  `unit_id_2` int(11) NOT NULL COMMENT 'Идентификатор второй единицы',
  `is_del` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `fk_unit_replace_unit1_idx` (`unit_id_1`),
  KEY `fk_unit_replace_unit2_idx` (`unit_id_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Взаимозаменяемые сборочные единицы' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `unit_revision`
--

CREATE TABLE `unit_revision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_id` int(11) NOT NULL COMMENT 'Идентификатор единицы',
  `revision` int(11) NOT NULL COMMENT 'Ревизия - порядковый номер',
  `date_create` int(11) NOT NULL COMMENT 'Дата и время создания ревизии. Дата в формате unix time (от 00:00:00 UTS 01.01.1970)',
  `prot_unit_rev_id` int(11) DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT '0',
  `is_fixed` int(1) NOT NULL DEFAULT '0',
  `is_del` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `fk_unit_revision_unit1_idx` (`unit_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Ревизия единицы' AUTO_INCREMENT=231 ;

--
-- Триггеры `unit_revision`
--
DROP TRIGGER IF EXISTS `unit_revision_before_insert`;
DELIMITER //
CREATE TRIGGER `unit_revision_before_insert` BEFORE INSERT ON `unit_revision`
 FOR EACH ROW BEGIN
SET new.date_create = UNIX_TIMESTAMP();
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `unit_type`
--

CREATE TABLE `unit_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `is_del` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `unit_view`
--
CREATE TABLE `unit_view` (
`u_id` int(11)
,`u_name` varchar(128)
,`ut_id` int(11)
,`ut_name` varchar(128)
,`ur_rev` int(11)
,`ur_is_fixed` int(1)
,`ur_level` int(11)
);
-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `typ` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Структура для представления `offer_content_view`
--
DROP TABLE IF EXISTS `offer_content_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`loginov`@`%` SQL SECURITY DEFINER VIEW `offer_content_view` AS select concat(`ocu`.`name`,' (',`u0`.`name`,')',' R',`ur0`.`revision`) AS `name`,`ocu`.`id` AS `ocu_id`,`ocu`.`offer_revision_id` AS `offer_rev_id`,`ocu`.`name` AS `ocu_name`,`ocu`.`number` AS `ocu_number`,`or0`.`elements_unit_rev_id` AS `offer_rev_elements`,`ur0`.`id` AS `ur0_id`,`ur0`.`is_fixed` AS `ur0_is_fixed`,`ur0`.`revision` AS `ur0_revision`,`u0`.`id` AS `u0_id`,`u0`.`name` AS `u0_name`,11 AS `typ`,`ucu1`.`id` AS `uc_id`,`ucu1`.`number` AS `uc_number`,`ur1`.`id` AS `ur_id`,`ur1`.`revision` AS `ur_revision`,`u1`.`id` AS `u_i_id`,`u1`.`name` AS `u_i_name` from ((((((`offer_content_unit` `ocu` left join `offer_revision` `or0` on((`or0`.`id` = `ocu`.`offer_revision_id`))) left join `unit_revision` `ur0` on((`ur0`.`id` = `ocu`.`unit_revision_id`))) left join `unit` `u0` on((`u0`.`id` = `ur0`.`unit_id`))) left join `unit_content_unit` `ucu1` on((`ucu1`.`unit_revision_id` = `ocu`.`unit_revision_id`))) left join `unit_revision` `ur1` on((`ur1`.`id` = `ucu1`.`value_unit_revision_id`))) left join `unit` `u1` on((`u1`.`id` = `ur1`.`unit_id`))) where ((`ocu`.`offer_revision_id` = (select `param_tmp`.`value_int` from `param_tmp` where (`param_tmp`.`name` = 'OfferRevId'))) and (`ucu1`.`id` is not null)) union all select concat(`ocu`.`name`,' (',`u0`.`name`,')',' R',`ur0`.`revision`) AS `name`,`ocu`.`id` AS `ocu_id`,`ocu`.`offer_revision_id` AS `offer_rev_id`,`ocu`.`name` AS `ocu_name`,`ocu`.`number` AS `ocu_number`,`or0`.`elements_unit_rev_id` AS `offer_rev_elements`,`ur0`.`id` AS `ur0_id`,`ur0`.`is_fixed` AS `ur0_is_fixed`,`ur0`.`revision` AS `ur0_revision`,`u0`.`id` AS `u0_id`,`u0`.`name` AS `u0_name`,12 AS `typ`,`uci`.`id` AS `uc_id`,`uci`.`number` AS `uc_number`,0 AS `ur_id`,0 AS `ur_revision`,`item`.`id` AS `u_i_id`,`item`.`name` AS `u_i_name` from (((((`offer_content_unit` `ocu` left join `offer_revision` `or0` on((`or0`.`id` = `ocu`.`offer_revision_id`))) left join `unit_revision` `ur0` on((`ur0`.`id` = `ocu`.`unit_revision_id`))) left join `unit` `u0` on((`u0`.`id` = `ur0`.`unit_id`))) left join `unit_content_item` `uci` on((`uci`.`unit_revision_id` = `ocu`.`unit_revision_id`))) left join `item` on((`item`.`id` = `uci`.`item_id`))) where ((`ocu`.`offer_revision_id` = (select `param_tmp`.`value_int` from `param_tmp` where (`param_tmp`.`name` = 'OfferRevId'))) and (`uci`.`id` is not null)) union all select concat(`ocu`.`name`,' (',`u0`.`name`,')',' R',`ur0`.`revision`) AS `name`,`ocu`.`id` AS `ocu_id`,`ocu`.`offer_revision_id` AS `offer_rev_id`,`ocu`.`name` AS `ocu_name`,`ocu`.`number` AS `ocu_number`,`or0`.`elements_unit_rev_id` AS `offer_rev_elements`,`ur0`.`id` AS `ur0_id`,`ur0`.`is_fixed` AS `ur0_is_fixed`,`ur0`.`revision` AS `ur0_revision`,`u0`.`id` AS `u0_id`,`u0`.`name` AS `u0_name`,10 AS `typ`,0 AS `uc_id`,0 AS `uc_number`,0 AS `ur_id`,0 AS `ur_revision`,0 AS `u_i_id`,'' AS `u_i_name` from (((((`offer_content_unit` `ocu` left join `offer_revision` `or0` on((`or0`.`id` = `ocu`.`offer_revision_id`))) left join `unit_revision` `ur0` on((`ur0`.`id` = `ocu`.`unit_revision_id`))) left join `unit` `u0` on((`u0`.`id` = `ur0`.`unit_id`))) left join `unit_content_unit` `ucu` on((`ucu`.`unit_revision_id` = `ocu`.`unit_revision_id`))) left join `unit_content_item` `uci` on((`uci`.`unit_revision_id` = `ocu`.`unit_revision_id`))) where ((`ocu`.`offer_revision_id` = (select `param_tmp`.`value_int` from `param_tmp` where (`param_tmp`.`name` = 'OfferRevId'))) and isnull(`ucu`.`id`) and isnull(`uci`.`id`)) union all (select '' AS `name`,0 AS `ocu_id`,0 AS `offer_rev_id`,'' AS `ocu_name`,0 AS `ocu_number`,0 AS `offer_rev_elements`,0 AS `ur0_id`,0 AS `ur0_is_fixed`,0 AS `ur0_revision`,0 AS `u0_id`,'' AS `u0_name`,0 AS `typ`,0 AS `uc_id`,0 AS `uc_number`,0 AS `ur_id`,0 AS `ur_revision`,0 AS `u_i_id`,'' AS `u_i_name` from `offer_content_unit` where isnull((select `ocu`.`id` from `offer_content_unit` `ocu` where (`ocu`.`offer_revision_id` = (select `param_tmp`.`value_int` from `param_tmp` where (`param_tmp`.`name` = 'OfferRevId'))) limit 1)) limit 1) order by `name`,`typ`,`u_i_name`;

-- --------------------------------------------------------

--
-- Структура для представления `offer_view`
--
DROP TABLE IF EXISTS `offer_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`loginov`@`%` SQL SECURITY DEFINER VIEW `offer_view` AS select `offer`.`id` AS `offer_id`,`offer`.`code` AS `offer_code`,`offer_revision`.`id` AS `ofrev_id`,`offer_revision`.`revision` AS `revision`,`client`.`id` AS `client_id`,`client`.`name` AS `client_name` from ((`offer` left join `offer_revision` on((`offer_revision`.`id` = (select max(`or2`.`id`) from `offer_revision` `or2` where (`or2`.`offer_id` = `offer`.`id`))))) left join `client` on((`client`.`id` = `offer_revision`.`client_id`))) where (`offer`.`is_del` = 0);

-- --------------------------------------------------------

--
-- Структура для представления `unit_content_item_view`
--
DROP TABLE IF EXISTS `unit_content_item_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`loginov`@`%` SQL SECURITY DEFINER VIEW `unit_content_item_view` AS select `uci`.`id` AS `uci_id`,concat(`u`.`name`,' (id=',`u`.`id`,' rev ',`ur`.`revision`,')') AS `u_name`,`u`.`id` AS `u_id`,`u`.`unit_type_id` AS `u_type_id`,`ur`.`id` AS `ur_id`,`ur`.`revision` AS `ur_revision`,`item`.`id` AS `item_id`,concat(`item`.`name`,' (id=',`item`.`id`,' арт=',`item`.`code`,')') AS `item_name`,`item`.`code` AS `item_code`,`item`.`brand_id` AS `item_brand_id`,`uci`.`number` AS `uci_number` from (((`unit_content_item` `uci` join `item`) join `unit_revision` `ur`) join `unit` `u`) where ((`item`.`id` = `uci`.`item_id`) and (`ur`.`id` = `uci`.`unit_revision_id`) and (`u`.`id` = `ur`.`unit_id`));

-- --------------------------------------------------------

--
-- Структура для представления `unit_content_unit_view`
--
DROP TABLE IF EXISTS `unit_content_unit_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`loginov`@`%` SQL SECURITY DEFINER VIEW `unit_content_unit_view` AS select `u`.`id` AS `u_id`,`ucu`.`id` AS `ucu_id`,`ucu`.`unit_revision_id` AS `ucu_rev_id`,`ucu`.`value_unit_revision_id` AS `ucu_v_rev_id`,`ucu`.`number` AS `ucu_num`,`vur`.`unit_id` AS `vur_unit_id`,`vur`.`revision` AS `vur_revision`,`vur`.`date_create` AS `vur_date_create`,`vu`.`name` AS `vu_name`,`vu`.`unit_type_id` AS `vu_type_id`,`vu`.`is_del` AS `vu_is_del` from ((((`unit_content_unit` `ucu` join `unit_revision` `ur`) join `unit` `u`) join `unit_revision` `vur`) join `unit` `vu`) where ((`u`.`id` = (select `ur3`.`unit_id` from `unit_revision` `ur3` where (`ur3`.`id` = `ucu`.`unit_revision_id`))) and (`ur`.`id` = `ucu`.`unit_revision_id`) and (`ucu`.`unit_revision_id` = (select max(`ur2`.`id`) from `unit_revision` `ur2` where (`ur2`.`unit_id` = `u`.`id`))) and (`vur`.`id` = `ucu`.`value_unit_revision_id`) and (`vur`.`unit_id` = `vu`.`id`));

-- --------------------------------------------------------

--
-- Структура для представления `unit_content_view`
--
DROP TABLE IF EXISTS `unit_content_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`loginov`@`%` SQL SECURITY DEFINER VIEW `unit_content_view` AS select concat('&#60;Элементы&#62;') AS `name`,0 AS `ucu0_id`,0 AS `ucu0_number`,`ur0`.`id` AS `ur0_id`,`ur0`.`revision` AS `ur0_revision`,`u0`.`id` AS `u0_id`,concat('&#60;Элементы&#62;') AS `u0_name`,32 AS `typ`,`uci`.`id` AS `uc_id`,`uci`.`number` AS `uc_number`,0 AS `ur_id`,0 AS `ur_revision`,`item`.`id` AS `u_i_id`,`item`.`name` AS `u_i_name` from (((`unit_revision` `ur0` left join `unit` `u0` on((`u0`.`id` = `ur0`.`unit_id`))) left join `unit_content_item` `uci` on((`uci`.`unit_revision_id` = `ur0`.`id`))) left join `item` on((`item`.`id` = `uci`.`item_id`))) where ((`ur0`.`id` = (select `param_tmp`.`value_int` from `param_tmp` where (`param_tmp`.`name` = 'UnitRevId'))) and (`uci`.`id` is not null)) union all select concat('&#60;Элементы&#62;') AS `name`,0 AS `ucu0_id`,0 AS `ucu0_number`,`ur0`.`id` AS `ur0_id`,`ur0`.`revision` AS `ur0_revision`,`u0`.`id` AS `u0_id`,concat('&#60;Элементы&#62;') AS `u0_name`,30 AS `typ`,0 AS `uc_id`,0 AS `uc_number`,0 AS `ur_id`,0 AS `ur_revision`,0 AS `u_i_id`,'' AS `u_i_name` from (((`unit_revision` `ur0` left join `unit` `u0` on((`u0`.`id` = `ur0`.`unit_id`))) left join `unit_content_item` `uci` on((`uci`.`unit_revision_id` = `ur0`.`id`))) left join `item` on((`item`.`id` = `uci`.`item_id`))) where ((`ur0`.`id` = (select `param_tmp`.`value_int` from `param_tmp` where (`param_tmp`.`name` = 'UnitRevId'))) and isnull(`uci`.`id`)) union all select concat(`u0`.`name`,' R',`ur0`.`revision`) AS `name`,`ucu0`.`id` AS `ucu0_id`,`ucu0`.`number` AS `ucu0_number`,`ur0`.`id` AS `ur0_id`,`ur0`.`revision` AS `ur0_revision`,`u0`.`id` AS `u0_id`,`u0`.`name` AS `u0_name`,21 AS `typ`,`ucu1`.`id` AS `uc_id`,`ucu1`.`number` AS `uc_number`,`ur1`.`id` AS `ur_id`,`ur1`.`revision` AS `ur_revision`,`u1`.`id` AS `u_i_id`,`u1`.`name` AS `u_i_name` from (((((`unit_content_unit` `ucu0` left join `unit_revision` `ur0` on((`ur0`.`id` = `ucu0`.`value_unit_revision_id`))) left join `unit` `u0` on((`u0`.`id` = `ur0`.`unit_id`))) left join `unit_content_unit` `ucu1` on((`ucu1`.`unit_revision_id` = `ucu0`.`value_unit_revision_id`))) left join `unit_revision` `ur1` on((`ur1`.`id` = `ucu1`.`value_unit_revision_id`))) left join `unit` `u1` on((`u1`.`id` = `ur1`.`unit_id`))) where ((`ucu0`.`unit_revision_id` = (select `param_tmp`.`value_int` from `param_tmp` where (`param_tmp`.`name` = 'UnitRevId'))) and (`ucu1`.`id` is not null)) union all select concat(`u0`.`name`,' R',`ur0`.`revision`) AS `name`,`ucu0`.`id` AS `ucu0_id`,`ucu0`.`number` AS `ucu0_number`,`ur0`.`id` AS `ur0_id`,`ur0`.`revision` AS `ur0_revision`,`u0`.`id` AS `u0_id`,`u0`.`name` AS `u0_name`,22 AS `typ`,`uci`.`id` AS `uc_id`,`uci`.`number` AS `uc_number`,0 AS `ur_id`,0 AS `ur_revision`,`item`.`id` AS `u_i_id`,`item`.`name` AS `u_i_name` from ((((`unit_content_unit` `ucu0` left join `unit_revision` `ur0` on((`ur0`.`id` = `ucu0`.`value_unit_revision_id`))) left join `unit` `u0` on((`u0`.`id` = `ur0`.`unit_id`))) left join `unit_content_item` `uci` on((`uci`.`unit_revision_id` = `ucu0`.`value_unit_revision_id`))) left join `item` on((`item`.`id` = `uci`.`item_id`))) where ((`ucu0`.`unit_revision_id` = (select `param_tmp`.`value_int` from `param_tmp` where (`param_tmp`.`name` = 'UnitRevId'))) and (`uci`.`id` is not null)) union all select concat(`u0`.`name`,' R',`ur0`.`revision`) AS `name`,`ucu0`.`id` AS `ucu0_id`,`ucu0`.`number` AS `ucu0_number`,`ur0`.`id` AS `ur0_id`,`ur0`.`revision` AS `ur0_revision`,`u0`.`id` AS `u0_id`,`u0`.`name` AS `u0_name`,20 AS `typ`,0 AS `uc_id`,0 AS `uc_number`,0 AS `ur_id`,0 AS `ur_revision`,0 AS `u_i_id`,'' AS `u_i_name` from ((((`unit_content_unit` `ucu0` left join `unit_revision` `ur0` on((`ur0`.`id` = `ucu0`.`value_unit_revision_id`))) left join `unit` `u0` on((`u0`.`id` = `ur0`.`unit_id`))) left join `unit_content_unit` `ucu1` on((`ucu1`.`unit_revision_id` = `ucu0`.`value_unit_revision_id`))) left join `unit_content_item` `uci` on((`uci`.`unit_revision_id` = `ucu0`.`value_unit_revision_id`))) where ((`ucu0`.`unit_revision_id` = (select `param_tmp`.`value_int` from `param_tmp` where (`param_tmp`.`name` = 'UnitRevId'))) and isnull(`ucu1`.`id`) and isnull(`uci`.`id`)) union all (select '' AS `name`,0 AS `ucu0_id`,0 AS `ucu0_number`,0 AS `ur0_id`,0 AS `ur0_revision`,0 AS `u0_id`,'' AS `u0_name`,0 AS `typ`,0 AS `uc_id`,0 AS `uc_number`,0 AS `ur_id`,0 AS `ur_revision`,0 AS `u_i_id`,'' AS `u_i_name` from `unit_content_unit` where isnull((select `ur0`.`id` from `unit_revision` `ur0` where (`ur0`.`id` = (select `param_tmp`.`value_int` from `param_tmp` where (`param_tmp`.`name` = 'UnitRevId'))) limit 1)) limit 1) order by `name`,`typ`,`u_i_name`;

-- --------------------------------------------------------

--
-- Структура для представления `unit_view`
--
DROP TABLE IF EXISTS `unit_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`loginov`@`%` SQL SECURITY DEFINER VIEW `unit_view` AS select `u`.`id` AS `u_id`,`u`.`name` AS `u_name`,`ut`.`id` AS `ut_id`,`ut`.`name` AS `ut_name`,`ur`.`revision` AS `ur_rev`,`ur`.`is_fixed` AS `ur_is_fixed`,`ur`.`level` AS `ur_level` from ((`unit` `u` join `unit_type` `ut`) join `unit_revision` `ur`) where ((`u`.`is_del` = 0) and (`ut`.`id` = `u`.`unit_type_id`) and (`ur`.`id` = (select max(`ur2`.`id`) from `unit_revision` `ur2` where (`ur2`.`unit_id` = `u`.`id`))));

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `fk_item_brand` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_item_measurement1` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `item_price`
--
ALTER TABLE `item_price`
  ADD CONSTRAINT `fk_item_price_currency1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_item_price_item1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_item_price_item_price_list1` FOREIGN KEY (`item_price_list_id`) REFERENCES `item_price_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_item_price_price_type1` FOREIGN KEY (`price_type_id`) REFERENCES `price_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `offer`
--
ALTER TABLE `offer`
  ADD CONSTRAINT `fk_offer_client1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `offer_content_item`
--
ALTER TABLE `offer_content_item`
  ADD CONSTRAINT `fk_offer_content_item_item1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_offer_content_item_offer_revision1` FOREIGN KEY (`offer_revision_id`) REFERENCES `offer_revision` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `offer_content_unit`
--
ALTER TABLE `offer_content_unit`
  ADD CONSTRAINT `fk_offer_content_unit_offer_revision1` FOREIGN KEY (`offer_revision_id`) REFERENCES `offer_revision` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_offer_content_unit_unit_revision1` FOREIGN KEY (`unit_revision_id`) REFERENCES `unit_revision` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `offer_revision`
--
ALTER TABLE `offer_revision`
  ADD CONSTRAINT `fk_offer_revision_offer1` FOREIGN KEY (`offer_id`) REFERENCES `offer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `rate`
--
ALTER TABLE `rate`
  ADD CONSTRAINT `fk_rate_currency1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `request_content`
--
ALTER TABLE `request_content`
  ADD CONSTRAINT `fk_request_content_request_revision1` FOREIGN KEY (`request_revision_id`) REFERENCES `request_revision` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `request_revision`
--
ALTER TABLE `request_revision`
  ADD CONSTRAINT `fk_request_revision_offer1` FOREIGN KEY (`offer_id`) REFERENCES `offer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `unit`
--
ALTER TABLE `unit`
  ADD CONSTRAINT `fk_unit_unit_type1` FOREIGN KEY (`unit_type_id`) REFERENCES `unit_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `unit_content_item`
--
ALTER TABLE `unit_content_item`
  ADD CONSTRAINT `fk_unit_content_item1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_unit_content_item_unit_revision1` FOREIGN KEY (`unit_revision_id`) REFERENCES `unit_revision` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `unit_content_unit`
--
ALTER TABLE `unit_content_unit`
  ADD CONSTRAINT `fk_block_content_unit_block_revision1` FOREIGN KEY (`unit_revision_id`) REFERENCES `unit_revision` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_unit_content_unit_unit_revision1` FOREIGN KEY (`value_unit_revision_id`) REFERENCES `unit_revision` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `unit_replace`
--
ALTER TABLE `unit_replace`
  ADD CONSTRAINT `fk_unit_replace_unit1` FOREIGN KEY (`unit_id_1`) REFERENCES `unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_unit_replace_unit2` FOREIGN KEY (`unit_id_2`) REFERENCES `unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `unit_revision`
--
ALTER TABLE `unit_revision`
  ADD CONSTRAINT `fk_unit_revision_unit1` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
