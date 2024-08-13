import { FastifyRequest, FastifyReply } from "fastify";
import { prisma } from "@/lib/prisma";
import { z } from "zod";
import bcrypt from "bcrypt";
import jwt from "jasonwebtoken";

//Registro de novos usuários
export async function register(request: FastifyRequest, reply: FastifyReply) {
    const registerSchema = z.object({
        nome: z.string(),
        email: z.string.email(),
        senha: z.string.min(8),
    });

    const { nome, email, senha } = registerSchema.parse(request.body);

    const existingUser = await prisma.usuario.findUnique({
        where: { email },
    });

    if (existingUser) {
        return reply.status(400).send({ error: "Email already in use" });
    }

    const saltRounds = 10;
    const senha_hash = await bcrypt.hash(senha, saltRounds);

    const user = await prisma.usuario.create({
        data: {
            nome,
            email,
            senha_hash,
        },
    });

    const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET!, {
        expiresIn: "1h",
    });

    return reply.status(201).send({ token })
}


//Login de usuários
export async function login(request: FastifyRequest, reply: FastifyReply) {
    const loginSchema = z.object({
        email: z.string().email(),
        senha: z.string(),
    });

    const { email, senha } = loginSchema.parse(request.body);

    const user = await prisma.usuario.findUnique({
        where: { email },
    });

    if (!user) {
        return reply.status(400).send({ error: "Invalid email or password" });
    }

    const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET!, {
        expiresIn: "1h",
    });

    return reply.send({ token });
}

