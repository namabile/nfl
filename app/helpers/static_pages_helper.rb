module StaticPagesHelper
	require 'flickraw'
	
	def get_flickr_photo(type='favorite')
		FlickRaw.api_key = 'fef941fcf399b4f6becc35f6e6f2b432'
		FlickRaw.shared_secret = 'd4f5aacbb7de698c'
		group_id = '60356848@N00' #MLB group id

		if type == 'favorite'
			photos = flickr.favorites.getList
			index = rand(photos.total)
		else
			page = rand(50)
			photos = flickr.groups.pools.getPhotos(:group_id => group_id, :page => page)
			index = rand(100)
		end

		photo_id = photos[index].id
		photo_secret = photos[index].secret
		photo_user_name = photos[index].ownername
		info = flickr.photos.getInfo(:photo_id => photo_id, :secret => photo_secret)
		sizes = flickr.photos.getSizes(:photo_id => photo_id, :secret => photo_secret)
		medium = sizes.find { |s| s.label == 'Medium 640' }
		ratio = medium.height.to_i/medium.width.to_i
		height = 640 * ratio
		height = 500 if height > 500 
		flickr_hero_url = medium.source
		flickr_user_url = FlickRaw.url_profile(info)

		"#{image_tag(flickr_hero_url, alt: 'Top Baseball Tickets', width: '640px', height: height)}<h6>via Flickr user #{link_to(photo_user_name, flickr_user_url)}</h6>".html_safe
	end
end
