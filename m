Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1103911B6;
	Wed, 24 Jun 2026 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782283610; cv=none; b=Ea1PjH1PW5APWzNRaom/kggAvTdoYmQxp4+Pr+6aoZA+0VBigieYOzTX/RanK02VIlz1oSVsJ95HKLKzXepZ7UoD8t/vyQ5t+EoepLmyX78GntRYFfAZFfI91Uhm+mJVdmIhPGVBgT62HxG+EzCQQ+Y8r8CQ4BBsBdJwb3M0RD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782283610; c=relaxed/simple;
	bh=nwRkIG1D7sHKv4NHd0HMuT5kiLtb9PZpcIa3nzgNehc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ic+FNUPSXWI1CEC/wRkdzvVoziVBx0ZzZHefk2mi8sPr2AcaOjDyU4lLztW7c4B+6EWmn7Uuu/dMiHeBGmKaOpVFiq3tKmKNHf9gsMGprvC2RABIJvv7CSLsUgQ9qEWJYQvuTQUhjWo9Dhqpbwb8I19SpLGBFyNhvLNwqr4g8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=pHg/bxLA; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="pHg/bxLA"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id F28B932C;
	Wed, 24 Jun 2026 06:37:50 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=pHg/bxLA;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id DF8BD2141;
	Wed, 24 Jun 2026 06:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1782283073;
	bh=7IcY48b5jFfuxu5UTqcZ9wz6LByK6SxWL34gP1XzfYE=;
	h=From:To:CC:Subject:Date;
	b=pHg/bxLABiz2Qj+igxxt3W1R2vL/o5WY3iloYqkRcJEdSVM1vPGoPhDJvoNYiw3i+
	 CvcJpbzrtl0fgkF1xP2Il4P3KY/pDPUYK+tO6BMD5VIEug2PrUEJIMuuX5T4sUQWtm
	 Psw6sC12QlSNnTLTultctNYrw/7yd1vxyZIqMU28=
Received: from localhost.localdomain (172.30.20.193) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 24 Jun 2026 09:37:50 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alessandro Schino <7991aleschino@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Edward Adam Davis <eadavis@qq.com>, Helen
 Koike <koike@igalia.com>, Jamie Nguyen <jamien@nvidia.com>, Konstantin
 Komarov <almaz.alexandrovich@paragon-software.com>, Michael Bommarito
	<michael.bommarito@gmail.com>, Mihai Brodschi <m.brodschi@gmail.com>, Tristan
 Madani <tristan@talencesecurity.com>, Yunpeng Tian <shionthanatos@gmail.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>, ZhengYuan Huang
	<gality369@gmail.com>
Subject: [GIT PULL] ntfs3: changes for 7.2
Date: Wed, 24 Jun 2026 09:37:25 +0300
Message-ID: <20260624063725.5151-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Hello, please pull this branch containing ntfs3 code for 7.2.
 
Regards,
Konstantin
 
----------------------------------------------------------------
The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:
 
  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)
 
are available in the Git repository at:
 
https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.2
 
for you to fetch changes up to 5b08dccecf825cbf905f348bc6ccb497507e28e2:
 
  ntfs3: reject direct userspace writes to reserved $LX* xattrs (2026-06-10 12:37:10 +0200)
 
----------------------------------------------------------------
Changes for 7.2-rc1
 
Added:
    depth limit to indx_find_buffer() to prevent stack overflow
    validate split-point offset in indx_insert_into_buffer()
    bounds check to run_get_highest_vcn()
    fileattr_get() and fileattr_set() support
    zero stale pagecache beyond valid data length
    handle delayed allocation overlap in run lookup
    validate lcns_follow in log_replay() conversion
    cap RESTART_TABLE free-chain walker at rt->used
    resize log->one_page_buf when adopting on-disk page size
    reject direct userspace writes to reserved $LX* xattrs
 
Fixed:
    out-of-bounds read in decompress_lznt()
    avoid -Wmaybe-uninitialized warnings
    hold ni_lock across readdir metadata walk
    preserve non-DOS attribute bits in system.dos_attrib
    validate index entry key bounds
    syncing wrong inode on DIRSYNC cross-directory rename
    validate Dirty Page Table capacity in log_replay() copy_lcns
    wrong LCN in run_remove_range() when splitting a run
    allocate iomap inline_data using alloc_page
    mount failure on 64K page-size kernels
    out-of-bounds read in ntfs_dir_emit() and hdr_find_e()
    bound attr_off in UpdateResidentValue against data_off
    bound DeleteIndexEntryAllocation memmove length
    bound copy_lcns dp->page_lcns[] index in analysis pass
    bound NTFS_DE view.data_off in UpdateRecordData{Root,Allocation}
    prevent potential lcn remains uninitialized
 
