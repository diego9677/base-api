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
    "fechaFin" VARCHAR(100) NOT NULL,
    "fechaInicio" VARCHAR(100) NOT NULL,

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
    "fechaFundacion" VARCHAR(100) NOT NULL,
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
    "cronogramaId" INTEGER,

    CONSTRAINT "Resultado_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cronograma" (
    "id" SERIAL NOT NULL,
    "campeonatoId" INTEGER NOT NULL,
    "equipoLocalId" INTEGER NOT NULL,
    "equipoVisitanteId" INTEGER NOT NULL,
    "fechaEncuentro" VARCHAR(100),
    "resultadoId" INTEGER,
    "canchaId" INTEGER,
    "arbitroId" INTEGER,

    CONSTRAINT "Cronograma_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_CampeonatoToEquipo" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
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
CREATE UNIQUE INDEX "Resultado_cronogramaId_key" ON "Resultado"("cronogramaId");

-- CreateIndex
CREATE UNIQUE INDEX "_CampeonatoToEquipo_AB_unique" ON "_CampeonatoToEquipo"("A", "B");

-- CreateIndex
CREATE INDEX "_CampeonatoToEquipo_B_index" ON "_CampeonatoToEquipo"("B");

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
ALTER TABLE "Resultado" ADD CONSTRAINT "Resultado_cronogramaId_fkey" FOREIGN KEY ("cronogramaId") REFERENCES "Cronograma"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cronograma" ADD CONSTRAINT "Cronograma_equipoLocalId_fkey" FOREIGN KEY ("equipoLocalId") REFERENCES "Equipo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cronograma" ADD CONSTRAINT "Cronograma_equipoVisitanteId_fkey" FOREIGN KEY ("equipoVisitanteId") REFERENCES "Equipo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cronograma" ADD CONSTRAINT "Cronograma_campeonatoId_fkey" FOREIGN KEY ("campeonatoId") REFERENCES "Campeonato"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cronograma" ADD CONSTRAINT "Cronograma_arbitroId_fkey" FOREIGN KEY ("arbitroId") REFERENCES "Arbitro"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cronograma" ADD CONSTRAINT "Cronograma_canchaId_fkey" FOREIGN KEY ("canchaId") REFERENCES "Cancha"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CampeonatoToEquipo" ADD CONSTRAINT "_CampeonatoToEquipo_A_fkey" FOREIGN KEY ("A") REFERENCES "Campeonato"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CampeonatoToEquipo" ADD CONSTRAINT "_CampeonatoToEquipo_B_fkey" FOREIGN KEY ("B") REFERENCES "Equipo"("id") ON DELETE CASCADE ON UPDATE CASCADE;
