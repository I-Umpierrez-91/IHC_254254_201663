module.exports = {
  client: 'mysql',
  connection: {
    host: process.env.RDS_HOSTNAME,
    user: process.env.RDS_USERNAME,
    password: process.env.RDS_PASSWORD,
    database: process.env.RDS_DB_NAME,
    port: process.env.RDS_PORT,
  },
  migrations: {
    directory: './src/persistence/knex/migrations',
  },
};
