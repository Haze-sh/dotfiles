-- New listened tracks will be pushed to the tmp_music table, and normalized by
-- a trigger.
drop table if exists tmp_music cascade;
create table tmp_music(
    id          serial not null,
    artist      varchar(255) not null,
    title       varchar(255) not null,
    album       varchar(255),
    created_at  timestamp with time zone default CURRENT_TIMESTAMP,
    primary key(id)
);

-- This table will store the tracks' info
drop table if exists music_track cascade;
create table music_track(
    id          serial not null,
    artist      varchar(255) not null,
    title       varchar(255) not null,
    album       varchar(255),
    created_at  timestamp with time zone default CURRENT_TIMESTAMP,
    primary key(id),
    unique(artist, title)
);

-- Create an index on (artist, title), and ensure that the (artist, title) pair
-- is unique
create unique index track_artist_title_idx on music_track(lower(artist), lower(title));
create index track_artist_idx on music_track(lower(artist));

-- music_activity holds the listened tracks
drop table if exists music_activity cascade;
create table music_activity(
    id          serial not null,
    track_id    int not null,
    created_at  timestamp with time zone default CURRENT_TIMESTAMP,
    primary key(id)
);

-- music_similar keeps track of the similar tracks
drop table if exists music_similar cascade;
create table music_similar(
    source_track_id   int not null,
    target_track_id   int not null,
    match_score       float not null,
    primary key(source_track_id, target_track_id),
    foreign key(source_track_id) references music_track(id),
    foreign key(target_track_id) references music_track(id)
);

-- music_discovery_playlist keeps track of the generated discovery playlists
drop table if exists music_discovery_playlist cascade;
create table music_discovery_playlist(
    id          serial not null,
    name        varchar(255),
    created_at  timestamp with time zone default CURRENT_TIMESTAMP,
    primary key(id)
);

-- This table contains the track included in each discovery playlist
drop table if exists music_discovery_playlist_track cascade;
create table music_discovery_playlist_track(
    id            serial not null,
    playlist_id   int not null,
    track_id      int not null,
    primary key(id),
    unique(playlist_id, track_id),
    foreign key(playlist_id) references music_discovery_playlist(id),
    foreign key(track_id) references music_track(id)
);

-- This table contains the new releases from artist that we've listened to at
-- least once
drop table if exists new_release cascade;
create table new_release(
    id serial not null,
    artist varchar(255) not null,
    album varchar(255) not null,
    genre varchar(255),
    created_at timestamp with time zone default CURRENT_TIMESTAMP,

    primary key(id),
    constraint u_artist_title unique(artist, album)
);

-- This trigger normalizes the tracks inserted into tmp_track
create or replace function sync_music_data()
    returns trigger as
$$
declare
    track_id int;
begin
    insert into music_track(artist, title, album)
        values(new.artist, new.title, new.album)
    on conflict(artist, title) do update
        set album = coalesce(excluded.album, old.album)
    returning id into track_id;

    insert into music_activity(track_id, created_at)
        values (track_id, new.created_at);

    delete from tmp_music where id = new.id;
    return new;
end;
$$
language 'plpgsql';

drop trigger if exists on_sync_music on tmp_music;
create trigger on_sync_music
    after insert on tmp_music
    for each row
    execute procedure sync_music_data();

-- (Optional) accessory view to easily peek the listened tracks
drop view if exists vmusic;
create view vmusic as
select t.id as track_id
     , t.artist
     , t.title
     , t.album
     , a.created_at
from music_track t
join music_activity a
on t.id = a.track_id;
