namespace my.bookshop;
using { Country,cuid, managed,sap} from '@sap/cds/common';

@cds.search : {title,author}
entity Books:cuid,managed{
    key ID: UUID @odata.Type:'Edm.String';
    title : String; 
    stock : Integer @assert.range: [ 1,500];
    author : Association to Authors;
    level: Integer;
    genre: Association to Genres;
    lang: String;
    image: LargeBinary @Core.MediaType: imageType;
    imageType : String @Core.IsMediaType: true;
} 

//@cds.search :{name}
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


