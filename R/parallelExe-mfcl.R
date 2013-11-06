
scanText<-function(string, what = character(0), ...){
  ## Like scan() but reading from a vector of character strings
  tc <- textConnection(string)
  result <- scan(tc, what = what, quiet = TRUE, ...)
  close(tc)
  return(result)}

## reads in the doitall file and extracts teh data between "# grid" and "# endg " 
readDoitall=function(file){
  dat=scan(file,what="",sep="\n",skip=1)
  dat=maply(dat,str_trim)
  
  x=data.frame(from=(1:length(dat))[substr(dat,1,6)=="# grid"]+1,
               to  =(1:length(dat))[substr(dat,1,6)=="# endg"]-1)
  grid=mlply(x,seq)
  grid=llply(grid,function(x,dat) dat[x], dat=dat)
  
  res=llply(grid,function(grd){
    val=as.numeric(unlist(laply(grd,function(x) strsplit(x," +"))))
    t(array(val,dim=c(length(val)/length(grd),length(grd))))})
  
  names(res)=substr(dat[x[,1]-1],7,nchar(dat[x[,1]-1]))
  res}

writeDoitall=function(file,obj){
  dat=scan(file,what="",sep="\n",skip=1)
  
  x=data.frame(from=(1:length(dat))[substr(dat,1,6)=="# grid"]+1,
               to  =(1:length(dat))[substr(dat,1,6)=="# endg"]-1)
  
  pos=mlply(x,seq)
  
  for (i in 1:length(obj))
    dat[pos[[i]]]=apply(doit[[i]],1,paste, collapse=" ")
  
  write.table(dat,file=file)}
