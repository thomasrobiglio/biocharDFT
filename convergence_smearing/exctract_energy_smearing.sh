smearing="0.5 0.3 0.1 0.09 0.07 0.05 0.03 0.01 0.005"

for sm in $smearing
do
printf "${sm}"
awk 'BEGIN{FS=" *= *"} /!    total energy/{split($2,a," +");print "  " a[1]}' graphite_sm${sm}.scf.out 
done > energy_smearing.dat
