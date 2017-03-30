#PBS -l walltime=256:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=13
#PBS -M ben.johnson@vai.org
#PBS -m abe
#PBS -N giab

cd /data

mkdir human_giab_NA12878

cd human_giab_NA12878

touch parallel_download_jobs.txt

echo 'wget -r ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/131219_D00360_005_BH814YADXX' >> parallel_download_jobs.txt

echo 'wget -r ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/131219_D00360_006_AH81VLADXX' >> parallel_download_jobs.txt

echo 'wget -r ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/131223_D00360_007_BH88WKADXX' >> parallel_download_jobs.txt

echo 'wget -r ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/131223_D00360_008_AH88U0ADXX' >> parallel_download_jobs.txt

echo 'wget -r ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/140115_D00360_0009_AH8962ADXX' >> parallel_download_jobs.txt

echo 'wget -r ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/140115_D00360_0010_BH894YADXX' >> parallel_download_jobs.txt

echo 'wget -r ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/140127_D00360_0011_AHGV6ADXX' >> parallel_download_jobs.txt

echo 'wget -r ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/140127_D00360_0012_BH8GVUADXX' >> parallel_download_jobs.txt

echo 'wget -r ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/140207_D00360_0013_AH8G92ADXX' >> parallel_download_jobs.txt

echo 'wget -r ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/140313_D00360_0014_AH8GGVADXX' >> parallel_download_jobs.txt

echo 'wget -r ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/140313_D00360_0015_BH9258ADXX' >> parallel_download_jobs.txt

echo 'wget -r ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/140407_D00360_0016_AH948VADXX' >> parallel_download_jobs.txt

echo 'wget -r ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/140407_D00360_0017_BH947YADXX' >> parallel_download_jobs.txt

parallel -j 13 < parallel_download_jobs.txt
