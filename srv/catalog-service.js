module.exports = srv =>{

    srv.after('READ','Books',each=>{
        each.level = each.stock > 100 ? 3 : 1
    }
    )
}
