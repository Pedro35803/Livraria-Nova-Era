import { Request, Response } from "express";
import { Publisher } from "@prisma/client";
import { db } from "../../db";
import { clearStringForNumber } from "../../services/formatData";

export const getById = async (req: Request, res: Response) => {
  const cnpj = req.params.id;
  const response = await db.publisher.findUniqueOrThrow({ where: { cnpj } });
  res.json(response);
};

export const getAll = async (req: Request, res: Response) => {
  const response = await db.publisher.findMany();
  res.json(response);
};

export const create = async (req: Request, res: Response) => {
  const data: Publisher = req.body;
  const cnpj = clearStringForNumber(data.cnpj);
  const response = await db.publisher.create({ data: { ...data, cnpj } });
  res.status(201).json(response);
};

export const update = async (req: Request, res: Response) => {
  const data = req.body;
  const cnpj = clearStringForNumber(req.params.id);

  const update: Publisher = {
    ...data,
    cnpj: data.cnpj ? clearStringForNumber(data.cnpj) : undefined,
  };

  const response = await db.publisher.update({ data: update, where: { cnpj } });
  res.status(203).json(response);
};

export const destroy = async (req: Request, res: Response) => {
  const cnpj = clearStringForNumber(req.params.id);
  const where = { cnpj };
  await db.publisher.findUniqueOrThrow({ where });
  const response = await db.publisher.delete({ where });
  res.status(204).json(response);
};
