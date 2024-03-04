import { Request, Response } from "express";
import { db } from "../../db";
import { PublisherPhone } from "@prisma/client";
import { clearStringForNumber } from "../../services/formatData";

export const getById = async (req: Request, res: Response) => {
  const publisher_cnpj = req.params.id;
  const response = await db.publisherPhone.findUniqueOrThrow({
    where: { publisher_cnpj },
  });
  res.json(response);
};

export const getAll = async (req: Request, res: Response) => {
  const response = await db.publisherPhone.findMany();
  res.json(response);
};

export const create = async (req: Request, res: Response) => {
  const data: PublisherPhone = req.body;
  const publisher_cnpj = clearStringForNumber(data.publisher_cnpj);
  const phone = clearStringForNumber(data.phone);
  const response = await db.publisherPhone.create({
    data: { publisher_cnpj, phone },
  });
  res.status(201).json(response);
};

// Error causado para encontrar um registro, mas para isso tem que fundir os dois, colocar para ser com req.query

export const update = async (req: Request, res: Response) => {
  const publisher_cnpj = clearStringForNumber(req.params.id);
  const data: PublisherPhone = req.body;

  const update: Partial<PublisherPhone> = {};
  if (data.publisher_cnpj) update.publisher_cnpj = clearStringForNumber(data.publisher_cnpj);
  if (data.phone) update.phone = clearStringForNumber(data.phone);

  const response = await db.publisherPhone.update({ data: update, where: { publisher_cnpj } });
  res.status(203).json(response);
};

export const destroy = async (req: Request, res: Response) => {
  const publisher_cnpj = req.params.id;
  const where = { publisher_cnpj };
  await db.publisherPhone.findUniqueOrThrow({ where });
  const response = await db.publisherPhone.delete({ where });
  res.status(204).json(response);
};
