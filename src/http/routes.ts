import { FastifyInstance } from "fastify";
import { register, login  } from "./controllers/auth";
import { createEspaco, updateEspaco, deleteEspaco } from "./controllers/espacos";
import { createPostagem, deletePostagem } from "./controllers/postagens";
import { authenticate } from "./middleware/authenticate";

export async function appRoutes(app: FastifyInstance) {
  //Rotas de autenticação
  app.post('/register', register);
  app.post('/login', login);

  //Rotas de Espaços
  app.post('/espacos', { preHandler: [authenticate] }, createEspaco);
  app.put('/espacos/:id', { preHandler: [authenticate] }, updateEspaco);
  app.delete('/espacos/:id', { preHandler: [authenticate] }, deleteEspaco);
  
  //Rotas de Postagens
  app.post('/postagem', { preHandler: [authenticate] }, createPostagem);
  app.delete('/postagem/:id', { preHandler: [authenticate] }, deletePostagem);
}


