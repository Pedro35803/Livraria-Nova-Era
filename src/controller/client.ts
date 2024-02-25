import { Request, Response } from "express";
import { db } from "../db";

export const getById = async (req: Request, res: Response) => {
  const id = Number(req.params.id);
  const response = await db.client.findUniqueOrThrow({ where: { code: id } });
  res.json(response);
};

export const getAll = async (req: Request, res: Response) => {
  const response = await db.client.findMany();
  res.json(response);
};

export const create = async (req: Request, res: Response) => {
  const data = req.body;
  const response = await db.client.create({ data });
  res.status(201).json(response);
};

export const update = async (req: Request, res: Response) => {
  const data = req.body;
  const id = Number(req.params.id);
  const response = await db.client.update({ data, where: { code: id } });
  res.status(203).json(response);
};

export const destroy = async (req: Request, res: Response) => {
  const id = Number(req.params.id);
  await db.client.findUniqueOrThrow({ where: { code: id } });
  const response = await db.client.delete({ where: { code: id } });
  res.status(204).json(response);
};
