import { Redirect } from "react-router-dom";
import { User } from "../utils/types";

type Props = {
  user: User;
  redirectPath: string;
  children: JSX.Element;
  disableExtraRedirect?: boolean;
};

export default function ProtectedRoute({
  user,
  redirectPath,
  children,
  disableExtraRedirect = false,
}: Props) {
  if (!user) {
    return <Redirect to={redirectPath} />;
    // window.location.href = "/signup";
  }

  if (!user?.name) {
    return <Redirect to="/new" />;
  }

  if (!disableExtraRedirect && !user.prefs?.stores?.length) {
    return <Redirect to="/store/new" />;
  }

  return children;
}
