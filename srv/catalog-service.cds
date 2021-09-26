using my.bookshop as my from '../db/schema';


service CatalogService{
    @Capabilities : { Insertable:true, Deletable:true}
    entity Books as projection on my.Books;
   @Capabilities : { Insertable:true, Deletable:true}
   entity Authors as projection on my.Authors;

    // entity Authors as select from my.Authors
    // actions
    // {
    //     function truncatedName (l: Integer) returns Authors;
    // }
    @Capabilities : { Insertable:true, Deletable:true}
    entity Genres as projection on my.Genres;

     @Capabilities : { Insertable:true, Deletable:true}
    entity Orders as projection on my.Orders;
}
