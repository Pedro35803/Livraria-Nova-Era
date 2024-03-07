import { generateController } from "./generate/generate";
import { db } from "../db";

import * as publisherController from "./custom/publisherController";
import { generateForDoubleIDController } from "./generate/generateForDoubleID";
import { clearStringForNumber } from "../services/formatData";

const choseValue = (data, callback) => (data ? callback(data) : undefined);

export const client = generateController(
  db.client,
  (id) => ({ code: id }),
  (data) => ({
    ...data,
    phone_01: choseValue(data.phone_01, clearStringForNumber),
    phone_02: choseValue(data.phone_02, clearStringForNumber),
  })
);

export const legalClient = generateController(
  db.legalClient,
  (id) => ({
    client_code: id,
  }),
  (data) => ({
    ...data,
    cnpj: choseValue(data.cnpj, clearStringForNumber),
  })
);

export const physicalClient = generateController(
  db.physicalClient,
  (id) => ({
    client_code: id,
  }),
  (data) => ({
    ...data,
    cpf: choseValue(data.cpf, clearStringForNumber),
    rg: choseValue(data.rg, clearStringForNumber),
  })
);

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
  cnpj_publisher: choseValue(data.cnpj_publisher, clearStringForNumber),
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

const modelDataBookAll = (data) => ({
  ...data,
  code_book: choseValue(data.code_book, Number),
});

export const book = generateController(
  db.book,
  (id) => ({ code: id }),
  modelDataPublisherAll
);

export const bookAuthor = generateForDoubleIDController(
  db.bookAuthor,
  ["code_book", "author"],
  modelDataBookAll
);
export const bookCategory = generateForDoubleIDController(
  db.bookCategory,
  ["code_book", "category"],
  modelDataBookAll
);

export const copy = generateController(db.copy, (id) => ({ code: id }));
