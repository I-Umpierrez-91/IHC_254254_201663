const path = require('path');

// import .env variables

require('dotenv-safe').config({
	path: path.join(__dirname, '../../.env'),
	example: path.join(__dirname, '../../.env.example'),
});


const common = require('./constants.common');

module.exports = Object.assign(common);
