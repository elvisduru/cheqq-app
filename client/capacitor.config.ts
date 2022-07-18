import { CapacitorConfig } from "@capacitor/cli";

const config: CapacitorConfig = {
  appId: "co.cheqq.cheqq",
  appName: "cheqq",
  webDir: "dist",
  bundledWebRuntime: false,
  plugins: {
    SplashScreen: {
      androidScaleType: "CENTER_CROP",
    },
  },
};

export default config;
