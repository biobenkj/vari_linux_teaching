#PBS -l walltime=256:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=28
#PBS -M ben.johnson@vai.org
#PBS -m abe
#PBS -N nanopore

cd /data

mkdir human_nanopore

cd human_nanopore

parallel -j 39 < ~/human_nanopore/lol_jobs.txt

pigz -d ./*.fastq.gz
