require 'fileutils'
require 'CSV'
require 'rake'

$resultDirName = 'ios_strings'

FileUtils.rm_rf Dir[$resultDirName]

Dir.glob('**/').select { |csvLangFolder|
	stringsLangFolder = FileUtils.mkdir_p($resultDirName + '/' + csvLangFolder)

  Dir.foreach(csvLangFolder) do |csvFile|
    next if csvFile == '.' or csvFile == '..'
    puts 'Processing ' + File.join(csvLangFolder, csvFile) + '...'

    locStrings = []

    file = File.open(File.join(csvLangFolder, 'tmp'), 'w') do |out|
      out << File.open(File.join(csvLangFolder, csvFile), 'r:bom|utf-8').read.gsub('","','";"').gsub('" , "', '" ; "').gsub('"', '"""')
    end

    CSV.foreach(file, quote_char: '"', col_sep: (';'), force_quotes: true) { |csvLine|
      if csvLine.count >=2
        locStrings.push(csvLine[csvLine.count - 2] + ' = ' + csvLine[csvLine.count - 1] + ';')
      end
    }

    FileUtils.rm_rf(file)

    stringsFile = File.open(File.join(stringsLangFolder, csvFile.ext('.strings')), 'w+')
    stringsFile.write(locStrings.join("\n"))
    stringsFile.close

  end
}