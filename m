Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F52C08BC
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183279; cv=none; b=GIIZkYQYMvlSK+p0NlIIXgvN/BRLHK3CL9VOM0vJzAOPF0IRV+N2b73zceKhF2Umw+0VtULpQU2SodfSVOdonOvPjJR8jlUGzDCNsphjGRmbjs3RZs076NwloRwP/4cbtxc5re2YuBlHtpbDnzQauxiG5b9KRTTb4b+WSpCVe1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183279; c=relaxed/simple;
	bh=D3gtxWF/AkKwDeuCUENk1rnewPZVGoZ/Zu+TAg666DM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwV16jta6QRMRWwev/hgY4a73hkF0cy9g3nf2nOKIyJPUgrv044obfjIF8K+DMNp+68C7IznFbo2lE3QZeIcmLhJVA+FSziy5SavXvRCcLBqT7ga/tdVqYGtMpAnaaIGLyHmDMNh5pMxtTa3nqzNvjqg2xY7s1OsSFMk9A2JYEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Hd6LzcNw; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Hd6LzcNw"
X-KPN-MessageId: 27190aa2-77c7-11f1-83b1-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 27190aa2-77c7-11f1-83b1-005056ab378f;
	Sat, 04 Jul 2026 18:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=4KcK7pn2nDx7TEmaI8mvgo0DppWddTtw68XKweuIPzg=;
	b=Hd6LzcNwACwBqWbM8jpDdaydzBaMXLzwd7KG/rvQMrGr3h8KQ4RKVRKLu4h742hAX5UWwpmqBfUY4
	 lhDgcdVFe6KfpcpU5NwNOqpuHPeqlv1jqFHF4ZtM33TyyOcdnsMdp5DKhaLh8uUphDqy4YJa7abs3q
	 ykOcHn8uTSB6kvH6kN9gwXSfaMpBpAHMFxmn44zhiXbeH/d9SMz4u9I48WCGgZkh/+hMHzljzYc0Ph
	 PvPusfnVgPCt1mOeFgGAd/VxP0Cjdl97p9Lc++RRlmMt1OoB8vceJWe8jNaj61KxgOH6bMe0c98AZY
	 bCgigaoMnHwNGWGSXEP8NUEf5LAWd8g==
X-KPN-MID: 33|m5zfoPceBSmAMGGbbvu8pZjRbjZDlqsengtGEgeh8ls/1t6ST/Hx2vltdAQMG8l
 Itvcol55XbbUBSDOtDJuI+aBCQ6wS3EQgLM7hm2H9srw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|zV0jdeTVnY6NbCPr9P6fr+gEGAK+lx1N55tV4GcQFDwJm0/EZu1UAEecJh5dmZ7
 dmwwE7vXiF3DsWYm/If+YsQ==
Received: from daedalus.home (unknown [178.230.195.42])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 23fde80b-77c7-11f1-a998-005056abf0db;
	Sat, 04 Jul 2026 18:41:06 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v3 00/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Sat,  4 Jul 2026 18:41:34 +0200
Message-ID: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
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
preparation. Also, the inconsistency in calling audit_inode_child() in
lookup_open() versus vfs_create() path is addressed. The
"vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens" patch is
also worth paying extra attention to as it short-circuits doomed opening
of directories as writable. This check for regular files is now done
very late in do_open(), but for O_CREAT|O_DIRECTORY this is unacceptable
as this would create the directory and then still fail.

Jori Koolstra (14):
  fs/namei.c: use trailing_slashes()
  vfs: move create error && negative dentry case in lookup_open() up
  vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
  vfs: call audit_inode_child() in lookup_open() on failure too
  fs/namei.c: update docstring of atomic_open()
  vfs: lookup_open(): move setting FMODE_CREATED down
  vfs: move ->create check in lookup_open() to before try_break_deleg()
  vfs: lookup_open(): use vfs_create_no_perm()
  vfs: add O_CREAT|O_DIRECTORY to open*(2)
  vfs: move O_IS_MKDIR check from lookup_open() into individual
    filesystems
  vfs: refuse O_CREAT for directories through a dangling symlink
  vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
  selftest: fix headers in fclog.c
  selftest: add tests for open*(O_CREAT|O_DIRECTORY)

 fs/9p/vfs_inode.c                             |   3 +
 fs/9p/vfs_inode_dotl.c                        |   3 +
 fs/ceph/file.c                                |   3 +
 fs/fuse/dir.c                                 |   3 +
 fs/gfs2/inode.c                               |   3 +
 fs/namei.c                                    | 313 ++++++++++++------
 fs/nfs/dir.c                                  |   6 +
 fs/open.c                                     |  32 +-
 fs/smb/client/dir.c                           |   3 +
 fs/vboxsf/dir.c                               |   3 +
 include/linux/fcntl.h                         |   6 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 tools/testing/selftests/filesystems/fclog.c   |   4 +-
 .../filesystems/open_o_creat_o_dir.c          | 197 +++++++++++
 15 files changed, 463 insertions(+), 119 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c

-- 
2.55.0

