/* eslint-disable prefer-template */
/* eslint-disable guard-for-in */
const db = require('../db');

const getHotels = async () => {
  const { rows } = await db.query('SELECT * from hotels order by hotel_id');
  return rows;
};

async function getHotelDistrict(bzrkName) {
  const { rows } = await db.query(
    'SELECT * FROM hotels join bezirke b on hotels.postleitzahl = b.postleitzahl WHERE b.bzrk_name = $1;',
    [bzrkName],
  );
  return rows;
}

const getHotelAusstattungen = async (id) => {
  const { rows } = await db.query(
    'select bezeichnung from hotels join hotels_austattungen ha on hotels.hotel_id = ha.hotel_id join austattungen a on a.bezeichnung = ha.bezeichnungen where hotels.hotel_id = $1;',
    [id],
  );
  return rows;
};

const postHotel = async (body) => {
  const { rows } = await db.query(
    'INSERT INTO hotels (name, preis_pro_nacht, bewertung, unterkunftsart, postleitzahl) VALUES ($1,$2,$3,$4,$5) returning *',
    [body.name, body.preisProNacht, body.bewertung, body.unterkunftsart, body.postleitzahl],
  );
  return rows;
};

const deleteHotel = (id) => db.query('DELETE FROM hotels WHERE hotel_id = $1', [id]);

const getHotel = async (param) => {
  let result = null;
  if (param.id) {
    result = await db.query('SELECT * FROM hotels WHERE hotel_id = $1', [param.id]);
  }
  return result.rows;
};

const changeHotelProps = async (id, object) => {
  const upd = [];
  for (const key in object) {
    upd.push(`${key} = '${object[key]}'`);
  }
  const cmd = 'UPDATE hotels SET ' + upd.join(', ') + ' WHERE hotel_id = $1';
  await db.query(cmd, [id]);
};

module.exports = {
  getHotels,
  getHotelDistrict,
  postHotel,
  deleteHotel,
  getHotel,
  changeHotelProps,
  getHotelAusstattungen,
};
