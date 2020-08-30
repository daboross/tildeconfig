module TildeConfig
  ##
  # Script which can detect a particular OS or set of operating systems.
  class OsDetectionScript
    ##
    # Constructs an +OsDetectionScript+ wrapping the given detection script.
    # The script should return an OS name if found, or otherwise nothing.
    def initialize(&detection_script)
      @script = detection_script
    end

    ##
    # Detects this operating system. Returns the OS symbol if found, otherwise
    # nothing.
    def detect
      result = @script.call
      return result.intern if result
    end
  end
end
