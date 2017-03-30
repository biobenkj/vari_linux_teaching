#!/usr/bin/env perl

# download_and_clean_sra_files.pl

# Given a list of SRR ids, download the appropriate .lite.sra files, unpack them, concatenate them, clean them and leave compressed
# *purified.fastq.gz and *fastq.gz files. 

# Kevin Childs
# 31 January 2012

use Getopt::Std;
use strict;

my $usage = "\n$0   -i \"list of SRR identifiers\"  -d working_directory \n\n";

our ($opt_i, $opt_d, $opt_h);
getopts("i:d:h") or die $usage;

if ($opt_h) {
    print $usage;
    exit;
}

my $input_list = $opt_i;
my $working_directory = $opt_d;

if (!defined($input_list) || !defined($working_directory) || !(-d $working_directory)) {
    die $usage;
}

chdir $working_directory;

$input_list =~ s/^\s+//;
$input_list =~ s/\s+$//;
$input_list =~ s/\s+/\t/g;

my @srr_ids = split "\t", $input_list;

#my @list_of_files;

#foreach my $srr_id (@srr_ids) {
 #   my $fastq = $srr_id . ".fastq";
 #   push @list_of_files, $fastq;
#}
#my $list_of_files = join " ", @list_of_files;

my $output_prefix = join "_", @srr_ids;
my $srr_fastq;

foreach my $srr_id (@srr_ids) {
   
    my $srr_prefix;
    if ($srr_id =~ /(SRR\d\d\d)/){
	$srr_prefix = $1;
    }
    if ($srr_id =~ /(ERR\d\d\d)/) {
	$srr_prefix = $1;
    }
    if ($srr_id =~ /(DRR\d\d\d)/) {
	$srr_prefix = $1;
    }
    
    my $srr_id_lite = $srr_id . ".sra";
    $srr_fastq = $srr_id . ".fastq";
    my $srr_fastq_gz = $srr_id . ".fastq.gz";
    
    if (!-e $srr_fastq_gz) {
	if ($srr_prefix =~ /SRR/) {
	    print "Download $srr_id_lite file from NCBI.\n";
	    system("wget --limit-rate=10M ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/$srr_prefix/$srr_id/$srr_id_lite");
	}
	if ($srr_prefix =~ /ERR/) {
	    print "Download $srr_id_lite file from NCBI.\n";	  
	    system("wget --limit-rate=10M ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByRun/sra/ERR/$srr_prefix/$srr_id/$srr_id_lite");
	}
	if ($srr_prefix =~ /DRR/) {
	    print "Download $srr_id_lite file from NCBI.\n";
	    system("wget --limit-rate=10M ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByRun/sra/DRR/$srr_prefix/$srr_id/$srr_id_lite");
	}		
	print "Unpack $srr_id_lite file with fastq-dump.\n";
	system("/secondary/projects/bbc/tools/sratoolkit/sratoolkit.2.7.0-centos_linux64/bin/fastq-dump --split-files $srr_id_lite");
	
	print "Delete the original $srr_id_lite file.\n";
	system("rm $srr_id_lite");
    }
    else {
	system("pigz -d $srr_fastq_gz");
    }
    
}
