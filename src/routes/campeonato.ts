import { Router } from "express";


const router = Router();

router.get('', async (req, res) => {
  const campeonatos = await prisma.campeonato.findMany({ orderBy: { id: 'asc' }, include: { categoria: true, equipos: true } });

  return res.status(200).json(campeonatos);
});

router.post('', async (req, res) => {
  const { nombre, categoriaId, fechaInicio, fechaFin, equiposId } = req.body;
  const ids = equiposId.map((id: number) => ({ id }));
  const campeonato = await prisma.campeonato.create({
    data: {
      nombre,
      fechaInicio,
      fechaFin,
      categoria: {
        connect: { id: categoriaId },
      },
      equipos: {
        connect: ids,
      },
    }
  });

  return res.status(200).json(campeonato);
});

router.get('/:id', async (req, res) => {
  const { id: idTxt } = req.params;
  const campeonato = await prisma.campeonato.findFirst({ where: { id: Number(idTxt) }, include: { equipos: true } });

  if (!campeonato) return res.status(404).json({ error: 'Campeonato no encontrado' });

  return res.status(200).json(campeonato);
});

router.put('/:id', async (req, res) => {
  const { id: idTxt } = req.params;
  const { nombre, categoriaId, fechaInicio, fechaFin, equiposId } = req.body;
  const ids = equiposId.map((id: number) => ({ id }));
  const campeonato = await prisma.campeonato.findFirst({ where: { id: Number(idTxt) } });

  if (!campeonato) return res.status(404).json({ error: 'Campeonato no encontrado' });

  const updated = await prisma.campeonato.update({
    data: {
      nombre,
      fechaInicio,
      fechaFin,
      categoria: {
        connect: { id: categoriaId }
      },
      equipos: {
        set: ids,
      }
    },
    where: { id: Number(idTxt) }
  });

  return res.status(200).json(updated);
});

router.delete('/:id', async (req, res) => {
  const { id: idTxt } = req.params;
  const campeonato = await prisma.campeonato.findFirst({ where: { id: Number(idTxt) } });

  if (!campeonato) return res.status(404).json({ error: 'Campeonato no encontrado' });

  const deleted = await prisma.campeonato.delete({ where: { id: Number(idTxt) } });

  return res.status(200).json(deleted);
});

export default router;
