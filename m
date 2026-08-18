Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D13AB47E;
	Tue, 18 Aug 2026 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055692; cv=none; b=bRiGKhL+ivQdf0hy11O9ZHFByZ3h6oJqwU8tlISND3N/Pu5R0wWrfcP3CzVvOzm9qU/lim6ZKAzS5FbHoXosDvz1+KOwgeTPX3OduAnajMl1XrZ8ztpdaUR+4dtnbgXBzvxb8kJBbpd3j0NXPkkvaSsKKJDXw8P1lfcyzGli5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055692; c=relaxed/simple;
	bh=Gf2rSQ6n/22wl6Tsvb6bhAtD3MU0szXJScoUwLmKEoo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jrU5uaz8sV/fMJyqPU6Ml2xeAz7652Nnx7q6qwIqt3yZpnMwPdPI6CENIEcL149b1P37xricMPIHjwN4/C6lwHwMjOq1owMDtWCEz47Z8UtBXqAtzsv2b6WRF5DPyhSSV8zOu5nV/jB5BIfPa6ZmDe8Y1MgmPQQjWXArx5sUW1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=M7kZX+F9; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="M7kZX+F9"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 029861D2F;
	Tue, 18 Aug 2026 12:22:13 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=M7kZX+F9;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id CB5D01D99;
	Tue, 18 Aug 2026 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1787055683;
	bh=Gw/pU8kOBaahxBGBQYamTKScx0sYad3gegHjlLNv49o=;
	h=From:To:CC:Subject:Date;
	b=M7kZX+F9gBIwJgppFccb8p29ezeAwhYoKEQmXj1W3Aa1YiCdYKblxiuijXkUwKuL+
	 hGbCiA8nuiXza1HpchE8xz7rKAY6ud2v79xwsmNNpJxxcfnYoxD59RaBkoFsaOtRih
	 DSQ5gkTDE2CXkXEAEXI8RTzJeK1Svj+IJcpzmDcI=
Received: from localhost.localdomain (172.30.20.186) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 18 Aug 2026 15:21:20 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	=?UTF-8?q?HE=20WEI=EF=BC=88=E3=82=AE=E3=82=AB=E3=82=AF=EF=BC=89?=
	<skyexpoc@gmail.com>, Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>, Kyle Zeng <kylebot@openai.com>,
	Ruoyu Wang <ruoyuw560@gmail.com>, Samuel Page <sam@bynar.io>, Senjin
	<senjin@hatchling.org>, Weiming Shi <bestswngs@gmail.com>, Weiming Wu
	<weiming3@asu.edu>, Xiang Mei <xmei5@asu.edu>, Zhan Xusheng
	<zhanxusheng1024@gmail.com>
Subject: [GIT PULL] ntfs3: changes for 7.3
Date: Tue, 18 Aug 2026 14:21:03 +0200
Message-ID: <20260818122105.24094-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Hello, please pull this branch containing ntfs3 code for 7.3.
 
Regards,
Konstantin

----------------------------------------------------------------
The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.3

for you to fetch changes up to c22f91d82cb9a29d22bdffdce6c803467984ad0c:

  fs/ntfs3: validate ef->size covers the record's name and value (2026-08-18 10:35:39 +0200)

----------------------------------------------------------------
Changes for 7.3-rc1

Added:
    load ATTR_BITMAP run extents from $MFT extension records
    initialize err in attr_wof_frame_info
    reserve NUL byte when converting UTF-16 names
    reject restart table growth beyond U16_MAX entries
    validate dirty page table on log replay
    basic support for alternative data streams
    validate ef->size covers the record's name and value

Fixed:
    slab-out-of-bounds write in ni_create_attr_list()
    out-of-bounds read of INDEX_ROOT in reparse/objid init
    boundary check in ntfs_dir_count()
    info-leak in ntfs_rename()
    lseek EINVAL on sparse/compressed files with 64-bit clusters
    info-leak on partial LZNT decompress in ni_read_frame()
    bound page_lcns[] index by the log record
    memory leak in indx_find_sort()
    integer overflow in MFT cluster validation
    reject out-of-range evcn in mi_enum_attr()
    out-of-bounds read in read_log_rec_buf()

Changed:
    widen inode/record number storage to u64
    cosmetic fixes and improvements
    rename 'err' to 'ret' in read paths

----------------------------------------------------------------
HE WEI（ギカク） (1):
      fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()

Konstantin Komarov (10):
      fs/ntfs3: widen inode/record number storage to u64
      fs/ntfs3: cosmetic fixes and improvements
      ntfs3: fix boundary check in ntfs_dir_count()
      ntfs3: fix info-leak in ntfs_rename()
      fs/ntfs3: load ATTR_BITMAP run extents from $MFT extension records
      fs/ntfs3: bound page_lcns[] index by the log record
      fs/ntfs3: Fix memory leak in indx_find_sort()
      fs/ntfs3: Rename 'err' to 'ret' in read paths
      fs/ntfs3: Add basic support for alternative data streams
      fs/ntfs3: fix out-of-bounds read in read_log_rec_buf()

Kyle Zeng (1):
      fs/ntfs3: reserve NUL byte when converting UTF-16 names

Ruoyu Wang (1):
      ntfs3: initialize err in attr_wof_frame_info

Samuel Page (1):
      fs/ntfs3: fix info-leak on partial LZNT decompress in ni_read_frame()

Senjin (1):
      fs/ntfs3: fix lseek EINVAL on sparse/compressed files with 64-bit clusters

Weiming Shi (2):
      fs/ntfs3: reject restart table growth beyond U16_MAX entries
      fs/ntfs3: validate ef->size covers the record's name and value

Weiming Wu (1):
      fs/ntfs3: fix out-of-bounds read of INDEX_ROOT in reparse/objid init

Xiang Mei (1):
      fs/ntfs3: validate dirty page table on log replay

Zhan Xusheng (2):
      fs/ntfs3: fix integer overflow in MFT cluster validation
      fs/ntfs3: reject out-of-range evcn in mi_enum_attr()

 fs/ntfs3/attrib.c   | 159 +++++++++++++++++-----------
 fs/ntfs3/attrlist.c |  15 ++-
 fs/ntfs3/dir.c      | 132 ++++++++++++++++-------
 fs/ntfs3/file.c     |  66 ++++++++----
 fs/ntfs3/frecord.c  | 199 +++++++++++++++++++++++++++++------
 fs/ntfs3/fslog.c    |  68 +++++++++---
 fs/ntfs3/fsntfs.c   |  34 ++++--
 fs/ntfs3/index.c    |   8 +-
 fs/ntfs3/inode.c    | 298 +++++++++++++++++++++++++++++++++++++++++++++-------
 fs/ntfs3/lznt.c     |   4 +-
 fs/ntfs3/namei.c    |  64 +++++++----
 fs/ntfs3/ntfs.h     |   3 +-
 fs/ntfs3/ntfs_fs.h  |  51 ++++++---
 fs/ntfs3/record.c   |  34 +++++-
 fs/ntfs3/run.c      |   9 +-
 fs/ntfs3/super.c    |  38 +++++--
 fs/ntfs3/xattr.c    |  22 ++--
 17 files changed, 922 insertions(+), 282 deletions(-)
