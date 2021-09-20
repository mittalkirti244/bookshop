using from '../srv/catalog-service';
using from '@sap/cds/common';

annotate CatalogService.Genres with
@(
    Common.SemanticKey : [name],
    UI : {
        SelectionFields : [name],
        LineItem : [
            {Value : name},
            {
                Value : parent.name,
                Label : 'Main Genre'
            },
        ],
    }
);


////////////////////////////////////////////////////////////////////////////
//
//	Genre Details
//
annotate CatalogService.Genres with @(
    UI : {
    Identification : [{Value : name}],
    HeaderInfo : {
        TypeName : '{i18n>Genre}',
        TypeNamePlural : '{i18n>Genres}',
        Title : {Value : name},
        Description : {Value : ID}
    },
    Facets : [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>SubGenres}',
        Target : 'children/@UI.LineItem'
    }, ],
});


////////////////////////////////////////////////////////////////////////////
//
//	Genres Elements
//
annotate CatalogService.Genres with {
    ID
    @title : '{i18n>ID}';
    name
    @title : '{i18n>Genre}';
}
