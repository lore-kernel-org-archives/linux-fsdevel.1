Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A1395AE7
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740991; cv=none; b=trYCHi9Sr3bIGS12ypmfzvgrulX2e5bHma3cMoAaYlqBZGp7CK8kA2ml4ptbEOYp1A502E2YWOyJCmIGE76qJEx0PcPpsysR5/m8KLXWmGQ7+hASjB/euMzZZiyYl3qIHe9fN9MhzvscSZ5HOlEttc7rIwwiEb5f1Bchb5SE96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740991; c=relaxed/simple;
	bh=MbWp3pk3tt2wd79k8v84WRdKJdh154IaLoYxj+yBtjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KP0pk1HKqq6WTysW5HyhyMcZby2WmRbKRenqgYg+SzmFwnSJ9uxgerzY2qKeLDZtK+VOcXp5hdFRLidbC40OWk/heF0f4gtWQ8f776Mpk8N25oSyQneNIiIpy8Ax799Bh1u8Qi+63OLc9Yq+LBheulEqfi3UinvVxraSqglukRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Ok7XH7tv; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Ok7XH7tv"
X-KPN-MessageId: 50b227af-5878-11f1-afe2-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 50b227af-5878-11f1-afe2-005056994fde;
	Mon, 25 May 2026 22:28:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=KU+a/g+SjpGRWZ83YGxQf44xP5ttht7BWpA9Us9/BGc=;
	b=Ok7XH7tvKQHtXDnSehtjT0aFTvMPSonP9jaElKUgeNnniwppoBh2qWol8uipSTezmrmtrk1GWjou3
	 +VRH5lZ0b385aY1IhiafaO3NWj8FOaTHAGWIR0Mq3EpufTEtc8fqu1Ylkdo/NandNO/dpXawImcdGU
	 kfcv8iBZsJKqJfcZWrOxir08cOiPkVlKC52cEWRwRjqAlPk+ULzd+xA+Wd3/oyzS0UO/I0LjT0RmjY
	 bKtPyRE/cHArtOdBkO7XzTdfYnGcCjxWGN00DsaV+qpxgXrj7xttjJVo7TiQZ+fGOat2yTl0hK54VL
	 jpPb7CltJxFfOkus1H1/ml4ngUTXtqg==
X-KPN-MID: 33|ujxsS43zemqptwyl4hbXrvX3baYAaoHkpzKvGgn7Uo0pabzxyTMjgbPi+FOQbTp
 QsBClOPNYAgk1rt1yYURYqHpBGA7/zYyqkNcZ+EO69Hg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|g6ZLSgGsNYGXJgi3vMw6cmNZMdhMrOAv8CyKUhLUx2e/e69OkJHRCyamfevMoT6
 vaQeITU983E53OkmaMtj+Iw==
Received: from daedalus.home (unknown [178.227.141.192])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 4de7c953-5878-11f1-bffc-00505699772e;
	Mon, 25 May 2026 22:28:39 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cmirabil@redhat.com
Subject: [RFC PATCH v5 0/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Mon, 25 May 2026 22:29:35 +0200
Message-ID: <20260525202937.466497-1-jkoolstra@xs4all.nl>
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

Three comments from me upfront:

- This patch EINVAL bans O_CREAT|O_DIRECTORY in each individual
  atomic_open implementation. An argument to do it in the generic
  atomic_open() in fs/namei.c instead is to give out of tree
  filesystems more time to implement (or block) O_CREAT|O_DIRECTORY.

- If we create a regular file with mknod, before creation
  security_path_mknod() is called, and after creation
  security_path_post_mknod(). If we create a regular file using O_CREAT
  (and this is also pre-patch) only security_path_mknod() is called. Is
  this the correct behaviour?

- open_last_lookups() locks the parent inode like like: 

		inode_lock(dir->d_inode);

  should this perhaps be

		inode_lock_nested(dir, I_MUTEX_PARENT);

  to stay consistent with the start_dirop() path that is used by
  filename_create() for instance in mknod(2)? I get that we are only
  locking one inode here at most, so it does not really matter, but
  now one regular file create path does set the lockdep and the other
  does not.

Changes:
v5: fixed Sashiko reported issues [1]. Moved to EINVAL banning
O_CREAT|O_DIRECTORY in each individual atomic_open implementation
instead of in the generic atomic_open() in fs/namei.c.
v3/4: fixed syzbot reported bugs
v2: don't introduce a new syscall (mkdirat2) but implement this
functionality as O_CREAT|O_DIRECTORY in open*(2).

[1]: 
https://sashiko.dev/#/patchset/20260518165237.2084042-1-jkoolstra%40xs4all.nl

Jori Koolstra (2):
  vfs: add O_CREAT|O_DIRECTORY to open*(2)
  selftest: add tests for open*(O_CREAT|O_DIRECTORY)

 fs/9p/vfs_inode.c                             |   3 +
 fs/9p/vfs_inode_dotl.c                        |   3 +
 fs/ceph/file.c                                |   3 +
 fs/fuse/dir.c                                 |   3 +
 fs/gfs2/inode.c                               |   3 +
 fs/namei.c                                    | 177 ++++++++++------
 fs/nfs/dir.c                                  |   3 +
 fs/nfs/file.c                                 |   3 +
 fs/open.c                                     |  25 ++-
 fs/smb/client/dir.c                           |   3 +
 fs/vboxsf/dir.c                               |   3 +
 include/linux/fcntl.h                         |   2 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   4 +-
 tools/testing/selftests/filesystems/fclog.c   |   1 +
 .../filesystems/open_o_creat_o_dir.c          | 197 ++++++++++++++++++
 16 files changed, 362 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c

-- 
2.54.0

