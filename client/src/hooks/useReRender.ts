import React from "react";

export default function useReRender() {
  const [, updateState] = React.useState<{}>();
  const forceUpdate = React.useCallback(() => updateState({}), []);
  return forceUpdate;
}
