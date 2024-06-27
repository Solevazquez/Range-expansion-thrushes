
# 2003
library(VennDiagram)
venn1993 <- draw.quad.venn(area1=4201665, area2=1247330, area3=1180211, area4=5170209, n12=181422, n13=0, 
                           n14=3571472, n23=121507, n24=139076, n34=0, n123=0, n124=109465, n134=0, n234=0, n1234=0, 
                           cat.cex = 1.5, category = c("T. amaurochalinus","T. chiguanco", "T. falcklandii", "T. rufiventris"), 
                           euler.d = TRUE, print.mode = "raw", sigdigs = 1,lty = "blank", 
                           fill = c("skyblue", "pink1", "mediumorchid", "orange"))



# 2023
library(VennDiagram)
venn2023 <- draw.quad.venn(area1=10408018, area2=3257687, area3=1932435, area4=7302661, n12=2395162, n13=1279489, 
                           n14=7272865, n23=1260661, n24=1572036, n34=1028775, n123=1131534, n124=1546594, 
                           n134=1003307, n234=948217, n1234=922776, cat.cex = 1.5,
                           category = c("T. amaurochalinus","T. chiguanco", "T. falcklandii", "T. rufiventris"), 
                           euler.d = TRUE, print.mode = "raw", sigdigs = 1,lty = "blank", 
                           fill = c("skyblue", "pink1", "mediumorchid", "orange"))

