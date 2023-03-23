import { Application } from "@hotwired/stimulus"

const application = Application.start()

let burgerIcon = document.querySelector('.fa-bars')

const showLinks = () => {
  let navLinks = document.querySelector('#nav-links')
  if (navLinks.style.display === 'block') {
    navLinks.style.display = 'none'
  } else {
    navLinks.style.display = 'block'
  }
}

document.addEventListener('turbo:load', () => {
  burgerIcon.addEventListener('click', showLinks)
})

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application


export { application}
