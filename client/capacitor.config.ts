import { CapacitorConfig } from "@capacitor/cli";

const config: CapacitorConfig = {
  appId: "co.cheqq.cheqq",
  appName: "cheqq-app",
  webDir: "build",
  bundledWebRuntime: false,
  plugins: {
    SplashScreen: {
      androidScaleType: "CENTER_CROP",
    },
  },
};

export default config;
