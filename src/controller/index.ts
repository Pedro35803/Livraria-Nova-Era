import { generateController } from "./generate";
import { db } from "../db";

export const client = generateController(db.client, (id) => ({ code: id }));
export const legalClient = generateController(db.legalClient, (id) => ({
  client_code: id,
}));
