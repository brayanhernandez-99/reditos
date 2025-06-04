const request = require('supertest');
const app = require('../index.js'); 

describe('GET /health', () => {
  it('Debería responder con estado 200 y { health: "ok" }', async () => {
    const res = await request(app).get('/health');
    if (res.status !== 200) {
      throw new Error(`Se esperaba status 200 pero se recibió ${res.status}`);
    }
    if (res.body.health !== "ok") {
      throw new Error(`Se esperaba el cuerpo { health: "ok" } pero se recibió: ${JSON.stringify(res.body)}`);
    }
  });
});
