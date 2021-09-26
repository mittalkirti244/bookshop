using from '../srv/catalog-service';
using from '@sap/cds/common';

annotate CatalogService.Books with @odata.draft.enabled;

annotate CatalogService.Books with @(
    Common.SemanticKey: [title],
    Metadata.layer: #Core,
	UI: {
        SelectionFields: [title, author_ID,author.name,country_code],
        LineItem:[ 
        {$Type: 'UI.DataField',Value: ID},
        {$Type: 'UI.DataField',Value: title},
        {$Type: 'UI.DataField',Value: author.name,Label:'{i18n>Author Name}'},
        {$Type: 'UI.DataField',Value: author_ID,Label:'{i18n>Author ID}'},
        {$Type: 'UI.DataField',Value: stock,Criticality: level}
        ],

        HeaderInfo:{
        $Type: 'UI.HeaderInfoType',    
        TypeName: '{i18n>Book}',
        TypeNamePlural: '{i18n>Books List}',
        Title: {Value: ID},
        Description: {Value: author.name}
        },
  
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>General}', Target: '@UI.FieldGroup#General'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Details}',Target: '@UI.FieldGroup#Details'},
            {$Type: 'UI.ReferenceFacet', Label: '{i18n>Books List}', Target: '@UI.FieldGroup#BooksList'},
		],

		FieldGroup#General: {
			Data: [
				{Value: title},
                {Value: author_ID,Label:'{i18n>Author ID}'},
             // { $Type : 'UI.DataFieldForAnnotation', Target : '@UI.ConnectedFields#ProductNumberDescr'},
                {Value: author.name,Label:'{i18n>Author Name}'},
                {Value: genre_ID,Label:'{i18n>Genre ID}'},
			]
		},
		FieldGroup#Details: {
			Data: [
                {Value: stock},
                {Value: language.code, Label:'{i18n>Book Language}'},
               // {$Type: 'UI.DataField', Value : image},
			]
		},
        FieldGroup #BooksList : {
          //  $Type : 'UI.FieldGroupType',
            Data:[
              {Value: author.books.title},
             // {$Type: 'UI.DataFieldWithIntentBasedNavigation',Label:'{i18n>Books Series}',Target:'BooksList',SemanticObject: author, Value:'author'},

            ]
        },
        
	},

);
// {
//     author @ValueList.entity:'Authors';
// };

// annotate CatalogService.Books.image with {
//     @UI.IsImageUrl : true
//     @Common.Text : '{i18n>Book Image}'
//     image
// };


annotate CatalogService.Books with {
    ID @title:'{i18n>Book ID}' @Core.Computed;
    title @title:'{i18n>Title}' @Core.Description;
    stock @title : '{i18n>Book Stock}';
}

annotate CatalogService.Books with{
    author @(Common : {
        FieldControl : #Mandatory,
        ValueList    : {
            CollectionPath  : 'Authors',
            Label           : 'Authors',
            SearchSupported : true,
            Parameters      : [
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'author_ID',
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'dateOfBirth'
                },
            ]
        }
    });
}


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


annotate CatalogService.Orders with @odata.draft.enabled;
annotate CatalogService.Orders with @(
	UI: {
        SelectionFields: [orderID,myBookName],
        LineItem:[ 
           {$Type: 'UI.DataField',Value: orderID},
           {$Type: 'UI.DataField',Value: myBookName}, 
        {$Type: 'UI.DataField',Value: name},
        {$Type: 'UI.DataField',Value: noOfBooks},
        ],

        HeaderInfo:{
        $Type: 'UI.HeaderInfoType',    
        TypeName: '{i18n>Orders}',
        TypeNamePlural: '{i18n>Orders List}',
        Title: {Value: orderID},
        },

		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>General}', Target: '@UI.FieldGroup#General'}
		],

		FieldGroup#General: {
			Data: [
				{Value: book_ID,Label:'{i18n>Books ID}'},
                {Value: name,Label:'{i18n>Order Name}'},
			]
		} 
	},

);

annotate CatalogService.Orders with {
    name @title:'{i18n>Order Name}';
    noOfBooks @title:'{i18n>No of Books}';
    myBookName @title:'{i18n>Books Name}';
    orderID @title:'{i18n>Order ID}';
}

annotate CatalogService.Orders with {
    myBookName @(Common : {
        FieldControl : #Mandatory,
        ValueList    : {
            CollectionPath  : 'Orders',
            Label           : 'Orders',
            SearchSupported : true,
            Parameters      : [
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'myBookName',
                    ValueListProperty : 'myBookName'
                }
            ]
        }
    });
}


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
