import express from "express";

import * as user from "./controller/user";

import {
  client,
  employee,
  legalClient,
  order,
  orderHasCopy,
  physicalClient,
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
// generateRouter("/online_order", onlineOrder)
// generateRouter("/in_person_order", inPersonOrder)
generateRouter("/order_has_copy", orderHasCopy);

generateRouter("/publisher", publisher);
generateRouterWhithoutID("/publisher_phone", publisherPhone);
generateRouterWhithoutID("/publisher_email", publisherEmail);
