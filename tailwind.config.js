const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: '#1E5631',
          light: '#2E7D4A',
        },
        secondary: '#A0522D',
        accent: '#F6BE00',
        neutral: {
          light: '#F5F5F5',
          dark: '#333333',
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/aspect-ratio'),
  ]
}