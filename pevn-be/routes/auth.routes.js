import express from "express";
import authentication from '../controllers/auth'

const router = express.Router()

router.post('/signup', authentication.signup)

router.post('/signin', authentication.signIn)


module.exports = router;