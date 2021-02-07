/*
  Warnings:

  - Added the required column `admin` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `post` DROP FOREIGN KEY `post_ibfk_1`;

-- AlterTable
ALTER TABLE `user`
    ADD COLUMN `admin` BOOLEAN NOT NULL;

-- AddForeignKey
ALTER TABLE `Post`
    ADD FOREIGN KEY (`authorId`) REFERENCES `User` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
