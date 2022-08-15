import { BaseOutputDto } from '../../common/dtos/base.output.dto';
import { IsBoolean, IsEmail, IsNotEmpty, IsString } from 'class-validator';

export class UsersSignUpInputDto {
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @IsString()
  @IsNotEmpty()
  password: string;

  @IsString()
  @IsNotEmpty()
  confirmPassword: string;

  @IsBoolean()
  alram: boolean;
}

export class UsersSignUpOutputDto extends BaseOutputDto<any> {}
