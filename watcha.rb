require 'httparty'
require 'rest-client'
require 'json'
require 'awesome_print'
require 'csv'

headers = {
  cookie: "_s_guit=245d3cb41b4391d02d82c5200c4cb6dd239aa1909fafc0516e08b42baff2; autologin_auth_key=---%0A%3Aid%3A+3309877%0A%3Atoken%3A+%22%246%24Gf5EffTB%24g5KPdU10Bjiv8sE7X90zuERwQIGhcZcm.H3i3WIf9cKn%2Fhm1lD0TnX6VhCqGfAAjGamyAYezyyMMgAhfbQ4Nz0%22%0A; watcha_fb_joined=true; share_facebook=true; __uvt=; fbm_126765124079533=base_domain=.watcha.net; _gat=1; _ga=GA1.2.1569291270.1510902247; _gid=GA1.2.1549525087.1511237841; fbsr_126765124079533=cg3SO8wRuKHR_T6LZ7aX-P6cyaUx6oKUiWPsYfWLjmw.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImNvZGUiOiJBUUJZRUQxdTlseVFuX1BDTEZoQVhqcDlzd2ZTWlJILW13WVBLZEhjbzNjaVZtSm9nZl82V0pZOHRZTnBEUVdnaWtRdWsyUGk4NVlGVmlwMzJDbFVFR21vVXd6RTkzSm5YNnBhbm5DZnVHcXM0VDR6OEZENzl0U2NYekRvZU8yOEQ1WmNtSTJrM2ozNFVrVklWUUhMazJZRGZLWmh4Sktkd0cwa2tMc0hPSFh5SEpHTDZNazFkUmdTeGxjYnRhMzdQUUV0cVc2WXpZYk5kb0xYOFNVXy0wbkhuZTY2cnhpOWtlQWxubkJBTWZoVXlQYmJ6TUM0WEVTRnlhclVkV0dPcmM2MWpWWDl6NGExdjRQU2lPRG0xNFAzd0dHWENnel9ZbW1DZnhhMlZlTTBKMXRmczJTSGpqRWxFR2FLT2N3ZDFib1lUX2kwcEhlOXMzY0o2bWRsS1VhSSIsImlzc3VlZF9hdCI6MTUxMTIzODI3MSwidXNlcl9pZCI6IjU2NTQwNTU0NzE0NTY1MCJ9; uvts=6m4XayBBzMS2M9sc; _guinness_session=SUs3MHAyNXFWTUVBZzBiZjVJNkVLSzVSc3NmSUtYemMxdlRBdnoxZHBrRit4KyszMnFsNm5GVkpwbng0MGtvOVBDdnVUdVhtdncxR01SN21SNjhJL1pvNWRqRGJ4d0ErMXN3N04zR0JlL3l4MUFLUGM1Q25ockxSMjg1NUlDaEtuTHd2ODZDRFlxL0Y0MEwyaWtuOUtjMUFZbWdNWjZvK2hHZGdrdlI0S1VlUDlCbFRyMmM3ckM0aVphMUd0bmtkLS03aWZVa3RoS1M4ck5QYk1DMDFtWWJRPT0%3D--d91648e7f4ff0c3d99e0cc313f37d314d7d2985d"
}

res = HTTParty.get(
  "https://watcha.net/boxoffice.json",
  :headers => headers
)

watcha = JSON.parse(res.body)

list = watcha['cards']

list.each do |item|
  movie = item["items"].first["item"]
  title = movie["title"]
  image = movie["poster"]["large"]
  desc = movie["interesting_comment"]["text"] if movie["interesting_comment"]
  CSV.open("movie_list.csv", "a+") do |csv|
    csv << [title, image, desc]
  end
end

# title = watcha['cards'].first['items'].first['item']['title']
# image = watcha['cards'].first['items'].first['item']['poster']['small']
# desc = watcha['cards'].first['items'].first['item']['interesting_comment']['text']
