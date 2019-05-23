FROM vvoronin/perlbrew

RUN cpanm -q Catalyst::Devel --force && rm -rf ~/.cpanm
RUN cpanm -q DBIx::Class --force && rm -rf ~/.cpanm
RUN cpanm -q Catalyst::Model::DBIC::Schema --force && rm -rf ~/.cpanm
RUN cpanm -q HTML::FormFu --force && rm -rf ~/.cpanm
RUN cpanm -q Catalyst::Plugin::Session --force && rm -rf ~/.cpanm
RUN cpanm -q Catalyst::Plugin::Session::Store::File --force && rm -rf ~/.cpanm
RUN cpanm -q Catalyst::Plugin::Session::State::Cookie --force && rm -rf ~/.cpanm
RUN cpanm -q Catalyst::Plugin::Authentication --force && rm -rf ~/.cpanm
RUN cpanm -q Catalyst::Authentication::Realm::SimpleDB --force && rm -rf ~/.cpanm

RUN mkdir -p /projects/catalyst/ && chmod 777 /projects/catalyst/

EXPOSE 3000