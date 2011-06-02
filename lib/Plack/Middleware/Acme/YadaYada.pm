## no critic (RequireUseStrict)
package Plack::Middleware::Acme::YadaYada;

## use critic (RequireUseStrict)
use strict;
use warnings;

use parent 'Plack::Middleware';

use Try::Tiny;

sub call {
    my ( $self, $env ) = @_;

    my $app = $self->app;
    my $retval;

    try {
        $retval = $app->($env);
    } catch {
        if(/^Unimplemented/) {
            $retval = [
                501,
                ['Content-Type' => 'text/plain'],
                ['Not Implemented'],
            ];
        } else {
            die;
        }
    };

    return $retval;
};

1;

__END__

# ABSTRACT: Middleware that handles the Yada Yada operator

=head1 SYNOPSIS

  use Plack::Builder;

  my $app = sub { ... };

  builder {
    enable 'Acme::YadaYada';
    $app;
  };

=head1 DESCRIPTION

This middleware handles exceptions thrown by the Yada Yada operator and
returns "501 Not Implemented" if it encounters any.

=head1 SEE ALSO

L<perlop/Yada_Yada_Operator>

=cut
