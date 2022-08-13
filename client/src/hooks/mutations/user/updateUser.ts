import { useMutation, useQueryClient } from '@tanstack/react-query';
import api from "../../../lib/api";
import { User } from "../../../utils/types";

type UserUpdate = Partial<Omit<User, "stores" | "id">>;

const updateUser = (data: UserUpdate) =>
  api.patch<User>("/users/current", data);

export default function useUpdateUser() {
  const queryClient = useQueryClient();

  return useMutation(updateUser, {
    onSuccess() {
      queryClient.invalidateQueries(['user']);
    },
  });
}
