import { FastifyRequest, FastifyReply } from "fastify";
import { prisma } from "@/lib/prisma";
import { z } from "zod";

export async function createEspaco(request: FastifyRequest, reply: FastifyReply) {
    const espacoSchema = z.object({
        nome: z.string(),
        data: z.date().optional(),
        endereco: z.string(),
        contato: z.string(),
        email: z.string().email(),
        descricao: z.string(),
    });

    const { nome, data, endereco, contato, email, descricao } = espacoSchema.parse(request.body);

    const espaco = await prisma.espacos.create({
        nome,
        data,
        endereco,
        contato,
        email,
        descricao,
        bolsistaId: request.user.userId, // Assumindo que o userId é o ID do bolsista autenticado
    });

    return reply.status(200).send(espaco);
}

export async function updateEspaco(request: FastifyRequest, reply: FastifyReply) {
    const espacoSchema = z.object({
        nome: z.string(),
        data: z.date().optional(),
        endereco: z.string(),
        contato: z.string(),
        email: z.string().email(),
        descricao: z.string(),
    });

    const { nome, data, endereco, contato, email, descricao } = espacoSchema.parse(request.body);
    const { id } = request.params;

    const espaco = await prisma.espacos.update({
        where: { id: Number(id) },
        data: {
            nome,
            data,
            endereco,
            contato,
            email,
            descricao,
        },
    });

    return reply.status(200).send(espaco);
}

export async function deleteEspaco(request: FastifyRequest, reply: FastifyReply) {
    const { id } = request.params;
  
    await prisma.espacos.delete({
      where: { id: Number(id) },
    });
  
    return reply.status(204).send();
  }
  