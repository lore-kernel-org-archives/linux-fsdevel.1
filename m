Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F03F5BF1
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816933; cv=none; b=PBRyoxCyNPvamozdlj8N3Yhg3dmT4q1X/JxOekuRY8bhnBZUAyzgvaLzzA4wpsaO9vbfVpd8sbzv9PqZBCyE5VTiQ+S84KWF2QH5aovqjbt4NGJ9NHHFEYczkcEp5/bRaK6KgR2B8D3sCz8zJv9TP+F+HMtGnW043PIOcc6fxrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816933; c=relaxed/simple;
	bh=rKcsLXtf82MUUOCEfokeX2It5z2o+ghnsHYIP+7xndo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnR2G7Dh4nPU2VxNnvVo1HkH7XJudb26iMiIsQisDxsrjkigtqEcBfpMqzndcNJADm2n6ASIHJOYWVr5IHFJtVu3DMS9VaWoa1dqRHSRiP94RzqaQe/pfIfYxavFB6otmbA9qYHAUMmctsBx1G0JYfSwXC1Q4YH16KQLwWfLQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ZXe7t0at; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ZXe7t0at"
X-KPN-MessageId: 0b79b4b6-7472-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0b79b4b6-7472-11f1-a055-005056abad63;
	Tue, 30 Jun 2026 12:54:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=GnsH9SRIgEHrMLM2sYIuvjSa/m55FKVnWT/qX9HiudU=;
	b=ZXe7t0atyHAJj0a8v223BRH0PAtgMUfcOkDK8Jn3r4GFVdSzSoMxeW0NrSmPhyxF38yI4QYWFJcKQ
	 4bB+neS/m95VWtsZcQhm+yd//ILj1T3tSQJ1J8d25DQuiincLM+BqzNrH0TtQr0BRl4zCQUZMMA4HN
	 ETJvvDbo2dUtOOxraODDh3ctWz9eGPpWaEeyZTwfSvSg/zD25C1gj+G33yjnk9N9QZWTcU6/0HGJTv
	 wx3tvofRmuff3808KHEXNZzNwDyxhJsTpMIEdcyQCJNoU9qP1Y18T7cbteZujpjycgBY5Yc/0RNJ8O
	 5fz1kfBuP+3T9Oy/kaD/Sd7HuxOtRcw==
X-KPN-MID: 33|c846QUfeY9ZddxtJtC5RSSvoA1jZgrXmcd+opjHUQcAKvAhB8Mp70687z1nBtfx
 nRkIl9vKa7WIT+q0VlgNh+usDZSFOlpuU7/1chkthJxo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|3lC70oNEmQTbuPjXAUk4MQYL/IIwhRptpQdVODTJIQ6xG+ayNMqbbixV+oESTQg
 qkgUv6OlZaKmCQk9+f0wCnQ==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0838808c-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:19 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 00/31] vfs: pass S_IFDIR mode to vfs_prepare_mode()
Date: Tue, 30 Jun 2026 12:53:29 +0200
Message-ID: <20260630105400.68459-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a comment in vfs_prepare_mode() that says:

Note that it's currently valid for @type to be 0 if a directory is
created. Filesystems raise that flag individually and we need to check
whether each filesystem can deal with receiving S_IFDIR from the vfs
before we enforce a non-zero type.

It is useful to do this clean-up ahead of O_CREAT|O_DIRECTORY.
Specifically, in lookup_open() we need to replace the vfs_prepare_mode()
with something that also handles dirs. I don't really want to push the
odd

    mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);

further into that code, and neither do I want this to be different from
the regular vfs_mkdir() path. We can then also match on S_IFMT in
may_o_create(), instead of passing a bool to signal whether we are
creating a dir (and assuming 0 means a dir is really ugly).

It is a bit challenging to verify that passing S_IFDIR is safe, as there
are many filesystems. Claude Opus 4.8 was used to generate the context
for each mkdir implementation from which it can be judged whether
passing S_IFDIR is OK. The result was then verified by hand by looking
at how the mode argument is used in each case. To check whether all
mkdir implementations are covered, 'rg "\.mkdir" ' was used and checked
against the list of uses Claude found.

