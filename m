Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF173FC5AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989517; cv=none; b=f3cWQEvMpgzX/2CMpSPrqNLGIFy9SLrLcqDnRxeZuiY2zZzAla0A1orxDYURiNClX3MymvKO1DmPboLsK/+EaawOVmLz0yyIlIdwaXzb4dAXg0pcVrlk/vANc9Cnx4qe8QeNMY1mdHcs/IqCpO9gldGvINXEsV88PfQgPteDQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989517; c=relaxed/simple;
	bh=5CCPuqb9zz+TTg4Uaw417ctZfy7l7fkFBLSs6LNis/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SaSWr+xd0OWld8VSBrMDrOsB5Ylhl1YECdb7AuA4hedm3VywKkZAjK608FfTduEFN0wEJOPhc1BRiRY+U6/V3P8uA1jtfHYV0tI/mougZzzX/qN263aWSpezdLTZG+5TA0eJbTBc+n6mq164Nf7RoYgYlBdt8Cz2eULzoEc0Mrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WY4fsU5q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WY4fsU5q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=q/2fb3LsE5p71sojG2x+TQcETWGSEHC5JYCijUi/pUk=; b=WY4fsU5qPzBv7zMQQZ2plBHYX9
	2OQwiWHWQgtkDpIOihufid/p1Nlu+PB7uu4ujkNHhK2GGlLGDpOLwHB9RMCMBvlC9ufkbqUkXwOFc
	m4g2A3RNwnb936l3icjW8kTCI6hOJISdqyA2r8T+GSENXs2/ffJzCBkC7tpiJkR1H+M0conkC5CmS
	Mf6V+OXvnNc+cvDrdFekNYMvREoVjMRhrtW2q6Vj3agnwNSYWkWb6DFYoOpgqEwApFnXGLJsFBcbQ
	YT1kkYPeuFjecJ120VFF70WX178gP3bBmD202sMWOssoQqUWT1qDXuuZxbyLtSGtVOW1SPohKxiYr
	AqYKxGmg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaF-00000004aXs-1cFK;
	Thu, 28 May 2026 17:31:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 00/34] Remove b_end_io from struct buffer_head
Date: Thu, 28 May 2026 18:31:13 +0100
Message-ID: <20260528173150.1093780-1-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are four benefits to this patchset.  First, it removes an
indirect function call from the completion path.  Instead of setting
bio->bi_end_io to end_bio_bh_io_sync() which then calls bh->b_end_io(),
we set bio->bi_end_io to the appropriate completion handler, replacing
two indirect function calls with one.

Second, there is a slight security advantage to this.  It is one fewer
function pointer in the middle of a writable data structure that can
be corrupted.  Third, it shrinks struct buffer_head from 104 bytes to 96
bytes, allowing for appropriximately 7% reduction in the amount of memory
used by buffer_heads (or, alternatively, allows 7% more buffer_heads to
be cached in the same amount of memory).  Fourth, it removes some
atomic operations as the buffer refcount is no longer incremented before
calling the end_io handler.

I've run ext4 through its paces, and everything seems OK.  I've only
compiled ocfs2/gfs2/nilfs/md-bitmap.  Hopefully the maintainers can give
this series a try.  I'm sending the entire series to linux-fsdevel
and cc'ing the fs-specific mailing lists for the fs-specific patches.

v2:
 - Redo bio_endio_bh() to return a bool and the buffer_head instead of
   requiring callers to retried bi_status themselves (Jan)
 - Remove buffer refcount inc/dec (Jan)
 - Add kernel-doc for end_buffer_read_sync()
 - Collect tags from Jan, Ted, Joseph, Viacheslav and Ryusuke

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
  buffer: Change calling convention for end_buffer_read_sync()
  buffer: Remove end_buffer_write_sync()

 Documentation/filesystems/locking.rst |  14 -
 Documentation/trace/ftrace.rst        |   4 +-
 drivers/md/md-bitmap.c                |  27 +-
 drivers/md/raid5.h                    |   6 +-
 fs/buffer.c                           | 385 ++++++++++++++------------
 fs/ext4/ext4.h                        |  10 +-
 fs/ext4/fast_commit.c                 |   8 +-
 fs/ext4/ialloc.c                      |   6 +-
 fs/ext4/mmp.c                         |   5 +-
 fs/ext4/super.c                       |  18 +-
 fs/gfs2/bmap.c                        |  13 +-
 fs/gfs2/dir.c                         |  12 +-
 fs/gfs2/meta_io.c                     |  13 +-
 fs/jbd2/commit.c                      |  13 +-
 fs/jbd2/journal.c                     |   4 +-
 fs/nilfs2/btnode.c                    |   4 +-
 fs/nilfs2/gcinode.c                   |   4 +-
 fs/nilfs2/mdt.c                       |   4 +-
 fs/ocfs2/buffer_head_io.c             |  16 +-
 include/linux/buffer_head.h           |  16 +-
 mm/vmscan.c                           |   2 +-
 21 files changed, 288 insertions(+), 296 deletions(-)

-- 
2.47.3

