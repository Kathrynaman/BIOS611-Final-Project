.PHONY: clean

clean: 
	rm derived_data/*
	rm figures/*
	
derived_data/Sleep_health_and_lifestyle_dataset.csv:
	curl -Lo derived_data/Sleep_health_and_lifestyle_dataset.csv https://raw.githubusercontent.com/Kathrynaman/BIOS611-Final-Project/main/derived_data/Sleep_health_and_lifestyle_dataset.csv
	
figures/figure1.png figures/figure2.png: derived_data/Sleep_health_and_lifestyle_dataset.csv
	Rscript Skratch.r