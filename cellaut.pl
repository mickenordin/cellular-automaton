#!/usr/bin/env perl
use strict;
use warnings;

# Get arguments
my $gens = $ARGV[0];
my $width = $ARGV[1];
my $rule = $ARGV[2]; 

# Set up all possible rules 0 - 255
# 0   = 00000000
# 1   = 00000001
# ...
# 254 = 11111110
# 255 = 11111111
my @rules;
for (my $index = 255; $index >=0; $index--) {
	push @rules, [get_bin($index, 8)];
}

# extract the correct binary number for this position and this rule
sub get_val_at_pos {
	my ($binstr) = @_;
	my $pos = sprintf ('%d', $binstr);
	return $rules[$rule][$pos];
}

# Get the binary representation of a number as an array of 1's and 0's
sub get_bin{
	my ($dec, $padding) = @_;
	my $bin = sprintf('%0' . $padding .'b',$dec); 
	my @binarr = split(//,$bin);
	return @binarr;
}

# Set up the initial condition to be all 1's except fo one 0 in the middle
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

# Print usage
sub usage {
	print "$0 <number of generations> <width> <rule number (0-255)>\n";
}

# Some error handling
if (scalar @ARGV < 3 or $rule > 255) {
	usage;
	exit 1;

}

# Get the initial condition and print it out
my @initial = set_up_init;
print @initial;
print "\n";

# Now loop through all the generations
for (my $gen = 0; $gen < $gens; $gen++) {
	# This is the next evoultion of the the automation
	my @next;
	for (my $elem = 0; $elem < $width ; $elem++) {
		# Boundary conditions
		my $state;
		if($elem == 0  ) {
			$state = $initial[$width -1] . $initial[$elem] . $initial[$elem +1 ] ;
		} elsif ($elem  == $width -1 ) {
			$state = $initial[$elem-1] . $initial[$elem] . $initial[0];
		# Normal, we are not on the boundary
		} else {
			$state =  $initial[$elem - 1] . $initial[$elem] . $initial[$elem +1];
		}
		# Get the corresponding value for this state
		$next[$elem] = get_val_at_pos oct("0b".$state);
	}
	# The next state is now the new initial
	@initial = @next;
	# Print it out
	print @initial;
	print "\n";
}

exit 0
