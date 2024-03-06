import { Request, Response } from "express";
import { verifyDoubleID, verifyField } from "../services/formatData";

export const generateForDoubleIDController = <PrismaTable>(
  dbTable,
  listDoubleID,
  funcModelData = (data) => data
) => {
  const getAll = async (req: Request, res: Response) => {
    const search = funcModelData(req.query) as PrismaTable;
    const objFunc = { where: search };
    const response = verifyDoubleID(search, listDoubleID)
      ? await dbTable.findFirstOrThrow(objFunc)
      : await dbTable.findMany(objFunc);
    res.json(response);
  };

  const create = async (req: Request, res: Response) => {
    const dataJSON: PrismaTable = req.body;
    const data = funcModelData(dataJSON);
    const response = await dbTable.create({ data });
    res.status(201).json(response);
  };

  const update = async (req: Request, res: Response) => {
    const search = funcModelData(req.query) as PrismaTable;
    const data: PrismaTable = req.body;

    verifyField(search, listDoubleID);

    const update: PrismaTable = funcModelData(data);

    await dbTable.findFirstOrThrow({ where: search });

    await dbTable.updateMany({
      data: update,
      where: search,
    });

    const response = await dbTable.findFirst({
      where: { ...search, ...update },
    });

    res.status(203).json(response);
  };

  const destroy = async (req: Request, res: Response) => {
    const search = funcModelData(req.query) as PrismaTable;
    const where = { ...search };

    verifyField(search, listDoubleID);

    await dbTable.findFirstOrThrow({ where });
    const response = await dbTable.deleteMany({ where });

    res.status(204).json(response);
  };

  return { getAll, create, destroy, update };
};
