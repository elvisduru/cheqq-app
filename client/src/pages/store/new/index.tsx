import { IonLoading, IonRouterOutlet } from "@ionic/react";
import React, { Suspense, useState } from "react";
import { FormProvider, useForm } from "react-hook-form";
import { Redirect, Route } from "react-router-dom";
import { User } from "../../../utils/types";
const Categories = React.lazy(() => import("./categories"));
const Details = React.lazy(() => import("./details"));

export type StoreFormValues = {
  name: string;
  tag: string;
  logo: File;
  logoUrl?: string;
  banner: File;
  bannerUrl?: string;
  description: string;
  address: string;
  addressCoordinates?: { lat: number; lng: number };
  categories: number[];
  currency: string;
  country: string;
  phone: string;
};

export default function NewStore({ user }: { user: User }) {
  const [progress, setProgress] = useState(1);
  const methods = useForm<StoreFormValues>({
    mode: "onChange",
  });

  if (!user) {
    return <Redirect to="/signup" />;
  }

  return (
    <Suspense fallback={<IonLoading isOpen={true} translucent />}>
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
    </Suspense>
  );
}
