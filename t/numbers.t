#!/usr/bin/perl

use Test::More tests => 6;
use Sort::Key::Radix qw(nkeysort rnkeysort nkeysort_inplace nsort rnsort);

use strict;
use warnings;

my @data = map { rand(200)-100 } 1..10000;

is_deeply([nkeysort {$_*$_} @data], [sort {$a*$a <=> $b*$b} @data], 'i sqr');

my @sorted = sort {$a<=>$b} @data;
my @rsorted = reverse @sorted;
is_deeply([nkeysort {$_} @data], \@sorted, 'n id');
is_deeply([rnkeysort {$_} @data], \@rsorted, 'reverse');

my @cp;
@cp = @data;
nkeysort_inplace {$_} @cp;
is_deeply(\@cp, \@sorted, 'in place');

is_deeply([nsort @data], \@sorted, 'nsort');
is_deeply([rnsort @data], \@rsorted, 'rnsort');
