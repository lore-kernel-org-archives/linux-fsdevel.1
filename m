Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.186
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877666;
	b=5srSfg2yRYlYXDu32YTO3pA0KfynN7dCPpjHDFsGmCYfJ+aFnSmQUNRStJYmIfcJJT3X
	 GFLw4yET7+ChH8ACowwzI/psbtfplJwOs2chSB1vGKM3/SFn5qtijmqMLQiTDIV5InbcQ
	 /33++rpGi0J3QsAp7f1qNn6xhXPXj1bT1+bkediwGe7hMBvV+xGJ6k/ArqW13qK40D+Dv
	 J+CPLPtyCxietwbe+PEgCSDYQmWIa8jrsnvNCqGFOrhcn92jpR8lFqdd8NY1NbxBkheCl
	 YVTc2IJgMcE5lbJ9umxdRWrWqIx3THIhmQwXTrNRv3rihYyy0FiLV2P658HjzEbdB9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877666;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n1ASQiBeiy0/TyX2PUTRONzaubde+XGUSDZ7NVCzFF0=;
	b=w5auEvTjac4PtGZ1m/qBl0ct2ITlGmwhm3ARAUBHhX9nsKTS9ahYz7UR44HYd3hUTS1P
	 I0tHk5jh7qC4ACL86nHvZUZOSmVbbG9K/+GuByzOrVILOMhibyPgDgei5cyqG8RmkGm3V
	 s11IN8CF3eZKLJcmBHq38/YVBYRMjcVIdFPtWfxU96Vb+27P543jM/c3eZKEYb+QWZXmS
	 TDrJgZpnfR2RsSJZsMg4oCzqPmYFGfQjPldYJVvJT/5CUnyVD9Ii0W57JwOFCGn3+Z03w
	 4QTO1wVNrhCQIAg14cH4EjV0K5z0OKIgHT1l3Ijimo8HbxP6rsSYMGzvdLFe2T/lAnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=rQZIPvvg;
	arc=none smtp.remote-ip=195.121.94.186
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6D606A31A
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 21:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5B6D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=rQZIPvvg
X-KPN-MessageId: a7bf5de5-cff2-11f1-87e5-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a7bf5de5-cff2-11f1-87e5-00505699b430;
	Sat, 24 Oct 2026 23:34:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=n1ASQiBeiy0/TyX2PUTRONzaubde+XGUSDZ7NVCzFF0=;
	b=rQZIPvvgGv5Hd40M/LiJG05ClYIJ9E+YEjEiSyyCvljBCHxbFdTp6T+oeJUwC4yAbkWl9+5veIXXI
	 ZP2oICbEEmUoVJWrBubX3Aj/2nt0RZ3popclFP7ndKCxhm4g/ok/CLbanFTs/IiAl52sh9kIQB9ota
	 lQrrrndIWy9pqMAEImLUQmBQav9s/1j1FmZnS49GvNDx7jL1tK0lTqypXto1JYc7IRUPFBgztl/i+/
	 TREW1YH9gpiYbgnaUYdLvwZNgFvdIr6fduE5U2V5m4TE9cFZ8qSYgRHpUWyLSEJBpHp3cf/SJnwtk1
	 1Q6Klc3E8K5mBF2Tyhxc22zBwxT8zWQ==
X-KPN-MID: 33|+seAJrZKYOGAuJwvNZgVn6VSv8P0b70NKE6F/nBIriyooeJUbjJmtSpQTDWy+uc
 XILOvq1+cvxNRTTQd6HmW2QiE7pm4u1F4cEML8kRPjc8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|gBnN1WpvIeOeLouyCwebPLkswTPD0UntvZ0iDkx82YwntRwhqSMn4Ap0/F3SYs5
 qjjZlo7xzNLA/f5KBWuH61w==
Received: from daedalus.home (unknown [178.227.247.81])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id a50dd341-cff2-11f1-8686-00505699b758;
	Sat, 24 Oct 2026 23:34:12 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	neil@brown.name,
	cyphar@cyphar.com,
	jlayton@kernel.org,
	amir73il@gmail.com,
	shakeel.butt@linux.dev,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v8 00/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Sat, 24 Oct 2026 23:35:27 +0200
