declare module '*.scss' {
  interface IClassNames {
    [css: string]: string
  }
  const classNames: IClassNames;
  export = classNames;
}
