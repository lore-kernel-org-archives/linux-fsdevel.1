Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC0F31064B
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780251654; cv=none; b=rQ2WqyMVnZj4rftFjgjSHednsTVSKpayJjgaPzmFH/szkHrfFR3iaC07FrjSkUczdSpY8r7IQgVi1sWMSgjRv31mJZ5ibHvIz8glQgb3cHxUV7klzg87cAv/LCT2pVjvQzIxYsx8q0d99yvBbDitWZ+ycaAC8LJtq0NOYjDlnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780251654; c=relaxed/simple;
	bh=P5PPuiKj4n/XyFExSpLMma98NqOeTAuK6k69upGR3w8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djtpZRlo6dsZaAOxqOllloedcXmS6PYcNGGXyqAfbPc/ODeybffIfa/835pHtMw2uAdlYRIULxWjmXGgjrd4mSiGBZ9EE2MjClKib1xDGiQcaetDVv2PrtpMxE5dgMMUKPWAHpUSnd8L9y2KeMWVLe7JUsDH7nZ8sKpv3MkjtaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=q37DNRRp; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="q37DNRRp"
X-KPN-MessageId: 4cb05e35-5d1d-11f1-96a9-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4cb05e35-5d1d-11f1-96a9-005056abbe64;
	Sun, 31 May 2026 20:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=i8BIv4Cj6Dj1dMLP/wxz+R76v8YtmEraZBU7zr1nYbQ=;
	b=q37DNRRpByITRM48zdoufoVIvVPBMyiltMxnLC4M7wluIZcDKdv+EoimfTgHUn9ZZQLlwZIAQe0kj
	 CMYOE3FKkQAzrU0zckchXjdyZZXLLdRLkzLwjvvjhS9DplkDaA5ZxEmtIVq0VJ6e0rvVqfuCxp+2uy
	 lXwz12E6bI2XvumQLs+dRfVSuvKf3XDiBGfd1xA81DZL0dSoEU7NMP8NT35ECUeXE9VXu+FLM4pqOO
	 NcmRLwulVBXihWlYxNRY5yC+LL6byr67RudCiVuS6KxMyuii0tCEHvIaVbf9ypztwaYd+6tHZOpzmn
	 3ry+kGsk3KV5zCKPVaV4w9Z6azLpRZw==
X-KPN-MID: 33|+My5gXP5EIgq9o0ihmybijSf0on7TzkauT2frCYDjKT1NAoi0JRjGNVjU3cm5iO
 SfpDBYhQM23046YPPV/tvChwJDh6Ig+JveCsjkBn2xSI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|qhrbzhT7JIh19jgEbJy+BaElh/MZdtMnlmpQiYkrgcXko/3q1nImjht+rAtdGJe
 TsgEmpEFP5BfxkP5QFat08A==
Received: from daedalus.home (unknown [178.227.141.146])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 49d2fe9f-5d1d-11f1-8011-005056ab7447;
	Sun, 31 May 2026 20:19:44 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Charles Mirabile <cmirabil@redhat.com>
Subject: [RFC PATCH v6 0/9] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Sun, 31 May 2026 20:20:36 +0200
Message-ID: <20260531182045.171711-1-jkoolstra@xs4all.nl>
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

Changes:
v6: split up the series in more steps. Call may_create_in_sticky() also
    for directories. Revert to old errnos on missing i_op functions
    instead of EOPNOTSUPP.
v5: fixed Sashiko reported issues [1]. Moved to EINVAL banning
    O_CREAT|O_DIRECTORY in each individual atomic_open implementation
    instead of in the generic atomic_open() in fs/namei.c.
    v3/4: fixed syzbot reported bugs
v2: don't introduce a new syscall (mkdirat2) but implement this
    functionality as O_CREAT|O_DIRECTORY in open*(2).

[1]: 
https://sashiko.dev/#/patchset/20260518165237.2084042-1-jkoolstra%40xs4all.nl



Jori Koolstra (9):
  fs/namei.c: make lookup_last() use trailing_slashes()
  fs/namei.c: move create error && negative dentry case in lookup_open
    up
  vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
  vfs: lookup_open(): move setting FMODE_CREATED up when calling
    create()
  vfs: lookup_open(): move audit_inode_child() and i_op->create check to
    before try_break_deleg()
  vfs: lookup_open(): use vfs_create_no_perm()
  vfs: add O_CREAT|O_DIRECTORY to open*(2)
  vfs: move O_IS_MKDIR check out atomic_open() to individual filesystems
  selftest: add tests for open*(O_CREAT|O_DIRECTORY)

 fs/9p/vfs_inode.c                             |   3 +
 fs/9p/vfs_inode_dotl.c                        |   3 +
 fs/ceph/file.c                                |   3 +
 fs/fuse/dir.c                                 |   3 +
 fs/gfs2/inode.c                               |   3 +
 fs/namei.c                                    | 213 ++++++++++++------
 fs/nfs/dir.c                                  |   3 +
 fs/nfs/file.c                                 |   3 +
 fs/open.c                                     |  25 +-
 fs/smb/client/dir.c                           |   3 +
 fs/vboxsf/dir.c                               |   3 +
 include/linux/fcntl.h                         |   7 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   4 +-
 tools/testing/selftests/filesystems/fclog.c   |   1 +
 .../filesystems/open_o_creat_o_dir.c          | 197 ++++++++++++++++
 16 files changed, 389 insertions(+), 86 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c


base-commit: 174914ea551314c52a61713b9c4bde9e42d48073
-- 
2.54.0

