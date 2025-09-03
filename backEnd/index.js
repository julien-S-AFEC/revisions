import express from 'express'
import path from 'path'
import dotenv from 'dotenv'
import sqlite3 from 'sqlite3'
import crypto from 'crypto'
import bodyParser from 'body-parser'

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
app.use(express.urlencoded({ extended: true }))
app.use(express.static(path.join(path.resolve(), "front")));
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


app.get('/contact', (req, res)=>{
    res.sendFile(path.join(path.resolve(), "/front/contact.html"))
})
app.post('/contact/y', (req, res)=>{

    console.log(req.body)

 
})
app.listen(3000, () => {
    console.log("http://localhost:3000")
})