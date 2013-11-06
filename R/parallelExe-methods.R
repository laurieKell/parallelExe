setMethod('set', signature(x="character"), function(x,package="parallelExe",dir=tempdir(),...){
  setFn(x,package,dir,...)})
          
setMethod('exe', signature(x="character"), function(x,package="parallelExe",dir=tempdir(),...){
  exeFn(x,package,dir,...)})

