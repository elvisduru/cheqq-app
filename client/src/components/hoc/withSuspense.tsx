import { IonLoading } from "@ionic/react";
import { Suspense } from "react";

/**
 * HOC to wrap a component in a Suspense component.
 */

export default function withSuspense<P>(Component: React.ComponentType & any) {
  return function WithSuspense(props: P) {
    return (
      <Suspense fallback={<IonLoading isOpen={true} translucent />}>
        <Component {...props} />
      </Suspense>
    );
  };
}
