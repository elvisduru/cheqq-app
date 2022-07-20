import axios from "axios";
import { useQuery } from "react-query";
import { CountryStates } from "../../utils/types";

const getCountries = async () => {
  const { data } = await axios.get<CountryStates[]>(
    "https://raw.githubusercontent.com/elvisduru/countries-states-cities-database/master/countries%2Bstates.json"
  );
  return data;
};

export default function useCountries() {
  return useQuery("countries", getCountries, {
    staleTime: Infinity,
    cacheTime: Infinity,
  });
}
