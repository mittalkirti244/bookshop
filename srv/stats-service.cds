using my from '../db/schema';

service Stats{
    @readonly entity OrderInfo as projection on my.bookshop.Genres excluding{
        createdAt,
        createdBy,
        modifiedAt,
        modifiedBy,
        book
    }
}