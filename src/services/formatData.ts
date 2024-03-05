export const clearStringForNumber = (string) => {
  return string.replace(/\.|\-|\/|\(|\)/g, "");
};

export const verifyField = (query, listColumns) => {
  listColumns.forEach((column) => {
    if (!query[column]) throw { message: `Field ${column} is required` };
  });
};