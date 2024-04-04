import 'package:flutter/material.dart';

class Movie {
  String title;
  String backdrop_path;
  String original_title;
  String overview;
  String poster_path;
  double vote_average;
  String release_date;

  Movie(
      {required this.title,
      required this.original_title,
      required this.overview,
      required this.poster_path,
      required this.vote_average,
      required this.backdrop_path,
      required this.release_date});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json["title"],
        original_title: json["original_title"],
        overview: json["overview"],
        poster_path: json["poster_path"],
        vote_average: json["vote_average"].toDouble(),
        backdrop_path: json["backdrop_path"],
        release_date: json["release_date"]);
  }
}

// {
//   "page": 1,
//   "results": [
//     {
//       "adult": false,
//       "backdrop_path": "/oBIQDKcqNxKckjugtmzpIIOgoc4.jpg",
//       "id": 969492,
//       "title": "Land of Bad",
//       "original_language": "en",
//       "original_title": "Land of Bad",
//       "overview": "When a Delta Force special ops mission goes terribly wrong, Air Force drone pilot Reaper has 48 hours to remedy what has devolved into a wild rescue operation. With no weapons and no communication other than the drone above, the ground mission suddenly becomes a full-scale battle when the team is discovered by the enemy.",
//       "poster_path": "/h3jYanWMEJq6JJsCopy1h7cT2Hs.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         28,
//         53,
//         10752
//       ],
//       "popularity": 337.553,
//       "release_date": "2024-01-25",
//       "video": false,
//       "vote_average": 7.1,
//       "vote_count": 67
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/nTPFkLUARmo1bYHfkfdNpRKgEOs.jpg",
//       "id": 1072790,
//       "title": "Anyone But You",
//       "original_language": "en",
//       "original_title": "Anyone But You",
//       "overview": "After an amazing first date, Bea and Ben’s fiery attraction turns ice cold — until they find themselves unexpectedly reunited at a destination wedding in Australia. So they do what any two mature adults would do: pretend to be a couple.",
//       "poster_path": "/yRt7MGBElkLQOYRvLTT1b3B1rcp.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         35,
//         10749
//       ],
//       "popularity": 604.475,
//       "release_date": "2023-12-21",
//       "video": false,
//       "vote_average": 6.939,
//       "vote_count": 484
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/7grv5ULlK9wMr2T1fkgr56HlbT.jpg",
//       "id": 760774,
//       "title": "One Life",
//       "original_language": "en",
//       "original_title": "One Life",
//       "overview": "British stockbroker Nicholas Winton visits Czechoslovakia in the 1930s and forms plans to assist in the rescue of Jewish children before the onset of World War II, in an operation that came to be known as the Kindertransport.",
//       "poster_path": "/kmGCB4TTMEphUSxDHsDULDgJMuB.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         18,
//         36,
//         10752
//       ],
//       "popularity": 71.081,
//       "release_date": "2023-09-09",
//       "video": false,
//       "vote_average": 7.787,
//       "vote_count": 68
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/uUiIGztTrfDhPdAFJpr6m4UBMAd.jpg",
//       "id": 634492,
//       "title": "Madame Web",
//       "original_language": "en",
//       "original_title": "Madame Web",
//       "overview": "Forced to confront revelations about her past, paramedic Cassandra Webb forges a relationship with three young women destined for powerful futures...if they can all survive a deadly present.",
//       "poster_path": "/rULWuutDcN5NvtiZi4FRPzRYWSh.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         14,
//         28,
//         53
//       ],
//       "popularity": 1007.123,
//       "release_date": "2024-02-14",
//       "video": false,
//       "vote_average": 5.472,
//       "vote_count": 197
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/uhUO7vQQKvCTfQWubOt5MAKokbL.jpg",
//       "id": 693134,
//       "title": "Dune: Part Two",
//       "original_language": "en",
//       "original_title": "Dune: Part Two",
//       "overview": "Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.",
//       "poster_path": "/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         878,
//         12
//       ],
//       "popularity": 342.906,
//       "release_date": "2024-02-27",
//       "video": false,
//       "vote_average": 10,
//       "vote_count": 1
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/8SwK37xrQnLnLeLqdy3ByH09wI1.jpg",
//       "id": 1026436,
//       "title": "Miller's Girl",
//       "original_language": "en",
//       "original_title": "Miller's Girl",
//       "overview": "A precocious young writer becomes involved with her high school creative writing teacher in a dark coming-of-age drama that examines the blurred lines of emotional connectivity between professor and protégé.",
//       "poster_path": "/aygFQeDmmtlArzo8epmsOg9mz9f.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         18,
//         53
//       ],
//       "popularity": 260.522,
//       "release_date": "2024-01-18",
//       "video": false,
//       "vote_average": 6.773,
//       "vote_count": 44
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/1ZSKH5GGFlM8M32K34GMdaNS2Ew.jpg",
//       "id": 802219,
//       "title": "Bob Marley: One Love",
//       "original_language": "en",
//       "original_title": "Bob Marley: One Love",
//       "overview": "Jamaican singer-songwriter Bob Marley overcomes adversity to become the most famous reggae musician in the world.",
//       "poster_path": "/1lQftpEARVVB9op4TaYiIbactzG.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         10402,
//         18
//       ],
//       "popularity": 399.568,
//       "release_date": "2024-02-14",
//       "video": false,
//       "vote_average": 6.929,
//       "vote_count": 84
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/hYmqZt9LYNLxQvlDqOBnYAfV2Oq.jpg",
//       "id": 1053544,
//       "title": "The Abyss",
//       "original_language": "sv",
//       "original_title": "Avgrunden",
//       "overview": "Frigga tries to balance her risky job as a security manager in the Kiirunavaara mine with her family life, her new love, and her ex, who doesn’t want to let go. But when the ground suddenly starts to shake under their feet, the puzzle of life doesn’t matter and the struggle to not be pulled into the abyss begins.",
//       "poster_path": "/685xLjwk9H5uZaPiioO4Oi81mHh.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         53,
//         18,
//         28
//       ],
//       "popularity": 78.753,
//       "release_date": "2023-09-15",
//       "video": false,
//       "vote_average": 6.333,
//       "vote_count": 30
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/4l65BWqJBl7hBwdIwp2nQdwsOuw.jpg",
//       "id": 850165,
//       "title": "The Iron Claw",
//       "original_language": "en",
//       "original_title": "The Iron Claw",
//       "overview": "The true story of the inseparable Von Erich brothers, who made history in the intensely competitive world of professional wrestling in the early 1980s. Through tragedy and triumph, under the shadow of their domineering father and coach, the brothers seek larger-than-life immortality on the biggest stage in sports.",
//       "poster_path": "/nfs7DCYhgrEIgxKYbITHTzKsggf.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         18,
//         36
//       ],
//       "popularity": 281.662,
//       "release_date": "2023-12-21",
//       "video": false,
//       "vote_average": 7.6,
//       "vote_count": 242
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/bQS43HSLZzMjZkcHJz4fGc7fNdz.jpg",
//       "id": 792307,
//       "title": "Poor Things",
//       "original_language": "en",
//       "original_title": "Poor Things",
//       "overview": "Brought back to life by an unorthodox scientist, a young woman runs off with a debauched lawyer on a whirlwind adventure across the continents. Free from the prejudices of her times, she grows steadfast in her purpose to stand for equality and liberation.",
//       "poster_path": "/kCGlIMHnOm8JPXq3rXM6c5wMxcT.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         878,
//         10749,
//         35
//       ],
//       "popularity": 537.904,
//       "release_date": "2023-12-07",
//       "video": false,
//       "vote_average": 8.1,
//       "vote_count": 1265
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/zA4sQNuZc4WcZtnbwE5xe5sy9jC.jpg",
//       "id": 467244,
//       "title": "The Zone of Interest",
//       "original_language": "en",
//       "original_title": "The Zone of Interest",
//       "overview": "The commandant of Auschwitz, Rudolf Höss, and his wife Hedwig, strive to build a dream life for their family in a house and garden next to the camp.",
//       "poster_path": "/AbFtI353N2Pggl5TxfsI2VtpUt8.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         18,
//         36,
//         10752
//       ],
//       "popularity": 157.954,
//       "release_date": "2023-11-03",
//       "video": false,
//       "vote_average": 7.336,
//       "vote_count": 216
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/4woSOUD0equAYzvwhWBHIJDCM88.jpg",
//       "id": 1096197,
//       "title": "No Way Up",
//       "original_language": "en",
//       "original_title": "No Way Up",
//       "overview": "Characters from different backgrounds are thrown together when the plane they're travelling on crashes into the Pacific Ocean. A nightmare fight for survival ensues with the air supply running out and dangers creeping in from all sides.",
//       "poster_path": "/rieMzC6JJoMVbsaUv6Rzj0fR7Px.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         28,
//         27,
//         53
//       ],
//       "popularity": 193.348,
//       "release_date": "2024-01-18",
//       "video": false,
//       "vote_average": 5.333,
//       "vote_count": 27
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/ycnO0cjsAROSGJKuMODgRtWsHQw.jpg",
//       "id": 872585,
//       "title": "Oppenheimer",
//       "original_language": "en",
//       "original_title": "Oppenheimer",
//       "overview": "The story of J. Robert Oppenheimer's role in the development of the atomic bomb during World War II.",
//       "poster_path": "/ptpr0kGAckfQkJeJIt8st5dglvd.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         18,
//         36
//       ],
//       "popularity": 548.474,
//       "release_date": "2023-07-19",
//       "video": false,
//       "vote_average": 8.1,
//       "vote_count": 6753
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/A0EqMM4WZpzfxpdoDoqICCpzSQ1.jpg",
//       "id": 609681,
//       "title": "The Marvels",
//       "original_language": "en",
//       "original_title": "The Marvels",
//       "overview": "Carol Danvers, aka Captain Marvel, has reclaimed her identity from the tyrannical Kree and taken revenge on the Supreme Intelligence. But unintended consequences see Carol shouldering the burden of a destabilized universe. When her duties send her to an anomalous wormhole linked to a Kree revolutionary, her powers become entangled with that of Jersey City super-fan Kamala Khan, aka Ms. Marvel, and Carol’s estranged niece, now S.A.B.E.R. astronaut Captain Monica Rambeau. Together, this unlikely trio must team up and learn to work in concert to save the universe.",
//       "poster_path": "/9GBhzXMFjgcZ3FdR9w3bUMMTps5.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         878,
//         12,
//         28
//       ],
//       "popularity": 1053.458,
//       "release_date": "2023-11-08",
//       "video": false,
//       "vote_average": 6.272,
//       "vote_count": 1795
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
//       "id": 866398,
//       "title": "The Beekeeper",
//       "original_language": "en",
//       "original_title": "The Beekeeper",
//       "overview": "One man’s campaign for vengeance takes on national stakes after he is revealed to be a former operative of a powerful and clandestine organization known as Beekeepers.",
//       "poster_path": "/A7EByudX0eOzlkQ2FIbogzyazm2.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         28,
//         53,
//         18
//       ],
//       "popularity": 793.933,
//       "release_date": "2024-01-10",
//       "video": false,
//       "vote_average": 7.279,
//       "vote_count": 1233
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/yyFc8Iclt2jxPmLztbP617xXllT.jpg",
//       "id": 787699,
//       "title": "Wonka",
//       "original_language": "en",
//       "original_title": "Wonka",
//       "overview": "Willy Wonka – chock-full of ideas and determined to change the world one delectable bite at a time – is proof that the best things in life begin with a dream, and if you’re lucky enough to meet Willy Wonka, anything is possible.",
//       "poster_path": "/qhb1qOilapbapxWQn9jtRCMwXJF.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         35,
//         10751,
//         14
//       ],
//       "popularity": 1175.854,
//       "release_date": "2023-12-06",
//       "video": false,
//       "vote_average": 7.2,
//       "vote_count": 2191
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/jYEW5xZkZk2WTrdbMGAPFuBqbDc.jpg",
//       "id": 438631,
//       "title": "Dune",
//       "original_language": "en",
//       "original_title": "Dune",
//       "overview": "Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet's exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity's greatest potential-only those who can conquer their fear will survive.",
//       "poster_path": "/d5NXSklXo0qyIYkgV94XAgMIckC.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         878,
//         12
//       ],
//       "popularity": 382.859,
//       "release_date": "2021-09-15",
//       "video": false,
//       "vote_average": 7.8,
//       "vote_count": 10106
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/y3sKoItrKZdVEfPeLyoE9m5OG2v.jpg",
//       "id": 695721,
//       "title": "The Hunger Games: The Ballad of Songbirds & Snakes",
//       "original_language": "en",
//       "original_title": "The Hunger Games: The Ballad of Songbirds & Snakes",
//       "overview": "64 years before he becomes the tyrannical president of Panem, Coriolanus Snow sees a chance for a change in fortunes when he mentors Lucy Gray Baird, the female tribute from District 12.",
//       "poster_path": "/mBaXZ95R2OxueZhvQbcEWy2DqyO.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         18,
//         878,
//         28
//       ],
//       "popularity": 686.862,
//       "release_date": "2023-11-15",
//       "video": false,
//       "vote_average": 7.2,
//       "vote_count": 1813
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/cnqwv5Uz3UW5f086IWbQKr3ksJr.jpg",
//       "id": 572802,
//       "title": "Aquaman and the Lost Kingdom",
//       "original_language": "en",
//       "original_title": "Aquaman and the Lost Kingdom",
//       "overview": "Black Manta seeks revenge on Aquaman for his father's death. Wielding the Black Trident's power, he becomes a formidable foe. To defend Atlantis, Aquaman forges an alliance with his imprisoned brother. They must protect the kingdom.",
//       "poster_path": "/7lTnXOy0iNtBAdRP3TZvaKJ77F6.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         28,
//         12,
//         14
//       ],
//       "popularity": 782.717,
//       "release_date": "2023-12-20",
//       "video": false,
//       "vote_average": 6.894,
//       "vote_count": 1735
//     },
//     {
//       "adult": false,
//       "backdrop_path": "/dmiN2rakG9hZW04Xx7mHOoHTOyD.jpg",
//       "id": 673593,
//       "title": "Mean Girls",
//       "original_language": "en",
//       "original_title": "Mean Girls",
//       "overview": "New student Cady Heron is welcomed into the top of the social food chain by the elite group of popular girls called ‘The Plastics,’ ruled by the conniving queen bee Regina George and her minions Gretchen and Karen. However, when Cady makes the major misstep of falling for Regina’s ex-boyfriend Aaron Samuels, she finds herself prey in Regina’s crosshairs. As Cady sets to take down the group’s apex predator with the help of her outcast friends Janis and Damian, she must learn how to stay true to herself while navigating the most cutthroat jungle of all: high school.",
//       "poster_path": "/fbbj3viSUDEGT1fFFMNpHP1iUjw.jpg",
//       "media_type": "movie",
//       "genre_ids": [
//         35
//       ],
//       "popularity": 99.34,
//       "release_date": "2024-01-10",
//       "video": false,
//       "vote_average": 6.6,
//       "vote_count": 131
//     }
//   ],
//   "total_pages": 1000,
//   "total_results": 20000
// }