import sqlite3 from 'sqlite3'
import path from 'path'
export const db = new sqlite3.Database(path.join(path.resolve(), '/db/revisions.db'));

// db.serialize(() => {
//     try {
//         const stmt = db.prepare("INSERT INTO lorem VALUES (?)"); // préparation, ne pas mettre de valeur mais des "?""
//         // run la commande avec l'argument qui va être mis à la place des "?""
//         stmt.run("salut", function(err) {
//             if (err) {
//                 console.log(err)
//                 return
//             }

//             // Si on veux récupérer le nombre de lignes affectées
//             const rowsAffected = this.changes;
//             // Si on veux récupérer le dernier id affecté
//             const lastId = this.lastID;

//             stmt.finalize(); // libérer la mémoire.
//             db.close();
//         });
//     }
//     catch (error) {
//         console.log(error)
//     }
// });

