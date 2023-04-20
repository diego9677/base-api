import { Router } from "express";
import jwt from "jsonwebtoken";

import { matchPwd } from "../helper/auth";
import prisma from "../lib/prisma";

const secretKey = "secret_key";

export const loginRouter = Router();

loginRouter.post("", async (req, res) => {
  const { username, password: plainPwd } = req.body;
  const credentialsDb = await prisma.credenciales.findUnique({ where: { username } });
  if (!credentialsDb) return res.status(400).json({ error: "Credenciales invalidas" });
  const { password: hashPwd, ...restCredentials } = credentialsDb;
  const isMached = matchPwd(plainPwd, hashPwd);
  if (!isMached) return res.status(400).json({ error: "Credenciales invalidas" });
  const token = jwt.sign(restCredentials, secretKey, { expiresIn: "5d" });
  return res.status(200).json({ ...restCredentials, token });
});

loginRouter.get("/whoiam", async (req, res) => {
  const [_, token] = req.headers.authorization!.split(' ');
  const credentialsDb = await prisma.credenciales.findUnique({ where: { id: req.user?.id } });
  if (!credentialsDb) return res.status(400).json({ error: "Credenciales no encontradas" });
  const { password: __, ...restCredentials } = credentialsDb;
  return res.status(200).json({ ...restCredentials, token });
});