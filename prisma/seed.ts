import { PrismaClient } from "@prisma/client";
import { encryptPwd } from "../src/helper/auth";

async function main() {
  const prisma = new PrismaClient();
  try {
    const pwd = await encryptPwd('Admin12345');
    const credDb = await prisma.credenciales.create({ data: { username: 'admin', password: pwd } });
    console.log(`Credencial ${credDb.id} creada`);
  } finally {
    await prisma.$disconnect();
  }
}

main()
  .then(() => console.log('Seeded'));