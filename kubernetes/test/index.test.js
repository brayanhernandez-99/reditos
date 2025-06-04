const request = require('supertest');
const app = require('../index.js'); 

describe('GET /index', () => {
  it('Debería responder con estado 200 y mensaje esperado', async () => {
    const res = await request(app).get('/index');

    if (res.status !== 200) {
      throw new Error(`Se esperaba status 200 pero se recibió ${res.status}`);
    }

    if (res.body.message !== "Hola mundo desde Kubernetes") {
      throw new Error(`Se esperaba mensaje "Hola mundo desde Kubernetes" pero se recibió: ${JSON.stringify(res.body)}`);
    }
  });
});
