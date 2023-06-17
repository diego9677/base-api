import { Router } from "express";


const router = Router();

router.get('', async (req, res) => {
  const arbitros = await prisma.arbitro.findMany({
    orderBy: { id: 'asc' },
    include: { persona: true }
  });

  return res.status(200).json(arbitros);
});

export default router;
