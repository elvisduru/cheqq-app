/** @type {import('tailwindcss').Config} */
const defaultTheme = require("tailwindcss/defaultTheme");
module.exports = {
  content: ["./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      colors: {
        primary: "#f51e63",
      },
      fontFamily: {
        sans: ["Twemoji Country Flags", ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [],
};
