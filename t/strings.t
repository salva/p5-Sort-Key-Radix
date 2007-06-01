#!/usr/bin/perl

use Test::More tests => 2;

use Sort::Key::Radix qw(skeysort ssort);

my @data = map { int(rand(200)-100) } 1..100_000;
my @good = sort @data;

is_deeply([skeysort {$_} @data], \@good, 'skeysort');
is_deeply([ssort @data], \@good, 'ssort');
