Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6E3BB69A;
	Wed, 16 Sep 2026 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549822; cv=none; b=CvSj85aRspnfzFQ6ub5RJ+cViJxRTAgODnYTyVPwYGPD4zJlRabGYSP0qQc0HYn2amxQNE06CARo9Nlaz7wQNUhMZQbjcKi+mK3v6hZnsTK+jF/IQMU+vKwcomvYkEBsDZQPl9g/joKvFezuHz1hwRnoTU+7BDnBeuWHBYL6/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549822; c=relaxed/simple;
	bh=3l4L+12TqPxPoIbkfReRDGgXM9Hl0sPvjnQqrdSEvtU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=JUPV00LEjLr8Fe5C/Dx58qVLQQsnQ7tXXJ/zidcIM2TPaIygc+sY+pZo/nZvassbUiFFcBdNwc6QoUkXKHjMqS8heLOfsVAauQ41C9RyhmoxrnzFO0aLS+yInHg70ZlkJylmL9HPblJB4A2JqxTqSt6+1JVaTlaHNND5sZ+VbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CwusOGzY; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CwusOGzY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1789549799; bh=uexswBwLq71x1NaD3JnEGJZAfUbja5b9Uucd3D81usM=;
	h=From:To:Cc:Subject:Date;
	b=CwusOGzYZZtUjVWPzJHZvRpI2fOpxNTfChQ5hHhzZEniEab32TtHHJp5U02GV1SGY
	 TEvsKbW1bo6LHmOJm++5lLv5XWyIBI6v3oFeqoUZ83s+ZOASx1MQupt21a6wTfvUHW
	 NQlBtND6awuRHL39IbKHUkPpRC85ot92ZjkikjNc=
Received: from WIN-U8J9BGQPJ22 ([61.136.26.125])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 277B8E5A; Wed, 16 Sep 2026 17:09:55 +0800
X-QQ-mid: xmsmtpt1789549795tlfyoknkz
Message-ID: <tencent_24D928451FEFA8A35482EFFA9132A7305307@qq.com>
X-QQ-XMAILINFO: MqG4KXyEKpQymgVBiGLJdwL6G/klle7eS9J0OwljW0bjYLKOWnWf0aFNP+9weE
	 V3O0Q8/a6Bp4QUTNwehf/0bdNXzsyuwFH8gFo4ZUgapNDNuctbcyeMpqPo302noVjzW55xTK/5KN
	 NPPhVt6B+e0u8owURMVI7IkmuK0J8IZoEh/WfY2F19faaOFzlns3OhcK54+A9CM9VKUakYPRUHeg
	 PpRcCCe9jEODtqSwsT69WhXMl4LJX4eOHFq61FQLnHhg2QspDPzpepV6jM7Xdzq1e4iDJv8wQOai
	 RtmxsXYGKekV7YFL5529S+mSb+3ZlyFZuhDCgb7vwPu/T4TqRUmEIgFGM5csV6RTi6Wrstzqjac7
	 ktVkNhEX9LAbbbyji18zk+XNTB73cyORuqXUm/zJpoRY2KNLco+bQ0bALVmAOQ2jUvbUyqCteD0Q
	 0lrEstFq1xFhFOWbUBdDWpnkSDvH6nVR+TBrZ4NfPgF/M4l/sAdo17Us5pcHCO0pdqnF2W5OhcHE
	 QvDCpo8552k7mQOifTuGs2YII9kfx5cMOZ/dYksX1rxZXW3UgYxCNy3Q+RzgvLJEeBF+aSrrzzjW
	 K3Q/+xD98GD50LTTSJU1p+NPTDpLXeIqdMc2aVcGGItih+Ecoqv7pNSRIQ6s9xuh30ifdLBYfs+R
	 2WFS36K9QVQjWPMXeWYl9Msv8uZ6gdCqBpt43HjZLRe/om7IpJ3VWn/Fam7FF2dvybJ4Cl46IFGL
	 wEmx/7Ek9YCUExn33zhRo9KqKngiX4AmDjiO7jYOUpuyujzRaXRUQaywPJz0abCHnDFOxRj1Fhfh
	 xSdvowzm8jEoG+jr2O6bVOI9Sj6eeZ5j0vK4TRFQD5PJPYTrQlqXPxE01rT+V8HJONO4DcC1oQX7
	 /R5nb6SCWRlWOl8uYlzZLP+HfxUjTtgqEjlQECUWNhDP+ObsNwgHyEcgA2PjVoslC6p/4OVS7htf
	 x60vkg0OGqg8Ze769SvBSBrPF0sXg2nwqcyHafC7exfg5waj9VKK3/91JHSOZlVE5AHoWMBuTnbn
	 crpO9X/8tNLwKazggLjPQ7+1i4brpKH9hgrdR60+mgtZmmI93Ry1sAdSshv3d16v5DoMUxtQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: 1sh1ro <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: 1sh1ro <yangguikun19@qq.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [BUG][PATCH 0/1] hfs: crafted image aliases typeless internal B-tree inode into VFS open path -> kernel BUG in may_open()
