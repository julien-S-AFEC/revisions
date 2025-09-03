import 'dotenv/config'

import express from 'express'
import path from 'path'
import crypto from 'crypto'
import bodyParser from 'body-parser'
import sqlite3 from 'sqlite3'
import { transporter } from './mailer/mailer.js'

const generateToken = () => {
    const token = crypto.randomBytes(32).toString("hex");
    const hash = crypto.createHash("sha256").update(token).digest("hex")

    const expiresAt = Date.now() + 15 * 60 * 1000;
    return { token, hash, expiresAt, isUsed: false };
}

const isTokenValid = (token) => {
    const hash = crypto.createHash("sha256").update(token.token).digest("hex")

    if (Date.now() > token.expiresAt) {
        return false
    }

    if (token.hash === hash) {
        return true
    }
    return false
}

const app = express()
app.use(express.json())
app.use(express.static(path.join(path.resolve(), "front")));
app.use(bodyParser.urlencoded({ extended: true }));

// Front
app.get('/register', (req, res) => {
    res.sendFile(path.join(path.resolve(), '/front/accountCreation/register.html'))
})

app.post("/api/register", async (req, res) => {
    try {
        const db = new sqlite3.Database(
            path.join(path.resolve(), "/db/revisions.db")
        );

        db.get("SELECT * FROM users WHERE email=? OR name=?",
            [req.body.email, req.body.name],
            async (err, row) => {
                if (err) {
                    return res.status(500).json({ error: err.message });
                }

                if (row) {
                    return res.send("The email or username already exists.");
                }

                const hashedPassword = crypto.createHash("sha256").update(req.body.password).digest("hex");

                db.run(
                    "INSERT INTO users (name, email, password) VALUES (?, ?, ?)",
                    [req.body.name, req.body.email, hashedPassword],
                    async (err) => {
                        if (err) {
                            return res.status(500).json({ error: err.message });
                        }

                        try {
                            const token = generateToken()
                            await transporter.sendMail({
                                from: process.env.MAILER_USER,
                                to: req.body.email,
                                subject: "Hello ",
                                text: "Hello world?",
                                html: `<p>Hello, here is your activation link: http://localhost:3000/verify/?token=${token.token}&hash=${token.hash}&mail=${req.body.email}</p>`,
                            });

                            res.sendFile(
                                path.join(path.resolve(), "/front/accountCreation/registerAccepted.html")
                            );
                        } catch (mailErr) {
                            res.status(500).json({ error: "Email not sent", details: mailErr });
                        }
                    }
                );
            }
        );
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Unexpected server error" });
    }
});

app.get('/verify', (req, res) => {
    if (crypto.createHash("sha256").update(req.query.token).digest("hex") != req.query.hash) { return res.send("Error, the token is invalid or expired") }
    const db = new sqlite3.Database(
        path.join(path.resolve(), "/db/revisions.db")
    )
    db.run(
        "UPDATE users SET status=1 WHERE email=?",
        [req.query.mail],
        async (err) => {
            if (err) {
                return res.status(500).json({ error: err.message });
            }

            res.sendFile(path.join(path.resolve(), "/front/accountCreation/accountVerified.html"))
        })
})



app.listen(3000, () => {
    console.log("http://localhost:3000")
})