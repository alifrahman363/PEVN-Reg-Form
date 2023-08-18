import express, { json } from "express" 
import morgan from "morgan";
import cors from "cors"
import fileUpload from "express-fileupload";
import history from "connect-history-api-fallback";
import path from 'path';
import { request } from "http";

const app = express();

// const morgan = require('morgan')
// Middleware
app.use(morgan('tiny'));
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(fileUpload({useTempFiles: true}));

// console.log("Directory name is: ", __dirname) 

// Routes
app.use('/', require('./routes/auth.routes'))
app.use('/professor', require('./routes/professor.routes'))

// middleware for vue
app.use(history());
app.use(express.static(path.join(__dirname, 'public')));

// app.get('/', (req, res)=>{
//     res.send('Hello world');
// })

// Settings
app.set('port', process.env.PORT || 3000);

app.listen(app.get('port'), ()=>{
    console.log('server on port 3000', app.get('port'));
})
