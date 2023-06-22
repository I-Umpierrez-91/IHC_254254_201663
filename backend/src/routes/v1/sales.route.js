const express = require('express');
// eslint-disable-next-line new-cap
const router = express.Router();
const controller = require('../../controllers/saleController');

router.post('/', controller.post);

module.exports = router;
