import { Request, Response } from "express";
import { db } from "../../db";
import { PublisherPhone } from "@prisma/client";
import { clearStringForNumber, verifyField } from "../../services/formatData";

export const getAll = async (req: Request, res: Response) => {
  const search = req.query as PublisherPhone;
  const dbTable = db.publisherPhone;
  const objFunc = { where: search };
  const response =
    search.cnpj_publisher && search.phone
      ? await dbTable.findFirst(objFunc)
      : await dbTable.findMany(objFunc);
  res.json(response);
};

export const create = async (req: Request, res: Response) => {
  const data: PublisherPhone = req.body;
  const cnpj_publisher = clearStringForNumber(data.cnpj_publisher);
  const phone = clearStringForNumber(data.phone);
  const response = await db.publisherPhone.create({
    data: { cnpj_publisher, phone },
  });
  res.status(201).json(response);
};

export const update = async (req: Request, res: Response) => {
  const search = req.query as PublisherPhone;
  const data: PublisherPhone = req.body;

  verifyField(search, ["cnpj_publisher", "phone"]);

  const update: PublisherPhone = {
    ...data,
    cnpj_publisher: data.cnpj_publisher
      ? clearStringForNumber(data.cnpj_publisher)
      : undefined,
  };

  await db.publisherPhone.updateMany({
    data: update,
    where: search,
  });

  const response = await db.publisherPhone.findFirst({
    where: { ...search, ...update },
  });

  res.status(203).json(response);
};

export const destroy = async (req: Request, res: Response) => {
  const search = req.query as PublisherPhone;
  const where = { ...search };

  verifyField(search, ["cnpj_publisher", "phone"]);

  await db.publisherPhone.findFirstOrThrow({ where });
  const response = await db.publisherPhone.deleteMany({ where });

  res.status(204).json(response);
};
