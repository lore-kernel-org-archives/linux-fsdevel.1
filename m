Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DB13793B1;
	Tue, 17 Feb 2026 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362451; cv=none; b=I0LbHzqJZjyRT6TRznoAPe3CWDyDiI3z4qj4/y0TdNQ3l3aeh8GuoTg80KhVx3CZXNSeOWLKg8/qHIUCQ8dLCjpzwvewNDcirHI5exvil57UmHF6dHwe/jjZPb14mBqatBbQeuSn8c+dKxGHpbvT81xKSiKHPFj40LKpN9Fh+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362451; c=relaxed/simple;
	bh=o96IP32jKboGEJjdyNl8aupkU6gPlTLCcy9U85ulj08=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=mdgL7OgL92jktEMDZHCvDmmhje2j12cwyZUde+BUZ1Vc5iwCfAL4d4nUTtVVde88b+av/rywdhXea0YqGZiZeL3jDIWKQlxIru2hOc/tbQI6azPtt3AQdRwkFGlLXZbJ1dM5pnF8FoxAdDnyVkWaaygRunq5hMLxzBTkPCrQIic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=SeIhmMaI; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="SeIhmMaI"
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id F0EA61D29;
	Tue, 17 Feb 2026 21:05:29 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=SeIhmMaI;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id AC23421DA;
	Tue, 17 Feb 2026 21:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1771362446;
	bh=aV46JmNaVjTrWtGbQrw71SO+thEjZT6SGdF6M4ILplw=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=SeIhmMaI8h/BDnrNhVGJdqdQhVy0+MeBQ4ec62x+6xYr0DDjL46BKnUUfacl8+Wbw
	 P81zqS09xlWRdU5+JxsmfNoC1LIv4f8OM/O/WUJAIqy2Vc+gplVWsYLcCnmLYEGOpr
	 lOG/0r6bbxVLbayozorcB4jt42wqtFwRbQrVuRCA=
Received: from [192.168.95.128] (172.30.20.181) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 18 Feb 2026 00:07:24 +0300
Message-ID: <a4d17661-4a75-46e2-a338-cc90d36f0b70@paragon-software.com>
Date: Tue, 17 Feb 2026 22:07:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] ntfs3: changes for 7.0
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260217190630.19176-1-almaz.alexandrovich@paragon-software.com>
Content-Language: en-US
In-Reply-To: <20260217190630.19176-1-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 2/17/26 20:06, Konstantin Komarov wrote:

