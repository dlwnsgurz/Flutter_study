import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail.model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/episode_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  final String title, thumb, id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late final SharedPreferences prefs;
  bool isLike = false;

  Future initPref() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList("likedToons");
    if (likedToons != null) {
      if (likedToons.contains(widget.id)) {
        setState(() {
          isLike = true;
        });
      }
    } else {
      await prefs.setStringList("likedToons", []);
    }
  }

  Future onHeartTapped() async {
    final likedToons = prefs.getStringList("likedToons");
    if (isLike) {
      likedToons!.remove(widget.id);
    } else {
      likedToons!.add(widget.id);
    }
    await prefs.setStringList("likedToons", likedToons);
    setState(() {
      isLike = !isLike;
    });
  }

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.etLatestEpisodes(widget.id);
    initPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: isLike
                ? const Icon(Icons.favorite_outlined)
                : const Icon(Icons.favorite_outline_outlined),
            onPressed: onHeartTapped,
          )
        ],
        shadowColor: Colors.black,
        elevation: 1,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: const Offset(10, 10),
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 250,
                      child: Image.network(
                        widget.thumb,
                        headers: const {
                          "user-agent":
                              "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36"
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${snapshot.data!.genre} / ${snapshot.data!.age} ",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(episode: episode, webtoon_id: widget.id),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
