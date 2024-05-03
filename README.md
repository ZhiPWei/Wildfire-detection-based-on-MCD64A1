# Wildfire-detection-based-on-MCD64A1
The MCD64A1 data was used to locate the fire point and non-fire point position, and the fuel moisture content(FMC) and foliage fuel load(FFL) before the fire occurred were collected, and the logistic regression model was established to estimate the probability of fire occurrence. This project is implemented based on MATLAB.

# Functions
`Getpoints_index.m`:  Get the indices of fire and non-fire points in an image and get the DOY(day of year) when fire occured.<br>
`Getnearest_FMC`:  Get the FMC image path of the closest date before the fire occurred at each fire point.<br>
`Getnearest_FFL`:  Get the FFL image path of the closest date before the fire occurred at each fire point.<br>
`GetValue`:  Get FMC or FFL values for fire and non-fire locations.<br>
`split_train_test`:  Divide the training set and test set.<br>
`Doy2Date`:  Convert a day of the year (from January 1) to a date.<br>

# Running fires
`main`:  Get fire point data and non-fire point data and save as txt files.<br>
`LOGISTIC_MODEL`:  Carry out Logistic regression and draw ROC curve. The AUC is calculated to evaluate the accuracy of the model. The weight coefficients will be saved as txt files.<br>
