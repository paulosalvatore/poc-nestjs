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
CREATE TABLE `Campus`
(
    `id`          INTEGER         NOT NULL AUTO_INCREMENT,
    `name`        VARCHAR(191)    NOT NULL,
    `logradouro`  VARCHAR(191)    NOT NULL,
    `numero`      VARCHAR(191)    NOT NULL,
    `complemento` VARCHAR(191)    NOT NULL,
    `bairro`      VARCHAR(191)    NOT NULL,
    `cep`         VARCHAR(8)      NOT NULL,
    `referencia`  VARCHAR(191)    NOT NULL,
    `telefone`    VARCHAR(11)     NOT NULL,
    `email`       VARCHAR(191)    NOT NULL,
    `latitude`    DECIMAL(65, 30) NOT NULL,
    `longitude`   DECIMAL(65, 30) NOT NULL,
    `metaId`      INTEGER         NOT NULL,
    `courseId`    INTEGER,
    UNIQUE INDEX `Campus.name_unique`(`name`),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Course`
(
    `id`             INTEGER      NOT NULL AUTO_INCREMENT,
    `title`          VARCHAR(191) NOT NULL,
    `type`           ENUM('Course', 'Lecture') NOT NULL,
    `ementa`         VARCHAR(191) NOT NULL,
    `targetAudience` VARCHAR(191) NOT NULL,
    `preparation`    VARCHAR(191) NOT NULL,
    `preRequisites`  VARCHAR(191) NOT NULL,
    `metaId`         INTEGER      NOT NULL,
    UNIQUE INDEX `Course.title_unique`(`title`),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CourseClass`
(
    `id`              INTEGER         NOT NULL AUTO_INCREMENT,
    `gradeCurricular` VARCHAR(191)    NOT NULL,
    `cargaHoraria`    DECIMAL(65, 30) NOT NULL,
    `metaId`          INTEGER         NOT NULL,
    `courseId`        INTEGER         NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CourseSpeaker`
(
    `id`        INTEGER NOT NULL AUTO_INCREMENT,
    `metaId`    INTEGER NOT NULL,
    `courseId`  INTEGER NOT NULL,
    `speakerId` INTEGER NOT NULL,
    `campusId`  INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Track`
(
    `id`     INTEGER      NOT NULL AUTO_INCREMENT,
    `name`   VARCHAR(191) NOT NULL,
    `metaId` INTEGER      NOT NULL,
    UNIQUE INDEX `Track.name_unique`(`name`),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Formation`
(
    `id`       INTEGER      NOT NULL AUTO_INCREMENT,
    `title`    VARCHAR(191) NOT NULL,
    `subtitle` VARCHAR(191) NOT NULL,
    `metaId`   INTEGER      NOT NULL,
    UNIQUE INDEX `Formation.title_unique`(`title`),
    UNIQUE INDEX `Formation.subtitle_unique`(`subtitle`),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Meta`
(
    `id`       INTEGER NOT NULL AUTO_INCREMENT,
    `created`  DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP (3),
    `modified` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP (3),
    `active`   BOOLEAN NOT NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Speaker`
(
    `id`     INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `metaId` INTEGER NOT NULL,
    UNIQUE INDEX `Speaker.userId_unique`(`userId`),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UserRole`
(
    `userId` INTEGER NOT NULL,
    `role`   ENUM('ADMIN', 'STUDENT', 'SPEAKER') NOT NULL,
    UNIQUE INDEX `unique_user_role`(`userId`, `role`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User`
(
    `id`        INTEGER      NOT NULL AUTO_INCREMENT,
    `email`     VARCHAR(191) NOT NULL,
    `password`  VARCHAR(191),
    `name`      VARCHAR(191),
    `nickname`  VARCHAR(191),
    `cpf`       VARCHAR(11)  NOT NULL,
    `phone`     VARCHAR(15),
    `gender`    ENUM('MALE', 'FEMALE', 'OTHER'),
    `birthdate` DATETIME(3),
    `avatar`    VARCHAR(191),
    `metaId`    INTEGER      NOT NULL,
    UNIQUE INDEX `User.email_unique`(`email`),
    UNIQUE INDEX `User.cpf_unique`(`cpf`),

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

-- CreateTable
CREATE TABLE `_CampusToSpeaker`
(
    `A`   INTEGER NOT NULL,
    `B`   INTEGER NOT NULL,
    UNIQUE INDEX `_CampusToSpeaker_AB_unique`(`A`, `B`),
    INDEX `_CampusToSpeaker_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_CourseToTrack`
(
    `A`   INTEGER NOT NULL,
    `B`   INTEGER NOT NULL,
    UNIQUE INDEX `_CourseToTrack_AB_unique`(`A`, `B`),
    INDEX `_CourseToTrack_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_CourseClassToCourseSpeaker`
(
    `A`   INTEGER NOT NULL,
    `B`   INTEGER NOT NULL,
    UNIQUE INDEX `_CourseClassToCourseSpeaker_AB_unique`(`A`, `B`),
    INDEX `_CourseClassToCourseSpeaker_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_FormationToTrack`
(
    `A`   INTEGER NOT NULL,
    `B`   INTEGER NOT NULL,
    UNIQUE INDEX `_FormationToTrack_AB_unique`(`A`, `B`),
    INDEX `_FormationToTrack_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Campus`
    ADD FOREIGN KEY (`metaId`) REFERENCES `Meta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Campus`
    ADD FOREIGN KEY (`courseId`) REFERENCES `Course` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Course`
    ADD FOREIGN KEY (`metaId`) REFERENCES `Meta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CourseClass`
    ADD FOREIGN KEY (`courseId`) REFERENCES `Course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CourseClass`
    ADD FOREIGN KEY (`metaId`) REFERENCES `Meta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CourseSpeaker`
    ADD FOREIGN KEY (`courseId`) REFERENCES `Course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CourseSpeaker`
    ADD FOREIGN KEY (`speakerId`) REFERENCES `Speaker` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CourseSpeaker`
    ADD FOREIGN KEY (`campusId`) REFERENCES `Campus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CourseSpeaker`
    ADD FOREIGN KEY (`metaId`) REFERENCES `Meta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Track`
    ADD FOREIGN KEY (`metaId`) REFERENCES `Meta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Formation`
    ADD FOREIGN KEY (`metaId`) REFERENCES `Meta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Speaker`
    ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Speaker`
    ADD FOREIGN KEY (`metaId`) REFERENCES `Meta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserRole`
    ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `User`
    ADD FOREIGN KEY (`metaId`) REFERENCES `Meta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CampusToUser`
    ADD FOREIGN KEY (`A`) REFERENCES `Campus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CampusToUser`
    ADD FOREIGN KEY (`B`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CampusToSpeaker`
    ADD FOREIGN KEY (`A`) REFERENCES `Campus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CampusToSpeaker`
    ADD FOREIGN KEY (`B`) REFERENCES `Speaker` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CourseToTrack`
    ADD FOREIGN KEY (`A`) REFERENCES `Course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CourseToTrack`
    ADD FOREIGN KEY (`B`) REFERENCES `Track` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CourseClassToCourseSpeaker`
    ADD FOREIGN KEY (`A`) REFERENCES `CourseClass` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CourseClassToCourseSpeaker`
    ADD FOREIGN KEY (`B`) REFERENCES `CourseSpeaker` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_FormationToTrack`
    ADD FOREIGN KEY (`A`) REFERENCES `Formation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_FormationToTrack`
    ADD FOREIGN KEY (`B`) REFERENCES `Track` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
