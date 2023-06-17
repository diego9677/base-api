import { Router } from "express";


const router = Router();

router.get('', async (req, res) => {
  const canchas = await prisma.cancha.findMany({
    orderBy: { id: 'asc' }
  });

  return res.status(200).json(canchas);
});

export default router;