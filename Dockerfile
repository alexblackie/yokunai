FROM ruby:2.4

# Create a user for jenkins so bundler stops complaining.

# HACK: this uid is manually specified here and in the (not public) Ansible
# that set up the Jenkins instance this project currently runs on. This is
# easier than creating a custom entrypoint script to dynamically generate the
# user on container-start based on the uid of the mounted volume permissions,
# but is inflexible.
#
# Just keep in mind if you want to run this on your own Jenkins, you'll need to
# either sync its UID to this, or maintain a patch to this file to change the
# expected UID.
RUN useradd -m -u995 jenkins
