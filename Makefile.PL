
use ExtUtils::MakeMaker;

use strict;
use warnings;

my @D;

my %nv_format = ('5839b4c876bebf3f' => '8LE',
                 '3fbfbe76c8b43958' => '8BE');

my $pf = unpack 'H*' => pack F => 0.124;
my $nv_format = $nv_format{$pf};

if (defined $nv_format) {
    push @D, "-DNV_FORMAT_$nv_format";
}
else {
    warn <<EOW
The floating point format of your computer is not supported by
Sort::Key::Radix yet!

Please, send an email to the author at sfandino\@yahoo.com with
information about your hardware, OS and the output from running "perl
-V".

Thank you!
EOW

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
