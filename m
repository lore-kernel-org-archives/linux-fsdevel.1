Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A236E473;
	Wed, 22 Apr 2026 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776899931; cv=none; b=VA19xYk3U/W2NqI3YugL6kZ/OHl68LH+jOT3q3dYtMHFH9PCOqyFPXBP5aQAHhitoBNu93f9eSOhxjdmdgDf5rZxgVU8e6N8lVmQHHNdWpW2A55lWZQ0jDeT2aD4lCNG0QQ7C5gXZ9J0mUYpGS653lR4kVsRJ84TuQL++Kg/Kqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776899931; c=relaxed/simple;
	bh=52xLyCc4MOtUu587muAl95vf9inJaCeuzScYraf1QjE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I82U6LIEQZr4kVFFGfbVwYfGyfL3Jh70MFi8coObzx64I5MrcKXWJDMYYEugvmLcO7DBijWnaxjEVwLUvTpi7Ss7iIk06thYW/QNQf9Gvq4NMlvxDbXdU2cPDpz3rVYTxyZL2phj4CDSrQmrWymOp0ASNbwkexkZnCH7599Xr20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbV0gn1Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbV0gn1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EB9C2BCAF;
	Wed, 22 Apr 2026 23:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776899930;
	bh=52xLyCc4MOtUu587muAl95vf9inJaCeuzScYraf1QjE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jbV0gn1Y/Wu6pDizUN/vC4tQgWZb4fcqLijPSgaHdNeHjZPr8bV98rN2xLxPFNG2s
	 UTML6hQ1CwLrIAO++tsE+WFRkJerzZIxi4QRr480iJIKh82G9IITmzco8Shu3PyOq3
	 GoWtRA9T8uc3mVkoLWqu+2ndTeMC3A+tQ5PDCld1QmJeZY+GvBqryyLr4UaEqLEZ92
	 MxHum9HbaA2XYl2Gs8LCZWI+S7thfxdyqN9D876BQFOrYs/fhIl9+hMwkN/yWKPkZR
	 A4Xgrf2/m6K2U3hhIfQXRVdYPbnkEHY+95WKjXMIxpahQLuNynrF5ynOtDYyfINjOT
	 Vr2B6a6I1Kafw==
Date: Wed, 22 Apr 2026 16:18:50 -0700
Subject: [PATCHSET v5] libfuse: run fuse servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: bschubert@ddn.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 joannelkoong@gmail.com, miklos@szeredi.hu, fuse-devel@lists.linux.dev
Message-ID: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
In-Reply-To: <20260422231518.GA7717@frogsfrogsfrogs>
References: <20260422231518.GA7717@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This patchset defines the necessary communication protocols and library
code so that users can mount fuse servers that run in unprivileged
systemd service containers.  That in turn allows unprivileged untrusted
mounts, because the worst that can happen is that a malicious image
crashes the fuse server and the mount dies, instead of corrupting the
kernel's memory.

v5: Refactor socket IO into helpers, tighten the security checks in
    mount_service.c, always set nosuid/nodev for unprivileged mounts,
    use posix_spawnp in mount.fuse, restructure sample programs and hl
    library code to avoid the need for unmounting during startup
v4.1: fix various cppcheck/codecheck complaints
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

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-service-container
---
Commits in this patchset:
 * Refactor mount code / move common functions to mount_util.c
 * mount_service: add systemd socket service mounting helper
 * mount_service: create high level fuse helpers
 * mount_service: use the new mount api for the mount service
 * mount_service: update mtab after a successful mount
 * util: hoist the fuse.conf parsing and setuid mode enforcement code
 * util: fix checkpatch complaints in fuser_conf.[ch]
 * mount_service: enable unprivileged users in a similar manner as fusermount
 * mount.fuse3: integrate systemd service startup
 * mount_service: allow installation as a setuid program
 * example/service_ll: create a sample systemd service fuse server
 * example/service: create a sample systemd service for a high-level fuse server
 * nullfs: support fuse systemd service mode
---
 example/single_file.h                            |  191 ++
 include/fuse.h                                   |   34 
 include/fuse_service.h                           |  243 +++
 include/fuse_service_priv.h                      |  161 ++
 lib/fuse_i.h                                     |    3 
 lib/mount_common_i.h                             |   22 
 lib/mount_util.h                                 |    8 
 lib/util.h                                       |   35 
 util/fuser_conf.h                                |   62 +
 util/mount_service.h                             |   49 +
 .github/workflows/install-ubuntu-dependencies.sh |    4 
 README.md                                        |    3 
 doc/fuservicemount3.8                            |   32 
 doc/meson.build                                  |    3 
 example/meson.build                              |   26 
 example/null.c                                   |   51 +
 example/null.socket.in                           |   15 
 example/null@.service                            |  102 +
 example/service_hl.c                             |  224 ++
 example/service_hl.socket.in                     |   15 
 example/service_hl@.service                      |  102 +
 example/service_ll.c                             |  313 +++
 example/service_ll.socket.in                     |   15 
 example/service_ll@.service                      |  102 +
 example/single_file.c                            |  970 ++++++++++
 include/meson.build                              |    4 
 lib/fuse_service.c                               | 1220 +++++++++++++
 lib/fuse_service_stub.c                          |  106 +
 lib/fuse_versionscript                           |   18 
 lib/helper.c                                     |  160 ++
 lib/meson.build                                  |   17 
 lib/mount.c                                      |   72 +
 lib/mount_util.c                                 |    9 
 meson.build                                      |   53 +
 meson_options.txt                                |    9 
 test/ci-build.sh                                 |   14 
 util/fuser_conf.c                                |  396 ++++
 util/fusermount.c                                |  363 ----
 util/fuservicemount.c                            |   65 +
 util/install_helper.sh                           |    6 
 util/meson.build                                 |   24 
 util/mount.fuse.c                                |  169 ++
 util/mount_service.c                             | 2111 ++++++++++++++++++++++
 43 files changed, 7197 insertions(+), 404 deletions(-)
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

