-- DropForeignKey
ALTER TABLE `user` DROP FOREIGN KEY `user_ibfk_1`;

-- DropForeignKey
ALTER TABLE `userrole` DROP FOREIGN KEY `userrole_ibfk_1`;

-- DropForeignKey
ALTER TABLE `_campustouser` DROP FOREIGN KEY `_campustouser_ibfk_1`;

-- DropForeignKey
ALTER TABLE `_campustouser` DROP FOREIGN KEY `_campustouser_ibfk_2`;

-- AlterTable
ALTER TABLE `meta` MODIFY `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP (3),
    MODIFY `modified` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP (3);

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
