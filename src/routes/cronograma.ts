import { Router } from "express";

function generatePairings(players: number[]) {
  let n = players.length;
  let mod = n - 1;
  let decr = 0;
  let incr = -1;
  let gameCount = n / 2; // n is assumed to be even
  let props = ["visitante", "local"];
  let template = { local: players[mod], visitante: players[mod] };
  let pairings = [];
  for (let ronda = 1; ronda < n; ronda++) {
    let partidos = [{
      ...template,
      ...{ [props[ronda % 2]]: players[incr = (incr + 1) % mod] }
    }];
    for (let k = 1; k < gameCount; k++) {
      partidos.push({
        local: players[incr = (incr + 1) % mod],
        visitante: players[decr = (decr + mod - 1) % mod]
      });
    }
    pairings.push({ ronda, partidos });
  }
  return pairings;
}

const router = Router();

router.get('/:id', async (req, res) => {
  const { id } = req.params;
  const cronograma = await prisma.cronograma.findFirst({
    where: { id: Number(id) },
    include: { equipoLocal: true, equipoVisitante: true, arbitro: true, campeonato: true, resultado: true },
  });

  return res.status(200).json(cronograma);
});

router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { canchaId, arbitroId, fechaEncuentro } = req.body;

  const cronograma = await prisma.cronograma.update({
    data: { canchaId, arbitroId, fechaEncuentro },
    where: { id: Number(id) },
    include: { equipoLocal: true, equipoVisitante: true, arbitro: true, campeonato: true, resultado: true },
  });

  return res.status(200).json(cronograma);
});


router.post('/generar', async (req, res) => {
  const { campeonatoId, equiposId } = req.body;
  const partidos = generatePairings(equiposId);
  const campeonato = await prisma.campeonato.findFirst({ where: { id: Number(campeonatoId) } });
  if (!campeonato) return res.status(404).json({ error: 'Campeonato no encontrado' });

  const cronograma = partidos.flatMap(p => p.partidos).map(p => ({ campeonatoId, equipoLocalId: p.local, equipoVisitanteId: p.visitante }));

  await prisma.cronograma.createMany({ data: cronograma });

  const tablaCronograma = await prisma.cronograma.findMany({
    where: { campeonatoId: Number(campeonatoId) },
    include: { equipoLocal: true, equipoVisitante: true, arbitro: true, campeonato: true, cancha: true, resultado: true }
  });

  return res.status(200).json(tablaCronograma);
});

router.get('/campeonato/:campId', async (req, res) => {
  const { campId } = req.params;
  const tablaCronograma = await prisma.cronograma.findMany({
    where: { campeonatoId: Number(campId) },
    include: { equipoLocal: true, equipoVisitante: true, arbitro: true, campeonato: true, resultado: true, cancha: true },
    orderBy: { id: 'asc' }
  });

  return res.status(200).json(tablaCronograma);
});


export default router;