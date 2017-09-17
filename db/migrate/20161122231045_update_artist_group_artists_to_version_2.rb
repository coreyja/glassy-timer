class UpdateArtistGroupArtistsToVersion2 < ActiveRecord::Migration[4.2]
  def change
    update_view :artist_group_artists, version: 2, revert_to_version: 1
  end
end
