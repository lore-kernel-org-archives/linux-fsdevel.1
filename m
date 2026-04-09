Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA30138AC80
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773452; cv=none; b=DaXo8dkozYR4+VjEZeHPgddajlHZNHR50MuJ51nOevmRMhjnJQXucUnHl+a4mYPegVEaZdo0QJYySCnlOlQySh2bJvlc8DHif5mcC7XJ67bT2eE7BVgAcPyimO6UjYyUpUQuB30u1JtYTtbNUonkWnxil26/h9rwRY8h+5VPudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773452; c=relaxed/simple;
	bh=qxgwhL/O4zk3tAycExTPTJFlV4DOHSsP9x3v9zvKEdI=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=Pn36zVH54o3iYc28bxSy6mI9b68RjwtFPMnRI+TSNl43JZQiyiG7IR61BxfyLEDRzXOGAKnrK3TJWTWvcBjKuxcvWDIBYIoqCIA2cCZQb7Ed6NMyDnms/UvSxuzu/LnWf072Z0d2xPdf/TsBPSftrxerQ4SOWudO2JevBvFzNrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxK+Cnl4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxK+Cnl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E38DC4CEF7;
	Thu,  9 Apr 2026 22:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775773452;
	bh=qxgwhL/O4zk3tAycExTPTJFlV4DOHSsP9x3v9zvKEdI=;
	h=Date:Subject:From:To:Cc:From;
	b=KxK+Cnl4eoegBawVziwN2cTGUz7NYez+yeVYSLGo5FjuKUiAD7e6+oNkR0MmmJnYC
	 Bbl9gG/xpTM1GXFNNTkg1bHiC5jo6khjYri6OIQGOG8zyhaC3i06cPGIsRleD5sz7Y
	 ag8gOaDLp7BEPCqPK9KPXzCISujIa5fJ6gmqY7yKPDBDoIuGJlfg+o334u1ft1j1E0
	 8kw0h0FSErRZFgD6c9qiLFIiHa7sYCLWe+b22eNoZHOfVOUqVG3RrkIJS7Wv3B8chF
	 HXqFXd2GuycvnTUR2TzR2eHR0t2wx1+x+z8DJo0JYbahabBXdtosThR/cqR86o5Wtq
	 dP1OXevQAK71A==
Date: Thu, 09 Apr 2026 15:24:11 -0700
Subject: [GIT PULL] libfuse: run fuse servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: bernd@bsbernd.com, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <177577271287.2064584.12214566734023027732.stg-ugh@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Bernd,

Please pull this branch with changes for libfuse.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 3bb9cd99b3688df1bb7536de158ed9e532b277fb:

Add the codechecker/cppcheck github action (2026-04-07 10:08:49 +0200)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container_2026-04-09

for you to fetch changes up to 0db39a8f8844ff88496ed36da417554cb4f3751d:

nullfs: support fuse systemd service mode (2026-04-09 12:31:08 -0700)

----------------------------------------------------------------
libfuse: run fuse servers as a contained service [v4 1/9]

This patchset defines the necessary communication protocols and library
code so that users can mount fuse servers that run in unprivileged
systemd service containers.  That in turn allows unprivileged untrusted
mounts, because the worst that can happen is that a malicious image
crashes the fuse server and the mount dies, instead of corrupting the
kernel's memory.

v4: fix a large number of security problems that only matter when the
mount helper is being run as a setuid program; fix protocol
byteswapping problems; add CLOEXEC to all files being traded
back and forth; add an umount command; and strengthen mount socket
protocol checks.
v3: refactor the sample code to reduce duplication; fix all the
checkpatch complaints; examples actually build standalone;
fuservicemount handles utab now; cleaned up meson feature detection;
handle MS_ flags that don't translate to MOUNT_ATTR_*
v2: cleaned up error code handling and logging; add some example fuse
service; fuservicemount3 can now be a setuid program to allow
unprivileged userspace to fire up a contained filesystem driver.
This could be opening Pandora's box...
v1: detach from fuse-iomap series

With a bit of luck, this should all go splendidly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

----------------------------------------------------------------
Bernd Schubert (1):
Refactor mount code / move common functions to mount_util.c

Darrick J. Wong (12):
mount_service: add systemd/inetd socket service mounting helper
mount_service: create high level fuse helpers
mount_service: use the new mount api for the mount service
mount_service: update mtab after a successful mount
util: hoist the fuse.conf parsing and setuid mode enforcement code
util: fix checkpatch complaints in fuser_conf.[ch]
mount_service: enable unprivileged users in the same manner as fusermount
mount.fuse3: integrate systemd service startup
mount_service: allow installation as a setuid program
example/service_ll: create a sample systemd service fuse server
example/service: create a sample systemd service for a high-level fuse server
nullfs: support fuse systemd service mode

example/single_file.h                            |  184 +++
include/fuse.h                                   |   34 +
include/fuse_service.h                           |  243 +++
include/fuse_service_priv.h                      |  134 ++
lib/fuse_i.h                                     |    3 +
lib/mount_common_i.h                             |   22 +
lib/mount_util.h                                 |    8 +
lib/util.h                                       |   35 +
util/fuser_conf.h                                |   53 +
util/mount_service.h                             |   47 +
.github/workflows/install-ubuntu-dependencies.sh |   12 +-
README.md                                        |    3 +
doc/fuservicemount3.8                            |   32 +
doc/meson.build                                  |    3 +
example/meson.build                              |   26 +
example/null.c                                   |   51 +-
example/null.socket.in                           |   15 +
example/null@.service                            |  102 ++
example/service_hl.c                             |  237 +++
example/service_hl.socket.in                     |   15 +
example/service_hl@.service                      |  102 ++
example/service_ll.c                             |  309 ++++
example/service_ll.socket.in                     |   15 +
example/service_ll@.service                      |  102 ++
example/single_file.c                            |  856 ++++++++++
include/meson.build                              |    4 +
lib/fuse_service.c                               | 1114 +++++++++++++
lib/fuse_service_stub.c                          |  106 ++
lib/fuse_versionscript                           |   18 +
lib/helper.c                                     |  176 +-
lib/meson.build                                  |   17 +-
lib/mount.c                                      |   72 +-
lib/mount_util.c                                 |    9 +
meson.build                                      |   53 +-
meson_options.txt                                |    9 +
test/ci-build.sh                                 |    7 +
util/fuser_conf.c                                |  369 +++++
util/fusermount.c                                |  329 +---
util/fuservicemount.c                            |   66 +
util/install_helper.sh                           |    6 +
util/meson.build                                 |   24 +-
util/mount.fuse.c                                |  135 +-
util/mount_service.c                             | 1866 ++++++++++++++++++++++
43 files changed, 6650 insertions(+), 373 deletions(-)
create mode 100644 example/single_file.h
create mode 100644 include/fuse_service.h
create mode 100644 include/fuse_service_priv.h
create mode 100644 lib/mount_common_i.h
create mode 100644 util/fuser_conf.h
create mode 100644 util/mount_service.h
create mode 100644 doc/fuservicemount3.8
create mode 100644 example/null.socket.in
create mode 100644 example/null@.service
create mode 100644 example/service_hl.c
create mode 100644 example/service_hl.socket.in
create mode 100644 example/service_hl@.service
create mode 100644 example/service_ll.c
create mode 100644 example/service_ll.socket.in
create mode 100644 example/service_ll@.service
create mode 100644 example/single_file.c
create mode 100644 lib/fuse_service.c
create mode 100644 lib/fuse_service_stub.c
create mode 100644 util/fuser_conf.c
create mode 100644 util/fuservicemount.c
create mode 100644 util/mount_service.c

