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

const CANCHAS = [
  { nombre: "Cancha Brannif", direccion: "Av. Siempre Viva" },
  { nombre: "Cancha Santa Rosa", direccion: "Av. Siempre Viva" },
  { nombre: "Cancha Villa Warnes", direccion: "Av. Siempre Viva" },
  { nombre: "Cancha Morita", direccion: "Av. Siempre Viva" },
  { nombre: "Cancha El Carmen", direccion: "Av. Siempre Viva" },
  { nombre: "Cancha Los Lotes", direccion: "Av. Siempre Viva" },
  { nombre: "Cancha Plan 3000", direccion: "Av. Siempre Viva" },
  { nombre: "Cancha Tajibos", direccion: "Av. Siempre Viva" },
  { nombre: "Cancha Villa Fatima", direccion: "Av. Siempre Viva" },
];

const ARBITROS = [
  { persona: { ci: "12345", nombres: "Pepe", apellidos: "Perez" } },
  { persona: { ci: "11231", nombres: "Juan", apellidos: "Martinez" } },
  { persona: { ci: "21334", nombres: "Ivan", apellidos: "Trolazo" } },
  { persona: { ci: "31273", nombres: "Ruben", apellidos: "Deleva" } },
];


async function main() {
  const prisma = new PrismaClient();
  try {
    // const pwd = await encryptPwd('Admin12345');
    // const credDb = await prisma.credenciales.create({ data: { username: 'admin', password: pwd } });
    // console.log(`Credencial ${credDb.id} creada`);

    const categoriesCount = await prisma.categoria.count();
    const equiposCount = await prisma.equipo.count();
    const canchasCount = await prisma.cancha.count();
    const arbitrosCount = await prisma.arbitro.count();

    if (arbitrosCount === 0) {
      for (let i = 0; i < ARBITROS.length; i++) {
        const { nombres, apellidos, ci } = ARBITROS[i].persona;
        await prisma.arbitro.create({
          data: {
            persona: {
              create: {
                ci,
                nombres,
                apellidos
              }
            }
          }
        });
      }
    }

    if (canchasCount === 0) {
      await prisma.cancha.createMany({ data: CANCHAS });
    }

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