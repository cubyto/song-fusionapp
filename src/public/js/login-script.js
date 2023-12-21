const signInBtn = document.querySelector('#sign-in-btn')
const signUpBtn = document.querySelector('#sign-up-btn')
const container = document.querySelector('.container')

signUpBtn.addEventListener('click', () => {
  container.classList.add('sign-up-mode')
})

signInBtn.addEventListener('click', () => {
  container.classList.remove('sign-up-mode')
})

const btnSignUp = document.getElementById('btn-signup')
btnSignUp.addEventListener('submit', async (e) => {
  e.preventDefault()
  const url = e.target.ownerDocument.referrer // Domain
  const userValue = e.target.children.dusername.children.username.value /// Value of name user
  const emailValue = e.target.children.demail.children.email.value // Value of email user
  const phoneValue = parseInt(e.target.children.dtelefono.children.telefono.value) // Value of phone user
  const passValue = e.target.children.dpass.children.pass.value // Value of password

  await fetch(`${url}user/`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      urlhost: url,
      user: userValue,
      email: emailValue,
      phone: phoneValue,
      pass: passValue
    })
  })
})