import { server } from "./server.js";
import { DatabaseModel } from "./model/DatabaseModel.js";

const port: number = 3333;

async function startServer() {

  const db = new DatabaseModel();

  console.log("🔍 Testando conexão com o banco de dados...");

  const conectado = await db.testeConexao();

  if (!conectado) {
    console.log(" O servidor não conectado.");
    process.exit(1);
  }

  server.listen(port, () => {
    console.log(` Servidor executando em http://localhost:${port}`);
  });
}

startServer();
