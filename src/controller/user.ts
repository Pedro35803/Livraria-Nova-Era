import { Request, Response } from "express";
import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
import { db } from "../db";

export const register = async (req: Request, res: Response) => {
  const { email, password } = req.body;
  const encryptedPassword = await bcrypt.hash(password, 10);

  const user = await db.user.create({
    data: { email, password: encryptedPassword },
  });

  const response = { ...user, password: undefined };
  res.status(201).json(response);
};

export const login = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  const objError = { status: 401, message: "Invalid email or password" };

  const user = await db.user.findUniqueOrThrow({ where: { email } });
  if (!user) throw objError;

  const samePassword = await bcrypt.compare(password, user.password);
  if (!samePassword) throw objError;

  const secret = process.env.JWT_SECRET;
  const token = jwt.sign(user.id, secret, { algorithm: "HS256" });

  res.status(201).json({ token });
};

export const getUser = async (req: Request, res: Response) => {
  const id = Number(req.userId);
  const user = await db.user.findUnique({ where: { id } });
  res.json({ ...user, password: undefined });
};