Date: Wed, 16 Sep 2026 17:09:53 +0800
X-OQ-MSGID: <20260916080000.0-hfs-fix@localhost>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

While fuzzing mainline v7.2-rc7 (KASAN + lockdep + CONFIG_DEBUG_VFS=y)
we hit a deterministic panic-class kernel BUG in the generic VFS open
path, reachable through the HFS filesystem with a single crafted image:

  VFS_BUG_ON_INODE(!IS_ANON_FILE(inode)): inode:ffff8880206c5740
    fs:hfs mode:0 opflags:0xc flags:0x0 state:0x0 count:2
  ------------[ cut here ]------------
  kernel BUG at fs/namei.c:4271!
  RIP: 0010:may_open+0x2ba/0x480 fs/namei.c:4271
  Call Trace:
   do_open fs/namei.c:4698 [inline]
   path_openat+0x1600/0x3de0 fs/namei.c:4863
   do_file_open+0x216/0x470 fs/namei.c:4892
   do_sys_openat2+0xe8/0x250 fs/open.c:1368
   __x64_sys_openat+0x13f/0x1f0 fs/open.c:1385

Root cause (verified against source):

  1. hfs_btree_open() (fs/hfs/btree.c) creates the extents/catalog
     B-tree inodes with iget_locked(sb, HFS_EXT_CNID / HFS_CAT_CNID)
     and never assigns a file type; hfs_inode_read_fork() does not
     touch i_mode either.  Both internal inodes therefore stay cached
     with i_mode == 0 after every mount.

  2. A crafted catalog record whose DirID/FlNum equals 3 or 4 makes
     hfs_lookup() -> hfs_iget() -> iget5_locked() return that cached
     inode (hfs_test_inode() only compares i_ino), bypassing
     hfs_read_inode() entirely.

  3. openat() on the resulting dentry reaches may_open() with no
     S_IFMT bits set, hits the 'default:' case added by the
     CONFIG_DEBUG_VFS series (1e7ab6f67824) and panics.

Note on visibility: with !CONFIG_DEBUG_VFS the assertion compiles away,
so the same image merely yields an openable typeless inode - which is
presumably why this has never shown up on syzbot.  Current mainline
(7.3-rc) still carries the unfixed hfs code; the issue is not
regressed, it is simply old.

Patch [1/1] fixes it in two steps:

  - hfs_btree_open(): give the internal B-tree inodes an S_IFREG type,
    restoring the VFS "valid inode type" invariant for every cached
    inode no matter what the image contains;

  - hfs_iget(): refuse catalog records addressing the reserved B-tree
    CNIDs (NULL per the existing convention: mount failure / -EACCES).

A self-contained syzkaller reproducer (embeds the crafted image,
triggers in under a second) and the full C repro are available on
request.

Environment:

  Kernel: 7.2.0-rc7-00232-gdcb68831eac7 (v7.2-rc7 based)
  Config: KASAN (inline), KCOV, lockdep, CONFIG_DEBUG_VFS=y, SMP PREEMPT
  QEMU (KVM), x86_64

Best regards,
1sh1ro

