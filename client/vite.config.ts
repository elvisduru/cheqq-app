import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    port: 8100,
    host: true,
  },
  css: {
    devSourcemap: true,
  },
  build: {
    sourcemap: true,
  },
});
