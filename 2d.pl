#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use POSIX;
use utf8;
binmode(STDOUT, ":utf8");



my $max = $ARGV[0];
my $num_rules = $ARGV[1];
my $gens = $ARGV[2];
my $rule = $ARGV[3];
my $half = $max / 2;
if( $max % 2) {
	$half = $half -0.5;
}

# Set num_rules to 255 and bits to 8 by default
my $bits = 8;
if($num_rules) {
	$bits = floor(log($num_rules)/log(2)) + 1;
} else {
	$num_rules = 255;
}

sub get_bin{
	my ($dec, $padding) = @_;
	my $bin = sprintf('%0' . $padding .'b',$dec); 
	my @binarr = split(//,$bin);
	return @binarr;
}

my @rules;
for (my $index = $num_rules; $index >=0; $index--) {
	push @rules, [get_bin($index, $bits)];
}

sub init {
	my @column;
	for (my $x = 0; $x < $max; $x++) {
		my @row;
		for (my $y = 0; $y < $max; $y++) {
			if ($x == $half and $y == $half) {
				$row[$y] = 1;
			} else {
				$row[$y] = 0;
			}
		}
		$column[$x] = [@row];
	}

	return @column;
}

sub get_val_at_pos {
	my ($binstr) = @_;
	my $pos = sprintf ('%d', $binstr);
	return $rules[$rule][$pos];
}

sub print_arr {
	foreach my $elem (values @_) {
		unless($elem) {
			print " ";
		} else {
			print "■";
		}
	}
	print "\n";
}


#print "\033[2J";    #clear the screen
#print "\033[0;0H"; #jump to 0,0

my @initial = init;
foreach my $elem (values @initial) {
	print_arr @$elem;
}

for (my $gen = 0; $gen < $gens; $gen++) {
	my @column;
	for (my $x = 0; $x < $max ; $x++) {
		my @row;
		for (my $y = 0; $y < $max; $y++) {
			my $state;
			# This is the upper column boundary
			if($x == 0) {
				# This is the left boundary of the row
				if($y == 0 ) {
					$state  = $initial[$max -1][$max -1] . $initial[$max -1][$y] . $initial[$max -1][$y +1 ];
					$state .= $initial[$x][$max -1]      . $initial[$x][$y]      . $initial[$x][$y +1 ];
					$state .= $initial[$x +1][$max -1]   . $initial[$x +1][$y]   . $initial[$x +1][$y +1 ];
				# This is the right boundary of the row
				} elsif ($y  == $max -1 ) {
					$state  = $initial[$max -1][$y-1] . $initial[$max -1][$y] . $initial[$max -1][0];
					$state .= $initial[$x][$y-1]      . $initial[$x][$y]      . $initial[$x][0];
					$state .= $initial[$x +1][$y-1]   . $initial[$x +1][$y]   . $initial[$x +1][0];
				# Normal, we are not on the boundary of the row
				} else {
					$state  =  $initial[$max -1][$y - 1] . $initial[$max -1][$y] . $initial[$max -1][$y +1];
					$state .=  $initial[$x][$y - 1]      . $initial[$x][$y]      . $initial[$x][$y +1];
					$state .=  $initial[$x +1][$y - 1]   . $initial[$x +1][$y]   . $initial[$x +1][$y +1];
				}
			# This is bottom boundary of the column 
			} elsif ($x = $max -1) {
				# This is the left boundary of the row
				if($y == 0 ) {
					$state  = $initial[$x -1][$max -1] . $initial[$x -1][$y] . $initial[$x -1][$y +1 ];
					$state .= $initial[$x][$max -1]    . $initial[$x][$y]    . $initial[$x][$y +1 ];
					$state .= $initial[0][$max -1]     . $initial[0][$y]     . $initial[0][$y +1 ];
				# This is the right boundary of the row
				} elsif ($y  == $max -1 ) {
					$state  = $initial[$x -1][$y-1] . $initial[$x -1][$y] . $initial[$x -1][0];
					$state .= $initial[$x][$y-1]    . $initial[$x][$y]    . $initial[$x][0];
					$state .= $initial[0][$y-1]     . $initial[0][$y]     . $initial[0][0];
				# Normal, we are not on the boundary of the row
				} else {
					$state  =  $initial[$x -1][$y - 1] . $initial[$x -1][$y] . $initial[$x -1][$y +1];
					$state .=  $initial[$x][$y - 1]    . $initial[$x][$y]    . $initial[$x][$y +1];
					$state .=  $initial[0][$y - 1]     . $initial[0][$y]     . $initial[0][$y +1];
				}

			# Normal, we are not on the boundary of the column
			} else {
				# This is the left boundary of the row
				if($y == 0 ) {
					$state  = $initial[$x -1][$max -1] . $initial[$x -1][$y] . $initial[$x -1][$y +1 ];
					$state .= $initial[$x][$max -1]    . $initial[$x][$y]    . $initial[$x][$y +1 ];
					$state .= $initial[$x +1][$max -1] . $initial[$x +1][$y] . $initial[$x +1][$y +1 ];
				# This is the right boundary of the row
				} elsif ($y  == $max -1 ) {
					$state  = $initial[$x -1][$y-1] . $initial[$x -1][$y] . $initial[$x -1][0];
					$state .= $initial[$x][$y-1]    . $initial[$x][$y]    . $initial[$x][0];
					$state .= $initial[$x +1][$y-1] . $initial[$x +1][$y] . $initial[$x +1][0];
				# Normal, we are not on the boundary of anything
				} else {
					$state  =  $initial[$x -1][$y - 1] . $initial[$x -1][$y] . $initial[$x -1][$y +1];
					$state .=  $initial[$x][$y - 1]    . $initial[$x][$y]    . $initial[$x][$y +1];
					$state .=  $initial[$x +1][$y - 1] . $initial[$x +1][$y] . $initial[$x +1][$y +1];
				}
			}
			$row[$y] =  get_val_at_pos oct("0b".$state);
			print "$state\n\n";
		}
		$column[$x] = [@row];
	}
	#print "\033[2J";    #clear the screen
	#print "\033[0;0H"; #jump to 0,0
	@initial = @column;
	#foreach my $elem (values @initial) {
#		print_arr $elem;
#	}
}
