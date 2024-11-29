/*  mysqldump -u root -p --no-data fave_db > fave_db.ddl (powershell) */
/* 以下コマンドプロンプト */
/* mysql -u root -p */
/* morijyobi */
/* source C:/Users/ユーザーパス/IdeaProjects/Fave_Projects/db/fave_db.ddl; */

create table if not exists account
(
    log_id     varchar(30)  not null
        primary key,
    password   varchar(255) not null,
    nick       varchar(30)  not null,
    regimg     int          not null,
    amounthand int          not null,
    living     int          not null,
    saiosi     int          null,
    mainwork   int          null
);

create table if not exists category
(
    cate_id  int auto_increment
        primary key,
    category varchar(50) null
);

create table if not exists osi
(
    osi_id   int auto_increment
        primary key,
    img      varchar(255) null,
    name     varchar(50)  not null,
    birthday date         null,
    osimemo  varchar(255) null,
    log_id   varchar(30)  not null,
    cate_id  int          not null,
    constraint fk_category
        foreign key (cate_id) references category (cate_id),
    constraint osi_ibfk_1
        foreign key (log_id) references account (log_id)
);

create index log_id
    on osi (log_id);

create table if not exists osikatu
(
    osikatu_id int auto_increment
        primary key,
    day        date         null,
    price      int          not null,
    item       varchar(50)  not null,
    purchase   int          not null,
    osi_id     int          not null,
    priority   int          not null,
    memo       varchar(255) null,
    itemtype   int          not null
);

create table if not exists tag
(
    tag_id  int auto_increment
        primary key,
    cate_id int         not null,
    tag     varchar(50) not null,
    constraint tag_ibfk_1
        foreign key (cate_id) references category (cate_id)
);

create table if not exists ositag
(
    ositag_id int auto_increment
        primary key,
    osi_id    int not null,
    tag_id    int not null,
    constraint ositag_ibfk_1
        foreign key (osi_id) references osi (osi_id),
    constraint ositag_ibfk_2
        foreign key (tag_id) references tag (tag_id)
);

create index osi_id
    on ositag (osi_id);

create index tag_id
    on ositag (tag_id);

create index cate_id
    on tag (cate_id);

create table if not exists work
(
    work_id    int auto_increment
        primary key,
    hourlywage int         not null,
    work       varchar(50) not null,
    log_id     varchar(30) not null,
    constraint work_ibfk_1
        foreign key (log_id) references account (log_id)
);

create table if not exists shift
(
    shift_id      int auto_increment
        primary key,
    startdatetime datetime    not null,
    enddatetime   datetime    not null,
    work_id       varchar(30) not null,
    breaktime     int         not null,
    wage          int         not null,
    constraint shift_ibfk_1
        foreign key (work_id) references work (log_id)
);

create index work_id
    on shift (work_id);

create index log_id
    on work (log_id);


