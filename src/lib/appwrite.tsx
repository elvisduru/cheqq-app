import { Appwrite } from "appwrite";

const appwrite = new Appwrite();

appwrite
  .setEndpoint(process.env.REACT_APP_APPWRITE_ENDPOINT!)
  .setProject(process.env.REACT_APP_APPWRITE_PROJECT_ID!);

export default appwrite;
