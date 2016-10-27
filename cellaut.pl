#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

my $rule = $ARGV[0]; 
my $gens = $ARGV[1];
my $init = $ARGV[2];
# Set up all possible rules 0 - 255
my @rules;
for (my $index = 0; $index < 256; $index++) {
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

my @initial = get_bin($init,$gens);
print @initial;
print "\n";
for (my $gen = 0; $gen < $gens; $gen++) {
	my @next;
	for (my $elem = 0; $elem < $gens; $elem++) {
		# Boundary conditions
		my $state;
		if($elem == 0) {
			$state =  "0" . $initial[$elem] . $initial[$elem+1];
		} elsif ($elem +1 == $gens) {
			$state = $initial[$elem -1] . $initial[$elem] . "0";

		} else {
			$state = $initial[$elem -1] . $initial[$elem] . $initial[$elem+1];

		}
		$next[$elem] = get_val_at_pos oct("0b".$state);
	}
	@initial = @next;
	print @initial;
	print "\n";
}
