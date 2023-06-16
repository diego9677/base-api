import { Router } from "express";


const router = Router();

router.get('', async (req, res) => {
  const equipos = await prisma.equipo.findMany({
    orderBy: { id: 'asc' }
  });
  return res.status(200).json(equipos);
});

export default router;