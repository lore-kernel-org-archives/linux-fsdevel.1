Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.157.23.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173004;
	b=pYGlxW02z0Xgr5+Ca4f2TdZ/J/iU7V8zSeoOH6HZz54DEDO61+vk1nfVa8QevAj8IUEc
	 LMzEVMxyaEqxQ5Pc2c7LxCsiNWyiZFKW+DhCz6ZPE2bte+vLTHbWYnVGs80iFgclJijdh
	 OOIOHpsApqcF0wANwRdeWuW/lxli3anE+tTjhfqhCmIxq/Zdt2mBgGTikZQx+/eXHmGqF
	 i8RTXHszOI1IoJH3MxxguuAW+IqslYAO8NZntFipRdgc9OBza2qHRkaUrJxKyfSP7HSlA
	 MhcVfhGqG9R62vqNfyX64SAXnLkFBEXAyXbiMMu+NxUQRSjSYP5cfg7XH7Vxzx62Oug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173004;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=iDxtdBCxNRy120Jr7U7dKBOjk9V5+i35Ujgi5oq7B+c=;
	b=40utSayN5HUVvbOtZNyCL0BvxL6DEg51GS4xxnfJHpEnurAtWSdH8nNtMaR/mGgDcWvt
	 3IuoyyrxjZRb/kokYHkWFmZiJGlIQPDtmQ/IGfwPmPG0xCcxcPDvZKlLtQAP18A5PWqQt
	 HHt6RzuyTUZRqCxogPuBFF9CCGwkn2J/8cekACiyxq1SL/7Jmkn8PAF25NXPvlf99Qjmo
	 lAwB7RfQWWZVnuTciSa1EAScYxyKTcqA/ghz2UgcRu06PTbqaTVdE+fimVw0yzVJIt5Xy
	 ZDX32L+NSpCaBESwXDADTrcfQG1q2e1aaOzTpL38tgOko8gbLkF3WfNr6alz6yHnVAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paragon-software.com;
	spf=pass smtp.mailfrom=paragon-software.com;
	dkim=pass header.d=paragon-software.com header.i=@paragon-software.com header.a=rsa-sha256 header.s=mail header.b=BlnvUqsz;
	arc=none smtp.remote-ip=35.157.23.187
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F6F606A31D;
	Wed, 28 Oct 2026 07:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54F6F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.a=rsa-sha256 header.s=mail header.b=BlnvUqsz
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8CBAD1D15;
	Wed, 28 Oct 2026 07:37:23 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=BlnvUqsz;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id ED39A213E;
	Wed, 28 Oct 2026 07:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1793172995;
	bh=iDxtdBCxNRy120Jr7U7dKBOjk9V5+i35Ujgi5oq7B+c=;
	h=From:To:CC:Subject:Date;
	b=BlnvUqszZtfdezwyaI94elQJRNdk6yrg+qu/zFRbyKqVLa5jIezSSlGc9bUgG3RZO
	 MXlY6zM2kh46KqfJElTE3nUpA2EquYST3+nUGCnXiLUd1dDQg2D5ij7PFcNUtuVLo2
	 gE22r05+rYmst20yC0kHF/z38KuWmW+Y+c+taV50=
Received: from localhost.localdomain (172.30.20.183) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 28 Oct 2026 10:36:32 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Alexandro Calo <alexandro.calo@nozominetworks.com>, Baolin Liu
	<liubaolin@kylinos.cn>, Dmitry Morgun <d.morgun@ispras.ru>, Hongling Zeng
	<zenghongling@kylinos.cn>, Hyeontae Lee <wonju345@naver.com>, Ibrahim
 Hashimov <security@auditcode.ai>, Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>, liyouhong <liyouhong@kylinos.cn>,
	Matvey Kovalev <matvey.kovalev@ispras.ru>, Michael Bommarito
	<michael.bommarito@gmail.com>, Slawomir Stepien <sst@poczta.fm>, Vidhu Sarwal
	<vidhu.linux@gmail.com>, Weiming Shi <bestswngs@gmail.com>, Xiang Mei
	<xmei5@asu.edu>, Yi Xie <xieyi@kylinos.cn>, Yousef Alhouseen
	<alhouseenyousef@gmail.com>, Yuejie Shi <syjcnss@gmail.com>, Yun Zhou
	<yun.zhou@windriver.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>
Subject: [GIT PULL] ntfs3: changes for 7.4
Date: Wed, 28 Oct 2026 08:36:22 +0100
Message-ID: <20261028073622.8942-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Hello, please pull this branch containing ntfs3 code for 7.4.

Added a better description of changes in pull-request.
 
Regards,
Konstantin

----------------------------------------------------------------
The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.4

for you to fetch changes up to ee1cb3443cff5a800948b662756f75b17ca63fe2:

  ntfs3: add file I/O tracepoints (2026-10-28 08:09:20 +0100)

----------------------------------------------------------------
Changes for 7.4-rc1

The bulk of this cycle is hardening against corrupted or maliciously
crafted volumes. Most of these fixes come from fuzzing and KASAN
reports. The main areas are:

- $LogFile replay, where several unchecked on-disk sizes could make
  mount write past the MFT record buffer;
- MFT record and index parsing;
- extended attributes, where a bad $EA entry could leak up to 64K of
  kernel heap to userspace through getxattr().

Reading a damaged compressed file could also return uninitialized
page cache contents to userspace; that is fixed too.

A few fixes affect healthy volumes as well: a heap overflow in
fallocate(INSERT_RANGE) on small files, a use-after-free when a
WOF-compressed file is opened for writing during a concurrent read,
a lock-order deadlock in readdir, and stale disk data showing up in
newly allocated clusters of compressed files.