Changed:
    bound to_move in indx_insert_into_root() before hdr_insert_head()
    call _ntfs_bad_inode() when failing to rename
    fold resident writeback into writepages loop
    force waiting for direct I/O completion
    fold file size handling into ntfs_set_size()
    reject SEEK_DATA and SEEK_HOLE past EOF early
    format code, add descriptive comments and remove non-useful
 
----------------------------------------------------------------
Alessandro Schino (1):
      ntfs3: fix out-of-bounds read in ntfs_dir_emit() and hdr_find_e()
 
Arnd Bergmann (2):
      ntfs3: avoid -Wmaybe-uninitialized warning
      ntfs3: avoid another -Wmaybe-uninitialized warning
 
Edward Adam Davis (1):
      fs/ntfs3: prevent potential lcn remains uninitialized
 
Helen Koike (1):
      fs/ntfs3: call _ntfs_bad_inode() when failing to rename
 
Jamie Nguyen (2):
      fs/ntfs3: fix mount failure on 64K page-size kernels
      fs/ntfs3: resize log->one_page_buf when adopting on-disk page size
 
Konstantin Komarov (13):
      fs/ntfs3: add bounds check to run_get_highest_vcn()
      fs/ntfs3: add fileattr support
      fs/ntfs3: zero stale pagecache beyond valid data length
      fs/ntfs3: handle delayed allocation overlap in run lookup
      fs/ntfs3: fold resident writeback into writepages loop
      fs/ntfs3: force waiting for direct I/O completion
      fs/ntfs3: fold file size handling into ntfs_set_size()
      fs/ntfs3: reject SEEK_DATA and SEEK_HOLE past EOF early
      fs/ntfs3: format code, deal with comments
      fs/ntfs3: bound attr_off in UpdateResidentValue against data_off
      fs/ntfs3: bound DeleteIndexEntryAllocation memmove length
      fs/ntfs3: validate lcns_follow in log_replay conversion
      ntfs3: reject direct userspace writes to reserved $LX* xattrs
 
Michael Bommarito (6):
      fs/ntfs3: add depth limit to indx_find_buffer to prevent stack overflow
      ntfs3: bound to_move in indx_insert_into_root before hdr_insert_head
      ntfs3: validate split-point offset in indx_insert_into_buffer
      fs/ntfs3: bound copy_lcns dp->page_lcns[] index in analysis pass
      fs/ntfs3: bound NTFS_DE view.data_off in UpdateRecordData{Root,Allocation}
      ntfs3: cap RESTART_TABLE free-chain walker at rt->used
 
Mihai Brodschi (1):
      ntfs3: Allocate iomap inline_data using alloc_page
 
Tristan Madani (1):
      ntfs3: fix out-of-bounds read in decompress_lznt
 
Yunpeng Tian (1):
      fs/ntfs3: validate Dirty Page Table capacity in log_replay copy_lcns
 
Zhan Xusheng (2):
      fs/ntfs3: fix syncing wrong inode on DIRSYNC cross-directory rename
      fs/ntfs3: fix wrong LCN in run_remove_range() when splitting a run
 
ZhengYuan Huang (3):
      fs/ntfs3: hold ni_lock across readdir metadata walk
      fs/ntfs3: preserve non-DOS attribute bits in system.dos_attrib
      fs/ntfs3: validate index entry key bounds
 
fs/ntfs3/attrib.c  |  29 +++--
fs/ntfs3/dir.c     |  26 +++--
fs/ntfs3/file.c    | 304 +++++++++++++++++++++++++++--------------------------
fs/ntfs3/frecord.c |  38 ++++---
fs/ntfs3/fslog.c   | 157 +++++++++++++++++++++++----
fs/ntfs3/fsntfs.c  |   1 -
fs/ntfs3/index.c   | 119 +++++++++++++++++----
fs/ntfs3/inode.c   |  78 ++++++--------
fs/ntfs3/lznt.c    |   2 +-
fs/ntfs3/namei.c   |   6 +-
fs/ntfs3/ntfs_fs.h |  12 ++-
fs/ntfs3/run.c     |  75 ++++++++++++-
fs/ntfs3/xattr.c   |  16 ++-
13 files changed, 589 insertions(+), 274 deletions(-)

