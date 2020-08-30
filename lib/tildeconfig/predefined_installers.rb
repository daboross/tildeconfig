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

  # MacOS OS detection
  def_os_detection do
    begin
      spawn(%w[which sw_vers], %i[in out err] => :close).wait
      return nil unless $CHILD_STATUS.success?

      spawn(%w[which brew], %i[in out err] => :close).wait
      return nil unless $CHILD_STATUS.success?

      :homebrew
    rescue StandardError
      nil
    end
end
