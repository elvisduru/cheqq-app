import { IonLoading, IonRouterOutlet } from "@ionic/react";
import React, { useState } from "react";
import { FormProvider, useForm } from "react-hook-form";
import { Route, Redirect } from "react-router-dom";
import useUser from "../../../hooks/queries/users/useUser";
import Categories from "./categories";
import Details from "./details";

export default function NewStore() {
  const { data: user, isLoading } = useUser();
  const [progress, setProgress] = useState(1);
  const methods = useForm({
    defaultValues: {
      address: undefined,
      avatar: undefined,
      banner: undefined,
    },
    mode: "onBlur",
  });

  if (isLoading) {
    return <IonLoading isOpen={true} translucent />;
  }

  if (!user) {
    return <Redirect to="/signup" />;
  }

  return (
    <FormProvider {...methods}>
      <IonRouterOutlet>
        <Route
          path="/store/new/details"
          render={(props) => (
            <Details user={user!} progress={progress} {...props} />
          )}
          exact
        />
        <Route
          path="/store/new"
          render={(props) => (
            <Categories
              progress={progress}
              setProgress={setProgress}
              {...props}
            />
          )}
          exact
        />
        <Route render={() => <Redirect to="/store/new" />} />
      </IonRouterOutlet>
    </FormProvider>
  );
}
