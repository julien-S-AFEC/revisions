import express from 'express'
import path from 'path'
import dotenv from 'dotenv'
import sqlite3 from 'sqlite3'
import crypto from 'crypto'
import { transporter } from "./mailer.js";
import { body, validationResult } from "express-validator";
dotenv.config()

const generateToken = () => {
    const token = crypto.randomBytes(32);
    const hash = crypto.createHash("sha256").update(token).digest("hex")
    console.log(hash)

    const expiresAt = Date.now() + 15 * 60 * 1000;
    return { token, hash, expiresAt };
}

const isTokenValid = (token) => {
    const hash = crypto.createHash("sha256").update(token.token).digest("hex")

    if (Date.now() > token.expiresAt) {
        return false
    }

    if ( token.hash === hash ) {
        return true
    }
    return false
}

const token = generateToken()
console.log(isTokenValid(token))

const app = express()
app.use(express.json())
// app.use(bodyParser())

// Front
app.get('/', (req, res) => {
    res.sendFile(path.join(path.resolve(), '/front/index.html'))
})

//Back
app.get('/api/getUsers', (req, res) => {
    const db = new sqlite3.Database(path.join(path.resolve(), '/db/revisions.db'));

    db.all("SELECT * FROM users", function (err, rows) {
        // Fermer la DB en premier, peu importe le résultat
        if (err) {
            return res.status(500).send(err);
        }
        res.json(rows); // Envoie toutes les données en une fois
    });
})

app.get("/welcome-form", (req, res) => {
  res.send(`
    <h2>Formulaire de bienvenue</h2>
    <form action="/welcome" method="POST">
      <input type="text" name="name" placeholder="Votre prénom" required />
      <input type="email" name="email" placeholder="Votre email" required />
      <button type="submit">Envoyer</button>
    </form>
  `);
});

app.post(
  "/welcome",
  [
    body("name").notEmpty().withMessage("Le nom est requis"),
    body("email").isEmail().withMessage("Email invalide"),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).send("Erreur : " + JSON.stringify(errors.array()));
    }

    const { name, email } = req.body;

    try {
      await transporter.sendMail({
        from: process.env.EMAIL_USER,
        to: email,
        subject: "Bienvenue",
        html: `<h3>Bonjour ${name},</h3><p>Bienvenue dans notre application !</p>`,
      });

      res.send("Email de bienvenue envoyé !");
    } catch (err) {
      console.error(err);
      res.status(500).send("Erreur lors de l'envoi de l'email.");
    }
  }
);

app.listen(3000, () => {
    console.log("http://localhost:3000")
})