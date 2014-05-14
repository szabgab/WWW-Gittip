use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'          => 'WWW::Gittip',
    'VERSION_FROM'  => 'lib/WWW/Gittip.pm',
    'PREREQ_PM'     => {
                           'LWP::Simple' => 0,
                           'JSON'        => 0,
                           'Test::More'  => '1.00',
                           'Test::Deep'  => 0,
                        },
    ABSTRACT_FROM => 'lib/WWW/Gittip.pm',
    AUTHOR        => 'Gabor Szabo <szabgab@cpan.org>',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),

    (eval { ExtUtils::MakeMaker->VERSION(6.46) }
      ? (META_MERGE => {
          resources => {
            repository => 'http://github.com/szabgab/WWW-Gittip',
          }
        })
      : ()
    ),
);
