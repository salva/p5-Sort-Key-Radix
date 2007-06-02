
use ExtUtils::MakeMaker;

use strict;
use warnings;

my $msg = <<EOM;
The float point format of your computer is not supported by
Sort::Key::Radix yet!

Please, send an email to the author at sfandino\@yahoo.com with
information about your hardware, OS and the output from running "perl
-V".

Thank you!
EOM

my @D;

my %nv_format = ('5839b4c876bebf3f' => '8LE',
                 '3fbfbe76c8b43958' => '8BE');

my %sf_format = ('b6f3fd3d' => '4LE',
                 '3dfdf3b6' => '4BE',
                 '5839b4c876bebf3f' => '8LE',
                 '3fbfbe76c8b43958' => '8BE');

my $pnv = unpack 'H*' => pack F => 0.124;
my $nv_format = $nv_format{$pnv};

my $psf = unpack 'H*' => pack f => 0.124;
my $sf_format = $sf_format{$psf};

if (defined $nv_format) {
    push @D, "-DNV_FORMAT_$nv_format";
}

if (defined $sf_format) {
    push @D, "-DSF_FORAMT_$sf_format";
}

unless ($nv_format and $sf_format) {
    warn $msg;
}

WriteMakefile( NAME              => 'Sort::Key::Radix',
               VERSION_FROM      => 'lib/Sort/Key/Radix.pm',
               PREREQ_PM         => {},
               ABSTRACT_FROM  => 'lib/Sort/Key/Radix.pm',
               AUTHOR         => 'Salvador Fandino <sfandino@yahoo.com>',
               LIBS              => [''],
               DEFINE            => "@D",
               INC               => '-I.',
               # OPTIMIZE => '-O0 -g'
               # OPTIMIZE => '-pg'
               # OPTIMIZE => '-O3'
             );
