import database from "mysql2/promise";
import "dotenv/config";
const connection = database.createPool({
  host: process.env.DB_HOST || "localhost",
  user: process.env.DB_USER || "root",
<<<<<<< HEAD
  password: process.env.DB_PASSWORD,
=======
  password: process.env.DB_PASSWORD || "123456",
>>>>>>> b60f829 (Lưu thay đổi của tôi trong src/index.js)
  database: process.env.DB_NAME || "phone_store",
  waitForConnections: true,
  connectionLimit: 20,
  maxIdle: 10, // max idle connections, the default value is the same as `connectionLimit`
  idleTimeout: 60000, // idle connections timeout, in milliseconds, the default value 60000
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelay: 0,
});
export default connection;
