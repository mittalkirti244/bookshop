using my.bookshop as my from '../db/schema';


service CatalogService{
    @Capabilities : { Insertable:true, Deletable:true}
    entity Books as projection on my.Books;
    @Capabilities : { Insertable:true, Deletable:true}
    entity Authors as projection on my.Authors;

    @Capabilities : { Insertable:true, Deletable:true}
    entity Genres as projection on my.Genres;
}
