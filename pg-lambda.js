import { Client } from 'pg';

const dbOptions = {
    host: process.env.HOST,
    port: process.env.PORT,
    database: process.env.DATABASE,
    user: process.env.USERNAME,
    password: process.env.PASSWORD,
    ssl: {
        rejectUnauthorized: false
    },
    connectionTimeoutMillis: 5000
}


export const handler = async (event, context, callback) => {
    const client = new Client(dbOptions);
    await client.connect();

  try {


  } catch(error) {
    console.error(error);

    return {
      statusCode: 500,
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
      body: JSON.stringify({ message: 'Internal Server Error' }),
    }
  } finally {
    client.end();
  }
};
