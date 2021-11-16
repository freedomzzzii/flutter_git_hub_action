#!/bin/sh

hit_line=0
minimum_code_coverage_score=80
total_line=$(cat "coverage/new_lcov.info" | grep -E "DA:" | wc -l | grep -Eo "[0-9]+")

while read -r line; do
  if [[ $line == "LH:"* ]]; then
    lh_number=$(echo $line | grep -Eo "LH:[0-9]+" | grep -Eo "[0-9]+")
    hit_line=$(($hit_line + $lh_number))
  fi
done < "coverage/new_lcov.info"

calculate_result=$(echo "scale=4;($hit_line/$total_line)" | bc | grep -Eo "[0-9][0-9]")

join() {
  local IFS="$1"
  shift
  echo "$*"
}

code_coverage_score=$(join . ${calculate_result[@]})
code_coverage_score_integer=$(echo $code_coverage_score | grep -Eo "[0-9]{0,2}[.]" | grep -Eo "[0-9]{0,2}")

if  [[ $minimum_code_coverage_score -gt $code_coverage_score_integer ]]
then
    echo "Error: Your code coverage is ${code_coverage_score}% less than ${minimum_code_coverage_score}%"

    exit 1
fi

exit 0