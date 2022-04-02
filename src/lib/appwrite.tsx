import { Appwrite } from "appwrite";

const appwrite = new Appwrite();

appwrite
  .setEndpoint("https://appwrite.elvisduru.com/v1")
  .setProject("62423f6dee07148130fb");

export default appwrite;
