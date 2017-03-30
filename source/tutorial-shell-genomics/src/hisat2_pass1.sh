#PBS -l walltime=400:00:00
#PBS -l mem=500gb
#PBS -l nodes=1:ppn=80
#PBS -M ben.johnson@vai.org
#PBS -m abe
#PBS -N hisat

# Recursively move through the directories and align for the first pass by tissue
for dir in /data/hisat2/*; do
    cd "$dir"
    for file in ./*_1.fq; do
        SAMPLE=${file%%_1_val_1.fq}
        file2=${file%%_1_val_1.fq}_2_val_2.fq
        touch ${SAMPLE}.metrics
        hisat2 -q -p 80 --dta --novel-splicesite-outfile ${SAMPLE}.novel.ss --met-file ${SAMPLE}.metrics --mm -x /primary/projects/bbc/references/rat/indexes/hisat2/rn6 -1 $file -2 $file2 -S ${SAMPLE}.paired.alignment.sam 2> ${SAMPLE}.alignrate.metrics
        samtools view -@ 25 -hbu ${SAMPLE}.paired.alignment.sam | samtools sort -@ 25 -m 16G -O bam -o ${SAMPLE}.paired.alignment.bam
        samtools index ${SAMPLE}.paired.alignment.bam && rm ${SAMPLE}.paired.alignment.sam
    done
done
