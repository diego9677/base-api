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

-- CreateTable
CREATE TABLE "Arbitro" (
    "id" SERIAL NOT NULL,
    "personaId" INTEGER NOT NULL,

    CONSTRAINT "Arbitro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Presidente" (
    "id" SERIAL NOT NULL,
    "personaId" INTEGER NOT NULL,

    CONSTRAINT "Presidente_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Jugador" (
    "id" SERIAL NOT NULL,
    "personaId" INTEGER NOT NULL,
    "categoriaId" INTEGER NOT NULL,

    CONSTRAINT "Jugador_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Categoria" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(200) NOT NULL,
    "descripcion" TEXT NOT NULL,
    "edadInicio" INTEGER NOT NULL,
    "edadFin" INTEGER NOT NULL,

    CONSTRAINT "Categoria_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Campeonato" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(200) NOT NULL,
    "categoriaId" INTEGER NOT NULL,
    "fecha_inicio" TIMESTAMPTZ NOT NULL,
    "fecha_fin" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "Campeonato_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cancha" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(200) NOT NULL,
    "direccion" TEXT NOT NULL,

    CONSTRAINT "Cancha_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Color" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(200) NOT NULL,
    "equipoId" INTEGER NOT NULL,

    CONSTRAINT "Color_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Equipo" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(200) NOT NULL,
    "direccion" TEXT NOT NULL,
    "fecha_fundacion" TIMESTAMPTZ NOT NULL,
    "escudo" TEXT NOT NULL,

    CONSTRAINT "Equipo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Posiciones" (
    "id" SERIAL NOT NULL,
    "partidosJugados" INTEGER NOT NULL DEFAULT 0,
    "golesAFavor" INTEGER NOT NULL DEFAULT 0,
    "golesEnContra" INTEGER NOT NULL DEFAULT 0,
    "puntos" INTEGER NOT NULL DEFAULT 0,
    "equipoId" INTEGER NOT NULL,
    "campeonatoId" INTEGER NOT NULL,

    CONSTRAINT "Posiciones_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Resultado" (
    "id" SERIAL NOT NULL,
    "tarjetasAmarillas" INTEGER NOT NULL DEFAULT 0,
    "tarjetasRojas" INTEGER NOT NULL DEFAULT 0,
    "golesLocal" INTEGER NOT NULL DEFAULT 0,
    "golesVisitante" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Resultado_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cronograma" (
    "id" SERIAL NOT NULL,
    "equipoLocalId" INTEGER NOT NULL,
    "equipoVisitanteId" INTEGER NOT NULL,
    "fechaEncuentro" TIMESTAMPTZ NOT NULL,
    "canchaId" INTEGER NOT NULL,
    "resultadoId" INTEGER NOT NULL,
    "campeonatoId" INTEGER NOT NULL,
    "arbiroId" INTEGER NOT NULL,

    CONSTRAINT "Cronograma_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Credenciales_username_key" ON "Credenciales"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Arbitro_personaId_key" ON "Arbitro"("personaId");

-- CreateIndex
CREATE UNIQUE INDEX "Presidente_personaId_key" ON "Presidente"("personaId");

-- CreateIndex
CREATE UNIQUE INDEX "Jugador_personaId_key" ON "Jugador"("personaId");

-- CreateIndex
CREATE UNIQUE INDEX "Cronograma_resultadoId_key" ON "Cronograma"("resultadoId");

-- AddForeignKey
ALTER TABLE "Arbitro" ADD CONSTRAINT "Arbitro_personaId_fkey" FOREIGN KEY ("personaId") REFERENCES "Persona"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Presidente" ADD CONSTRAINT "Presidente_personaId_fkey" FOREIGN KEY ("personaId") REFERENCES "Persona"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Jugador" ADD CONSTRAINT "Jugador_personaId_fkey" FOREIGN KEY ("personaId") REFERENCES "Persona"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Jugador" ADD CONSTRAINT "Jugador_categoriaId_fkey" FOREIGN KEY ("categoriaId") REFERENCES "Categoria"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Campeonato" ADD CONSTRAINT "Campeonato_categoriaId_fkey" FOREIGN KEY ("categoriaId") REFERENCES "Categoria"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Color" ADD CONSTRAINT "Color_equipoId_fkey" FOREIGN KEY ("equipoId") REFERENCES "Equipo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Posiciones" ADD CONSTRAINT "Posiciones_equipoId_fkey" FOREIGN KEY ("equipoId") REFERENCES "Equipo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Posiciones" ADD CONSTRAINT "Posiciones_campeonatoId_fkey" FOREIGN KEY ("campeonatoId") REFERENCES "Campeonato"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cronograma" ADD CONSTRAINT "Cronograma_equipoLocalId_fkey" FOREIGN KEY ("equipoLocalId") REFERENCES "Equipo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cronograma" ADD CONSTRAINT "Cronograma_equipoVisitanteId_fkey" FOREIGN KEY ("equipoVisitanteId") REFERENCES "Equipo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cronograma" ADD CONSTRAINT "Cronograma_campeonatoId_fkey" FOREIGN KEY ("campeonatoId") REFERENCES "Campeonato"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cronograma" ADD CONSTRAINT "Cronograma_resultadoId_fkey" FOREIGN KEY ("resultadoId") REFERENCES "Resultado"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cronograma" ADD CONSTRAINT "Cronograma_arbiroId_fkey" FOREIGN KEY ("arbiroId") REFERENCES "Arbitro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
