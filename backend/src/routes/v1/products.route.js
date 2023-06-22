const express = require('express');
const controller = require('../../controllers/productController');

const router = express.Router();

router.post('/', controller.post);
router.get('/', controller.list);
router.get('/:productId(\\d+)', controller.get);
router.put('/:productId(\\d+)', controller.put);
router.delete('/:productId(\\d+)', controller.delete);

module.exports = router;
