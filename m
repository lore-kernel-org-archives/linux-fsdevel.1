Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C743C942B
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768960; cv=none; b=an9DJcN/60iY+AWhsrYlbvilfW2OZ4MqM+KDGkndvgYWV3pWd4inyx/csuv+hEh0tqYrxKYWbZzAZXj0cDBVyxNYRdSWskM4xHCxT3rtlpm3ptpXqxmotr/PjXcQHgtYj/PHUhcVA0puFiHvLZjIpIuYJ+myA2ubpti5o+bokf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768960; c=relaxed/simple;
	bh=9D2d6aiFEHIAIMQ3paTTCCNzLMZSxroQaEHX6YrmzqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AlNrwSK9TfjjnucCCcvZ/0uf4fy/oGVFVFFnE2/CMAV4Dz1ZZLVDnPnlPGIAfdTgVy0rqrHQpmNZsHU3s82iuivbTwuCIciBj+pexf/3ntlB/nR0qJftFdz4XoXFMcIcudIyzurQPH7v5Cu9GN864l4l+OPbYDOniVe7fIKbpSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWiQBgUZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWiQBgUZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781768957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E+9iAqnJ+k42JohY0zFHNvS/Rojpn4Ae9vbdriqzH+c=;
	b=WWiQBgUZRJEZk9Yk6G7/9RXsbuxlKoqpDsaioljoNJhOYeBMqPIfB96CzvChEVtfO6AEM/
	zsrHI8FR9yfB4YkSZMVbyuJ2HX3Qad47LNaS8l+uEGfuWjzPUBaEbWWL5IInCcciqu+08T
	6pE3IY+UlJeB/7hkb5pKIUlBrCANAU4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-bBUK2DN2NliItnt4dXOcog-1; Thu,
 18 Jun 2026 03:49:11 -0400
X-MC-Unique: bBUK2DN2NliItnt4dXOcog-1
X-Mimecast-MFC-AGG-ID: bBUK2DN2NliItnt4dXOcog_1781768950
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8598A1956051;
	Thu, 18 Jun 2026 07:49:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA0C31956086;
	Thu, 18 Jun 2026 07:49:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/17] afs: Miscellaneous fixes
Date: Thu, 18 Jun 2026 08:48:43 +0100
Message-ID: <20260618074903.2374756-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Christian,

Can you pick up these miscellaneous AFS fixes, please?

 (1) Fix the CB.InitCallBackState3 service handler to handle an unknown
     server (server pointer is NULL).

 (2) Fix the clobbering of the default error code in
     afs_extract_vl_addrs().

 (3) Fix a NULL pointer in a trace point in afs_get_tree().

 (4) Fix setting of AS_RELEASE_ALWAYS for symlinks (and mountpoints) as
     there's no release_folio function provided.  The pagecache isn't used
     by afs for symlinks and directories.

 (5) Fix the release of op->more_files to Use kvfree().

 (6) Fix erroneous seq |= 1 in volume lookup loop.

 (7) Drop for duplicate server records when parsing DNS reply into the VL
     server list (this is not strictly a bug fix, so could be punted to the
     merge window).

 (8) Fix malfunction in bulk lookup due to change in dir_emit() API added
     to mask off DT_* flags for overlayfs on fuse.

 (9) Fix misplaced inc of net->cells_outstanding causing netns destruction
     hang.

(10) Fix reinitialisation of afs_vnode::lock_work.  Not reinitialising it
     after allocation seems to upset DEBUG_OBJECTS despite there being an
     slab init-once handler provided.

(11) Fix callback service message parsers to pass through -EAGAIN when
     insufficient data yet received.

(12) Fix double netfs_inode initialisation in afs_root_iget().

(13) Further fixing of AS_RELEASE_ALWAYS handling.

(14) Switch to using scoped_seqlock_read() in volume lookup loop as a
     follow up to (6).

(15) Fix leak of a volume we failed to get because its refcount had hit 0.

(16) Fix missing NULL pointer check in afs_break_some_callbacks().

(17) Fix leak of empty new vllist in afs_update_cell().

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

Changes
=======
ver #2)
- Added patches to fix issues raised by Sashiko[1]

[1] https://sashiko.dev/#/patchset/20260609081738.770127-1-dhowells%40re

Dan Carpenter (1):
  afs: Fix error code in afs_extract_vl_addrs()

David Howells (11):
  afs: Remove setting of AS_RELEASE_ALWAYS for symlinks and mountpoints
  afs: Fix bulk lookup malfunction due to change in dir_emit() API
  afs: Fix misplaced inc of net->cells_outstanding
  afs: Fix reinitialisation of the inode, in particular ->lock_work
  afs: Fix callback service message parsers to pass through -EAGAIN
  afs: Fix double netfs initialisation in afs_root_iget()
  afs: Don't use AS_RELEASE_ALWAYS for dir/symlinks part 2
  afs: Remove erroneous seq |= 1 in volume lookup loop
  afs: Fix leak of ungot volume
  afs: Fix missing NULL pointer check in afs_break_some_callbacks()
  afs: Fix vllist leak

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

 fs/afs/callback.c     | 15 +++++----------
 fs/afs/cell.c         |  4 +++-
 fs/afs/cmservice.c    |  7 +++++--
 fs/afs/dir.c          | 32 +++++++++++++++++++++-----------
 fs/afs/fs_operation.c |  2 +-
 fs/afs/inode.c        |  8 +++-----
 fs/afs/internal.h     |  2 --
 fs/afs/super.c        |  5 +++--
 fs/afs/vl_list.c      | 18 ++++++++++++++++--
 9 files changed, 57 insertions(+), 36 deletions(-)

