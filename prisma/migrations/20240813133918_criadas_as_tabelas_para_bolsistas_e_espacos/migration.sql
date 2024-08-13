/*
  Warnings:

  - You are about to drop the column `CEP` on the `points_collection` table. All the data in the column will be lost.
  - You are about to drop the column `companies_Id` on the `points_collection` table. All the data in the column will be lost.
  - You are about to drop the column `created_at` on the `points_collection` table. All the data in the column will be lost.
  - You are about to drop the column `dias_funcionamento` on the `points_collection` table. All the data in the column will be lost.
  - You are about to drop the column `emp_pco_id` on the `points_collection` table. All the data in the column will be lost.
  - You are about to drop the column `end_pco_id` on the `points_collection` table. All the data in the column will be lost.
  - You are about to drop the column `horario_funcionamento` on the `points_collection` table. All the data in the column will be lost.
  - You are about to drop the column `telefone` on the `points_collection` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `points_collection` table. All the data in the column will be lost.
  - You are about to drop the `companies` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `bolsistaId` to the `points_collection` table without a default value. This is not possible if the table is not empty.
  - Added the required column `contato` to the `points_collection` table without a default value. This is not possible if the table is not empty.
  - Added the required column `descricao` to the `points_collection` table without a default value. This is not possible if the table is not empty.
  - Added the required column `email` to the `points_collection` table without a default value. This is not possible if the table is not empty.
  - Added the required column `endereco` to the `points_collection` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "points_collection" DROP CONSTRAINT "points_collection_companies_Id_fkey";

-- AlterTable
ALTER TABLE "points_collection" DROP COLUMN "CEP",
DROP COLUMN "companies_Id",
DROP COLUMN "created_at",
DROP COLUMN "dias_funcionamento",
DROP COLUMN "emp_pco_id",
DROP COLUMN "end_pco_id",
DROP COLUMN "horario_funcionamento",
DROP COLUMN "telefone",
DROP COLUMN "updated_at",
ADD COLUMN     "bolsistaId" INTEGER NOT NULL,
ADD COLUMN     "contato" TEXT NOT NULL,
ADD COLUMN     "data" TIMESTAMP(3),
ADD COLUMN     "descricao" TEXT NOT NULL,
ADD COLUMN     "email" TEXT NOT NULL,
ADD COLUMN     "endereco" TEXT NOT NULL;

-- DropTable
DROP TABLE "companies";

-- CreateTable
CREATE TABLE "bolsistas" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "titulo_do_pl" TEXT NOT NULL,
    "campus_de_origem" TEXT NOT NULL,
    "matricula" VARCHAR(12) NOT NULL,

    CONSTRAINT "bolsistas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Media" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "espacosId" INTEGER NOT NULL,

    CONSTRAINT "Media_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "points_collection" ADD CONSTRAINT "points_collection_bolsistaId_fkey" FOREIGN KEY ("bolsistaId") REFERENCES "bolsistas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Media" ADD CONSTRAINT "Media_espacosId_fkey" FOREIGN KEY ("espacosId") REFERENCES "points_collection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
