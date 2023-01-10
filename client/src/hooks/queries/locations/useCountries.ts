import { useQuery } from "@tanstack/react-query";
import api from "../../../lib/api";
import { CountryStates } from "../../../utils/types";

const getCountries = async () => {
  const { data } = await api.get<CountryStates[]>(
    "/locations/countries?states=true"
  );
  return data;
};

export default function useCountries() {
  return useQuery(["countries"], getCountries);
}
