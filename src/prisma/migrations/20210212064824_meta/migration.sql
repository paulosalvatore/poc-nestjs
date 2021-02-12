-- CreateTable
CREATE TABLE `Meta`
(
    `id`       INTEGER NOT NULL AUTO_INCREMENT,
    `created`  DATETIME(3) NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `active`   BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
