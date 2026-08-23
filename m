Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8032310645
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501227; cv=none; b=OKJ15djlF+HtbzQe3IBxuoWiLVFFWlsk6EYe6U1jNcNSzSC2jekmOnW8HTs+WUhh1+k1Yan6BCxtA+oL38FXHrpteLYVFIjG2BWZlb3UROIEErYVR23PxT+hbIP9TatQPILg3ZLgaVlOCgdeBW1ixmCo40LZCXQqjGvF3pgaWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501227; c=relaxed/simple;
	bh=65l/Jusatq8jUC6SKT+k0Hf6lk+Bb3WtzPdjxH5k1eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gI0y2f3SpcIOXA5gXoRgAd2LzA0TbS24atkpbD6zL70bIKiyvvWxgmbCqq3oAPRdFjOUnmesRxj7CL3084Sw9DeL/3yzDLhmWol290brY6ebHI09L/LqRcZDCI/0mW5ewxRaQTMycp9ClOn6Q3fdGvKsWl4pSthDyyEBcq6W3BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=HbW1F8mh; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="HbW1F8mh"
X-KPN-MessageId: 85a6417b-9f0c-11f1-a5a2-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 85a6417b-9f0c-11f1-a5a2-005056994fde;
	Sun, 23 Aug 2026 18:05:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=MDfCCpMsf92jj5t9dr9Lp8nqlHRzOP2rGbEK6gsycmY=;
	b=HbW1F8mhH3e+h7G/1tlhl2ZtAJjA59wNCElwkMuegCogYoi8vfiBSZdvcqshwsS/9yLu4f23qEhrH
	 mJLAOBRDU0GXk21dz10gaFa4/lyegLBRC7qAJLfmOX89sqeGFawkNj5vWQqCNroYZ1vg2+/7fzvoN/
	 YvhwZPp+1kr75M2KH56qdTrGP3IJlaN+2vDCDs+5v365HW6fOhDZaRAAtaTO6WEsSwRPBFBdP0FGEC
	 HwhaKT62pktACiFkUL8YjQVtjVgrLmERnbJc+1Ul1MmW28Z60bXGkOzkZBQHUp0WnzMsBSswC17jPf
	 e/y8/qYH6g9VjqUkclBBkWAjl8lXbLA==
X-KPN-MID: 33|6DTJD7AxRjJhljsCIvEX6De5Ew9G7e4M4M0MUnG9IU7yfJvMP8g3wIeIj0uFqAS
 ueARKThjdkHZySKz9eRiZkV81cDBl7HzHD4NxB/wS+7Y=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|wYmpkiSF2Mt/dIIoolFtwiMdRRzJukJtvpwTxkEzMGqDkakwes17TxpxtXnA6gy
 D0nQvtntxcpZWeyK0/c4SVg==
Received: from daedalus.home (unknown [178.231.250.211])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 83375e3a-9f0c-11f1-8ddb-00505699d6e5;
	Sun, 23 Aug 2026 18:05:55 +0200 (CEST)
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
Subject: [PATCH v5 00/10] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Sun, 23 Aug 2026 18:06:56 +0200
Message-ID: <20260823160706.358293-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian,

This will come too late for the current merge window (I was travelling),
but I hope we can get this in 7.3. I have rebased the series on 7.2 to
account for the changes Neil made to lookup_open() for implementing
vfs_lookup_open(), and my audit changes.

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
the directory and then still fail.

Changes from vn to v(n+1):
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
 fs/namei.c                                    | 212 ++++++++++++------
 fs/nfs/dir.c                                  |   6 +
 fs/open.c                                     |  32 ++-
 fs/smb/client/dir.c                           |   3 +
 fs/vboxsf/dir.c                               |   3 +
 include/linux/fcntl.h                         |   6 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 .../filesystems/open_o_creat_o_dir.c          | 201 +++++++++++++++++
 .../testing/selftests/filesystems/wrappers.h  |  11 +
 15 files changed, 416 insertions(+), 76 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_o_creat_o_dir.c


base-commit: 66fb95a521110da673090294561844c9f76ebe64
-- 
2.55.0

