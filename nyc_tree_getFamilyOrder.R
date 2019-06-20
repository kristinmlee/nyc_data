

library(taxonlookup)
library(dplyr)

#load data
tree_genera = read.csv('https://github.com/kristinmlee/nyc_data/raw/master/nyc_tree_genera.csv', header = FALSE, stringsAsFactors = FALSE)
all_trees = read.csv('https://github.com/kristinmlee/nyc_data/raw/master/nyc_trees_2015.csv', stringsAsFactors = FALSE)

#add column for genus
all_trees_genera = sapply(all_trees$spc_latin, function(i) strsplit(i, split = " ")[[1]][1])
all_trees = cbind(all_trees, all_trees_genera)
colnames(all_trees)[5] = "genus"

#use lookup table to find family/order for each genus
tree_data = lookup_table(tree_genera[ ,2], by_species=TRUE)

#inner join family/order and tree data by genus
all_tree_wFamilies = inner_join(tree_data, all_trees)

#write file
write.csv(all_tree_wFamilies[ ,c("genus", "family", "order")], file = "nyc_trees_2015_family.csv", quote = FALSE, row.names = FALSE)





