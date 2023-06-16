import { Router } from "express";


const router = Router();

router.get('', async (req, res) => {
  const categorias = await prisma.categoria.findMany({ orderBy: { id: 'asc' } });
  return res.status(200).json(categorias);
});

export default router;