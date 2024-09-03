/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './_includes/**/*.{html,md}',
    './_layouts/**/*.{html,md}',
    './_pages/**/*.{html,md}',
    './_posts/**/*.{html,md}',
    './index.html',
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
