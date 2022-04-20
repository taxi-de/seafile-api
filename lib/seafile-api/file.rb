# frozen_string_literal: true

module SeafileApi
  class Connect
    def file_link(filename, repo=self.repo)
      get_file_link(filename, repo)
    end

    def get_token
      get_sf_token
    end

    def file_detail(filename, repo=self.repo)
      get_description(filename, repo)
    end

    def link_revision(filename, commit_id, repo=self.repo)
      get_link_file_revision(filename, commit_id, repo)
    end

    def file_history(filename, repo=self.repo)
      get_history(filename, repo)
    end

    def block_link(repo=self.repo)
      get_block(repo)
    end

    def upload_file(file, path='/', repo=self.repo)
      post_upload(repo, { 'file' => file, 'filename' => File.basename(file), 'parent_dir' => path.to_s })
    end

    def update_file(file, target_file=nil, repo=self.repo)
      post_update(repo, { 'file' => file, 'filename' => File.basename(file), 'target_file' => target_file || File.basename(file) })
    end

    def create_file(filename, repo=self.repo)
      post_file(filename, repo)
    end

    def rename_file(old_name, new_name, repo=self.repo)
      post_rename(old_name, repo, { 'operation' => 'rename', 'newname' => new_name })
    end

    # TODO: missing arguments at 3,0,3 , at 3.0.0 all wark
    def copy_file(filename, dst_dir='/', dst_repo=repo, src_repo=repo)
      post_copy(src_repo, { 'file_names' => filename, 'dst_repo' => dst_repo, 'dst_dir' => dst_dir })
    end

    def move_file(filename, dst_dir='/', dest_repo=repo, src_repo=repo)
      post_move(filename, src_repo, { 'operation' => 'move', 'dst_repo' => dest_repo, 'dst_dir' => dst_dir })
    end

    def del_file(filename, repo=self.repo)
      delete_file(filename, repo)
    end

    # TODO: need test on new server version
    # not working seafile server version 3.0.3 , curl to not working
    def revert_file(filename, commit_id, repo=self.repo)
      post_revert(filename.to_s, commit_id, repo)
    end
  end
end
