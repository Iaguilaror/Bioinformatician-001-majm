## Winter Genomics Evaluation report
## Observations will appear as comment blocks

## Observation 1
# This plot is hardcoded, wich is never desired
# Plotter scripts must take data from an input file and operate over it
# read.table over the Resume_Coverage.txt file would have avoided the hardcoding of values
# In case of evaluating 20,000 genome regions, there is no chance to manually hardcode the values

x <- c(3.70732, 4.27473, 2.47423, 53.1429, 72.6667)
y <- c(82, 91, 64.6667, 100, 97.5)

plot(y,x, xlab="Mean Depth of Coverage (X)", ylab="Breadth of Coverage(%)", main="Sequencing Coverage", ylim=c(0,110), xlim=c(0,100), pch=15, col="blue")

