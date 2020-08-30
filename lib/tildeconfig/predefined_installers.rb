##
# Runs the TildeConfig code to create the predefined installers available to the
# user.
def define_predefined_installers
  def_installer :ubuntu do |packages|
    sh "sudo apt install #{packages.join(' ')}"
  end

  # attempt to detect Linux operating systems using lsb_release
  def_os_detection do
    result = nil
    begin
      IO.popen(['lsb_release', '--id', '--short']) do |lsb_release_io|
        result = lsb_release_io.read
      end
    rescue StandardError
      nil
    else
      result.strip.downcase.intern
    end
  end
end
