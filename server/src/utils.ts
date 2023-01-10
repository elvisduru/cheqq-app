import axios from 'axios';

/**
 * Exclude fields from any model
 */
export function exclude<T, Key extends keyof T>(
  resultSet: T,
  ...keys: Key[]
): Omit<T, Key> {
  for (let key of keys) {
    delete resultSet[key];
  }
  return resultSet;
}

export async function getExchangeRate(
  source: string,
  destination?: string,
): Promise<number> {
  try {
    if (!destination) return 1;
    if (destination === source) return 1;
    const res = await axios.get(
      `https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/${source.toLowerCase()}/${destination.toLowerCase()}.json`,
    );
    return res[destination.toLowerCase() as keyof typeof res];
  } catch (error) {
    return 1;
  }
}
