const axios = require("axios");
const { v4: uuid } = require("uuid");
const router = require("./routers.json");
const dotenv = require("dotenv");
dotenv.config();

const port = process.env.PORT || 3000;
const baseURL = `http://localhost:${port}/api/v1`;

const api = axios.create({ baseURL });

const generateIdRandom = () => {
  return Math.floor(Math.random() * 1000000);
};

describe.each(router)(
  "Tests for router: $router",
  ({ router, data, indentify }) => {
    let id, access;

    beforeAll(async () => {
      const objUser = {
        email: `${uuid()}@gmail.com`,
        password: uuid(),
        name: "tester",
      };

      const register = await api.post("/register", objUser);
      expect(register.status).toBe(201);

      const response = await api.post("/login", objUser);
      expect(response.data).toHaveProperty("token");
      expect(response.status).toBe(201);

      access = response.data.token.access;
      const string = `Bearer ${access}`;
      api.defaults.headers.common.Authorization = string;
    });

    it("Method get for list records", async () => {
      const response = await api.get(router);
      expect(response.status).toBe(200);
      expect(response.data).toBeInstanceOf(Array);
    });

    it("Create a record successfully", async () => {
      const response = await api.post(router, data);

      expect(response.status).toBe(201);
      expect(response.data).toBeInstanceOf(Object);
      expect(response.data).toHaveProperty(indentify);

      id = response.data[indentify];

      Object.keys(data).forEach((field) => {
        expect(response.data).toHaveProperty(field);
      });
    });

    it("Update a record successfully", async () => {
      const newValue = "Valor atualizado";

      let listObj = Object.entries(data);
      listObj[0][1] = newValue;
      const field = listObj[0][0];
      const objUpdate = Object.fromEntries(listObj);

      const response = await api.patch(`${router}/${id}`, objUpdate);
      expect(response.status).toBe(203);
      expect(response.data).toBeInstanceOf(Object);
      expect(response.data).toHaveProperty(indentify);
      expect(response.data[field]).toBe(newValue);

      Object.keys(objUpdate).forEach((field) => {
        expect(response.data).toHaveProperty(field);
      });
    });

    it("Get one record successfully", async () => {
      const response = await api.get(`${router}/${id}`);

      expect(response.status).toBe(200);
      expect(response.data).toBeInstanceOf(Object);
      expect(response.data).toHaveProperty(indentify);

      Object.keys(data).forEach((field) => {
        expect(response.data).toHaveProperty(field);
      });
    });

    it("Delete a record successfully", async () => {
      const response = await api.delete(`${router}/${id}`);
      expect(response.status).toBe(204);
      expect(response.data).toBe("");
    });

    it("Try update record not exists", async () => {
      const id = generateIdRandom()
      try {
        await api.patch(`${router}/${id}`, data);
        throw new Error("Error common");
      } catch (error) {
        expect(error).toBeInstanceOf(axios.AxiosError);
        expect(error.response.status).toBe(404);
      }
    });

    it("Try get record not exists", async () => {
      const id = generateIdRandom()
      try {
        await api.get(`${router}/${id}`);
        throw new Error("Error common");
      } catch (error) {
        expect(error).toBeInstanceOf(axios.AxiosError);
        expect(error.response.status).toBe(404);
      }
    });

    it("Try delete record after deleting", async () => {
      const record = await api.post(router, data);
      expect(record.status).toBe(201);
      const response = await api.delete(`${router}/${record.data[indentify]}`);
      expect(response.status).toBe(204);
      expect(response.data).toBe("");
      try {
        await api.delete(`${router}/${record.data[indentify]}`);
        throw new Error("Error common");
      } catch (error) {
        expect(error).toBeInstanceOf(axios.AxiosError);
        expect(error.response.status).toBe(404);
      }
    });
  }
);
