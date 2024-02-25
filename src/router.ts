import express from "express";

import * as user from "./controller/user";

import * as client from "./controller/client";

import { authorization } from "./middleware/isAuttenticate";

export const router = express.Router();

router.post("/register", user.register);
router.post("/login", user.login);
router.get("/me", authorization, user.getUser);

router.route("/client").post(client.create).get(client.getAll);

router
  .route("/client/:id")
  .get(client.getById)
  .patch(client.update)
  .delete(client.destroy);
