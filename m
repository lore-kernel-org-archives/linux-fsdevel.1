Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5D4192E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747411; cv=none; b=erUYLP5AsH8UOcLf1lGOTt4tqV31sXI86dqWYtzgeg9xmPahtOYME+3I42or9p/BOpNMX62iDvKiymnNoXWR3kSqRoMDuzayCHRz5f/bSZDmO/UtlcqLJCH4dNlSXlAbmnr/HG5CMRAVO5ejFYtfjp9tfm+oVjgWk6F/FpjlYVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747411; c=relaxed/simple;
	bh=2eATAG7R4ZWY4Dx3/NpLmmYwmyI4awTULFQ8AJofxm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ny8+9U+zld4ucIWyG/Y9s1kqIStrP0GIbOOcttx1G6RJX8Jk4Vex+Wz+7frFKBl69IeJRgsa1Bd43Fh7MeZD7JhVV5SikOeBvR2NoJgayhjfatGzfqTmbpIaBlcIjBTpv7uPCWhvsXc/nLA5kohzgqmuxcn/1kr6qHHcwH1VjFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=LDRtkWwl; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="LDRtkWwl"
X-KPN-MessageId: 30196889-73d0-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 30196889-73d0-11f1-bfba-00505699b430;
	Mon, 29 Jun 2026 17:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=vlvXrHOB2EnpBeMBZ+xGD2T8jeG3IQHbBLzaNvuL1fA=;
	b=LDRtkWwlpbQfUkt+jW47wkTTjAbXN4IP2CqGpSpJ2On2hdrMfooFyhQyKmMmOLzWuufXdCtCf5NLX
	 ZPpMimhwhdSvb+kGWtHwm82GEufarekO/OffJFsRBnRz0kK5XTo0bQ1eXlWpihGgFoAIKp2yn3rgQ1
	 5BJ05s59z/D96LjEkQAGMMvFThjE2aa6GSOGFKRK6cjM1Dks80o/fUYucTlNNnAYY5kGEdj0Qbo7iV
	 ga5QJeJesN+ZGsi0ns2JKqt+bIu+LSrZvkwNZFKeL3V6aMiegFSvoFK+cSj7KpLKV+TIGjSnm+tkXi
	 W6eK0utgzS/VtT+1xSenN4NdlcjLQ/Q==
X-KPN-MID: 33|r/16Rve8fLQRSGu/Gj3+1CU+/zAwV3drs6tHip9DhkqRr2mIxYDkSuQcLvolFYe
 r3U91CPOQb9ntuTpf1xZJQ0eRfupI6paVWn7nUVOKuIk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|boZMfIVEzOzQjHt97LjoJH24qi1j3jLJdQalCmwBKMjcMMvfoQ1JtjVR9N4hOqV
 Ds7in5Wo0T3FIFf91dUA0Iw==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2d156f16-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:42 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neilb@suse.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 00/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Mon, 29 Jun 2026 17:36:16 +0200
Message-ID: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
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

Jori Koolstra (14):
  fs/namei.c: use trailing_slashes()
  fs/namei.c: move create error && negative dentry case in lookup_open
    up
  vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
  vfs: call audit_inode_child() in lookup_open() on failure too
  fs/namei.c: don't dput() when atomic_open() errors
  vfs: lookup_open(): move setting FMODE_CREATED down
  fs/namei.c: lookup_open(): move i_op->create check before
    try_break_deleg()
  vfs: lookup_open(): use vfs_create_no_perm()
  vfs: add O_CREAT|O_DIRECTORY to open*(2)
  vfs: move O_IS_MKDIR check out atomic_open() to individual filesystems
  vfs: refuse O_CREAT for directories through a dangling symlink
  vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
  selftest: fix headers in fclog.c
  selftest: add tests for open*(O_CREAT|O_DIRECTORY)

 fs/9p/vfs_inode.c                             |   3 +
 fs/9p/vfs_inode_dotl.c                        |   3 +
 fs/ceph/file.c                                |   3 +
 fs/fuse/dir.c                                 |   3 +
 fs/gfs2/inode.c                               |   3 +
 fs/namei.c                                    | 291 ++++++++++++------
 fs/nfs/dir.c                                  |   6 +
 fs/open.c                                     |  32 +-
 fs/smb/client/dir.c                           |   3 +
 fs/vboxsf/dir.c                               |   3 +
 include/linux/fcntl.h                         |   6 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 tools/testing/selftests/filesystems/fclog.c   |   4 +-
 .../filesystems/open_o_creat_o_dir.c          | 197 ++++++++++++
 15 files changed, 447 insertions(+), 113 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

