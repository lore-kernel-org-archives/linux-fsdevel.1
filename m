Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23BC37DAD5
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325358; cv=none; b=r8IOePM16VEkrt7NKB2aJ0Ec4sPYxDrSHL0EixfAmxSdGsMhLQzVfVtr+Bmsll6Ml6m7mVQRcrr+czUIs+Rc2b19+AYnkF9AFtKqu354qgKfKiTWvWQoKfZiU1EYktYLbqFpC2L7UlravSRihxoXbhNwXSbA96QomBEM95dNppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325358; c=relaxed/simple;
	bh=vnNK3pm4U0gCQYsYGeSX40DN5pna76SwFCd/QsuxnXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUfLZ7nkkF8xeOgNn6EhcnWIhT+WdmSjR0Lm/VSf0y/QaiS4rcpI9B011XntHqdyyb1v36Uvck2nF2rrdUboFUYJISF3e0FcEjbcI+CbxAoM7heQzM/lKVz8pU+B3+gYwbOyc1up7zw5d6AXlX/yMbB5CO9wK7QHXaIGdUroGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=VvZLXSTL; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="VvZLXSTL"
X-KPN-MessageId: ca4aaee7-afa3-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ca4aaee7-afa3-11f1-b2a8-005056abbe64;
	Sun, 13 Sep 2026 20:49:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=VrQ/72DWEkUD9WmDiM0L0xRV0BLDfb4wOia7BMMgbNM=;
	b=VvZLXSTLGxAF1Dc7rn43uMJR7Ns5smVA6Td5M5RSyHRXNs8MxvezQSayTpz/9+CryXT/mHTepHmIf
	 hC4/VvGyU9URSrMQrp9h2dbgFMsYQp2M9AZwwYQoRgi6rm59Kh4zGQFZYlAKgcr2Z/FXrUH6S/Wuvz
	 c8vlW6NG/cBzWnuTnxqkeh72Z0dYbwr0/bpcIhzQ6OxeblYAI59cf7J+zE/sb2wZZynQ7TnEbH7q/0
	 LO1yNuvCpVweF/1RS8p6HuwQN3lH5mJMW+i4GuPUmYUgEKlLwhlx7+JlbjQP4j+gLkFYrVG4xt0DTk
	 fi5JdiyOailDb4BhGhRNWD+XIJFLpYA==
X-KPN-MID: 33|u8BGK/9jJ/f7k3PruIOET9q5+fmEuHy1PH44nKUhZXutmNkVG/aUgKKoF2FZ0db
 QuEJp5wbvsm57qlDft0IB8aEohI35ds00VRjXf9aAaDg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ctHD9IKRDCzRjYGqE/vENoio9NHHjxv3ciMKRj90hRaF0kdxRHRO8V4PZXYqhZY
 LK+e1BnQj8boTOG6gLR2y9A==
Received: from daedalus.home (unknown [178.231.250.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c791f3d1-afa3-11f1-bd2b-005056abf0db;
	Sun, 13 Sep 2026 20:49:03 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v6 00/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Sun, 13 Sep 2026 20:50:04 +0200
Message-ID: <20260913185016.523376-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian/Neil,

Finally got back from holiday. I know Neil is also attempting to make
changes to the same code paths as the O_CREAT|O_DIRECTORY series touch,
so I hope, now that I have a bit more time, that I can push this
forwards before I have to do more rebasing.

This series implements new semantics for the O_CREAT|O_DIRECTORY flag
combination for open*(2): perform a mkdir and open the resulting
directory; return a pinning fd (which mkdir does not).

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

Jori Koolstra (12):
  fs/namei.c: use trailing_slashes()
  vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
  vfs: lookup_open(): move setting FMODE_CREATED down
  vfs: move ->create check in lookup_open() to before try_break_deleg()
  vfs: lookup_open(): use vfs_create_no_perm()
  vfs: lookup_open(): lock the parent as I_MUTEX_PARENT
  vfs: add O_CREAT|O_DIRECTORY to open*(2)
  vfs: change ->create/->mkdir operations unavailable errno
  vfs: move O_IS_MKDIR check from lookup_open() into individual
    filesystems
  vfs: refuse O_CREAT for directories through a dangling symlink
  vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
  selftest: add tests for open*(O_CREAT|O_DIRECTORY)

 fs/9p/vfs_inode.c                             |   5 +
 fs/9p/vfs_inode_dotl.c                        |   5 +
 fs/ceph/file.c                                |   5 +
 fs/fuse/dir.c                                 |   5 +
 fs/gfs2/inode.c                               |   5 +
 fs/namei.c                                    | 247 ++++++++++-----
 fs/nfs/dir.c                                  |  10 +
 fs/open.c                                     |  32 +-
 fs/smb/client/dir.c                           |   5 +
 fs/vboxsf/dir.c                               |   5 +
 include/linux/fcntl.h                         |   6 +
 include/uapi/asm-generic/errno.h              |   2 +-
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 .../filesystems/open_o_creat_o_dir.c          | 296 ++++++++++++++++++
 .../testing/selftests/filesystems/wrappers.h  |  11 +
 16 files changed, 554 insertions(+), 88 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c


base-commit: 2f0c1cf72f4682178506f513bbf015e591b1aa4a
-- 
2.55.0

