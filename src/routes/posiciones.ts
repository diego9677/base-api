import { Router } from "express";


const router = Router();

router.get('/:campId', async (req, res) => {
  const { campId } = req.params;
  const tablaPosiciones = await prisma.posiciones.findMany({
    where: { campeonatoId: Number(campId) },
    include: { equipo: true },
    orderBy: { puntos: 'desc' },
  });

  return res.status(200).json(tablaPosiciones);
});

router.post('/generate', async (req, res) => {
  const { campeonatoId, equiposId } = req.body;

  for (const id of equiposId) {
    await prisma.posiciones.create({
      data: { equipoId: Number(id), campeonatoId }
    });
  }

  const tablaPos = await prisma.posiciones.findMany({ where: { campeonatoId }, include: { equipo: true } });

  return res.status(200).json(tablaPos);
});

export default router;