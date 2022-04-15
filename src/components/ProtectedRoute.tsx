import { Models } from "appwrite";
import { Redirect } from "react-router-dom";
import { User } from "../utils/types";

type Props = {
  user: User;
  redirectPath: string;
  children: JSX.Element;
};

export default function ProtectedRoute({
  user,
  redirectPath,
  children,
}: Props) {
  if (!user) {
    return <Redirect to={redirectPath} />;
  }

  if (!user.name) {
    return <Redirect to="/new" />;
  }

  return children;
}
