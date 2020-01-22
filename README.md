## Technical Test for Smart Pension
#### Barri Mason

## Usage

`ruby parser.rb [FILENAME]`

## Brief
Write a ruby script that:

a. Receives a log as argument (webserver.log is provided)
e.g.: `./parser.rb webserver.log`

b. Returns the following:

- list of webpages with most page views ordered from most pages views to less page views
e.g.:
```
/home 90 visits
/index 80 visits 
etc...
``` 

- list of webpages with most
unique page views also ordered
e.g.:
```
/about/2 8 unique views
/index 5 unique views
etc...
```

## Assumptions
- Output goes to STDOUT
- Output is on separate lines, with "Visits" and "Unique visits" as headers, not inline (better for piping output)

## Approach
- Visited URLs represented by `VisitedUrl` class, keeps count of total visits and list of remote IPs
- All visited URLs held in `VisitsCounter` class
- Visits are sorted by `VisitsReport` class
- File is parsed by `FileParser` class, which creates a `VisitsReport` object and an array of parsing errors
- The `ReportPrinter` class formats and prints a hash to STDOUT

## Notes

- I have mostly honoured the single expectation policy for tests, except where each assertion is
testing the same bit of logic and placing the assertions in one example is more readable.
- Currently parsing errors are limited to malformed lines, would be good to add URL and IP validation
- The `ReportPrinter` class is ugly, but I have run out of time!


