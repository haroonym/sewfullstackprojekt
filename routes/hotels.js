const express = require('express');
const {
  getHotels,
  postHotel,
  getHotelDistrict,
  deleteHotel,
  changeHotelProps,
  getHotelAusstattungen,
} = require('../controllers/hotels');

const router = express.Router();

router.get('/hotels', getHotels);
router.get('/hotels/:bzrkName', getHotelDistrict);
router.get('/hotels/ausstattungen/:id', getHotelAusstattungen);
router.post('/hotels', postHotel);
router.delete('/hotel/:id', deleteHotel);
router.patch('/hotel/:id', changeHotelProps);

module.exports = router;
