.PHONY: clean

clean: 
	rm figures/*
	
figures/figure1_age_hist.png figures/figure2_sleepduration_boxplot.png: source_data/sleep_health_and_lifestyle_dataset.csv Skratch.r
	Rscript Skratch.r