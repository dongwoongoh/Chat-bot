import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { UsersModule } from './users/users.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath:
        process.env.NODE_ENV === 'production'
          ? '.env.production'
          : process.env.NODE_ENV === 'development'
          ? '.env.development'
          : '.env.test',
    }),
    UsersModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
