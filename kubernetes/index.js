require('dotenv').config();
const express = require('express');
const reditos_app = express();
const port = process.env.PORT || 3000;

reditos_app.get('/health', (req, res) => {
  res.json({ health: "ok" });
});

reditos_app.get('/index', (req, res) => {
  res.json({ message: "Hola mundo desde Kubernetes" });
});

reditos_app.listen(port, () => {
  console.log(`Reditos-App en Node puerto: ${port}`);
  console.log(`http://localhost:${port}/health`);
  console.log(`http://localhost:${port}/index`);
});

// Exportar app para usar en los tests
module.exports = reditos_app;
