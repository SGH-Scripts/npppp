CREATE TABLE `wipe_tools_vehicles` (
	`identifier` VARCHAR(50) NOT NULL,
	`redeems_allowed` TINYINT(4) NOT NULL DEFAULT '1',
	UNIQUE INDEX `identifier` (`identifier`)
)
ENGINE=InnoDB
;
