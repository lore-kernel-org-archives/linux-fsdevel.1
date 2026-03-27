Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C37C2D77E6
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574697; cv=none; b=ZCR1wRUUAQOnRwp5l3MgGOJa/9EynlMCiZ/rVegOVCfVgq6YIMPEkm+KSsT8DKWrCm9/ytf4Z1nH0LauHeQmxckHPoP55nolUfyav1iFW7W34Ksn+6Fh6JcPmh5eWld3v0fWOdPcluTrKY/3wfpIYhTX67fadgao4DDjt+aykuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574697; c=relaxed/simple;
	bh=3n63Ppq3bpG8mQaQ5dr16KuN2mef1gxt+BOUfhWQdB0=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=nhz56rYc6YoJ7ror4383rzOsNwqnpRZo/bDPqSg+zhMd5bTK0o4yOToKhqGXd7L0+DpgitDB9OHZ3LENPziZidzawMqkN5WImrFyMTxJbRC67aBmrGUJt5744M7wJUE1QNNrRlMSzE7TClmpd0EPndA8aTjYeBel9mtfsESAkyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPa+HYEh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPa+HYEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1FAC116C6;
	Fri, 27 Mar 2026 01:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574696;
	bh=3n63Ppq3bpG8mQaQ5dr16KuN2mef1gxt+BOUfhWQdB0=;
	h=Date:Subject:From:To:Cc:From;
	b=SPa+HYEhsAkREZJi+5zLVlA5ysAtSLoY8oTjJfqgjDnn7bpxgzHc0Q7zTuWA6ZPeW
	 G0J1VDAsNGKs2spG4Y7NN7IB0hMjB/nixQ8gua2RYI5ZmTxxtvW9W5u5ZUFPRgcns4
	 trATD8q1F73pdf5v+Z9LAklBd0BKsdTXg3FuxxxVFDuXkMJs/vrce6de6RjhUFUdE1
	 oqMk83F+zM+fAfVUHi6N2qIkxWlN1DYk887E7p2B8Lv1Wlkcc9GREwlJO2a2lw3H3/
	 xu5UemeHBUlUbIdVP8egFxr8pLLQ/KEAZD1SBIP2GarSv6bVZ+1zUAvuWWfEFupO5X
	 ZHS0tiE+bax5w==
Date: Thu, 26 Mar 2026 18:24:56 -0700
Subject: [PATCHSET v3] libfuse: run fuse servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
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
 * mount_service: add systemd/inetd socket service mounting helper
 * mount_service: create high level fuse helpers
 * mount_service: use the new mount api for the mount service
 * mount_service: update mtab after a successful mount
 * util: hoist the fuse.conf parsing code
 * util: fix checkpatch complaints in fuser_conf.[ch]
 * mount_service: read fuse.conf to enable allow_other for unprivileged mounts
 * util: hoist the other non-root user limits
 * util: fix more checkpatch complaints in fuser_conf.[ch]
 * mount_service: use over the other non-root user checks
 * mount.fuse3: integrate systemd service startup
 * mount_service: allow installation as a setuid program
 * example/service_ll: create a sample systemd service fuse server
 * example/service: create a sample systemd service for a high-level fuse server
 * example/hello_ll: port to single-file common code
 * nullfs: support fuse systemd service mode
---
 example/single_file.h                       |  173 +++
 include/fuse.h                              |   33 +
 include/fuse_service.h                      |  215 ++++
 include/fuse_service_priv.h                 |  128 ++
 lib/mount_common_i.h                        |   22 
 lib/mount_util.h                            |    8 
 lib/util.h                                  |   35 +
 util/fuser_conf.h                           |   50 +
 util/mount_service.h                        |   40 +
 .github/workflows/abicheck.yml              |    2 
 .github/workflows/abicheck_prev_release.yml |    2 
 .github/workflows/pr-ci.yml                 |    2 
 README.md                                   |    3 
 doc/fuservicemount3.8                       |   32 +
 doc/meson.build                             |    3 
 example/hello_ll.c                          |  128 --
 example/meson.build                         |   28 
 example/null.c                              |   33 +
 example/nullfile.socket.in                  |   15 
 example/nullfile@.service                   |  102 ++
 example/service_hl.c                        |  215 ++++
 example/service_hl.socket.in                |   15 
 example/service_hl@.service                 |  102 ++
 example/service_ll.c                        |  304 +++++
 example/service_ll.socket.in                |   15 
 example/service_ll@.service                 |  102 ++
 example/single_file.c                       |  724 +++++++++++++
 include/meson.build                         |    4 
 lib/fuse_service.c                          | 1004 ++++++++++++++++++
 lib/fuse_service_stub.c                     |   96 ++
 lib/fuse_versionscript                      |   17 
 lib/helper.c                                |  110 ++
 lib/meson.build                             |   16 
 lib/mount.c                                 |   72 +
 lib/mount_util.c                            |    9 
 meson.build                                 |   59 +
 meson_options.txt                           |    6 
 test/ci-build.sh                            |    7 
 util/fuser_conf.c                           |  369 +++++++
 util/fusermount.c                           |  325 ------
 util/fuservicemount.c                       |   66 +
 util/install_helper.sh                      |    6 
 util/meson.build                            |   22 
 util/mount.fuse.c                           |   58 +
 util/mount_service.c                        | 1531 +++++++++++++++++++++++++++
 45 files changed, 5817 insertions(+), 491 deletions(-)
 create mode 100644 example/single_file.h
 create mode 100644 include/fuse_service.h
 create mode 100644 include/fuse_service_priv.h
 create mode 100644 lib/mount_common_i.h
 create mode 100644 util/fuser_conf.h
 create mode 100644 util/mount_service.h
 create mode 100644 doc/fuservicemount3.8
 create mode 100644 example/nullfile.socket.in
 create mode 100644 example/nullfile@.service
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

