import 'dotenv/config';
import express, { NextFunction, Request, Response } from "express";
import morgan from "morgan";
import cors from "cors";
import { loginRouter } from "./routes/login.route";
import { expressjwt } from "express-jwt";

const secretKey = "secret_key";

const app = express();

// middlewares
app.use(morgan("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cors());

// authentication
app.use(
  expressjwt({ secret: secretKey, credentialsRequired: true, requestProperty: 'user', algorithms: ['HS256'] })
    .unless({
      path: [
        '/api/login']
    })
);

// error habdlers
app.use((err: any, req: Request, res: Response, next: NextFunction) => {
  if (res.headersSent) {
    return next(err);
  }

  if (err.name === 'TypeError') {
    return res.status(400).json({ error: err.message });
  }

  if (err.name === 'UnauthorizedError') {
    return res.status(401).json({ error: err.message });
  }

  return res.status(500).json({ error: err.message });
});

// routes
app.use("/api/login", loginRouter);

app.listen(3000);
console.log("server running in http://localhost:3000");