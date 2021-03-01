import { HttpService, Injectable } from '@nestjs/common';
import { PrismaService } from '../services/prisma.service';
import { Prisma, User } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import { Observable } from 'rxjs';
import { AxiosResponse } from 'axios';
import { map } from 'rxjs/operators';

export interface PokemonApiResult {
    count: number;
    next?: string;
    previous?: string;
    results: Pokemon[];
}

export interface Pokemon {
    name: string;
    url: string;
}

@Injectable()
export class UserService {
    constructor(
        private prisma: PrismaService,
        private httpService: HttpService,
    ) {}

    findAll(): Observable<AxiosResponse<PokemonApiResult>> {
        return this.httpService
            .get('https://pokeapi.co/api/v2/pokemon')
            .pipe(map(value => value.data));
    }

    async user(
        userWhereUniqueInput: Prisma.UserWhereUniqueInput,
    ): Promise<User | null> {
        return this.prisma.user.findUnique({
            where: userWhereUniqueInput,
        });
    }

    async users(params: {
        skip?: number;
        take?: number;
        cursor?: Prisma.UserWhereUniqueInput;
        where?: Prisma.UserWhereInput;
        orderBy?: Prisma.UserOrderByInput;
    }): Promise<User[]> {
        const { skip, take, cursor, where, orderBy } = params;
        return this.prisma.user.findMany({
            skip,
            take,
            cursor,
            where,
            orderBy,
        });
    }

    async createUser(data: Prisma.UserCreateInput): Promise<User> {
        const salt = 10;
        data.password = await bcrypt.hash(data.password, salt);

        // TODO: Tentar tirar essa parte daqui e colocar automático
        // Talvez via trigger com o campo aqui sendo opcional
        // ou via algum evento global de beforeCreate
        data.meta = {
            create: {},
        };

        const createdUser = await this.prisma.user.create({ data });

        delete createdUser.password;

        return createdUser;
    }

    async updateUser(params: {
        where: Prisma.UserWhereUniqueInput;
        data: Prisma.UserUpdateInput;
    }): Promise<User> {
        const { where, data } = params;
        return this.prisma.user.update({
            data,
            where,
        });
    }

    async deleteUser(where: Prisma.UserWhereUniqueInput): Promise<User> {
        return this.prisma.user.delete({
            where,
        });
    }
}
