use warnings;
use strict;
use utf8;
use FindBin '$Bin';
use Test::More;
my $builder = Test::More->builder;
binmode $builder->output,         ":utf8";
binmode $builder->failure_output, ":utf8";
binmode $builder->todo_output,    ":utf8";
binmode STDOUT, ":encoding(utf8)";
binmode STDERR, ":encoding(utf8)";
use C::Utility qw/read_includes read_includes_local/;
use List::Util 'any';
my $includes = read_includes ("$Bin/read-includes-test.c");
print "@$includes\n";
ok (find ('stdio.h', $includes), "Got stdio.h");
ok (find ('read-includes-test.h', $includes), "Got double-quotes value");
my $lincludes = read_includes_local ("$Bin/read-includes-test.c");
ok (! find ('stdio.h', $lincludes), "Did not get stdio.h");
ok (find ('read-includes-test.h', $lincludes), "Got double-quotes value");
done_testing ();

sub find
{
my ($what, $where) = @_;
return any {$_ eq $what} @$where;
}
