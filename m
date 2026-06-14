Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95A399364
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455433; cv=none; b=toZI+s+/0B8DOBHxpLAfXoMLhFvIVKhZUilWiObi6VjMnv2hqSi7wSRHK+usXrtjNEBg/Z0zGUuapIrFkgZ2hHO0C6giNuIM/ZTu3y2CA7G2aCV9YSsYFh6z4vZTwstyVGXwOF5YL8Ogv5AaUBNwTnfQSxb94iYjZCcGrX/elJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455433; c=relaxed/simple;
	bh=tlSu4MjIb4X8JpXuQHMAWXXgKm8JORIcy+r2YbwhwBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rIOxD7NJ1OtrKoClL5wB2u/6gcJob9dmXv92vtkiQB91DdUO8IiMA9yG+CEtYBoS7Nm11lcn8ZzicDc6sd75duX9mGo4GNs8kIcY0F98i+kjmGMKqq8vvkqrWV/KmhFkrzf9QTr/EN5UR/LXibnZYozYLjdkm7zldCEXz2ZfZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ec8EpSpB; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ec8EpSpB"
X-KPN-MessageId: 335da435-6810-11f1-96a9-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 335da435-6810-11f1-96a9-005056abbe64;
	Sun, 14 Jun 2026 18:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Y8fTMg8yZtz3wdacP+nbSpzZnvA1DwhDeFRKe/x1h5Q=;
	b=ec8EpSpBPzhH+Cdo2nofCsmqEpCSO9an3o93urKOo6GOsjBEe6K7YnanBoOapWoBQUEv9voerik3L
	 zMsCl+ZS11Vw/QDy8PjKZUY6Ab40CW/PYaGeUrNlLXolboloJmI2XfA8oxgxGgq+bcwAQgX/z+/rfz
	 kfwa3CttGWjQWQMcSTcAm5fgdhqP5A7I9yqxqvQ5YZsoCHNFouvJus3+bnMGNl8BHLt4bXZLSJo0dX
	 0nO9Jh1efnQiTNpdIke5SR7RqtfmGgTtFf7jXntd0ZNLbUgT2eFDr1BDp5E5sVSFJUHmnDBustILI2
	 fmImK+LyA4j/KEQfh1LTUrWdkXUp53w==
X-KPN-MID: 33|XzFehU8qq2G/H+Av7IQKkRMZY364Out/6wl9yzsMDPlKYo14flytBS71qB/bQH5
 7iUN1+MGd+Zsg6LEM+LlPXu/xdWnXZkuS6q8dfKzEuOI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|vZXOIrA4Qqvg/c5eufsnvJFK4iX5IEv5oVKlDpVSei9nkdINj1tnbB9Zmz1Z3me
 VGFimZuxo6WDzq8dJSQZhnQ==
Received: from daedalus.home (unknown [178.230.193.94])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 303ee111-6810-11f1-8011-005056ab7447;
	Sun, 14 Jun 2026 18:43:41 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 00/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Sun, 14 Jun 2026 18:44:26 +0200
Message-ID: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
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

Jori Koolstra (12):
  fs/namei.c: use trailing_slashes()
  fs/namei.c: move create error && negative dentry case in lookup_open
    up
  vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
  fs/namei.c: lookup_open(): move audit_inode_child() up
  vfs: lookup_open(): move setting FMODE_CREATED up when calling
    create()
  vfs: lookup_open(): move i_op->create check to before
    try_break_deleg()
  vfs: lookup_open(): use vfs_create_no_perm()
  vfs: add O_CREAT|O_DIRECTORY to open*(2)
  vfs: move O_IS_MKDIR check out atomic_open() to individual filesystems
  vfs: refuse O_CREAT for directories through a dangling symlink
  vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
  selftest: add tests for open*(O_CREAT|O_DIRECTORY)

 fs/9p/vfs_inode.c                             |   3 +
 fs/9p/vfs_inode_dotl.c                        |   3 +
 fs/ceph/file.c                                |   3 +
 fs/fuse/dir.c                                 |   3 +
 fs/gfs2/inode.c                               |   3 +
 fs/namei.c                                    | 233 ++++++++++++------
 fs/nfs/dir.c                                  |   3 +
 fs/nfs/file.c                                 |   3 +
 fs/open.c                                     |  32 ++-
 fs/smb/client/dir.c                           |   3 +
 fs/vboxsf/dir.c                               |   3 +
 include/linux/fcntl.h                         |   7 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   4 +-
 tools/testing/selftests/filesystems/fclog.c   |   1 +
 .../filesystems/open_o_creat_o_dir.c          | 197 +++++++++++++++
 16 files changed, 413 insertions(+), 89 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.54.0

