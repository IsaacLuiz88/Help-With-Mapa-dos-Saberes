import { FastifyRequest, FastifyReply } from "fastify";
import jwt from "jsonwebtoken";

export async function authenticate(request: FastifyRequest, reply: FastifyReply) {
    const authHeader = request.headers.authorization;
    if (!authHeader) {
        return reply.status(401).send({ error: "No token provided" });
    }

    const [, token] = authHeader.split(" ");
    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET!);
        request.user = decoded;
    } catch (err) {
        return reply.status(401).send({ error: "Token invalid or expired" });
    }

}