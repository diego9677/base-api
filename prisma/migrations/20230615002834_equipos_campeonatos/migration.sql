-- CreateTable
CREATE TABLE "_CampeonatoToEquipo" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_CampeonatoToEquipo_AB_unique" ON "_CampeonatoToEquipo"("A", "B");

-- CreateIndex
CREATE INDEX "_CampeonatoToEquipo_B_index" ON "_CampeonatoToEquipo"("B");

-- AddForeignKey
ALTER TABLE "_CampeonatoToEquipo" ADD CONSTRAINT "_CampeonatoToEquipo_A_fkey" FOREIGN KEY ("A") REFERENCES "Campeonato"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CampeonatoToEquipo" ADD CONSTRAINT "_CampeonatoToEquipo_B_fkey" FOREIGN KEY ("B") REFERENCES "Equipo"("id") ON DELETE CASCADE ON UPDATE CASCADE;
