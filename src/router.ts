import express from "express";

import * as user from "./controller/user";

import {
  book,
  bookAuthor,
  bookCategory,
  client,
  copy,
  employee,
  legalClient,
  order,
  orderHasCopy,
  orderOnline,
  physicalClient,
  physicalOrder,
  publisher,
  publisherEmail,
  publisherPhone,
} from "./controller";

import { authorization } from "./middleware/isAuttenticate";

export const router = express.Router();

const generateRouter = (path, controller) => {
  router
    .route(path)
    .post(authorization, controller.create)
    .get(authorization, controller.getAll);

  router
    .route(`${path}/:id`)
    .get(authorization, controller.getById)
    .patch(authorization, controller.update)
    .delete(authorization, controller.destroy);
};

const generateRouterWhithoutID = (path, controller) => {
  router
    .route(path)
    .post(authorization, controller.create)
    .get(authorization, controller.getAll)
    .patch(authorization, controller.update)
    .delete(authorization, controller.destroy);
};

router.post("/register", user.register);
router.post("/login", user.login);
router.get("/me", authorization, user.getUser);

generateRouter("/client", client);
generateRouter("/legal_client", legalClient);
generateRouter("/physical_client", physicalClient);

generateRouter("/employee", employee);

generateRouter("/order", order);
generateRouter("/online_order", orderOnline)
generateRouter("/physical_order", physicalOrder)
generateRouter("/order_has_copy", orderHasCopy);

generateRouter("/publisher", publisher);
generateRouterWhithoutID("/publisher_phone", publisherPhone);
generateRouterWhithoutID("/publisher_email", publisherEmail);

generateRouter("/book", book);
generateRouterWhithoutID("/book_author", bookAuthor);
generateRouterWhithoutID("/book_category", bookCategory);

generateRouter("/copy", copy);