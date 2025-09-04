import nodemailer from 'nodemailer'

export const transporter = nodemailer.createTransport({
    host: process.env.MAILER_SMTP,
    port: 587,
    auth: {
        user: process.env.MAILER_USER,
        pass: process.env.MAILER_PASS,
    },
});