On the feature side there are new tracepoints covering mount, log
replay, lookup, directory index, allocation, iomap and file I/O.
There is also a new 'ugm' mount option (on by default): with ugm=0,
newly created files don't get the WSL uid/gid/mode extended
attributes, which Windows doesn't use.

The rest is smaller correctness fixes and cleanups.

----------------------------------------------------------------
Aldo Ariel Panzardo (1):
      fs/ntfs3: validate that EA entry size covers its name and value

Alexandro Calo (3):
      fs/ntfs3: Fix OOB write if ret == buf_len in ntfs_utf16_to_nls()
      fs/ntfs3: Fix heap overflow after ALIGN in mi_pack_runs()
      Fix OOB write if err == buflen in ntfs_readlink_hlp()

Baolin Liu (10):
      fs/ntfs3: update ctime only on successful setxattr
      fs/ntfs3: reject FS_IOC_SETFSLABEL on readonly mounts
      fs/ntfs3: return -ERANGE for short xattr buffers
      ntfs3: add mount and log replay tracepoints
      ntfs3: add namei tracepoints
      ntfs3: add create inode tracepoint
      ntfs3: add directory index tracepoints
      ntfs3: add allocation tracepoints
      ntfs3: add iomap tracepoints
      ntfs3: add file I/O tracepoints

Dmitry Morgun (1):
      fs/ntfs3: check return values in indx_delete_entry()

Hongling Zeng (1):
      ntfs3: fix mapping pairs bounds check for alignment

Hyeontae Lee (2):
      fs/ntfs3: bound CreateAttribute asize against record_size in do_action
      fs/ntfs3: bound DeleteAttribute asize against rec->used in do_action

Ibrahim Hashimov (1):
      fs/ntfs3: fix integer overflow in find_log_rec() causing OOB read

Konstantin Komarov (15):
      fs/ntfs3: document ads, nocase, and delalloc
      fs/ntfs3: convert to non-resident when the new size exceeds the record size
      fs/ntfs3: use MAX_LFS_FILESIZE for maxbytes with 64-bit clusters
      fs/ntfs3: validate EA entry layout against ef->size in ntfs_read_ea
      fs/ntfs3: show supported options when an unknown one is given
      fs/ntfs3: zero newly allocated clusters when the request is smaller than the frame
      fs/ntfs3: drop unused new_size argument from attr_make_nonresident()
      fs/ntfs3: minor code cleanups
      fs/ntfs3: do not force allocation for IOMAP_ZERO on a partial cluster
      fs/ntfs3: add 'ugm' mount option to control storing uid/gid/mode in xattrs
      fs/ntfs3: allow a zero cluster count for resident attributes
      fs/ntfs3: reserve a compression unit in maxbytes_sparse
      fs/ntfs3: take ni_lock() once in ntfs_readdir()
      fs/ntfs3: reject unaligned hole punching on compressed files
      fs/ntfs3: fix stale attr_b in attr_allocate_frame()

Matvey Kovalev (1):
      fs/ntfs3: remove redundant if-block in check_attr()

Michael Bommarito (1):
      fs/ntfs3: reject an oversized resident attribute on the inline iomap path

Slawomir Stepien (1):
      fs/ntfs3: handle partial allocation in attr_data_get_block_locked()

Vidhu Sarwal (1):
      fs/ntfs3: prevent positive E_NTFS_NONRESIDENT from reaching writeback error handling

Weiming Shi (4):
      fs/ntfs3: take run_lock when freeing offs_folio in ni_decompress_file
      fs/ntfs3: zero frame pages on read error
      ntfs3: fix out-of-bounds read in ntfs_read_mft()
      fs/ntfs3: do not mark frame pages uptodate on read error

Xiang Mei (1):
      fs/ntfs3: validate $SDH entry size in ntfs_insert_security

Xiang Mei (Microsoft) (2):
      fs/ntfs3: check INDEX_ROOT resident size before use in ntfs_read_mft()
      fs/ntfs3: fix slab-out-of-bounds write in attr_insert_range()

Yi Xie (1):
      ntfs3: fix resident attribute handling in run load paths

Yousef Alhouseen (2):
      ntfs3: reject empty iomap before reading its LCN
      ntfs3: bound index head insertions by buffer capacity

Yuejie Shi (1):
      fs/ntfs3: validate the EA value length in ntfs_read_ea()

Yun Zhou (1):
      ntfs3: release ni_lock before dir_emit in ntfs_readdir to fix deadlocks

Zhan Xusheng (1):
      fs/ntfs3: fix valid_size not being updated in attr_allocate_frame()

liyouhong (1):
      fs/ntfs3: fix ntfs_fnd leak when compare function is missing

 Documentation/filesystems/ntfs3.rst |  23 +++
 MAINTAINERS                         |   1 +
 fs/ntfs3/attrib.c                   | 189 +++++++++++-------
 fs/ntfs3/dir.c                      |  62 ++++--
 fs/ntfs3/file.c                     |   8 +
 fs/ntfs3/frecord.c                  |  16 +-
 fs/ntfs3/fslog.c                    |  35 +++-
 fs/ntfs3/fsntfs.c                   |   3 +
 fs/ntfs3/index.c                    |  40 +++-
 fs/ntfs3/inode.c                    |  37 +++-
 fs/ntfs3/namei.c                    |  11 +-
 fs/ntfs3/ntfs_fs.h                  |   5 +-
 fs/ntfs3/record.c                   |  16 +-
 fs/ntfs3/super.c                    |  44 +++-
 fs/ntfs3/xattr.c                    |  44 ++--
 include/trace/events/ntfs3.h        | 389 ++++++++++++++++++++++++++++++++++++
 16 files changed, 781 insertions(+), 142 deletions(-)
 create mode 100644 include/trace/events/ntfs3.h
