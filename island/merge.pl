#! /usr/bin/perl
use strict;
use warnings;
my @vcf = <*.vcf>;

open X, "<$vcf[1]" or die "no >2 number vcf";
while (<X>)
{
	print if /^#/
}
close X;

for my $vcf(@vcf)
{
	open I ,"<$vcf" , or die "no vcf flie!";
	while(<I>)
	{
	print unless /^#/;
	}	
}
close I;
