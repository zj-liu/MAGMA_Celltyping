# Test to see which cell types are more enriched in magmaPath2 than magmaPath1
compare.trait.enrichments <- function(magmaPath1,magmaPath2,annotLevel,ctd){
    magma1 = load.magma.results.file(magmaPath1,annotLevel=annotLevel,ctd=ctd)
    magma2 = load.magma.results.file(magmaPath2,annotLevel=annotLevel,ctd=ctd)  
    z = (magma1$BETA-magma2$BETA)/sqrt(magma1$SE^2+magma2$SE^2)
    pvalue2sided=2*pnorm(-abs(z))
    magma2$z=z
    magma2$comparisonP2sided = pvalue2sided
    magma2$BETA_magma1=magma1$BETA
    magma2$BETA_magma2=magma2$BETA
    magma2$P_magma1=magma1$P
    magma2$P_magma2=magma2$P
    magma2$SE_magma1=magma1$SE
    magma2$SE_magma2=magma2$SE
    magma3 = magma2[,c("COVAR","BETA_magma1","BETA_magma2","P_magma1","P_magma2","SE_magma1","SE_magma2","z","comparisonP2sided")]
    magma3$moreSignifIn2 = magma3$BETA_magma2 > magma3$BETA_magma1
    magma3$lessSignifIn2 = magma3$BETA_magma2 < magma3$BETA_magma1
    #magma2$moreSignif = moreSignif
    #magma2=magma2[order(magma2$comparisonP),]
    #magma2[magma2$P<0.05 & magma2$moreSignif==TRUE,]
    #print(magma3[magma3$comparisonP2sided<0.05,])
    return(magma3)
}