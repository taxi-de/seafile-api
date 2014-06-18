module SeafileApi

  class Connect
    #get libraries
    def get_default_library
      get_default_lib
    end
    def create_sub_library(repo_id,name,p=nil)
      get_create_sub_lib(repo_id,"/#{p}",name)
    end
    #TODO: check search
    def search_libraries(keyword)
      get_searched_lib(keyword)
    end
    #TODO: > "{\"error_msg\": \"Library name is required.\"}"
    def list_libraries
      get_list_liba
    end

    def list_virtual_libraries
      get_list_virtual_lib
    end
    def get_library_info(repo_id)
      get_lib_info(repo_id)
    end

    def get_library_owner(repo_id)
      get_lib_owner(repo_id)
    end

    def get_library_history(repo_id)
      get_lib_history(repo_id)
    end
    def fetch_library_info(repo_id)
      get_lib_download_info(repo_id)
    end

    #post libraries
    #TODO: check desk variable, add ecnrypt ability
    def create_library(name,desc="new repo")
      post_lib(name,desc)
    end
    def create_default_library
      post_default_lib
    end
    #TODO: Sorry, but the requested page could not be found.
    def create_public_library(repo_id)
      post_public_lib(repo_id)
    end

    #TODO: Sorry, but the requested page could not be found.
    def decrypt_library(repo_id,password)
      post_lib_pass(repo_id,password)
    end

    # del libraries
    #TODO: Sorry, but the requested page could not be found.
    def delete_library(repo_id)
      delete_lib(repo_id)
    end
    #TODO: Sorry, but the requested page could not be found.
    def remove_public_library(repo_id)
      delete_public_lib(repo_id)
    end




    private


  end

end