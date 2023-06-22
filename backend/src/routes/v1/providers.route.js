const express = require('express');
// eslint-disable-next-line new-cap
const router = express.Router();
const controller = require('../../controllers/providerController');

router.post('/', controller.post);
router.get('/:id', controller.get);
router.get('/', controller.getAll);
router.delete('/:id', controller.delete);
router.patch('/:id', controller.patch);

module.exports = router;
