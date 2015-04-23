library(zoo)
library(lattice)
library(Quandl)
Quandl.auth("9epnxupYt7ykNmMfuxRa")
x <- Quandl("BITCOIN/BITSTAMPUSD")
x$ror <- c(NA, exp(diff(log(x$Close)))) - 1
x$vol <- rollapply(x$ror, 30, sd, na.rm=TRUE, fill=0, partial=TRUE, align="right")
pdf("btcror.pdf")
xyplot(ror ~ Date, data=x, type="l",
         main="BTC/USD", ylab="Daily Returns")
dev.off()

pdf("btcvol.pdf")
xyplot(vol ~ Date, data=x, type="l",
         main="BTC/USD", ylab="Rolling 30-day Volatility")
dev.off()
