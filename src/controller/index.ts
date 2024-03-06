import { generateController } from "./generate";
import { db } from "../db";

import * as publisherController from "./custom/publisherController";
import { generateForDoubleIDController } from "./generateForDoubleID";
import { clearStringForNumber } from "../services/formatData";

export const client = generateController(db.client, (id) => ({ code: id }));
export const legalClient = generateController(db.legalClient, (id) => ({
  client_code: id,
}));
export const physicalClient = generateController(db.physicalClient, (id) => ({
  client_code: id,
}));

export const employee = generateController(db.employee, (id) => ({ code: id }));

export const order = generateController(db.order, (id) => ({ number: id }));
export const orderOnline = generateController(db.orderOnline, (id) => ({
  order_number: id,
}));
export const physicalOrder = generateController(db.physicalOrder, (id) => ({
  order_number: id,
}));
export const orderHasCopy = generateController(db.orderHasCopy, (id) => ({
  id,
}));

export const publisher = publisherController;

const modelDataPublisherAll = (data) => ({
  ...data,
  cnpj_publisher: data.cnpj_publisher
    ? clearStringForNumber(data.cnpj_publisher)
    : undefined,
});

export const publisherPhone = generateForDoubleIDController(
  db.publisherPhone,
  ["cnpj_publisher", "phone"],
  modelDataPublisherAll
);

export const publisherEmail = generateForDoubleIDController(
  db.publisherEmail,
  ["cnpj_publisher", "email"],
  modelDataPublisherAll
);

export const book = generateController(db.book, (id) => ({ code: id }));
export const bookAuthor = generateController(db.bookAuthor, (id) => ({
  book_code: id,
}));
export const bookCategory = generateController(db.bookCategory, (id) => ({
  book_code: id,
}));

export const copy = generateController(db.copy, (id) => ({ code: id }));
