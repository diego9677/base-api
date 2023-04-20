-- CreateTable
CREATE TABLE "Credenciales" (
    "id" SERIAL NOT NULL,
    "username" VARCHAR(250) NOT NULL,
    "password" VARCHAR(250) NOT NULL,

    CONSTRAINT "Credenciales_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Persona" (
    "id" SERIAL NOT NULL,
    "ci" VARCHAR(20) NOT NULL,
    "nombres" VARCHAR(250) NOT NULL,
    "apellidos" VARCHAR(250) NOT NULL,

    CONSTRAINT "Persona_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Credenciales_username_key" ON "Credenciales"("username");
