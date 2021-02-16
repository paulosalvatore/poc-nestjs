import { Gender, Prisma } from '@prisma/client';
import { IsDate, IsEnum, IsOptional, IsString, Length } from 'class-validator';
import { Cpf } from '../../decorators/validators/Cpf';

type UserCreateInput = Prisma.UserCreateInput;

export class CreateUserDto implements UserCreateInput {
    @IsString()
    @IsOptional()
    email: string;

    @IsString()
    @IsOptional()
    password?: string;

    @IsString()
    @IsOptional()
    name?: string;

    @IsString()
    @IsOptional()
    nickname?: string;

    @Cpf()
    cpf: string;

    @IsString()
    @Length(10, 11)
    @IsOptional()
    phone?: string;

    @IsEnum(Gender)
    @IsOptional()
    gender?: 'MALE' | 'FEMALE' | 'OTHER';

    @IsDate()
    @IsOptional()
    birthdate?: string | Date;

    @IsString()
    @IsOptional()
    avatar?: string;

    campuses?: Prisma.CampusCreateNestedManyWithoutUsersInput;
    role?: Prisma.UserRoleCreateNestedManyWithoutUserInput;
    speaker?: Prisma.SpeakerCreateNestedOneWithoutUserInput;
    meta: Prisma.MetaCreateNestedOneWithoutUserInput;
}
