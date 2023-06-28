#! /usr/bin/perl
use strict;
use warnings;

my $input = shift;
my $output = shift;

open I ," cat $input |  " or die "perl $0 $input $output"; ##如果bgzip压缩过,把cat改成 zcat
open O , ">$output";

while (<I>) 
{
	if(/^#/)
	{
		print O  $_;
	}

	else
	{
		chomp;
		my ($chr,$position,$name,@others) = split(/\t/);
		my $alter = join "\t", @others;
		print O "$chr\t$position\t"."$chr\.$position\t$alter\n";
	}

}
close I ;
close O;
