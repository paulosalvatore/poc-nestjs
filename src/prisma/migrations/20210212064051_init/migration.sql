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

-- CreateTable
CREATE TABLE `Meta`
(
    `id`       INTEGER NOT NULL AUTO_INCREMENT,
    `created`  DATETIME(3) NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `active`   BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User`
(
    `id`        INTEGER      NOT NULL AUTO_INCREMENT,
    `email`     VARCHAR(191) NOT NULL,
    `password`  VARCHAR(191) NOT NULL,
    `name`      VARCHAR(191),
    `cpf`       VARCHAR(11)  NOT NULL,
    `ddi`       VARCHAR(2),
    `ddd`       VARCHAR(2),
    `phone`     VARCHAR(15),
    `gender`    ENUM('MALE', 'FEMALE', 'OTHER'),
    `birthdate` DATETIME(3),
    `metaId`    INTEGER      NOT NULL,
    UNIQUE INDEX `User.email_unique`(`email`),
    UNIQUE INDEX `User.cpf_unique`(`cpf`),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UserRole`
(
    `id`     INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `role`   ENUM('ADMIN', 'STUDENT', 'SPEAKER', 'RECEPCIONIST') NOT NULL,
    UNIQUE INDEX `unique_user_role`(`userId`, `role`),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Campus`
(
    `id`   INTEGER      NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    UNIQUE INDEX `Campus.name_unique`(`name`),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_CampusToUser`
(
    `A`   INTEGER NOT NULL,
    `B`   INTEGER NOT NULL,
    UNIQUE INDEX `_CampusToUser_AB_unique`(`A`, `B`),
    INDEX `_CampusToUser_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `User`
    ADD FOREIGN KEY (`metaId`) REFERENCES `Meta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserRole`
    ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CampusToUser`
    ADD FOREIGN KEY (`A`) REFERENCES `Campus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CampusToUser`
    ADD FOREIGN KEY (`B`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
