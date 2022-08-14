import { BaseOutputDto } from "../../common/dtos/base.output.dto";
import { IsEmail, IsNotEmpty } from "class-validator";

export class UsersSignUpInputDto {
  @IsEmail()
  @IsNotEmpty()
  email: string


}

export class UsersSignUpOutputDto extends BaseOutputDto<any>{}
