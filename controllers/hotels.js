// eslint-disable-next-line spaced-comment
/*eslint max-len: ["error", { "code": 250 }] */

const asyncHandler = require('express-async-handler');
const model = require('../model/hotels');

const getHotels = asyncHandler(async (req, res) => {
  res.status(200).json(await model.getHotels());
});

const getHotelDistrict = asyncHandler(async (req, res) => {
  const { bzrkName } = req.params;
  const rows = await model.getHotelDistrict(req.params.bzrkName);
  if (rows.length === 0) {
    res
      .status(404)
      .send(
        `Für den Bezirk ${bzrkName} haben wir leider kein Hotel gespeichert. Bitte suchen Sie nach einem anderen Bezirk oder überprüfen Sie nochmal Ihre Eingabe`,
      );
  } else res.status(200).json(rows);
});

const getHotelAusstattungen = asyncHandler(async (req, res) => {
  const { id } = req.params;
  const rows = await model.getHotelAusstattungen(id);
  if (rows.length === 0) {
    res
      .status(404)
      .send(
        `Für das Hotel mit der ID ${id} haben wir leider kein Ausstattungen gespeichert. Bitte suchen Sie nach einem anderen Hotel oder überprüfen Sie nochmal Ihre Eingabe`,
      );
  } else res.status(200).json(rows);
});

const postHotel = asyncHandler(async (req, res) => {
  const { name, preisProNacht, bewertung, unterkunftsart, postleitzahl } = req.body;
  if (!name || !preisProNacht || !bewertung || !unterkunftsart || !postleitzahl) {
    res
      .status(400)
      .send('One or more properties missing: name, preisProNacht, bewertung, unterkunftsart, postleitzahl');
  } else res.status(201).json(await model.postHotel(req.body));
});

const deleteHotel = asyncHandler(async (req, res) => {
  const { id } = req.params;
  const rows = await model.getHotel({ id });
  if (rows.length > 0) {
    model.deleteHotel(id);
    res.status(200).send(`Das Hotel mit der ID ${id} wurde erfolgreich gelöscht`);
  } else {
    res.status(404).send(`Das folgende Hotel mit der ID ${id} wurde nicht gefunden`);
  }
});

const changeHotelProps = asyncHandler(async (req, res) => {
  const { id } = req.params;
  const rows = await model.getHotel({ id });
  if (rows.length > 0) {
    model.changeHotelProps(id, req.body);
    res.status(200).send(`Das Hotel mit der ID ${id} wurde erfolgreich geupdated`);
  } else {
    res.status(404).send(`Das Hotel mit der ID ${id} wurde nicht gefunden`);
  }
});

module.exports = {
  getHotels,
  postHotel,
  getHotelDistrict,
  deleteHotel,
  changeHotelProps,
  getHotelAusstattungen,
};
