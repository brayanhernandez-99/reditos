const request = require('supertest');
const app = require('../index.js'); 

describe('GET /not-found', () => {
  it('Debería responder con 404 a una ruta inexistente', async () => {
    const res = await request(app).get('/not-found');
    if (res.status !== 404) {
      throw new Error(`Se esperaba status 404 para una ruta inexistente, pero se recibió: ${res.status}`);
    }
  });
});
