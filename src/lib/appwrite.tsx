import { Appwrite } from "appwrite";

const appwrite = new Appwrite();

appwrite
  .setEndpoint("https://appwrite.elvisduru.com/v1")
  .setProject("62485dcf50c2ac8e67ac");

export default appwrite;
