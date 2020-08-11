## USER DEFINED VARIABLES ########################

xlabel = "Hazard Ratio" ## Label under the x-axis. Write anything you'd like in quotes. 

is.log = TRUE ## The values in the X-axis will be in logarithmic scale if TRUE, in natural scale if FALSE. Do not assign any other values.

############################################

inputFiles = list.files("Input")

for(files in inputFiles){
	output = paste0(substring(files, 1, nchar(files)-4), " Forest Plot.pdf")
	
	d = read.delim(file=paste0("Input/",files),sep="\t",header=TRUE)
	
	hrs = as.numeric(as.matrix(d[,2]))
	cil = as.numeric(as.matrix(d[,3]))
	cih = as.numeric(as.matrix(d[,4]))
	
	if(ncol(d)>4){
		ses = as.numeric(as.matrix(d[,5]))
		if(length(ses)==1){
			ses2 = 1
		}else{
			ses2 = -((ses-min(ses))/(max(ses)-min(ses)))
			ses2 = ses2 + 2
		}
	}else{
		ses = rep(1,nrow(d))
		ses2 = ses
	}
	
	m1 = min(cil,cih)
	m2 = max(cil,cih)
	m = exp(max(abs(log(m1)),abs(log(m2))))
	
	xat = seq(-log(m),log(m),length.out=7)
	xlab = c()
	
	if(is.log){
		xlab=xat
	}else{
		xlab=exp(xat)
	}
	xlim = c(-log(m), log(m))
	
	pdf(paste0("Output/",output),height=2+nrow(d)/2)
	par(mar=c(5,10,4,2))
	plot(NA,xlim=xlim,ylim=c(1,nrow(d)),yaxt="n",xaxt="n",ylab="",xlab=xlabel)
	
	axis(1,at=xat,labels=round(xlab,2),cex.axis=0.8)
	axis(2,at=nrow(d):1,labels=d[,1], las=1)
	
	abline(v=0,lty=2)
	
	for(i in 1:nrow(d)){
		color = "black"
		if((cil[i]<1 && cih[i]<1) || (cil[i]>1 && cih[i]>1)){
			color = "turquoise1"
		}
		
		points(log(hrs[i]),nrow(d)-i+1,pch=22,col="black",cex=ses2[i], bg="black")
		
		lines(c(log(cil[i]),log(cih[i])),c(nrow(d)-i+1,nrow(d)-i+1),lwd=1.5,col=color)
		
	}
	dev.off()
}

