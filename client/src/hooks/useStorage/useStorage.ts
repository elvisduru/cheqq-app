// Inspired by useLocalStorage from https://usehooks.com/useLocalStorage/
import { useState, useEffect, useCallback } from "react";
import { Storage } from "@capacitor/storage";
import { AvailableResult, notAvailable } from "./util/models";
import {
  isFeatureAvailable,
  featureNotAvailableError,
} from "./util/feature-check";
import { Capacitor } from "@capacitor/core";

interface StorageResult extends AvailableResult {
  get: (key: string) => Promise<string | null>;
  set: (key: string, value: string) => Promise<void>;
  remove: (key: string) => void;
  getKeys: () => Promise<{ keys: string[] }>;
  clear: () => Promise<void>;
}

type StorageItemResult<T> = [
  T | undefined,
  (value: T) => Promise<void>,
  boolean
];

if (!Capacitor.isPluginAvailable("Storage")) {
  console.warn(
    "The @capacitor/storage plugin was not found, did you forget to install it?"
  );
}

export const availableFeatures = {
  useStorage: isFeatureAvailable("Storage", "useStorage"),
};

export function useStorage(): StorageResult {
  const get = useCallback(async (key: string) => {
    const v = await Storage.get({ key });
    if (v) {
      return v.value;
    }
    return null;
  }, []);

  const set = useCallback((key: string, value: string) => {
    return Storage.set({ key, value: value });
  }, []);

  const remove = useCallback((key: string) => {
    return Storage.remove({ key });
  }, []);

  const getKeys = useCallback(() => {
    return Storage.keys();
  }, []);

  const clear = useCallback(() => {
    return Storage.clear();
  }, []);

  if (!availableFeatures.useStorage) {
    return {
      get: featureNotAvailableError,
      set: featureNotAvailableError,
      remove: featureNotAvailableError,
      getKeys: featureNotAvailableError,
      clear: featureNotAvailableError,
      ...notAvailable,
    };
  }

  return { get, set, remove, getKeys, clear, isAvailable: true };
}

export function useStorageItem<T>(
  key: string,
  initialValue?: T
): StorageItemResult<T> {
  const [storedValue, setStoredValue] = useState<T>();

  const setValue = useCallback(
    async (value: T) => {
      try {
        setStoredValue(value);
        await Storage.set({
          key,
          value: typeof value === "string" ? value : JSON.stringify(value),
        });
      } catch (e) {
        console.error(e);
      }
    },
    [key]
  );

  useEffect(() => {
    async function loadValue() {
      try {
        const result = await Storage.get({ key });
        if (result.value === undefined && initialValue !== undefined) {
          result.value =
            typeof initialValue === "string"
              ? initialValue
              : JSON.stringify(initialValue);
          setValue(result.value as any);
        } else {
          if (result.value) {
            setStoredValue(
              JSON.parse(result.value) ? JSON.parse(result.value) : result.value
            );
          } else {
            setStoredValue(undefined);
          }
        }
      } catch (e) {
        return initialValue;
      }
    }
    loadValue();
  }, [setStoredValue, initialValue, setValue, key]);

  if (!availableFeatures.useStorage) {
    return [undefined, featureNotAvailableError, false];
  }

  return [storedValue, setValue, true];
}
