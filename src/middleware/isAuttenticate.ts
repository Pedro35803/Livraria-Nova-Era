import { NextFunction, Request, Response } from "express";
import jwt from "jsonwebtoken";

export const authorization = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const bearerToken = req.headers.authorization;

  if (!bearerToken) throw { status: 401, message: "Token is required" };

  const listString = bearerToken.split(" ");
  const token = listString[1];

  const secret = process.env.JWT_SECRET;
  const decoded = jwt.verify(token, secret);

  if (!decoded) throw { status: 401, message: "Unauthorized access" };

  req.userId = decoded;
  next();
};
