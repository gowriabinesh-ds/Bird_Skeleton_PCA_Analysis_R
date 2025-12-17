# 🦜 Bird Skeleton Analysis: Dimensionality Reduction using PCA

## 📌 Project Overview
This project applies **Principal Component Analysis (PCA)** to a dataset of bird skeletal measurements to explore the relationship between bone structure and ecological groups. <br> By reducing 10 morphometric variables into primary components, this analysis identifies how skeletal features differ across groups like Raptors, Swimming Birds and Singing Birds.

## 📊 Dataset Description
The dataset consists of 413 observations of bird skeletons from the Natural History Museum of Los Angeles County. Each bird is measured across 10 features:
- **Humerus:** Length and Diameter
- **Ulna:** Length and Diameter
- **Femur:** Length and Diameter
- **Tibiotarsus:** Length and Diameter
- **Tarsometatarsus:** Length and Diameter

### 🏷️ Ecological Group Labels
To better understand the results, the following codes are used for bird types:
- **SW:** Swimming Birds (e.g., Ducks, Penguins)
- **W:** Wading Birds (e.g., Herons, Storks)
- **T:** Terrestrial Birds (e.g., Chickens, Ostriches)
- **R:** Raptors (e.g., Hawks, Owls)
- **P:** Scansorial Birds (e.g., Woodpeckers)
- **SO:** Singing Birds (e.g., Sparrows, Robins)

---

## 🚀 Key Analysis Steps
1. **Data Preprocessing:** Handling missing values and feature scaling.
2. **Correlation Analysis:** Identified high multicollinearity between bone lengths, justifying the need for PCA.
3. **Dimensionality Reduction:** Applied PCA to capture maximum variance with fewer variables.
4. **Interpretation:** Analyzed the "Loadings" to understand what each Principal Component represents (e.g., Overall Size vs. Shape).
5. **Cluster Visualization:** Comparing ecological groups based on their principal component scores.

## 📊 Key Insights & Visualizations

### 1. The "Information Test" (Scree Plot)
When we simplify 10 variables into just a few, we need to make sure we aren't losing important information. We use a **Scree Plot** to check this. Think of it as a "Value for Money" chart—it shows how much "truth" we keep as we simplify the data.

![Scree Plot](pca_scree_plot.jpg) 

* **The Result:** The sharp drop after the first point (the "elbow") is fantastic news. It shows that **Principal Component 1 (PC1)** captures over **90% of the information** from the original dataset.
* This means the model is incredibly efficient. 

### 2. The Skeletal "Heavyweights" (Overall Body Size)
To make the data easy to understand, I used PCA to combine 10 different bone measurements into one single score called **"Overall Bone Size."** This allows us to rank bird groups by their physical scale.

![Average Overall Bone Size](bone_size_comparison.jpg)

* **Who are the Giants?** **Raptors (R)** and **Swimming Birds (SW)** have the highest scores. This reflects their need for powerful, robust skeletons for hunting and diving in high-pressure environments.
* **Who are the Lightweights?** **Singing Birds (SO)** have the lowest scores. Their tiny, lightweight skeletons are an evolutionary masterpiece designed for agile flight and life in the trees.
* This chart proves that we can identify a bird's lifestyle just by looking at the scale of its bones.

---

## 🛠️ Tools & Technologies
- **Language:** R
- **Libraries:** `ggplot2`, `dplyr`, `GGally`, `stats`
- **Technique:** Principal Component Analysis (PCA)

---

## 🏁 Conclusion
The PCA successfully reduced the 10 bone measurements into a primary component that explains over 90% of the variance, representing "Overall Body Size." <br> This demonstrates a strong link between a bird's ecological role and its skeletal evolution.

---