> Regards,
> Konstantin
>
> ----------------------------------------------------------------
> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:
>
>    Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
>
> are available in the Git repository at:
>
>    https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.0
>
> for you to fetch changes up to 10d7c95af043b45a85dc738c3271bf760ff3577e:
>
>    fs/ntfs3: add delayed-allocation (delalloc) support (2026-02-16 17:23:51 +0100)
>
> ----------------------------------------------------------------
> Changes for 7.0-rc1
>
> Added:
>          improve readahead for bitmap initialization and large directory scans
> 	fsync files by syncing parent inodes
> 	drop of preallocated clusters for sparse and compressed files
> 	zero-fill folios beyond i_valid in ntfs_read_folio()
> 	implement llseek SEEK_DATA/SEEK_HOLE by scanning data runs
> 	implement iomap-based file operations
> 	allow explicit boolean acl/prealloc mount options
> 	a fall-through between switch labels
> 	a delayed-allocation (delalloc) support
>
> Fixed:
>          check return value of indx_find to avoid infinite loop
> 	initialize new folios before use
> 	an infinite loop in attr_load_runs_range on inconsistent metadata
> 	an infinite loop triggered by zero-sized ATTR_LIST
> 	ntfs_mount_options leak in ntfs_fill_super()
> 	a deadlock in ni_read_folio_cmpr
> 	a circular locking dependency in run_unpack_ex
> 	prevent infinite loops caused by the next valid being the same
> 	restore NULL folio initialization in ntfs_writepages()
> 	a slab-out-of-bounds read in DeleteIndexEntryRoot
>
> Changed:
>          allow readdir() to finish after directory mutations without rewinddir()
> 	handle attr_set_size() errors when truncating files
> 	make ntfs_writeback_ops static
> 	refactor duplicate kmemdup pattern in do_action()
> 	avoid calling run_get_entry() when run == NULL in ntfs_read_run_nb_ra()
>
> Replaced:
> 	use wait_on_buffer() directly
> 	rename ni_readpage_cmpr into ni_read_folio_cmpr
>
> ----------------------------------------------------------------
> Baokun Li (1):
>        fs/ntfs3: fix ntfs_mount_options leak in ntfs_fill_super()
>
> Baolin Liu (1):
>        ntfs3: Refactor duplicate kmemdup pattern in do_action()
>
> Bartlomiej Kubik (1):
>        fs/ntfs3: Initialize new folios before use
>
> Edward Adam Davis (1):
>        fs/ntfs3: prevent infinite loops caused by the next valid being the same
>
> Jaehun Gou (3):
>        fs: ntfs3: check return value of indx_find to avoid infinite loop
>        fs: ntfs3: fix infinite loop in attr_load_runs_range on inconsistent metadata
>        fs: ntfs3: fix infinite loop triggered by zero-sized ATTR_LIST
>
> Jiasheng Jiang (1):
>        fs/ntfs3: Fix slab-out-of-bounds read in DeleteIndexEntryRoot
>
> Konstantin Komarov (13):
>        fs/ntfs3: rename ni_readpage_cmpr into ni_read_folio_cmpr
>        fs/ntfs3: improve readahead for bitmap initialization and large directory scans
>        fs/ntfs3: allow readdir() to finish after directory mutations without rewinddir()
>        fs/ntfs3: fsync files by syncing parent inodes
>        fs/ntfs3: drop preallocated clusters for sparse and compressed files
>        fs/ntfs3: handle attr_set_size() errors when truncating files
>        fs/ntfs3: zero-fill folios beyond i_valid in ntfs_read_folio()
>        fs/ntfs3: implement llseek SEEK_DATA/SEEK_HOLE by scanning data runs
>        fs/ntfs3: implement iomap-based file operations
>        fs/ntfs3: allow explicit boolean acl/prealloc mount options
>        fs/ntfs3: add fall-through between switch labels
>        fs/ntfs3: avoid calling run_get_entry() when run == NULL in ntfs_read_run_nb_ra()
>        fs/ntfs3: add delayed-allocation (delalloc) support
>
> Lalit Shankar Chowdhury (1):
>        fs/ntfs3: Use wait_on_buffer() directly
>
> Nathan Chancellor (1):
>        ntfs3: Restore NULL folio initialization in ntfs_writepages()
>
> Szymon Wilczek (2):
>        fs/ntfs3: fix deadlock in ni_read_folio_cmpr
>        ntfs3: fix circular locking dependency in run_unpack_ex
>
> sunliming (1):
>        fs/ntfs3: make ntfs_writeback_ops static
>
>   fs/ntfs3/attrib.c   | 412 ++++++++++++++++++---------
>   fs/ntfs3/attrlist.c |  17 +-
>   fs/ntfs3/bitmap.c   |  17 ++
>   fs/ntfs3/dir.c      | 108 ++++---
>   fs/ntfs3/file.c     | 599 ++++++++++++++++++++++-----------------
>   fs/ntfs3/frecord.c  | 382 +++++++++++++------------
>   fs/ntfs3/fslog.c    |  65 +++--
>   fs/ntfs3/fsntfs.c   | 112 +++++---
>   fs/ntfs3/index.c    |  49 ++--
>   fs/ntfs3/inode.c    | 800 ++++++++++++++++++++++++++++------------------------
>   fs/ntfs3/ntfs.h     |   4 +
>   fs/ntfs3/ntfs_fs.h  | 153 +++++++---
>   fs/ntfs3/run.c      | 163 ++++++++++-
>   fs/ntfs3/super.c    |  73 +++--
>   fs/ntfs3/xattr.c    |   2 +-
>   15 files changed, 1822 insertions(+), 1134 deletions(-)
>
My apologies - the opening line of my previous message was accidentally
cut. For clarity:

Please pull this branch containing ntfs3 code for 7.0.

Everything else (the patches, commit messages, and Signed-off-by / trailers)
is unchanged.

Regards,
Konstantin

