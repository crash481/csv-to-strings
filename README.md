# csv-to-strings
Converter from .csv localization files to IOS .strings

How to use: 
1. You need to create this files hierarchy

 root    
 | +- lang1    
 |  | -- someFile.csv    
 | +- lang2    
 |  | -- someFile.csv    
 | +- langX    
 |  | -- someFile.csv    
 | +- csv_to_strings.rb    

2. After this you can run "ruby csv_to_strings.rb" and if no errors folder "ios_strings" appears
