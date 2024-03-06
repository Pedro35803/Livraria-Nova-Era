import { Request, Response } from "express";
import { db } from "../../db";
import { PublisherEmail } from "@prisma/client";
import { clearStringForNumber, verifyField } from "../../services/formatData";

export const getAll = async (req: Request, res: Response) => {
  const search = req.query as PublisherEmail;
  const dbTable = db.publisherEmail;
  const objFunc = { where: search };
  const response =
    search.cnpj_publisher && search.email
      ? await dbTable.findFirst(objFunc)
      : await dbTable.findMany(objFunc);
  res.json(response);
};

export const create = async (req: Request, res: Response) => {
  const data: PublisherEmail = req.body;
  const cnpj_publisher = clearStringForNumber(data.cnpj_publisher);
  const response = await db.publisherEmail.create({
    data: { cnpj_publisher, email: data.email },
  });
  res.status(201).json(response);
};

export const update = async (req: Request, res: Response) => {
  const search = req.query as PublisherEmail;
  const data: PublisherEmail = req.body;

  verifyField(search, ["cnpj_publisher", "email"]);

  const update: PublisherEmail = {
    ...data,
    cnpj_publisher: data.cnpj_publisher
      ? clearStringForNumber(data.cnpj_publisher)
      : undefined,
  };

  await db.publisherEmail.updateMany({
    data: update,
    where: search,
  });

  const response = await db.publisherEmail.findFirst({
    where: { ...search, ...update },
  });

  res.status(203).json(response);
};

export const destroy = async (req: Request, res: Response) => {
  const search = req.query as PublisherEmail;
  const where = { ...search };

  verifyField(search, ["cnpj_publisher", "email"]);

  await db.publisherEmail.findFirstOrThrow({ where });
  const response = await db.publisherEmail.deleteMany({ where });

  res.status(204).json(response);
};
