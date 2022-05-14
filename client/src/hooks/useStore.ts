import { Storage } from "@capacitor/storage";
import { useEffect, useState } from "react";
import create from "zustand";
import { persist, StateStorage } from "zustand/middleware";
import { User } from "../utils/types";

const storage: StateStorage = {
  getItem: async (key: string): Promise<string | null> => {
    return (await Storage.get({ key })).value || null;
  },
  setItem: async (key: string, value: string): Promise<void> => {
    await Storage.set({ key, value });
  },
  removeItem: async (key: string): Promise<void> => {
    await Storage.remove({ key });
  },
};

export const useHydration = () => {
  const [hydrated, setHydrated] = useState(useStore.persist.hasHydrated);

  useEffect(() => {
    const unsubHydrate = useStore.persist.onHydrate(() => setHydrated(false)); // Note: this is just in case you want to take into account manual rehydrations. You can remove this if you don't need it/don't want it.
    const unsubFinishHydration = useStore.persist.onFinishHydration(() =>
      setHydrated(true)
    );

    setHydrated(useStore.persist.hasHydrated());

    return () => {
      unsubHydrate();
      unsubFinishHydration();
    };
  }, []);

  return hydrated;
};

export const useStore = create(
  persist(
    (set, get) => ({
      user: null as User,
      setUser: (user: User) => set(() => ({ user })),
    }),
    {
      name: "cheqq-storage",
      getStorage: () => storage,
    }
  )
);
