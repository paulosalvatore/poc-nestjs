/*
  Warnings:

  - The migration will change the primary key for the `userrole` table. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `userrole` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `user` DROP FOREIGN KEY `user_ibfk_1`;

-- DropForeignKey
ALTER TABLE `userrole` DROP FOREIGN KEY `userrole_ibfk_1`;

-- DropForeignKey
ALTER TABLE `_campustouser` DROP FOREIGN KEY `_campustouser_ibfk_1`;

-- DropForeignKey
ALTER TABLE `_campustouser` DROP FOREIGN KEY `_campustouser_ibfk_2`;

-- AlterTable
ALTER TABLE `userrole` DROP PRIMARY KEY,
DROP
COLUMN `id`;

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
