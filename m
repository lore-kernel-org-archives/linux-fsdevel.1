Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A1E34AB0B;
	Tue, 19 May 2026 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162024; cv=none; b=nXsTxQoxNr3TAxfnkhw5GA4xivqWYmaj79ERlAmkGq0vTBBzEf7VFK/0JUKyokDQrov3Tetk0kPQj74F9JxeZMAsabgALOdqHVf2vY5WfmTIfyq3QDcs4bvsWDeAxjJctx7tNLlKm2jFZayoU5IN/3BDjJke7ezFFRsbm0hy3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162024; c=relaxed/simple;
	bh=P0unB8uVUKmOByzi2WkKwlIdwV8c7L38QlIpBwbHSLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkBYsCCHGXgaKtFau/f+PDLaWD/k4RgdwrSs3RAypQFvG4JBjxuhrYAMEKEWLPgjERJAjj/UYh9RX/Del25V+LPS2gFE2F9nhcfsk0sWRpWGpoCHXOVpXCgpLSHxE5C/BA80yjQEfGi0QUYBSxif+UnXgI5Wt2uzLOh4iRGY+5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTDggKqy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTDggKqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A65C2BCB3;
	Tue, 19 May 2026 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779162024;
	bh=P0unB8uVUKmOByzi2WkKwlIdwV8c7L38QlIpBwbHSLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTDggKqyPFCixNsbXshTdNzWin5poNPnoCnGCy89CqeGOfX4K4EIig4pqzbHDImwU
	 o3IayreKyutY/OZphkM911UavySFH0HR16dA6WfL40I/Lcn1Jq8NIK4LM/kNvClY21
	 cc3dMkAIBmURe83bboVXWgdNOOyQyf5LVa+3BOhYmMwDL4vyOOY/DM7Xuq1x6yxson
	 jnxoWd84fTmSykse1GrtKY/YZG2v7m55xnQg+31ALdVQLbrreRL9gr9qfe/UtJjsaA
	 F7qyjeslRBsKBQ3CZa7+wuQ/Hvib3aXIxIw9CuAcy2zGeEg2DwigNud0rChmXSvH7h
	 hchAG0G5hCH+A==
Date: Mon, 18 May 2026 20:40:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org,
	hch@lst.de, linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com,
	dxdt@dev.snart.me, chizhiling@kylinos.cn, chizhiling@163.com,
	linux-kernel@vger.kernel.org, charsyam@gmail.com
Subject: Re: [PATCH v4 00/11] exfat: convert to iomap
Message-ID: <20260519034023.GE9531@frogsfrogsfrogs>
References: <20260518114705.9601-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518114705.9601-1-linkinjeon@kernel.org>

On Mon, May 18, 2026 at 08:46:54PM +0900, Namjae Jeon wrote:
> This patch series converts the exfat filesystem to the iomap framework for
> buffered I/O, direct I/O, and llseek (SEEK_HOLE/SEEK_DATA) support.
> 
> iozone benchmark results (4KB cluster size, -s1g -r64k, 1GB file, 64KB record size)
> 
>                        1 thread                  4 threads
>                      Write      Read           Write      Read
>                      (MB/s)    (MB/s)         (MB/s)    (MB/s)
> -----------------------------------------------------------------
> exfat + iomap patch   332.7     418.1           78.6      82.4
> Current exfat         278.4     415.1           42.1      38.0
> -----------------------------------------------------------------
> Improvement           +19.5%    +0.7%          +86.7%   +117.4%

FWIW I scanned over the other patches in the series.  Nothing stood out
as scream-worthy, though as the maintainer I'm assuming you're watching
them closely for the kinds of QA problems that only an exfat expert
would know. ;)

Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> 
> Available in the Git repository at:
> ===================================
> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git iomap-work
> 
> v4:
>   - Declare initialized variables before uninitialized ones in
>     __iomap_write_begin.
>   - Clean up the logic for handling ei->valid_size in the non-alloc
>     iomap read path.
>   - Rename exfat_cluster_to_phys to exfat_cluster_to_phys_bytes.
>   - Use end variable in exfat_fallback_buffered_write.
> 
> v3:
>   - Remove extra >> 9 when adding to inode->i_blocks.
>   - Simplify exfat_file_open() by removing unnecessary err variable.
>   - Separate exfat_truncate() error return conversion from iomap changes.
>   - Fix xfstests failures with 512B cluster size.
>   - Make exfat_truncate() return error code.
>   - Use inode lock to protect valid_size in exfat_extend_valid_size().
>   - Unify num_clusters calculation regardless of may_alloc.
>   - Use min_t() to clamp iomap->length.
>   - Return early in exfat_write_iomap_end() if no data written.
>   - Remove s_lock in exfat_write_iomap_end().
>   - Split DIO fallback buffered write into helper function.
>   - Remove unnecessary goto in exfat_dio_write_iter().
> 
> v2:
>   - Replace macros with static inline functions.
>   - Remove noop_direct_IO.
>   - Consolidate read and write iomap_begin into __exfat_iomap_begin()
>   - Zero out stale data in straddle block beyond valid_size.
>   - Introduce IOMAP_F_ZERO_TAIL flag to remove exfat_iomap_put_folio().
>   - Select FS_IOMAP in Kconfig.
>   - Remove unnecessary alignment check in exfat_file_read_iter().
>   - Just use generic_file_llseek directly.
>   - Move exfat_extend_valid_size to exfat_file_write_iter().
>   - Use pagecache_isize_extended() to remove iomap_zero_range in
>     exfat_setattr().
>   - fix mmap write data corruption with byte-by-byte fallocate.
>   - Remove exfat_mkwrite_iomap_begin().
> 
> Namjae Jeon (11):
>   iomap: introduce IOMAP_F_ZERO_TAIL flag
>   exfat: replace unsafe macros with static inline functions
>   exfat: add balloc parameter to exfat_map_cluster() for iomap support
>   exfat: add exfat_file_open()
>   exfat: add support for multi-cluster allocation
>   exfat: add data_start_bytes and exfat_cluster_to_phys_bytes() helper
>   exfat: fix implicit declaration of brelse()
>   exfat: add iomap buffered I/O support
>   exfat: add iomap direct I/O support
>   exfat: add support for SEEK_HOLE and SEEK_DATA in llseek
>   exfat: make exfat_truncate() return error code
> 
>  fs/exfat/Kconfig       |   2 +-
>  fs/exfat/Makefile      |   2 +-
>  fs/exfat/balloc.c      |   2 +-
>  fs/exfat/dir.c         |  50 +++---
>  fs/exfat/exfat_fs.h    | 140 ++++++++++++-----
>  fs/exfat/fatent.c      |  30 ++--
>  fs/exfat/file.c        | 263 +++++++++++++++++++++++--------
>  fs/exfat/inode.c       | 342 ++++++-----------------------------------
>  fs/exfat/iomap.c       | 263 +++++++++++++++++++++++++++++++
>  fs/exfat/iomap.h       |  15 ++
>  fs/exfat/namei.c       |  28 ++--
>  fs/exfat/super.c       |   5 +-
>  fs/iomap/buffered-io.c |   4 +
>  include/linux/iomap.h  |   4 +
>  14 files changed, 703 insertions(+), 447 deletions(-)
>  create mode 100644 fs/exfat/iomap.c
>  create mode 100644 fs/exfat/iomap.h
> 
> -- 
> 2.25.1
> 
> 
