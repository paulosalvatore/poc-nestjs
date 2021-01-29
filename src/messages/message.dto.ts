import { IsInt, IsOptional, IsString } from 'class-validator';

export class MessageDto {
  @IsInt()
  @IsOptional()
  id: number;

  @IsString()
  text: string;
}
