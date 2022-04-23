import { Models } from "appwrite";
import { useMutation, useQueryClient } from "react-query";
import appwrite from "../../../lib/appwrite";

type UserUpdate = {
  name?: string;
  email?: string;
  password?: string;
  oldPassword?: string;
  prefs?: Record<string, any>;
};

const updateUser = (data: UserUpdate) => {
  const promises = [];
  if (data.name) {
    promises.push(appwrite.account.updateName(data.name));
  }

  if (data.email && data.password) {
    promises.push(appwrite.account.updateEmail(data.email, data.password));
  }

  if (data.prefs) {
    promises.push(appwrite.account.updatePrefs(data.prefs));
  }

  if (data.password && data.oldPassword) {
    promises.push(
      appwrite.account.updatePassword(data.password, data.oldPassword)
    );
  }

  return Promise.all(promises);
};

export function useUpdateUser() {
  const queryClient = useQueryClient();

  return useMutation(updateUser, {
    onSuccess() {
      queryClient.invalidateQueries("user");
    },
  });
}
