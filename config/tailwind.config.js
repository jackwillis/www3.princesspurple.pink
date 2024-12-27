module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans:     ['Fira Sans', 'sans-serif'],
        serif:    ['Bitter', 'serif'],
        body:     ['Fira Sans', 'sans-serif'],
        cursive:  ['Gluten', 'cursive'],
        display:  ['Barbie', 'cursive'],
      },
      colors: {
        'princess-purple':  '#800080',
        'princess-pink':    'rgb(208, 51, 140)',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require('tailwind-scrollbar'),
  ],
  experimental: {
    optimizeUniversalDefaults: true,
  },
};
