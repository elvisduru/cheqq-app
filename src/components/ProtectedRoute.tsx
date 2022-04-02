import React from "react";
import { Redirect } from "react-router-dom";

type Props = {
  isAllowed: boolean;
  redirectPath: string;
  children: JSX.Element;
};

export default function ProtectedRoute({
  isAllowed,
  redirectPath,
  children,
}: Props) {
  if (!isAllowed) {
    return <Redirect to={redirectPath} />;
  }

  return children;
}
