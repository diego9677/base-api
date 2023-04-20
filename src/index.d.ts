import { PrismaClient } from "@prisma/client";

export { };

declare global {
  var prisma: PrismaClient;
  namespace Express {
    export interface Request {
      user?: { id: number; username: string; };
    }
  }
}