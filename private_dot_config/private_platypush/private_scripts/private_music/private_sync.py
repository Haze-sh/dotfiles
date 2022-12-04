from os import environ
from logging import getLogger

from platypush.context import get_plugin
from platypush.event.hook import hook
from platypush.message.event.music import NewPlayingTrackEvent

USER = environ.get("USER")

logger = getLogger('music_sync')

# SQLAlchemy connection string that points to your database
music_db_engine = 'postgresql+pg5432://$USER@localhost/music'


# Hook that react to NewPlayingTrackEvent events
@hook(NewPlayingTrackEvent)
def on_new_track_playing(event, **_):
    track = event.track

    # Skip if the track has no artist/title specified
    if not (track.get('artist') and track.get('title')):
        return

    logger.info(
        'Inserting track: %s - %s',
        track['artist'], track['title']
    )

    db = get_plugin('db')
    db.insert(
        engine=music_db_engine,
        table='tmp_music',
        records=[
            {
                'artist': track['artist'],
                'title': track['title'],
                'album': track.get('album'),
            }
        ]
    )
