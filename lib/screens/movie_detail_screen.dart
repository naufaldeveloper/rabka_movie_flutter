import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabka_movie/api/api.dart';
import 'package:rabka_movie/models/movie_model.dart';
import 'package:rabka_movie/provider/drawer_toggle_provider.dart';
import 'package:rabka_movie/utils/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  final String titleMovie;
  const MovieDetailScreen({
    super.key,
    required this.movieId,
    required this.titleMovie,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<List<VideoMovies>> videoMovie;

  @override
  void initState() {
    super.initState();
    videoMovie = Api().getVideoMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    bool _toggleValue = Provider.of<DrawerToggleProvider>(context).toggleValue;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _toggleValue ? Colors.black87 : bgPrimaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: _toggleValue ? bgPrimaryColor : primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          widget.titleMovie,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: _toggleValue ? bgPrimaryColor : primaryColor,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: const Icon(Icons.search, size: 25),
              color: _toggleValue ? bgPrimaryColor : primaryColor,
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<VideoMovies>>(
        future: videoMovie,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final videoMovieData = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 1,
              itemBuilder: (context, index) {
                final int lastIndex = videoMovieData.length - 1;
                return YoutubePlayerBuilder(
                  onExitFullScreen: () {
                    // Do something when exit full screen
                  },
                  player: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: videoMovieData[lastIndex].key,
                      flags: const YoutubePlayerFlags(
                        mute: false,
                        autoPlay: false,
                        disableDragSeek: false,
                        loop: false,
                        isLive: false,
                        forceHD: false,
                        enableCaption: true,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: bgPrimaryColor,
                    progressColors: const ProgressBarColors(
                      handleColor: primaryColor,
                      playedColor: primaryColor,
                    ),
                    topActions: <Widget>[
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          videoMovieData[lastIndex].nameVideo,
                          style: const TextStyle(
                            color: bgPrimaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: bgPrimaryColor,
                          size: 25.0,
                        ),
                        onPressed: () {},
                      ),
                    ],
                    onReady: () {
                      // Do something when player is ready.
                    },
                    onEnded: (data) {
                      // Do something when video ends.
                    },
                  ),
                  builder: (context, player) {
                    return player;
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
