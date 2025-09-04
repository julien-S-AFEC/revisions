import 'dotenv/config'
import express from 'express'
import path from 'path'
import bodyParser from 'body-parser'
import sqlite3 from 'sqlite3'
import { transporter } from './mailer/mailer.js'
import crypto from 'crypto'
import { body, validationResult } from "express-validator";
import cors from 'cors'
import multer from 'multer'
import nodemailer from 'nodemailer'
import fs from 'fs'
//Active la memoire de multer
const stockage = multer.memoryStorage()
//filtrer les types authoriser
const fileFilter = (requeteExpress, fileMulter, callback) => {

    if (!fileMulter.originalname.match(/\.(jpg|jpeg|png)$/))
        return callback(
            console.log('on veut pas de ton truc !!!'),
            false,
        );
    callback(null, true);
};
const upload = multer({ storage: stockage, fileFilter: fileFilter })
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
app.use(cors())
app.use(express.json())
app.use(express.static(path.join(path.resolve(), "front")));
// app.use(bodyParser.urlencoded({ extended: true }))
app.use(express.urlencoded({ extended: true }))



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


app.get('/contact', (req, res) => {
    res.sendFile(path.join(path.resolve(), "/front/contact.html"))
})
app.post('/contact', (req, res) => {

    console.log("ed", req.body)


})

app.post('/images', upload.single("file"), async function (req, res) {

    console.log(req.body)
    console.log(req.file)
    const transporter = nodemailer.createTransport({
        //serveur smtp 
        host: "smtp.ethereal.email",
        port: 587,
        secure: false, // true for 465, false for other ports
        auth: {
            user: "leone.hyatt@ethereal.email",
            pass: "6Avr1JneZKCYR5Fa1A",
        },
    });
if(req.file){
        const info =  transporter.sendMail({
        
        from: '"Maddison Foo Koch" <maddison53@ethereal.email>',
        to: req.body.email,
        subject: "Hello ✔",
        text: req.body.message, // plain‑text body
        html: "<b>Hello world?</b>", // HTML body

        //  attachments:[{filename: req.file.originalname,content: fs.createReadStream("cerise.jpg"),}] //mettre en PJ une image du server
        // attachments:[{filename : req.file.originalname,path:req.body.file}] //stockage local
    
             attachments: [{filename: file_name , content: req.file.buffer, contentType: req.file.mimetype }]
        
  
    })
      console.log("Message sent:", info.messageId)
       res.send("hello")
}else{
            const info =  transporter.sendMail({
        
        from: '"Maddison Foo Koch" <maddison53@ethereal.email>',
        to: req.body.email,
        subject: "Hello ✔ !!!piece jointe manquante!!!",
        text: req.body.message, // plain‑text body
        html: "<b>Hello world?</b>", // HTML body
            })
    
}

  res.send("oups")


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