Message-ID: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements new semantics for the O_CREAT|O_DIRECTORY flag
combination for open*(2): perform a mkdir and open the resulting
directory; return a pinning fd (which mkdir does not).

The v6 was found by Brauner to contain a bug because ->mkdir
implementations may leave the dentry negative, and do_open() cannot deal
with that (NULL pointer deref.) This behavior occurs in kernfs and
tracefs at least. Since atomic mkdir is wanted for cgroupfs (as per
Brauner at LPC26), kernfs is changed to return the new kernfs_node from
the kernfs_syscall_ops ->mkdir() callbacks and splicing its inode.

Filesystems that do not support O_CREAT|O_DIRECTORY set
SB_I_NO_ATOMIC_MKDIR, and lookup_open() refuses the open with EOPNOTSUPP
for them before doing any lookup. These are all ->atomic_open()
filesystems, which cannot create directories without protocol
extensions, and tracefs, whose ->mkdir() drops the parent's i_rwsem so
that the directory at the name may not be the one created by the call
(or at least it has to be verified that this plays well with the
atomicity guarantee that O_CREAT|O_DIRECTORY attempts to provide.) For
ecryptfs and apparmorfs there are similar concerns and hence they are
also blocked for now.

Most of the work happens in "vfs: add O_CREAT|O_DIRECTORY to open*(2),"
as may be expected. Before that there is some clean-up work and
preparation. The "vfs: short-circuit MAY_WRITE access for O_DIRECTORY
opens" patch is also worth paying extra attention to as it
short-circuits doomed opening of directories as writable. This check (to
prevent one from opening directories as writable) is currently done very
late in do_open(), after an inode has been obtained. However, when
introducing O_CREAT|O_DIRECTORY this is unacceptable as it would create
the directory and then still fail. This patch does however change some
user visible error codes.

Moreover, "vfs: change ->create/->mkdir operations unavailable errno"
also changes the ->create and ->mkdir unavailable errnos to -EOPNOTSUPP.
A previous attempt to do this more widely stranded before.[1] However,
that regression was only for vfat and does seem specific to changing the
return code from vfs_symlink(). We can drop this patch if needed, but it
would be _really_ ugly.

Changes from vn to v(n+1):
v7: https://lore.kernel.org/linux-fsdevel/20261016143806.2946578-1-jkoolstra@xs4all.nl/
   - Rebased on Neil's shared lookup changes to lookup_open()
   - Fix implementation of kernfs_get_inode_prealloc() after
     discussion with Shakeel Butt.[2] The new kernfs_get_inode_locked()
     takes the kernfs_rwsem for reading, so that __kernfs_remove()
     always finds the inode to clear its i_nlink. The @lookup argument
     is added so that their patch can use the same function.
v6: https://lore.kernel.org/linux-fsdevel/20260913185016.523376-1-jkoolstra@xs4all.nl/
   - Change kernfs to instantiate ->mkdir dentry.
   - Fix kernfs locking when initializing a new inode to hold
     kernfs_iattr_rwsem.
   - Add flag SB_I_NO_ATOMIC_MKDIR to disable O_CREAT|O_DIRECTORY on
     unsupported filesystems (instead of only looking at ->atomic_open.)
   - Add tests to verify behavior of O_CREAT|O_DIRECTORY on cgroupfs and
     tracefs.
v5: https://lore.kernel.org/linux-fsdevel/20260823160706.358293-1-jkoolstra@xs4all.nl/
   - Uniformize ->create and ->mkdir unavailable errnos to -EOPNOTSUPP.
   - Return -EOPNOTSUPP instead of -ENOENT when O_CREAT|O_DIRECTORY is
     not supported by a ->atomic_open filesystem.
   - Added test cases for dangling symlink and sticky directory
     behaviour, and a test that verifies O_TMPFILE|O_CREAT is still
     -EINVAL.
   - Split off "vfs: lookup_open(): lock the parent as I_MUTEX_PARENT"
     as a separate patch.
   - Fixed the issues pointed out by Brauner in v5.
