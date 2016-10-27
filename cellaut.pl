#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

my $gens = $ARGV[0];
my $width = $ARGV[1];
my $rule = $ARGV[2]; 

# Set up all possible rules 0 - 255
my @rules;
for (my $index = 255; $index >=0; $index--) {
	push @rules, [get_bin($index, 8)];
}

sub get_val_at_pos {
	my ($binstr) = @_;
	my $pos = sprintf ('%d', $binstr);
	return $rules[$rule][$pos];
}

sub get_bin{
	my ($dec, $padding) = @_;
	my $bin = sprintf('%0' . $padding .'b',$dec); 
	my @binarr = split(//,$bin);
	return @binarr;
}

sub set_up_init {
	my @init;
	my $half = $width / 2;
	unless ($width % 2 == 0) {
		$half = $half + 0.5;
	}
	for (my $i = 0; $i < $width; $i++) {
		if($i == $half - 1) {
			$init[$i] = 0;
		} else {
			$init[$i] = 1;
		}
	}
	return @init;
	
}

sub usage {
	print "$0 <number of generations> <width> <rule number (0-255)>\n";
}

if (scalar @ARGV < 3 or $rule > 255) {
	usage;
	exit 1;

}

my @initial = set_up_init;
print @initial;
print "\n";
for (my $gen = 0; $gen < $gens; $gen++) {
	my @next;
	for (my $elem = 0; $elem < $width ; $elem++) {
		# Boundary conditions
		my $state;
		if($elem == 0  ) {
			$state = $initial[$width -1] . $initial[$elem] . $initial[$elem +1 ] ;
		} elsif ($elem  == $width -1 ) {
			$state = $initial[$elem-1] . $initial[$elem] . $initial[0];
		} else {
			$state =  $initial[$elem - 1] . $initial[$elem] . $initial[$elem +1];
		}
		$next[$elem] = get_val_at_pos oct("0b".$state);
	}
	@initial = @next;
	print @initial;
	print "\n";
}
