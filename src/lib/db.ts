import * as process from 'process';
import { Client } from 'pg';
import dotenv from 'dotenv';

dotenv.config();

export const getDBClient = async () => {
  const client = new Client({
    host: process.env.HOST,
    port: parseInt(process.env.PORT || '5432', 10),
    database: process.env.DATABASE,
    user: process.env.USERNAME,
    password: process.env.PASSWORD,
  });

  await client.connect();
  return client;
};