import express from "express";
import cors from "cors";
import router from "./routes.js"; // <- sem chaves, pois é export default

const server = express();
server.use(cors());
server.use(express.json());
server.use(router);

export { server };
