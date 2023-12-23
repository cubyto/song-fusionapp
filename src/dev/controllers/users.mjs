import { validateUser } from '../schemes/user-scheme.mjs'

export class UserController {
  constructor ({ userModel, emailService }) {
    this.userModel = userModel
    this.emailService = emailService
  }

  create = async (req, res) => {
    try {
      const result = validateUser(req.body)
      console.log(req.body)
      console.log('------------')
      console.log(result.data)

      if (result.error) {
        return res.status(400).json({ error: JSON.parse(result.error.message), postMessage: req.body })
      }

      const isUserExist = await this.userModel.check({ input: result.data })
      console.log(isUserExist)
      if (isUserExist === true) {
        return res.status(400).json({ message: 'Some of the data entered is already registered' })
      }

      if (Object.keys(isUserExist).length === 4) {
        const verifyEmail = await this.emailService.send({ input: isUserExist })
        console.log(verifyEmail)

        if (verifyEmail === 0) {
          return res.status(400).json({ message: 'There is some problem, sending the email verification' })
        }
        if (Object.keys(verifyEmail).length === 1) {
          const newData = { ...result.data, ...verifyEmail }
          const newUser = await this.userModel.create({ input: newData })
          if (newUser) {
            console.log(newUser)
            res.status(201).json({ message: 'User successfully created, you only need to check your email address to verify your account' })
          } else {
            res.status(500).json({ message: 'User could not be created' })
          }
        }
      }
    } catch (err) {
      console.log('Error:', err)
      res.status(500).json({ message: 'Error internal server' })
    }
  }
}
