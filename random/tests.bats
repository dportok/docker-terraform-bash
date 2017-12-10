#!/usr/bin/env bats

for count in {11..88};do
  @test "Check the size of each 11th file" {
    result="$(ls -l ./files/random-file.${count} | cut -d ' ' -f8)"
    [ "$result" -eq 510 ]
  }
let "count += 11";
done

for counter in {5..95};do
  @test "Check the size of each 5th file" {
    result="$(ls -l ./files/random-file.${counter} | cut -d ' ' -f8)"
    [ "$result" -eq 19 ]
  }
let "counter += 5";
done