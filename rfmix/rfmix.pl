#! /usr/bin/perl
use strict;
use warnings;
my $input = shift;
my $ref = shift;
my $output = shift;
open I, "<$input", or die "perl $0 input refspeciesname output";
open O ,">$output", or die "perl $0 input refspeciesname output";
print O "chr\tpos\trfmix\n";
my @row;
while(<I>)
{
	if(/^#/)
	{
	}
	elsif(/^chromosome/)
	{
	my @species = split(/\s+/);
	for(my $i=0; $i<@species ; $i++)
	{
	if ( $species[$i] =~ $ref )
		{
		push @row,$i;
		}
	}
	}	
	else
	{
		chomp;
		my $all = 0;
		my @line = split(/\s+/);
		for my $e (@row)
		{
			$all = $all + $line[$e];
		}
		my $avg = $all / @row;
		print O "$line[0]\t"."$line[1]\t"."$avg\n";

	}
}
close I;
close O;
