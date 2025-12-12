/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Hiragino Sans', 
               'Hiragino Kaku Gothic ProN', 'Yu Gothic', 'YuGothic', 'Meiryo', 'sans-serif'],
      },
    },
  },
  plugins: [],
}