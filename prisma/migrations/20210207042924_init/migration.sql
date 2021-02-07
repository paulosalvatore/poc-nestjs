-- CreateTable
CREATE TABLE `User`(
                       `id`       INTEGER      NOT NULL AUTO_INCREMENT,
                       `email`    VARCHAR(191) NOT NULL,
                       `name`     VARCHAR(191),
                       `password` VARCHAR(191),
                       UNIQUE INDEX `User.email_unique`(`email`),

                       PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Post` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,
    `content` VARCHAR(191),
    `published` BOOLEAN DEFAULT false,
    `authorId` INTEGER,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Post` ADD FOREIGN KEY (`authorId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;