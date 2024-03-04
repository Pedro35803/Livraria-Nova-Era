export const clearStringForNumber = (string) => {
  return string.replace(/\./g, "").replace(/-/g, "").replace(/\//g, "");
};