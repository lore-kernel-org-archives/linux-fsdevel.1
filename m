Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0CF1F4611
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729584; cv=none; b=PLxXyvBu012oT/z4r/t5+j4oysQmBkoppMmWOZQucReeI4FJA8CmPF1SBU5vtjqLh4sMmaEskb7T9Nsc3+ZJZ2Fo1h8Q6Ywzx2R27o2yetyp9AZcbsiazXEikW2gXhWTds8WMeg/zjX3On5daHpv3plc5tZfnzgvmRqFJzrGpEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729584; c=relaxed/simple;
	bh=pULmbpl2CnPjM7kPWMuvi+yGSNzJ3XphFcpwxUFwiH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAS/UBRtYtD5DIJicPRU/X8f9UzCj7xARDYn9e97UgIrjBHPvP3GI/PdiE9O2pPft2slo1p4CvLWQE7xNwTzFWbw3w9KFFpNu3AIqkmJtYlcaelQKwK8G/AE4cdeU74xfuymP2f07TnjPIWvCvPyO2NZZd0M/RVOGFI4bG5KJXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eTTMe9qQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eTTMe9qQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=7lLnQXXxBbCfILT0w2OqCnJylECxncagzi+1YurPPzk=; b=eTTMe9qQXDl7T5DI/l6f7T3z+S
	m8r8AK4DIuOXDllNiAJf/g7Sb9eqfsUqVuduMz0RA19KdoqmBLW+3H/tq5ByEVvtCS1RDtaoiikNP
	C7ZDbJfzQKxUBIrHTB6Zgwa2GQPFOw0yXqpSU0Yo/6LaqS1lsZwj7aee2X73ovSLNsihZUyIcONVe
	KucdCqzSmemWYp27ED+8xsDLb0Ge8lacsh7n3l1T8opeFgjPaPVEC7AhIzFMdj9gdg+2KKlgfgn68
	Pvw62B7plAvyRuFD/jc2rOWXFUQu+RdU6pI6r3vJuZbv4ELI4PrEb48BjFWHZIRb4hNcy29SWnyoL
	W3pqeyMg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxn-0000000HO9U-2912;
	Mon, 25 May 2026 17:19:39 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/34] Remove b_end_io from struct buffer_head
Date: Mon, 25 May 2026 18:18:53 +0100
Message-ID: <20260525171931.4144395-1-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are three benefits to this patchset.  First, it removes an
indirect function call from the completion path.  Instead of setting
bio->bi_end_io to end_bio_bh_io_sync() which then calls bh->b_end_io(),
we set bio->bi_end_io to the appropriate completion handler, replacing
two indirect function calls with one.

Second, there is a slight security advantage to this.  It is one fewer
function pointer in the middle of a writable data structure that can
be corrupted.  Third, it shrinks struct buffer_head from 104 bytes to 96
bytes, allowing for appropriximately 7% reduction in the amount of memory
used by buffer_heads (or, alternatively, allows 7% more buffer_heads to
be cached in the same amount of memory).

I've run ext4 through its paces, and everything seems OK.  I've only
compiled ocfs2/gfs2/nilfs/md-bitmap.  Hopefully the maintainers can give
this series a try.  I'm sending the entire series to linux-fsdevel
and cc'ing the fs-specific mailing lists for the fs-specific patches.

I have some unresolved thoughts while working on this:
 - Should gfs2_aspace_write_folio() be passing its wbc into __bh_submit()?
 - Should we allow callers of bh_submit() to pass in NULL instead of
   bh_end_read / bh_end_write and infer which one to use from the opf
   being REQ_OP_READ or REQ_OP_WRITE?
 - Should some of these callers of bh_submit() be calling higher level
   functions in buffer.c insteaad?  eg nilfs_mdt_submit_block() could
   call __bh_read().

Matthew Wilcox (Oracle) (34):
  buffer: Remove forward declaration of submit_bh_wbc()
  buffer: Add bh_submit()
  buffer: Remove mark_buffer_async_write_endio()
  buffer: Add bh_end_read(), bh_end_write() and bh_end_async_write()
  buffer: Convert write_dirty_buffer to bh_submit()
  buffer: Convert __bread_slow to bh_submit()
  buffer: Convert __sync_dirty_buffer to bh_submit()
  buffer: Convert __bh_read to bh_submit()
  buffer: Convert __bh_read_batch to bh_submit()
  buffer: Convert block_read_full_folio to bh_submit()
  buffer: Convert __block_write_full_folio to __bh_submit()
  ext4; Convert __ext4_read_bh() to bh_submit()
  ext4: Convert ext4_fc_submit_bh() to bh_submit()
  ext4: Convert write_mmp_block_thawed() to bh_submit()
  ext4: Convert ext4_commit_super() to bh_submit()
  jbd2: Convert journal commit to bh_submit()
  jbd2: Convert jbd2_write_superblock() to bh_submit()
  ocfs2: Convert ocfs2_write_block to bh_submit()
  ocfs2: Convert ocfs2_read_block to bh_submit()
  ocfs2: Convert ocfs2_read_blocks to bh_submit()
  ocfs2: Convert ocfs2_write_super_or_backup to bh_submit()
  gfs2: Convert gfs2_metapath_ra to bh_submit()
  gfs2: Convert gfs2_dir_readahead to bh_submit()
  gfs2: Remove use of b_end_io in gfs2_meta_read_endio()
  gfs2: Convert gfs2_aspace_write_folio to bh_submit()
  buffer: Remove mark_buffer_async_write()
  nilfs2: Convert nilfs_btnode_submit_block to bh_submit()
  nilfs2: Convert nilfs_gccache_submit_read_data to bh_submit()
  nilfs2: Convert nilfs_mdt_submit_block to bh_submit()
  md-bitmap: Convert read_file_page and write_file_page to bh_submit()
  buffer: Remove submit_bh()
  buffer: Remove b_end_io
  buffer: Remove __end_buffer_read_notouch()
  buffer: Remove end_buffer_write_sync()

 Documentation/filesystems/locking.rst |  14 -
 Documentation/trace/ftrace.rst        |   4 +-
 drivers/md/md-bitmap.c                |  27 +-
 drivers/md/raid5.h                    |   6 +-
 fs/buffer.c                           | 372 ++++++++++++++------------
 fs/ext4/ext4.h                        |  10 +-
 fs/ext4/fast_commit.c                 |   8 +-
 fs/ext4/ialloc.c                      |   5 +-
 fs/ext4/mmp.c                         |   4 +-
 fs/ext4/super.c                       |  16 +-
 fs/gfs2/bmap.c                        |   7 +-
 fs/gfs2/dir.c                         |   6 +-
 fs/gfs2/meta_io.c                     |  11 +-
 fs/jbd2/commit.c                      |  13 +-
 fs/jbd2/journal.c                     |   3 +-
 fs/nilfs2/btnode.c                    |   3 +-
 fs/nilfs2/gcinode.c                   |   3 +-
 fs/nilfs2/mdt.c                       |   3 +-
 fs/ocfs2/buffer_head_io.c             |  20 +-
 include/linux/buffer_head.h           |  16 +-
 mm/vmscan.c                           |   2 +-
 21 files changed, 280 insertions(+), 273 deletions(-)

-- 
2.47.3

