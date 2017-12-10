#!/bin/bash

for counter in {1..100}; do
  echo "Creating file no ${counter}";
  if [[ $(( counter % 11 )) == 0 ]]; then
    new_upper_counter=$(( counter - 1 ))
    new_lower_counter=$(( counter - 10 ))
    for count in $(seq ${new_lower_counter} ${new_upper_counter}); do
      cat ./files/random-file.${count} >> ./files/random-file.${counter};
      let "count += 1";
    done
  elif [[ $(( counter % 5 )) == 0 ]]; then
    echo -n "Nothing to see here" > ./files/random-file.${counter};
  else
    base64 /dev/urandom | head -c 59 > ./files/random-file.${counter};
  fi
  let "counter += 1";
done