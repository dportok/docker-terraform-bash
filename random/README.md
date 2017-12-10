## A bash script that does the following tasks:
### Generates 100 files with random data where:
* Every 5th file contains the string "Nothing to see here"
* Every 11th file should contains the contents of all previous files
* All random data files don't exceed 512 characters in length


As there is the prerequisite for each file to not exceed 512 characters, that is 512 bytes in length, this led us to the following restrictions: 

* Every 11th file should not exceed 512 bytes in total
* As every 11th file contains the content of the previous 10 files, and considering that every 5th file contains 19 characters, that is 19 bytes, this leaves us with 
512 - 19 x 2 = 474 bytes for the remaining 8 files.
* According to the above 2 considerations, each file in each and every 10 files should not contain more than 59.25 bytes which gives us 59 bytes. That is 59 characters.

e.g From the range of file1 to file10, only file5 and file10 will contain 19 bytes each, which is actually the size of the string ```"Nothing to see here"```, and the rest 8 files should have 59 characters each in order for the file11 to be less than 512 bytes in total.

## Requirements
The whole project was built using bash and a framework for testing bash scripts called bats:
[Bats](https://github.com/sstephenson/bats)

## How to run the script and the tests
The structure of the directory which contains the code is shown below:

```
.
├── README.md
├── files
├── random-gen.sh
└── tests.bats
```

In order to invoke the script you should first give it execute permissions by running:

``` chmod +x random-gen.sh ```

Then you can run the script: 
```./random-gen.sh ```

After the script finished you can run the following command to run the tests: 
``` bats tests.bats ``` and you will see something similar to this: 

```
bats tests.bats 
 ✓ Check the size of each 11th file
 ✓ Check the size of each 5th file

2 tests, 0 failures
```