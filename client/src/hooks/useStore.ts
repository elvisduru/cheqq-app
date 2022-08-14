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

export enum ModalState {
  SAVE = "SAVE",
  DELETE = "DELETE",
}

export type AppState = {
  user?: User;
  setUser: (user: User) => void;
  selectedStore?: number;
  setSelectedStore: (storeId: number) => void;
  physicalFormData: any;
  setPhysicalFormData: (data: any) => void;
  physicalModalState?: ModalState;
  setPhysicalModalState: (modalState: ModalState | undefined) => void;
  deleteForm: boolean;
  setDeleteForm: (deleteForm: boolean) => void;
  hideTabBar: boolean;
  toggleHideTabBar: (value: boolean) => void;
};

export const useStore = create(
  persist(
    (set) => ({
      user: undefined as User | undefined,
      setUser: (user: User) => set(() => ({ user })),
      selectedStore: undefined as number | undefined,
      setSelectedStore: (selectedStore: number) =>
        set(() => ({ selectedStore })),
      physicalFormData: undefined,
      setPhysicalFormData: (physicalFormData: any) =>
        set(() => ({ physicalFormData })),
      physicalModalState: undefined,
      setPhysicalModalState: (physicalModalState: ModalState | undefined) =>
        set(() => ({ physicalModalState })),
      deleteForm: false,
      setDeleteForm: (deleteForm: boolean) => set(() => ({ deleteForm })),
      hideTabBar: false,
      toggleHideTabBar: (value: boolean) => set(() => ({ hideTabBar: value })),
    }),
    {
      name: "cheqq-storage",
      getStorage: () => storage,
      partialize: (state) =>
        Object.fromEntries(
          Object.entries(state).filter(([key]) => !["hideTabBar"].includes(key))
        ),
    }
  )
);
