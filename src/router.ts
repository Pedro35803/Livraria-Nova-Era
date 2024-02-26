import express from "express";

import * as user from "./controller/user";

import { client, legalClient } from "./controller";

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

router.post("/register", user.register);
router.post("/login", user.login);
router.get("/me", authorization, user.getUser);

generateRouter("/client", client);
generateRouter("/legal_client", legalClient);
