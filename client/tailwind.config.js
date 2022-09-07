/** @type {import('tailwindcss').Config} */
const defaultTheme = require("tailwindcss/defaultTheme");
module.exports = {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
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
  plugins: [require("@tailwindcss/line-clamp")],
};
