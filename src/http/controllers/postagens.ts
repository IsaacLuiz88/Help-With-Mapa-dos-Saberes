import { FastifyRequest, FastifyReply } from "fastify";
import { prisma } from "@/lib/prisma";
import { z } from "zod";

export async function createPostagem(request: FastifyRequest, reply: FastifyReply) {
    const postagemSchema = z.object({
      titulo: z.string(),
      conteudo: z.string(),
    });

    const { titulo, conteudo } = postagemSchema.parse(request.body);

  const postagem = await prisma.postagem.create({
    data: {
      titulo,
      conteudo,
      usuarioId: request.user.userId, // Assumindo que o userId é o ID do usuário autenticado
    },
  });

  return reply.status(201).send(postagem);
}

export async function deletePostagem(request: FastifyRequest, reply: FastifyReply) {
    const { id } = request.params;
  
    const postagem = await prisma.postagem.findUnique({
      where: { id: Number(id) },
    });
  
    if (postagem?.usuarioId !== request.user.userId) {
      return reply.status(403).send({ error: "You can only delete your own posts" });
    }
  
    await prisma.postagem.delete({
      where: { id: Number(id) },
    });
  
    return reply.status(204).send();
  }