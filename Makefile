.PHONY: clean

clean: 
	rm derived_data/*
	rm figures/*
	
figures/figure1.png figures/figure2.png: derived_data/Sleep_health_and_lifestyle_dataset.csv
Rscript Skratch.R