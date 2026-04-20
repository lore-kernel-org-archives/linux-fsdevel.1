Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603D33EAE6;
	Mon, 20 Apr 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697696; cv=none; b=RLqbTq1k06eJ3vJNZtF+H8djsKSuFbHczRkH9d+Zv0t5FEs4yUukCwao9IGDSeyTtYGj0MR3FTIY2QhpYHP4K5zrl2oS74fnaTU5cMCOqB/BZbZC1DbWu7N7+XmjLVjJnueh2Ex5JG3UJc0Y5eomcS7FZGLbXLge0eUqc5a7M8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697696; c=relaxed/simple;
	bh=UvQOoLe2BqaTbJEaNvc2TaTpD8cCUZraZvH4CdwoXzU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D/E4vDJaZdTyXEFaiERycI5fSbN8NbRwXbIGxGKcF4KHqzKcyj7FRs2VRkweBc7XtlWZHMOQLsVkoiuyUL7c5jD3qz6UaSOb31lM/7JlqImS9n/fHwuiRaW99t74pMzl61n1CL54VrSRFR13qKJwyf2puMvZF66JUNXt6Q9R8fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=hl2VBGFC; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="hl2VBGFC"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 2AB311D3B;
	Mon, 20 Apr 2026 15:08:17 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=hl2VBGFC;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5BA8421C0;
	Mon, 20 Apr 2026 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1776697687;
	bh=SB6LUTEqMncDh3uvpRdPIDV7S9YL0GkgEewDBnsBhOI=;
	h=From:To:CC:Subject:Date;
	b=hl2VBGFCIrxK4lKyvcKrEKVjtsSbDxmAGUnXwSIOs5Q0Emapl508rB+CZd4zgsVz8
	 28dt7uaLsyJ4ObsKNaJI/ksxer2STMk2Fxix+mDV5ZAWNNprO8mjuNUy8eBdR9+zaI
	 A40TFcKfBcs4+1vu1YPofCgIN34eLwChhEZK5d0M=
Received: from localhost.localdomain (172.30.20.147) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 20 Apr 2026 18:08:05 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, 0xkato <0xkkato@gmail.com>, Adarsh Das
	<adarshdas950@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Deepanshu Kartikey
	<kartikey406@gmail.com>, Edward Adam Davis <eadavis@qq.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Pengpeng Hou
	<pengpeng@iscas.ac.cn>, Sun Jian <sun.jian.kdev@gmail.com>, Tobias Gaertner
	<tob.gaertner@me.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, Ziyi Guo
	<n7l8m4@u.northwestern.edu>
Subject: [GIT PULL] ntfs3: bugfixes for 7.1
Date: Mon, 20 Apr 2026 17:07:56 +0200
Message-ID: <20260420150756.6058-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Hello, please pull this branch containing ntfs3 code for 7.1.

Regards,
Konstantin

----------------------------------------------------------------
The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.1

for you to fetch changes up to 819bd270abf9de3b7f306e233054b85a07c47820:

  fs/ntfs3: fix Smatch warnings (2026-04-16 10:28:32 +0200)

----------------------------------------------------------------
Changes for 7.1-rc1

Added:
    reject inodes with zero non-DOS link count
    return folios from ntfs_lock_new_page()
    subset of W=1 warnings for stricter checks
    work around -Wmaybe-uninitialized warnings
    buffer boundary checks to run_unpack()
    terminate the cached volume label after UTF-8 conversion

Fixed:
    check return value of indx_find to avoid infinite loop
    prevent uninitialized lcn caused by zero len
    increase CLIENT_REC name field size to prevent buffer overflow
    missing run load for vcn0 in attr_data_get_block_locked()
    memory leak in indx_create_allocate()
    OOB write in attr_wof_frame_info()
    mount failure on volumes with fragmented MFT bitmap
    integer overflow in run_unpack() volume boundary check
    validate rec->used in journal-replay file record check

Changed:
    resolve compare function in public index APIs
    $LXDEV xattr lookup
    potential double iput on d_make_root() failure
    initialize err in ni_allocate_da_blocks_locked()
    correct the pre_alloc condition in attr_allocate_clusters()

----------------------------------------------------------------
0xkato (1):
      ntfs3: fix OOB write in attr_wof_frame_info()

Adarsh Das (1):
      fs/ntfs3: resolve compare function in public index APIs

Arnd Bergmann (1):
      ntfs3: work around false-postive -Wmaybe-uninitialized warnings

Deepanshu Kartikey (2):
      fs/ntfs3: fix missing run load for vcn0 in attr_data_get_block_locked()
      ntfs3: fix memory leak in indx_create_allocate()

Edward Adam Davis (1):
      fs/ntfs3: prevent uninitialized lcn caused by zero len

Greg Kroah-Hartman (1):
      fs/ntfs3: validate rec->used in journal-replay file record check

Konstantin Komarov (4):
      fs/ntfs3: add a subset of W=1 warnings for stricter checks
      fs/ntfs3: increase CLIENT_REC name field size
      ntfs3: fix mount failure on volumes with fragmented MFT bitmap
      fs/ntfs3: fix Smatch warnings

Pengpeng Hou (1):
      fs/ntfs3: terminate the cached volume label after UTF-8 conversion

Sun Jian (1):
      fs/ntfs3: return folios from ntfs_lock_new_page()

Tobias Gaertner (2):
      ntfs3: add buffer boundary checks to run_unpack()
      ntfs3: fix integer overflow in run_unpack() volume boundary check

Zhan Xusheng (2):
      fs/ntfs3: fix $LXDEV xattr lookup
      fs/ntfs3: fix potential double iput on d_make_root() failure

Ziyi Guo (1):
      ntfs3: reject inodes with zero non-DOS link count

 fs/ntfs3/Makefile  | 20 ++++++++++++++
 fs/ntfs3/attrib.c  | 23 +++++++++++++++-
 fs/ntfs3/frecord.c | 49 ++++++++++++++++++----------------
 fs/ntfs3/fslog.c   | 16 +++++++++---
 fs/ntfs3/fsntfs.c  |  4 +--
 fs/ntfs3/index.c   | 77 +++++++++++++++++++++++++++++++++++-------------------
 fs/ntfs3/inode.c   | 15 +++++++----
 fs/ntfs3/ntfs_fs.h |  3 ---
 fs/ntfs3/run.c     | 18 ++++++++++---
 fs/ntfs3/super.c   | 48 +++++++++++++++++++++++++++++-----
 fs/ntfs3/xattr.c   |  2 +-
 11 files changed, 202 insertions(+), 73 deletions(-)
