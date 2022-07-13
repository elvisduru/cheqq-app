/**
 * HOC react router authentication.
 */

import { IonLoading } from "@ionic/react";
import { Redirect, useLocation } from "react-router-dom";
import useUser from "../../hooks/queries/users/useUser";

export default function withAuth(Component: React.ComponentType & any) {
  return function WithAuth(props: any) {
    const { data: user, isLoading } = useUser();
    if (isLoading) {
      return <IonLoading isOpen={true} translucent />;
    }
    if (!user) {
      return <Redirect to="/signup" />;
    }
    if (!user.name) {
      return <Redirect to="/new" />;
    }

    if (!user.stores.length) {
      return <Redirect to="/store" />;
    }
    return <Component {...props} user={user} />;
  };
}
