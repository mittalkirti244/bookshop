using from '../srv/catalog-service';
using from '@sap/cds/common';
using from '../app/bookshop/annotations';


annotate CatalogService.Authors with @odata.draft.enabled; 
annotate CatalogService.Authors with @(
    Common.SemanticKey: [name],
	UI: {
        SelectionFields: [name],
        LineItem:[
        {Value: ID},
        {Value: name},
        {Value: books.stock},
        ],
        HeaderInfo:{
        TypeName: '{i18n>Authors}',
        TypeNamePlural: '{i18n>Authors}',
        Title: {Value: name},
        },
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Author Details}', Target: '@UI.FieldGroup#AuthorDetails'},
            {$Type: 'UI.ReferenceFacet', Label: '{i18n>Books}', Target: '@UI.FieldGroup#Books'},
            {$Type: 'UI.ReferenceFacet', Label: '{i18n>Books List}', Target: 'books/@UI.LineItem'},
		],
		FieldGroup#AuthorDetails: {
			Data: [
                {Value: ID, Label:'{i18n>Author ID}'},
				{Value: name},
			]
		},
        FieldGroup#Books: {
			Data: [
                {Value: books.ID, Label:'{i18n>Book ID}'},
				{Value: books.title, Label:'{i18n>Book Name}'},
                {Value: books.stock, Label:'{i18n>Book Stock}'},
			]
		},
        
	},
);
 
annotate CatalogService.Authors with {
    ID @title:'{i18n>Author ID}';
    name @title:'{i18n>Author Name}';

}
