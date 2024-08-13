/*
  Warnings:

  - You are about to drop the `Empresas` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Pontos_coleta` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "Empresas";

-- DropTable
DROP TABLE "Pontos_coleta";

-- CreateTable
CREATE TABLE "companies" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "cnpj" VARCHAR(14) NOT NULL,
    "end_emp_id" INTEGER,
    "CEP" VARCHAR(8) NOT NULL,
    "use_emp_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "companies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "points_collection" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "CEP" VARCHAR(8) NOT NULL,
    "end_pco_id" INTEGER,
    "emp_pco_id" INTEGER,
    "horario_funcionamento" VARCHAR(5) NOT NULL,
    "dias_funcionamento" VARCHAR(8) NOT NULL,
    "telefone" VARCHAR(13),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "companies_Id" INTEGER,

    CONSTRAINT "points_collection_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "companies_cnpj_key" ON "companies"("cnpj");

-- AddForeignKey
ALTER TABLE "points_collection" ADD CONSTRAINT "points_collection_companies_Id_fkey" FOREIGN KEY ("companies_Id") REFERENCES "companies"("id") ON DELETE SET NULL ON UPDATE CASCADE;
