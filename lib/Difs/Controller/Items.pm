package Difs::Controller::Items;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Difs::Controller::Items - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Difs::Controller::Items in Items.');
}

=head2 base
 
Can place common logic to start chained dispatch here
 
=cut
 
sub base :Chained('/') :PathPart('items') :CaptureArgs(0) {
    my ($self, $c) = @_;
 
    # Store the ResultSet in stash so it's available for other methods
    $c->stash(resultset => $c->model('DB::Item'));
 
    # Print a message to the debug log
    $c->log->debug('*** INSIDE BASE METHOD ***');
}

=head2 object
 
Fetch the specified item object based on the item ID and store
it in the stash
 
=cut
 
sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
    # $id = primary key of item to delete
    my ($self, $c, $id) = @_;
 
    # Find the item object and store it in the stash
    $c->stash(object => $c->stash->{resultset}->find($id));
 
    # Make sure the lookup was successful.  You would probably
    # want to do something like this in a real app:
    #   $c->detach('/error_404') if !$c->stash->{object};
    die "Item $id not found!" if !$c->stash->{object};
 
    # Print a message to the debug log
    $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
}

=head2 list
 
Fetch all item objects and pass to items/list.tt2 in stash to be displayed
 
=cut

sub list :Local {
    # Retrieve the usual Perl OO '$self' for this object. $c is the Catalyst
    # 'Context' that's used to 'glue together' the various components
    # that make up the application
    my ($self, $c) = @_;
 
    # Retrieve all of the item records as item model objects and store in the
    # stash where they can be accessed by the TT template
    $c->stash(items => [$c->model('DB::Item')->all]);
 
    # Set the TT template to use.  You will almost always want to do this
    # in your action methods (action methods respond to user input in
    # your controllers).
    $c->stash(template => 'items/list.tt');
}

=head2 url_create
 
Create a item with the supplied name, brand, and category
 
=cut
 
sub url_create :Chained('base') :PathPart('url_create') :Args(3) {
    # In addition to self & context, get the title, rating, &
    # acategory_id args from the URL.  Note that Catalyst automatically
    # puts the first 3 arguments worth of extra information after the
    # "/<controller_name>/<action_name/" into @_ because we specified
    # "Args(3)".  The args are separated  by the '/' char on the URL.
    my ($self, $c, $name, $brand, $category_id) = @_;
 
    # Call create() on the item model object. Pass the table
    # columns/field values we want to set as hash values
    my $item = $c->model('DB::Item')->create({
            name  => $name,
            brand => $brand
        });
 
    # Add a record to the join table for this item, mapping to
    # appropri  ate category
    $item->add_to_item_categories({category_id => $category_id});
    # Note: Above is a shortcut for this:
    # $item->create_related('item_categories', {category_id => $category_id});
 
    # Assign the Item object to the stash for display and set template
    $c->stash(item     => $item,
              template => 'items/create_done.tt');
 
    # Disable caching for this page
    $c->response->header('Cache-Control' => 'no-cache');
}

=head2 new_item
 
Display form to collect information for item to create
 
=cut
 
sub new_item :Chained('base') :PathPart('new_item') :Args(0) {
    my ($self, $c) = @_;
 
    # Set the TT template to use
    $c->stash(template => 'items/new_item.tt');
}

=head2 new_item_do
 
Take information from form and add to database
 
=cut
 
sub new_item_do :Chained('base') :PathPart('new_item_do') :Args(0) {
    my ($self, $c) = @_;
 
    # Retrieve the values from the form
    my $name     = $c->request->params->{name}     || 'N/A';
    my $brand    = $c->request->params->{brand}    || 'N/A';
    my $category_id = $c->request->params->{category_id} || '1';
 
    # Create the item
    my $item = $c->model('DB::item')->create({
            name   => $name,
            brand  => $brand,
        });
    # Handle relationship with category
    $item->add_to_item_categories({category_id => $category_id});
    # Note: Above is a shortcut for this:
    # $item->create_related('item_categories', {category_id => $category_id});
 
    # Store new model object in stash and set template
    $c->stash(item     => $item,
              template => 'items/create_done.tt');
}

=head2 delete
 
Delete a book
 
=cut
 
sub delete :Chained('object') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;
 
    # Use the book object saved by 'object' and delete it along
    # with related 'book_author' entries
    $c->stash->{object}->delete;
 
    # Redirect the user back to the list page with status msg as an arg
    $c->response->redirect($c->uri_for($self->action_for('list'),
        {status_msg => "Book deleted."}));
}

=head2 list_recent
 
List recently created books
 
=cut
 
sub list_recent :Chained('base') :PathPart('list_recent') :Args(1) {
    my ($self, $c, $mins) = @_;
 
    # Retrieve all of the book records as book model objects and store in the
    # stash where they can be accessed by the TT template, but only
    # retrieve books created within the last $min number of minutes
    $c->stash(items => [$c->model('DB::Item')
                            ->created_after(DateTime->now->subtract(minutes => $mins))]);
 
    # Set the TT template to use.  You will almost always want to do this
    # in your action methods (action methods respond to user input in
    # your controllers).
    $c->stash(template => 'items/list.tt');
}

=head2 list_recent_tcp
 
List recently created items
 
=cut
 
sub list_recent_adidas :Chained('base') :PathPart('list_recent_adidas') :Args(1) {
    my ($self, $c, $mins) = @_;
 
    # Retrieve all of the book records as book model objects and store in the
    # stash where they can be accessed by the TT template, but only
    # retrieve items created within the last $min number of minutes
    # AND that have 'TCP' in the title
    $c->stash(items => [
            $c->model('DB::Item')
                ->created_after(DateTime->now->subtract(minutes => $mins))
                ->brand_like('adidas')
        ]);
 
    # Set the TT template to use.  You will almost always want to do this
    # in your action methods (action methods respond to user input in
    # your controllers).
    $c->stash(template => 'items/list.tt');
}

=encoding utf8

=head1 category

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
