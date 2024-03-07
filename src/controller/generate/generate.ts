import { Request, Response } from "express";

export const generateController = (
  dbTable,
  filterFunc,
  funcModelData = (data) => data
) => {
  const getById = async (req: Request, res: Response) => {
    const id = Number(req.params.id);
    const where = filterFunc(id);
    const response = await dbTable.findUniqueOrThrow({ where });
    res.json(response);
  };

  const getAll = async (req: Request, res: Response) => {
    const response = await dbTable.findMany();
    res.json(response);
  };

  const create = async (req: Request, res: Response) => {
    const data = funcModelData(req.body);
    const response = await dbTable.create({ data });
    res.status(201).json(response);
  };

  const update = async (req: Request, res: Response) => {
    const data = funcModelData(req.body);
    const id = Number(req.params.id);
    const where = filterFunc(id);
    const response = await dbTable.update({ data, where });
    res.status(203).json(response);
  };

  const destroy = async (req: Request, res: Response) => {
    const id = Number(req.params.id);
    const where = filterFunc(id);
    await dbTable.findUniqueOrThrow({ where });
    const response = await dbTable.delete({ where });
    res.status(204).json(response);
  };

  return { getAll, getById, create, destroy, update };
};
