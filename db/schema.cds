namespace my.bookshop;
using { Country,cuid,sap,Language} from '@sap/cds/common';

@cds.search : {title,author}
entity Books:cuid{
    key ID: UUID @odata.Type:'Edm.String';
    title : String; 
    stock : Integer @assert.range: [ 1,500];
    level: Integer;
    language: Language;
    author : Association to Authors;
    genre: Association to Genres;
    order: Association to Orders;
    country: Country;
    image: LargeBinary @Core.MediaType: imageType;
    imageType : String @Core.IsMediaType: true;
} 

entity Authors{
    key ID : UUID @odata.Type:'Edm.String';
    name: String;
    placeOfBirth: String;
    dateOfBirth: Date;
    Email: String;
    books : Association to many Books on books.author = $self;
}

entity Genres:sap.common.CodeList{
    key ID       : UUID @odata.Type:'Edm.String';
    parent   : Association to Genres;
      children : Composition of many Genres
                     on children.parent = $self;
}

entity Orders{
    key orderID: UUID @odata.Type:'Edm.String';
    name : String;
    noOfBooks: Integer;
    book : Association to Books;
    myBookName: String;
}

