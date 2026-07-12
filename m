Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D6367B9F
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878901; cv=none; b=sqzACqXoOkh3etNNVw4c9xndSyh6T71foUW2UHM93bvmMB+K3Z6J7gtq+NNZvoCrnAkCUZ5VZLk2XuUUTFkve0dxuX/Glo9pCIijZ5yXdaX9jpFxS0aZakRcRvZJ82dTei4QhtZCpw3Qik+tB5vWhuPpVg6zPUG/slMngh1C9FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878901; c=relaxed/simple;
	bh=Gmp49eddTdYUV92s7f6nH6PIauAkiKFwMzz6XbZdzP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBlJAH2bwRxa8UHbBWrhaCp/Gd8eDQAhDhFeQJJY2KWuJl4bEhCboMZ8lYWO+9rkw2qnsW+wB6IYPU/n6facgGVEYYc6fxitbwSu/UpReFeGAv2YcQ41oZktFJrt9m16815PqnmIf7x9xXGeOQfQcdQvWxI4AuLoFv6e3guJamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=oKMPQdUl; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="oKMPQdUl"
X-KPN-MessageId: c88b7fdb-7e1a-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c88b7fdb-7e1a-11f1-9e8e-005056999439;
	Sun, 12 Jul 2026 19:54:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=7yRqcaw5+tY9Flm7LMEr7oKXg8wfm4lEpSXG1AcSENY=;
	b=oKMPQdUlBYmKseO4p/JjXGv56ym8vpI23UkWBs7gWXg7CRHkW6uwZbRBlwKkftD1/WVxRlEkG6LhC
	 DaZPLDdkhLRs9NjWfgBn88H+41ufBBZqUo3lCAvOifxu1UMxopQpc/VrBoCykUzq3uxXQ2jXKrIzEA
	 vgkdCnkxV1SvF57CcW+7HroQK8PEYwMmPIOis6RZY+ykbDb3ccs7ivPe/aY2/lUwG2ri38sM1tmb17
	 5ztYdcGrvvuETXGjFKqowk7kIP1rXk0W5aUKT87Pg5KIUSa0RHZGjc0zK9DOJP+uPjfoeT0KKo7YXr
	 f2I5u0Zss6S0w9CAhPu/nn+Q9/R5Afw==
X-KPN-MID: 33|bJdHKc9l8c40WmY5mk0dH55b4l5wiZcArLU9tqi3jHyvD8h+wB1Fsf4hTHmW1gn
 mjy5G65jQo/yNWsZTz3PyPMp9b4W3fofbkHFt/T/hkQ0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|gkIDK6kHM+jFOGkw9+DZTYIsxB6U999Rs4SaWtSrCFYAFVaaCOmR38mljL6ATFj
 nwoDs6jipV8hX0CQtRH+d/w==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c57546ee-7e1a-11f1-87f7-00505699b758;
	Sun, 12 Jul 2026 19:54:52 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	NeilBrown <neil@brown.name>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 00/10] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Sun, 12 Jul 2026 19:55:29 +0200
Message-ID: <20260712175539.1565444-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements new semantics for the O_CREAT|O_DIRECTORY flag
combination for open*(2): perform a mkdir and open the resulting
directory; return a pinning fd (which mkdir does not).

Most of the work happens in "vfs: add O_CREAT|O_DIRECTORY to open*(2),"
as may be expected. Before that there is some clean-up work and
preparation. The "vfs: short-circuit MAY_WRITE access for O_DIRECTORY
opens" patch is also worth paying extra attention to as it
short-circuits doomed opening of directories as writable. This check for
regular files is now done very late in do_open(), but for
O_CREAT|O_DIRECTORY this is unacceptable as this would create the
directory and then still fail.

Changes:
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

Jori Koolstra (10):
  fs/namei.c: use trailing_slashes()
  vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
  vfs: lookup_open(): move setting FMODE_CREATED down
  vfs: move ->create check in lookup_open() to before try_break_deleg()
  vfs: lookup_open(): use vfs_create_no_perm()
  vfs: add O_CREAT|O_DIRECTORY to open*(2)
  vfs: move O_IS_MKDIR check from lookup_open() into individual
    filesystems
  vfs: refuse O_CREAT for directories through a dangling symlink
  vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
  selftest: add tests for open*(O_CREAT|O_DIRECTORY)

 fs/9p/vfs_inode.c                             |   3 +
 fs/9p/vfs_inode_dotl.c                        |   3 +
 fs/ceph/file.c                                |   3 +
 fs/fuse/dir.c                                 |   3 +
 fs/gfs2/inode.c                               |   3 +
 fs/namei.c                                    | 224 ++++++++++++------
 fs/nfs/dir.c                                  |   6 +
 fs/open.c                                     |  32 ++-
 fs/smb/client/dir.c                           |   3 +
 fs/vboxsf/dir.c                               |   3 +
 include/linux/fcntl.h                         |   6 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 .../filesystems/open_o_creat_o_dir.c          | 201 ++++++++++++++++
 .../testing/selftests/filesystems/wrappers.h  |  11 +
 15 files changed, 419 insertions(+), 85 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c

-- 
2.55.0

