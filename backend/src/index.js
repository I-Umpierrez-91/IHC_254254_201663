const { port, env } = require("./constants");
const app = require("./config/express.config");
require("./persistence");

app.listen(port, (err) => {
  if (err) {
    console.error(err);
  }
  console.log(`Server is running on port ${port} in ${env} mode`);
});
