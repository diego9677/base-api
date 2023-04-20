import bcrypt from "bcrypt";

export async function encryptPwd(pwd: string) {
  const salt = await bcrypt.genSalt(10);
  return bcrypt.hash(pwd, salt);
}

export async function matchPwd(pwd: string, hashPwd: string) {
  return bcrypt.compare(pwd, hashPwd);
}