#### Run Exe ################################################################################
## 1) Sets path to exe
## 2) Copies MFCL exe and files and runs them
#############################################################################################

## 1) sets path to exe 
setFn=function(x,package="parallelExe",...){
  ##### set up temp dir with exe for data files
  # Linux
  if (R.version$os=="linux-gnu") {
    path=system.file("bin", "linux", package=package, mustWork=TRUE)
    #exe =paste(path,x, sep="/")
    
    # Windows
  } else if (.Platform$OS.type == "windows") {
    path = paste(system.file("bin", "windows", package=package, mustWork=TRUE), paste(x, ".exe", sep=""), sep="/")
    
    # Mac OSX
  }else 
    stop()
  
  Sys.setenv(PATH=path)
  }

## 2) Runs MFCL doitall with file(s)
doitallFn=function(x,file,package="parallelExe",dir=tempdir(),options="",get=NULL){
   
    path=system.file("bin", "linux", package=package, mustWork=TRUE)
    
    ## not sure why this doesnt work?
    Sys.setenv(PATH=paste(Sys.getenv("PATH"),path,sep=":"))
    
    exe =paste(path,x, sep="/")
    
    ## move to dir with files in
    oldwd=getwd()
    setwd(dir)
    
    ## remove any old files
    try(system("rm *", intern = TRUE, ignore.stderr = TRUE))
    
    ## copy exe
    file.copy(paste(path,x, sep="/"), paste(dir,x, sep="/"))
    
    ## copy files
    file.copy(file, dir)
    
    # run doitall
    exe=paste("./",basename(file[1]), " ",options, sep="")
    system(exe)
      
    ## reset  
    setwd(oldwd)
    
    if (!is.null(get)) return(get) else return(dir)}


exeFn2=function(x, dir=tempdir(), package="parallelExe",
                   .combine=NULL,
                   .multicombine=T,.maxcombine=10){
            
  if (is.null(.combine)) ..combine=list else ..combine=.combine          
    res=foreach(i=names(object), .combine=..combine,
                                 .multicombine=.multicombine,
                                 .maxcombine  =.maxcombine,
                                 .packages    =.packages) %dopar% {  
                          wkdir=tempfile('file', dir)
                          dir.create(wkdir, showWarnings = FALSE)
                          exe(x,dir=wkdir)}
            
  if (is.null(.combine)) {
    res=list(res)
    names(res)=names(object)}
            
  res}

  
