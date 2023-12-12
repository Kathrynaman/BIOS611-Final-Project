.PHONY: clean

clean: 
	rm -f figures/*
	rm -f finalreport/*
	
figures/figure1_age_hist.png figures/figure2_sleepduration_boxplot.png: source_data/sleep_health_and_lifestyle_dataset.csv skratch.r
	Rscript skratch.r

figures/figure3a_systolic_bp_phys_level.png figures/figure3b_diastolic_bp_phys_level.png: source_data/sleep_health_and_lifestyle_dataset.csv skratch2.r
	Rscript skratch2.r	
	
figures/figure4_quality_sleep_stress_level.png figures/figure5_sleep_duration_occupation.png: source_data/sleep_health_and_lifestyle_dataset.csv skratch3.r
	Rscript skratch3.r
	
figures/pca1_occupation.png figures/pca2_gender.png figures/pca3_bmi_category.png figures/pca4_sleep_disorder.png: source_data/sleep_health_and_lifestyle_dataset.csv clustering_script.r
	Rscript clustering_script.r
	
finalreport/final_project_report.html: source_data/sleep_health_and_lifestyle_dataset.csv final_project_report.rmd
	Rscript -e "rmarkdown::render('final_project_report.rmd', output_format = 'html_document', output_dir = 'finalreport')"