It is safe to do this clean-up except that three filesystems (fuse,
cifs, and coda) forward the mkdir @mode unchanged to something outside
the kernel. Mask S_IFDIR back out in coda_mkdir(), fuse_mkdir() and
cifs_mkdir() so that what is sent outside the kernel is unchanged.
Their maintainers can drop the mask once they have confirmed it is safe.
For the other filesystems redundant S_IFDIR OR'ing is dropped.

Jori Koolstra (31):
  vfs: pass S_IFDIR mode to vfs_prepare_mode()
  9p: drop redundant S_IFDIR from mkdir
  affs: drop redundant S_IFDIR from mkdir
  afs: drop redundant S_IFDIR from mkdir
  autofs: drop redundant S_IFDIR from mkdir
  btrfs: drop redundant S_IFDIR from mkdir
  ceph: drop redundant S_IFDIR from mkdir
  ext2: drop redundant S_IFDIR from mkdir
  ext4: drop redundant S_IFDIR from mkdir
  f2fs: drop redundant S_IFDIR from mkdir
  gfs2: drop redundant S_IFDIR from mkdir
  hfs: drop redundant S_IFDIR from mkdir
  hfsplus: drop redundant S_IFDIR from mkdir
  hpfs: drop redundant S_IFDIR from mkdir
  hugetlbfs: drop redundant S_IFDIR from mkdir
  jffs2: drop redundant S_IFDIR from mkdir
  jfs: drop redundant S_IFDIR from mkdir
  minix: drop redundant S_IFDIR from mkdir
  nilfs2: drop redundant S_IFDIR from mkdir
  ntfs3: drop redundant S_IFDIR from mkdir
  ocfs2: drop redundant S_IFDIR from mkdir
  ocfs2: dlmfs: drop redundant S_IFDIR from mkdir
  omfs: drop redundant S_IFDIR from mkdir
  orangefs: drop redundant S_IFDIR from mkdir
  ramfs: drop redundant S_IFDIR from mkdir
  udf: drop redundant S_IFDIR from mkdir
  ufs: drop redundant S_IFDIR from mkdir
  nfs: drop redundant S_IFDIR from mkdir
  ubifs: drop redundant S_IFDIR from mkdir
  xfs: drop redundant S_IFDIR from mkdir
  ntfs: drop redundant S_IFDIR from mkdir

 fs/9p/vfs_inode.c      | 2 +-
 fs/9p/vfs_inode_dotl.c | 1 -
 fs/affs/namei.c        | 2 +-
 fs/afs/dir.c           | 2 +-
 fs/autofs/root.c       | 2 +-
 fs/btrfs/inode.c       | 2 +-
 fs/ceph/dir.c          | 1 -
 fs/coda/dir.c          | 7 ++++++-
 fs/ext2/namei.c        | 2 +-
 fs/ext4/namei.c        | 2 +-
 fs/f2fs/namei.c        | 2 +-
 fs/fuse/dir.c          | 8 ++++++++
 fs/gfs2/inode.c        | 2 +-
 fs/hfs/dir.c           | 2 +-
 fs/hfsplus/dir.c       | 2 +-
 fs/hpfs/namei.c        | 4 ++--
 fs/hugetlbfs/inode.c   | 2 +-
 fs/jffs2/dir.c         | 2 --
 fs/jfs/namei.c         | 2 +-
 fs/minix/namei.c       | 2 +-
 fs/namei.c             | 7 +------
 fs/nfs/dir.c           | 2 +-
 fs/nilfs2/namei.c      | 2 +-
 fs/ntfs/namei.c        | 2 +-
 fs/ntfs3/namei.c       | 2 +-
 fs/ocfs2/dlmfs/dlmfs.c | 2 +-
 fs/ocfs2/namei.c       | 2 +-
 fs/omfs/dir.c          | 2 +-
 fs/orangefs/namei.c    | 2 +-
 fs/ramfs/inode.c       | 2 +-
 fs/smb/client/inode.c  | 7 +++++++
 fs/ubifs/dir.c         | 2 +-
 fs/udf/namei.c         | 2 +-
 fs/ufs/namei.c         | 2 +-
 fs/xfs/xfs_iops.c      | 2 +-
 35 files changed, 51 insertions(+), 40 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

