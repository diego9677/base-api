import { PrismaClient } from "@prisma/client";

const CATEGORIAS = [
  { nombre: "Sub 20", descripcion: "Jugadores desde los 18 a 21 años", edadInicio: 18, edadFin: 21 },
  { nombre: "Sub 25", descripcion: "Jugadores desde los 22 a 26 años", edadInicio: 22, edadFin: 26 }
];

const EQUIPOS = [
  { nombre: "Brannif", direccion: "Av. Siempre viva", fechaFundacion: "1999-12-31", color: { nombre: "Blanco" } },
  { nombre: "Santa Rosa", direccion: "Av. Siempre viva", fechaFundacion: "2005-01-31", color: { nombre: "Rojo" } },
  { nombre: "Villa Warnes", direccion: "Av. Siempre viva", fechaFundacion: "2001-02-28", color: { nombre: "Amarillo" } },
  { nombre: "Villa 1ro Mayo", direccion: "Av. Siempre viva", fechaFundacion: "1995-04-30", color: { nombre: "Verde" } },
  { nombre: "Morita", direccion: "Av. Siempre viva", fechaFundacion: "1969-12-31", color: { nombre: "Azul" } },
  { nombre: "El Carmen", direccion: "Av. Siempre viva", fechaFundacion: "2001-12-31", color: { nombre: "Naranja" } },
  { nombre: "Los Lotes", direccion: "Av. Siempre viva", fechaFundacion: "1969-12-31", color: { nombre: "Celeste" } },
  { nombre: "Plan 3000", direccion: "Av. Siempre viva", fechaFundacion: "1998-01-19", color: { nombre: "Guindo" } },
  { nombre: "Tajibos", direccion: "Av. Siempre viva", fechaFundacion: "1995-12-31", color: { nombre: "Negro" } },
  { nombre: "Villa Fatima", direccion: "Av. Siempre viva", fechaFundacion: "1999-12-31", color: { nombre: "Gris" } },
];


async function main() {
  const prisma = new PrismaClient();
  try {
    // const pwd = await encryptPwd('Admin12345');
    // const credDb = await prisma.credenciales.create({ data: { username: 'admin', password: pwd } });
    // console.log(`Credencial ${credDb.id} creada`);

    const categoriesCount = await prisma.categoria.count();
    const equiposCount = await prisma.equipo.count();

    if (categoriesCount === 0) {
      await prisma.categoria.createMany({ data: CATEGORIAS });
    }

    if (equiposCount === 0) {
      for (let i = 0; i < EQUIPOS.length; i++) {
        const equipo = EQUIPOS[i];
        await prisma.equipo.create({
          data: {
            nombre: equipo.nombre,
            direccion: equipo.direccion,
            fechaFundacion: equipo.fechaFundacion,
            escudo: '',
            colores: {
              create: {
                nombre: equipo.color.nombre,
              }
            }
          }
        });
      }
    }

  } finally {
    await prisma.$disconnect();
  }
}

main()
  .then(() => console.log('Seeded'));