const express = require("express");

const app = express();

const PORT = process.env.PORT || 3000;

// Home endpoint
app.get("/", (req, res) => {
    res.send(`
        <h1>DevOps Capstone Application</h1>
        <p>Running on AWS EKS</p>
    `);
});

// Health check endpoint
app.get("/health", (req, res) => {
    res.json({
        status: "healthy",
        application: "devops-capstone",
        timestamp: new Date().toISOString()
    });
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Application running on port ${PORT}`);
});