/*
  Warnings:

  - You are about to drop the `check_ins` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `gyms` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "check_ins" DROP CONSTRAINT "check_ins_gym_id_fkey";

-- DropForeignKey
ALTER TABLE "check_ins" DROP CONSTRAINT "check_ins_user_id_fkey";

-- DropTable
DROP TABLE "check_ins";

-- DropTable
DROP TABLE "gyms";

-- DropTable
DROP TABLE "users";

-- CreateTable
CREATE TABLE "Empresas" (
    "emp_id" INTEGER NOT NULL,
    "nome" TEXT NOT NULL,
    "cnpj" VARCHAR(14) NOT NULL,
    "end_emp_id" INTEGER,
    "CEP" VARCHAR(8) NOT NULL,
    "use_emp_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Empresas_pkey" PRIMARY KEY ("emp_id")
);

-- CreateTable
CREATE TABLE "Pontos_coleta" (
    "pco_id" INTEGER NOT NULL,
    "nome" TEXT NOT NULL,
    "CEP" VARCHAR(8) NOT NULL,
    "end_pco_id" INTEGER,
    "emp_pco_id" INTEGER,
    "horario_funcionamento" VARCHAR(5) NOT NULL,
    "dias_funcionamento" VARCHAR(8) NOT NULL,
    "telefone" VARCHAR(13),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Pontos_coleta_pkey" PRIMARY KEY ("pco_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Empresas_cnpj_key" ON "Empresas"("cnpj");
