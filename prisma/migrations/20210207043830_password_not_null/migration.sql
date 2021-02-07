/*
  Warnings:

  - Made the column `password` on table `user` required. The migration will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `post` DROP FOREIGN KEY `post_ibfk_1`;

-- AlterTable
ALTER TABLE `user` MODIFY `password` VARCHAR (191) NOT NULL;

-- AddForeignKey
ALTER TABLE `Post`
    ADD FOREIGN KEY (`authorId`) REFERENCES `User` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
