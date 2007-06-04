
use ExtUtils::MakeMaker;

use strict;
use warnings;

open my $ch, ">", "rconfig.h"
    or die "unable to create config.h";

my %nv_format = ('5839b4c876bebf3f' => 'LE8',
                 '3fbfbe76c8b43958' => 'BE8');

my %sf_format = ('b6f3fd3d' => 'LE4',
                 '3dfdf3b6' => 'BE4',
                 '5839b4c876bebf3f' => 'LE8',
                 '3fbfbe76c8b43958' => 'BE8');

my $pnv = unpack 'H*' => pack (($] < 5.008 ? 'd' : 'F') => 0.124);
my $nv_format = $nv_format{$pnv};

my $psf = unpack 'H*' => pack f => 0.124;
my $sf_format = $sf_format{$psf};


print $ch <<EOD;
#define NV_0124 "$pnv"
#define SF_0124 "$psf"
EOD

if (defined $nv_format) {
    print $ch "#define NV_FORMAT $nv_format\n";
}

if (defined $sf_format) {
    print $ch "#define SF_FORMAT $sf_format\n";
}

unless ($nv_format and $sf_format) {
warn <<EOM;
The float point format of your computer is not supported by
Sort::Key::Radix yet!

Please, send an email to the author at sfandino\@yahoo.com with
information about your hardware, OS and the output from running "perl
-V".

Thank you!
EOM
}

WriteMakefile( NAME              => 'Sort::Key::Radix',
               VERSION_FROM      => 'lib/Sort/Key/Radix.pm',
               PREREQ_PM         => {},
               ABSTRACT_FROM  => 'lib/Sort/Key/Radix.pm',
               AUTHOR         => 'Salvador Fandino <sfandino@yahoo.com>',
               LIBS              => [''],
               INC               => '-I.',
               # OPTIMIZE => '-O0 -g'
               # OPTIMIZE => '-pg'
               # OPTIMIZE => '-O3'
             );
