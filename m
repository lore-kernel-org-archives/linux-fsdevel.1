Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873571DDC1D
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797914; cv=none; b=NsYMe8vsmJGFq2QeVREc+86ykKBea1mYZiSRY65I6dTuGcWCe3beKtyRrZxdAyhif+X/Hq/XLpqqIPXm3VdIl47bmGaHaXOzMf4u9qrMvsK4XWXQ40DDqEaCBIkVC7fzNjAQAaNdfTqTu1+/+q/cbgdDEGbUBgjwecW7I/jI4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797914; c=relaxed/simple;
	bh=Fgmg1M4UClotPKFlIxIOoOkvR68tef4nDQC5gnUtyts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSIJ9mdjnd2hYs0mLzASqzeVYXoRCMPrjsNQ2sCAEtEbPOhJgsYTATR5zmsPIjSFQTOs7g8BFoJGo3wl5HZLeh7oaWxRstDA6tPvP2Ie9C9Cn5uYFehAReuVEHQkbGNam7hGfx3liUn/vT2pzlyCtK6HfSMqmqYaOfstGgbv2VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wbadnick; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wbadnick"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QN6QB9B8Xj3pBlV9n9AQf/VNc61CChfrHrRrkMOoDy8=;
	b=WbadnickcISImMzxSv4QFqz9R6vFrAQoxZBj3ijDXLrQy6ACvjKUzEcIh7ayzruPAy9Rou
	Gw73jO6x4WKyDkUJCqaADxnQgXRrIWWWwhQd8QcDQi5TWSvXDMu98HurY9ae02qzEPyXM9
	JQ78cRRFDwc+IOfqhWSCzc11wqLNtyI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-qQJWa0hpMYSF7IsbxqohCw-1; Thu,
 18 Jun 2026 11:51:48 -0400
X-MC-Unique: qQJWa0hpMYSF7IsbxqohCw-1
X-Mimecast-MFC-AGG-ID: qQJWa0hpMYSF7IsbxqohCw_1781797907
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF7AE1954B35;
	Thu, 18 Jun 2026 15:51:46 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 659AF3000232;
	Thu, 18 Jun 2026 15:51:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/20] afs: Miscellaneous fixes
Date: Thu, 18 Jun 2026 16:51:19 +0100
Message-ID: <20260618155141.2513212-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Christian,

Can you pick up these miscellaneous AFS fixes, please?

 (1) Fix the CB.InitCallBackState3 service handler to handle an unknown
     server (server pointer is NULL).

 (2) Fix the clobbering of the default error code in
     afs_extract_vl_addrs().

 (3) Fix a NULL pointer in a trace point in afs_get_tree().

 (4) Fix double netfs_inode initialisation in afs_root_iget().

 (5) Fix setting of AS_RELEASE_ALWAYS for symlinks (and mountpoints) as
     there's no release_folio function provided.  The pagecache isn't used
     by afs for symlinks and directories.

 (6) Fix the order of inode init to avoid clobbering
     NETFS_ICTX_SINGLE_NO_UPLOAD set on directories.

 (7) Fix the release of op->more_files to Use kvfree().

 (8) Fix erroneous seq |= 1 in volume lookup loop.

 (9) Drop for duplicate server records when parsing DNS reply into the VL
     server list (this is not strictly a bug fix, so could be punted to the
     merge window).

(10) Fix malfunction in bulk lookup due to change in dir_emit() API added
     to mask off DT_* flags for overlayfs on fuse.

(11) Fix misplaced inc of net->cells_outstanding causing netns destruction
     hang.

(12) Fix reinitialisation of afs_vnode::lock_work.  Not reinitialising it
     after allocation seems to upset DEBUG_OBJECTS despite there being an
     slab init-once handler provided.

(13) Fix callback service message parsers to pass through -EAGAIN when
     insufficient data yet received.

(14) Switch to using scoped_seqlock_read() in volume lookup loop as a
     follow up to (6).

(15) Fix leak of a volume we failed to get because its refcount had hit 0.

(16) Fix missing NULL pointer check in afs_break_some_callbacks().

(17) Fix leak of empty new vllist in afs_update_cell().

(18) Fix modifications of net->cells_dyn_ino to use locking; this requires
     the use of preallocation as the allocation has to be done under
     spinlock.

(19) Fix afs_insert_volume_into_cell() to set AFS_VOLUME_RM_TREE on the
     old volume, not the new.

(20) Fix afs_extract_vlserver_list() to limit the string displayed in the
     debug statement.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

Changes
=======
ver #3)
- Relabelled the patch that switched to using scoped_seqlock_read().
- Moved a bit from scoped_seqlock_read() patch to the preceding patch that
  had got committed to the wrong patch.
- Merged the two AS_RELEASE_ALWAYS patches.
- Moved patch to remove double-init from afs_root_iget() before
  AS_RELEASE_ALWAYS patch.
- Moved the patch to check for a NULL pointer in afs_break_some_callbacks()
  before the patch to lookup the volume that might then return NULL.
- Addressed some Sashiko comments[2]:
  - Made the ->lock_work reinit patch also flush the work when evicting an
    inode.
  - Made the afs_break_some_callbacks() NULL check patch drop the RCU lock
    and clear the count if the server is unknown.
  - Added some new fix patches.

ver #2)
- Added patches to fix issues raised by Sashiko[1]

[1] https://sashiko.dev/#/patchset/20260609081738.770127-1-dhowells%40re
[2] https://sashiko.dev/#/patchset/20260618074903.2374756-1-dhowells%40redhat.com

Dan Carpenter (1):
  afs: Fix error code in afs_extract_vl_addrs()

David Howells (14):
  afs: Fix double netfs initialisation in afs_root_iget()
  afs: Remove setting of AS_RELEASE_ALWAYS for symlinks and mountpoints
  afs: Fix directory inode initialisation order
  afs: Fix bulk lookup malfunction due to change in dir_emit() API
  afs: Fix misplaced inc of net->cells_outstanding
  afs: Fix reinitialisation of the inode, in particular ->lock_work
  afs: Fix callback service message parsers to pass through -EAGAIN
  afs: Use scoped_seqlock_read() rather than manually doing seqlock
    stuff
  afs: Fix missing NULL pointer check in afs_break_some_callbacks()
  afs: Fix leak of ungot volume
  afs: Fix vllist leak
  afs: Fix lack of locking around modifications of net->cells_dyn_ino
  afs: Fix the volume AFS_VOLUME_RM_TREE is set on
  afs: Fix unchecked-length string display in debug statement

Li RongQing (1):
  afs: Remove erroneous seq |= 1 in volume lookup loop

Matvey Kovalev (1):
  afs: fix NULL pointer dereference in afs_get_tree()

Nan Li (1):
  afs: handle CB.InitCallBackState3 requests without a server record

Yuto Ohnuki (1):
  afs: check for duplicate servers in VL server list

Zilin Guan (1):
  afs: use kvfree() to free memory allocated by kvcalloc()

 fs/afs/callback.c     | 17 +++++++----------
 fs/afs/cell.c         | 12 ++++++++++--
 fs/afs/cmservice.c    |  7 +++++--
 fs/afs/dir.c          | 32 +++++++++++++++++++++-----------
 fs/afs/fs_operation.c |  2 +-
 fs/afs/inode.c        | 15 +++++++--------
 fs/afs/internal.h     |  3 +--
 fs/afs/main.c         |  1 +
 fs/afs/super.c        |  5 +++--
 fs/afs/vl_list.c      | 24 +++++++++++++++++++++---
 fs/afs/volume.c       |  2 +-
 11 files changed, 78 insertions(+), 42 deletions(-)