v4: https://lore.kernel.org/linux-fsdevel/20260712175539.1565444-1-jkoolstra@xs4all.nl/
   - rebased on 7.2, which includes my changes to auditing in
     lookup_open() as well as Neil Brown's changes to the same function
     for the implementation of vfs_lookup_open().
v3: https://lore.kernel.org/linux-fsdevel/20260704164149.3480051-1-jkoolstra@xs4all.nl/
   - address the inconsistency in calling audit_inode_child() in
     lookup_open() versus vfs_create() in a separate series.
   - fclog.c selftest header fix moved to separate patch.
   - add a "with trailing slash test" success test to the included
     selftests. 
   - pass struct qstr by pointer to trailing_slashes() and add a comment
     on what it does
   - changed commit message of "vfs: add O_CREAT|O_DIRECTORY to
     open*(2)" to address comments of Brauner

[1]: https://lore.kernel.org/linux-fsdevel/90228c39-04e7-41ef-ad91-84a8bb866650@sirena.org.uk/
[2]: https://lore.kernel.org/linux-fsdevel/20261016220029.3276154-1-shakeel.butt@linux.dev/



Jori Koolstra (12):
  fs/namei.c: use trailing_slashes()
  vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
  vfs: lookup_open(): move setting FMODE_CREATED down
  vfs: move ->create check in lookup_open() to before try_break_deleg()
  vfs: lookup_open(): use vfs_create_no_perm()
  vfs: lookup_open(): lock the parent as I_MUTEX_PARENT
  vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
  kernfs: hold kernfs_iattr_rwsem when initializing a new inode
  vfs: add O_CREAT|O_DIRECTORY to open*(2)
  vfs: use finish_lookup() helper in __lookup_slow() and lookup_open()
  vfs: change ->create/->mkdir operations unavailable errno
  selftest: add tests for open*(O_CREAT|O_DIRECTORY)

 arch/alpha/include/uapi/asm/errno.h           |   2 +-
 arch/mips/include/uapi/asm/errno.h            |   2 +-
 arch/parisc/include/uapi/asm/errno.h          |   2 +-
 arch/sparc/include/uapi/asm/errno.h           |   2 +-
 fs/9p/vfs_super.c                             |   1 +
 fs/ceph/super.c                               |   1 +
 fs/ecryptfs/main.c                            |   1 +
 fs/fuse/inode.c                               |   1 +
 fs/gfs2/ops_fstype.c                          |   1 +
 fs/kernfs/dir.c                               |  38 +-
 fs/kernfs/inode.c                             |  60 ++-
 fs/kernfs/kernfs-internal.h                   |   4 +
 fs/namei.c                                    | 278 +++++++++-----
 fs/nfs/super.c                                |   1 +
 fs/open.c                                     |  42 ++-
 fs/resctrl/rdtgroup.c                         |  35 +-
 fs/smb/client/cifsfs.c                        |   1 +
 fs/tracefs/inode.c                            |   1 +
 fs/vboxsf/super.c                             |   1 +
 include/linux/fcntl.h                         |   6 +
 include/linux/fs/super_types.h                |   1 +
 include/linux/kernfs.h                        |   7 +-
 include/uapi/asm-generic/errno.h              |   2 +-
 kernel/cgroup/cgroup-internal.h               |   3 +-
 kernel/cgroup/cgroup.c                        |  16 +-
 security/apparmor/apparmorfs.c                |   1 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 .../filesystems/open_o_creat_o_dir.c          | 346 ++++++++++++++++++
 .../testing/selftests/filesystems/wrappers.h  |  11 +
 30 files changed, 724 insertions(+), 146 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c


base-commit: 5b0764a53235d3c77e1ed674e836e1b3fe1a4b1f
-- 
2.56.0

