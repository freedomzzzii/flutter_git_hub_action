unzip ios/build/ios_integ/build_products.zip -d ios/build/ios_integ/build_products

file_runner=$(cd ios/build/ios_integ/build_products;grep -l "string" Runner_iphonesimulator*)

cd ios/build/ios_integ/build_products;mv $file_runner ../; cd ../../../../

dir_runner=$(find ios/build/ios_integ/build_products -type d -name "Debug-iphonesimulator")

mv -vf $dir_runner ios/build/ios_integ

cd ios/build/ios_integ/build_products; zip -r ios_tests.zip .