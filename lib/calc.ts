export function subtract(a: number, b: number): number {
  return a - b;
}

export function div(a: number, b:number):number{
  if(b !== 0){
    return a / b;
  }
  return 0;
}