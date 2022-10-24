# Helble (2012) List of Medical Goods

This code cleans the list of medical goods from Helble (2012) and converts it into a dataframe.

## Procedure

1. import [SSRN working paper](https://doi.org/10.2139/ssrn.2165734) using Word
2. copy and paste table into Excel
3. manually fix line breaks in Excel
4. import Excel table into R and run `clean.R`
    - clean data
    - convert HS3 (2007) to HS5 (2017)
5. save as `medical_products.csv`

## Notes

23 codes are not valid HS3 codes. All but 4 of them are flagged as "old" in the last column of the table. It is unclear which HS revision they refer to so I do not try to convert them.

## References

Helble, Matthias. 2012. “More Trade for Better Health? - International Trade and Tariffs on Health Products.” SSRN Scholarly Paper ID 2165734. Rochester, NY: Social Science Research Network. https://doi.org/10.2139/ssrn.2165734, pages 28-35.