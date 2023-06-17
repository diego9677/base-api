import { Router } from "express";

const router = Router();

router.post('', async (req, res) => {
  const { cronogramaId, tarjetasAmarillas, tarjetasRojas, golesLocal, golesVisitante } = req.body;

  const resultado = await prisma.resultado.create({
    data: {
      cronograma: {
        connect: { id: cronogramaId },
      },
      tarjetasAmarillas,
      tarjetasRojas,
      golesLocal,
      golesVisitante,
    }
  });

  const cronograma = await prisma.cronograma.findFirst({
    where: { id: cronogramaId }
  });

  if (!cronograma) return res.status(404);

  if (golesLocal > golesVisitante) {
    // gano local
    const posicion = await prisma.posiciones.findFirst({
      where: {
        equipoId: cronograma.equipoLocalId
      }
    });

    await prisma.posiciones.update({
      data: {
        partidosJugados: { increment: 1 },
        golesAFavor: { increment: golesLocal },
        golesEnContra: { increment: golesVisitante },
        puntos: { increment: 3 },
      },
      where: {
        id: posicion?.id,
      }
    });
  }

  if (golesVisitante > golesLocal) {
    // gano visitante
    const posicion = await prisma.posiciones.findFirst({
      where: {
        equipoId: cronograma.equipoVisitanteId
      }
    });

    await prisma.posiciones.update({
      data: {
        partidosJugados: { increment: 1 },
        golesAFavor: { increment: golesLocal },
        golesEnContra: { increment: golesVisitante },
        puntos: { increment: 3 },
      },
      where: {
        id: posicion?.id,
      }
    });
  }

  if (golesLocal === golesVisitante) {
    // emaptaron
    const posicion1 = await prisma.posiciones.findFirst({
      where: {
        equipoId: cronograma.equipoLocalId
      }
    });

    const posicion2 = await prisma.posiciones.findFirst({
      where: {
        equipoId: cronograma.equipoVisitanteId
      }
    });

    await prisma.posiciones.update({
      data: {
        partidosJugados: { increment: 1 },
        golesAFavor: { increment: golesLocal },
        golesEnContra: { increment: golesVisitante },
        puntos: { increment: 1 },
      },
      where: {
        id: posicion1?.id,
      }
    });

    await prisma.posiciones.update({
      data: {
        partidosJugados: { increment: 1 },
        golesAFavor: { increment: golesLocal },
        golesEnContra: { increment: golesVisitante },
        puntos: { increment: 1 },
      },
      where: {
        id: posicion2?.id,
      }
    });
  }

  return res.status(200).json(resultado);
});


export default router;
