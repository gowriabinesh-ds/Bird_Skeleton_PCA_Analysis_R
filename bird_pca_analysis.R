# 1.	Import ‘Bird’ data in R.

# Importing Libraries
library(ggplot2)
library(GGally)
library(dplyr)

# Importing Data
bird_data <- read.csv(file.choose(), header = T)
head(bird_data)
sum(is.na(bird_data))

# Correlation Assessment

# Dropping the 'id' and 'type' columns as they are not needed for PCA
pca_bird_data<-subset(bird_data,select= -c(id,type))
head(pca_bird_data)

cor(pca_bird_data)

## Many pairs have correlations above 0.8 or 0.9 (Eg:- huml–ulnal, humw–ulnaw, feml–femw, tibl–tibw), indicating that these bone measurements tend to vary together.
## The highest correlation is around 0.98 (huml vs. ulnal), showing that birds with longer humerus lengths generally have longer ulna lengths as well.
## The lowest correlation in the table is 0.60 (tarl vs. tarw), but that is still a moderate to strong relationship in most biological contexts.

# Creating a pair plot
ggpairs(pca_bird_data)

ggpairs(
  data = pca_bird_data,
  columns = 1:10,  # Adjust if needed; these are the 10 bone measurements
  lower = list(continuous = wrap("points", color = "#734F96", alpha = 0.6)),
  diag  = list(continuous = wrap("densityDiag", fill = "#734F96", alpha = 0.4)),
  upper = list(continuous = "cor")
) + 
  theme_minimal() +
  labs(title = "Pair Plot of Bird Bone Measurements")

## All variables are strongly positively correlated, indicating a shared underlying dimension (likely overall size).
## The scatter plots show consistent upward-sloping trends. Birds larger in one bone measurement tend to be larger in others.
## Each diagonal histogram has a single main peak, which tells that for each bone measurement, most birds cluster around one typical value but still show some variation.


# 2.	Summarizing bird type using Principal Component Analysis. 
# How many principal components are required to explain maximum variation in the data? 

# Standardize the data by scaling it
pca_bird_data<-data.frame(scale(pca_bird_data))

# Run PCA on data
pc<-princomp(formula=~.,data=pca_bird_data,cor=T)

# Check summary of PCA output
summary(pc)

## Observation:
  
## The first principal component (PC1) captures most of the data's variation, explaining about 85.43% of the total variance.
## Combining PC1 with PC2, cover roughly 92% of the overall variability, and including up to the first five components brings that number to about 98.38%. 
## This means that just a few principal components are enough to represent almost all the information in the dataset.

# Scree Plot to determine the appropriate number of components

plot(pc, type = "lines", col = "#008080", lwd = 3, main = "Scree Plot for Bird Data PCA")

points(1:length(pc$sdev^2), pc$sdev^2, pch = 19, col = "darkorange")

## Observation :
## The scree plot shows a steep drop after the first component, indicating that PC1 alone captures the bulk of the variance in the data.
## The remaining components contribute only marginally, so one principal component might sufficient in explaining the maximum variation.


# Component Loadings
pc$loadings

## The first principal component (PC1) shows nearly equal positive loadings for all bone measurements, suggesting it represents overall bone size.
## Thus, birds with higher PC1 scores tend to have larger dimensions across all bones, confirming PC1 as a size indicator.


# 3. Store the principal component scores as a new variable.

bird_data$Overall_Bone_Size<-pc$score[,1]
head(bird_data)

## This new variable acts like a “size index".
## Positive values suggest that the bird has larger than average bone measurements.
## Negative values indicate smaller than average measurements.
## Hence, each bird now has a single numeric score that summarizes its overall bone size.

# 4. Finding average values of the new variable for each bird type and interpret the results.

# Group the data by type and calculate the average Overall_Bone_Size for each type
summary_pc_type<-bird_data %>%
  group_by(type) %>%
  summarize(Overall_Bone_Size = round(mean(Overall_Bone_Size),3))%>%
  as.data.frame()

# Create a lollipop chart with custom colors and a descriptive legend

ggplot(summary_pc_type, aes(x = reorder(type, Overall_Bone_Size), 
                            y = Overall_Bone_Size, color = type)) +
  geom_segment(aes(xend = reorder(type, Overall_Bone_Size),
                   y = 0, yend = Overall_Bone_Size),
               size = 1.2) +
  geom_point(size = 5) +
  coord_flip() +
  scale_color_brewer(
    name = "Bird Type",
    palette = "Set1", 
    labels = c(
      "SW" = "Swimming Birds",
      "W"  = "Wading Birds",
      "T"  = "Terrestrial Birds",
      "R"  = "Raptors",
      "P"  = "Scansorial Birds",
      "SO" = "Singing Birds"
    )
  ) +
  labs(
    title = "Average Overall Bone Size by Bird Type",
    x = "Bird Type",
    y = "Average Overall Bone Size"
  ) +
  theme_minimal()

## Raptors (R) show the largest average bone size, with highly positive PC1 scores which fits their powerful flight and predatory lifestyle.
## Swimming Birds (SW) also show relatively large sizes, likely reflecting their need for strong limbs in aquatic environments.
## On the other hand, , Singing Birds (SO) and Scansorial Birds (P) cluster on the negative side, indicating they have smaller skeletal structures overall.
## This clear spread across bird types suggests a strong link between each group’s average bone size and its ecological role.

