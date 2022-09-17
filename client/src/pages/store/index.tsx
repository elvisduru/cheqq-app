import {
  IonPage,
  IonRouterOutlet,
  useIonViewWillEnter,
  useIonViewWillLeave,
} from "@ionic/react";
import React, { useState } from "react";
import { FormProvider, useForm } from "react-hook-form";
import { Redirect, Route } from "react-router-dom";
import withSuspense from "../../components/hoc/withSuspense";
import useUser from "../../hooks/queries/users/useUser";
import { useStore } from "../../hooks/useStore";
import { User } from "../../utils/types";

const Categories = withSuspense<{
  progress: number;
  setProgress: (progress: number) => void;
}>(React.lazy(() => import("./categories")));
const Details = withSuspense<{ user: User; progress: number }>(
  React.lazy(() => import("./details"))
);

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

const StoreRouterOutlet = () => {
  const { data: user, isLoading } = useUser();
  const [progress, setProgress] = useState(1);
  const methods = useForm<StoreFormValues>({
    mode: "onChange",
  });

  const toggleHideTabBar = useStore((store) => store.toggleHideTabBar);

  useIonViewWillEnter(() => {
    toggleHideTabBar(true);
  });

  useIonViewWillLeave(() => {
    toggleHideTabBar(false);
  });

  return (
    <FormProvider {...methods}>
      <IonPage>
        <IonRouterOutlet>
          <Route path="/store/new/details" exact={true}>
            <Details user={user!} progress={progress} />
          </Route>
          <Route path="/store/new" exact={true}>
            <Categories progress={progress} setProgress={setProgress} />
          </Route>
          <Route path="/store" exact>
            <Redirect to="/store/new" />
          </Route>
        </IonRouterOutlet>
      </IonPage>
    </FormProvider>
  );
};

export default StoreRouterOutlet;
