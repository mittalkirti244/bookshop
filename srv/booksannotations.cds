using from '../srv/catalog-service';
using from '@sap/cds/common';

annotate CatalogService.Books with @odata.draft.enabled;
@fiori.draft.enabled

annotate CatalogService.Books with @(
    Common.SemanticKey: [title],
    Metadata.layer: #Core,
	UI: {
        SelectionFields: [title, author_ID],
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
        //Description: {Value: author.name}
        },

        HeaderFacets : [
            {
                $Type  : 'UI.ReferenceFacet',
                Label  : '{i18n>Created}',
                Target : '@UI.FieldGroup#Created'
            },
            {
                $Type  : 'UI.ReferenceFacet',
                Label  : '{i18n>Modified}',
                Target : '@UI.FieldGroup#Modified'
            },
        ],
        
        FieldGroup #Created         : {Data : [
            {Value : createdBy},
            {Value : createdAt},
        ]},
        FieldGroup #Modified        : {Data : [
            {Value : modifiedBy},
            {Value : modifiedAt},
        ]},

		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>General}', Target: '@UI.FieldGroup#General'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Details}',Target: '@UI.FieldGroup#Details'},
		],

		FieldGroup#General: {
			Data: [
				{Value: title},
                {Value: author_ID,Label:'{i18n>Author ID}'},
                {Value: genre_ID,Label:'{i18n>Genre ID}'},
			]
		},
		FieldGroup#Details: {
			Data: [
                {Value: stock},
                {Value: lang, Label:'{i18n>Book Language}'},
                {$Type: 'UI.DataField', Value : image},
			]
		},
    //     PresentationVariant #LineItem: {
    //     GroupBy : [
    //         'ID','genre_ID'
    //     ],
    //    // InitialExpansionLevel : stock,
    //     //Text : 'Browse Books',
    //     SortOrder : [{Property: 'author_ID'}],
    //     Visualizations : ['@UI.LineItem']
    //     },
        
	},

);
// {
//     author @ValueList.entity:'Authors';
// };

annotate CatalogService.Books.image with {
    @UI.IsImageUrl : true
    @Common.Text : '{i18n>Book Image}'
    image
};


annotate CatalogService.Books with {
    ID @title:'{i18n>Book ID}' @Core.Computed;
    title @title:'{i18n>Title}' @Core.Description;
    stock @title : '{i18n>Book Stock}';
}

annotate CatalogService.Books with {
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


// annotate common.Languages with
// @(
//     Common.SemanticKey : [code],
//     Identification : [{Value : code}],
//     UI : {
//         SelectionFields : [
//             name,
//             descr
//         ],
//         LineItem : [
//             {Value : code},
//             {Value : name},
//         ],
//     }
// )
// {
//     lang @ValueList.entity:'Languages';
// };

// annotate common.Languages with
// @(UI : {
//     HeaderInfo : {
//         TypeName : '{i18n>Language}',
//         TypeNamePlural : '{i18n>Languages}',
//         Title : {Value : name},
//         Description : {Value : descr}
//     },
//     Facets : [{
//         $Type : 'UI.ReferenceFacet',
//         Label : '{i18n>Details}',
//         Target : '@UI.FieldGroup#Details'
//     }, ],
//     FieldGroup #Details : {Data : [
//         {Value : code},
//         {Value : name},
//         {Value : descr}
//     ]},
// });

// // annotate CatalogService.Books {
// //     lang @ValueList : {
// //         entity : 'Languages',
// //         type : #fixed
// //     }
// // }

// annotate CatalogService.Books with {
//     lang @(Common : {
//         FieldControl : #Mandatory,
//         ValueList    : {
//             CollectionPath  : ' common.Languages',
//             Label           : 'Languages',
//             //SearchSupported : true,
//             Parameters      : [
//                 {
//                     $Type             : 'Common.ValueListParameterOut',
//                     LocalDataProperty : 'lang',
//                     ValueListProperty : 'lang'
//                 },
//             ]
//         }
//     });
// }

