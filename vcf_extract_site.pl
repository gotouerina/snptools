## Usage : perl vcf_extract_site.pl site.bed input.vcf.gz
## vcftools is more fast!!
use strict;
use warnings;
my $input = shift;
my $gvcf = shift;
open I ,"<$input" ,or die "no input site file";
open E , "zcat $gvcf | ", or die "no input vcf file";

my %data;
while (<I>) 
{
	chomp;
	my ($key,$value) = split(/\t/);
	push @{$data{$key}},$value;
}
print STDERR "site loaded .....";


while (<E>)
{
	if (/^#/)
	{
		print;
	}
	else
	{
		my ($key,$value) = split(/\t/);
		for  (my $i = 0; $i<  @{$data{$key}}; $i++)
		{
			if ( ${$data{$key}}[$i] == $value)
			{
			print;
			}
		}
		
	}


}
print STDERR "Done";
close I;
close E;
