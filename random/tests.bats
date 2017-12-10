#!/usr/bin/env bats

for ((count=11;count<=88;count+=11)); do
  @test "Check the size of each 11th file" {
    result="$(ls -l ./files/random-file.${count} | cut -d ' ' -f8)"
    [ "$result" == "510" ]
  }
 done

 for ((counter=5;counter<=95;counter+=5)); do
  @test "Check the size of each 5th file" {
    result="$(ls -l ./files/random-file.${counter} | cut -d ' ' -f8)"
    [ "$result" == "19" ]
  }
 done

  for ((size=1;size<=99;size+=1)); do
  @test "Check the size of each file" {
    result="$(ls -l ./files/random-file.${size} | cut -d ' ' -f8)"
    integer="$(( $result | bc))"
    [ "$integer" -le 512 ]
  }
 done