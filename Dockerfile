FROM vvoronin/perlbrew

RUN cpanm -q Catalyst::Devel --force && rm -rf ~/.cpanm
RUN cpanm -q DBIx::Class --force && rm -rf ~/.cpanm
RUN cpanm -q Catalyst::Model::DBIC::Schema --force && rm -rf ~/.cpanm
RUN cpanm -q HTML::FormFu --force && rm -rf ~/.cpanm

RUN mkdir -p /projects/catalyst/ && chmod 777 /projects/catalyst/

EXPOSE 3000
