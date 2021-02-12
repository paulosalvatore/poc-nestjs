-- CreateTable
CREATE TABLE `Audit`
(
    `id`         INTEGER      NOT NULL AUTO_INCREMENT,
    `table`      VARCHAR(191) NOT NULL,
    `foreignKey` INTEGER      NOT NULL,
    `action`     ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    `previous`   JSON,
    `after`      JSON,
    `created`    DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
