export const sum = (a: number, b: number): number => {
  return a + b
}
export const div = (a: number, b: number): number => {
  if(b !== 0){
    return a / b;
  }
  return 0;
}