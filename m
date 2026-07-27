Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C740A92F
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157718; cv=none; b=H8FY5b+kwg/DCddW47fcEM2ujNWFZxBV42BVLKp3fHpnY1zdlXJWYJO45TnhBvJk9JLx3XjCuI9MaT3sQwSKGU5F2W5w2F42fw/hh9HRKKWNvb/8LDhGs8DsgTQkAorO+oJb6akOewLCPDYiAoKq8DQSbEzyYt6ArpciX/6LcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157718; c=relaxed/simple;
	bh=8Cq7yC36h3gkySMZqxx0eQOgsgSHO7/JLnbYzJgpLsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPD+4fuZJfcyLpbMSlENW+CpydbX9lnmNKfwSlrn2Zk3kfO3R1BLTVSMYWwkVfpWtDSBQa7tsxi6IJG1p+zS0V5T+xlrv/0BJnNhtid0uMgce8zvkisTjU8nZ9H3Cpf78fUMiPUJbu3PQihNiuKP+XQ0Vbq3GVUSt7o6f+hjLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0+VGU42; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0+VGU42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785157716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NvkKZMiVzLvLTqBgNyHSijYHgzyt81kYyi7sTozyr8A=;
	b=Q0+VGU423MKwu5E8ZcIOfDXyOeggqaQu+qdKc+Nj8VA+PGSdYqAftMO/71khIS6VvLl3Mw
	WZFrZZBcsyG7ZgqvqyK8cgLyHbnbRDD6aOROFV0Wa4bR8E+kQlajClzAlP8TIT3tEVYKbH
	ctiZs4ha9p23X4GgPOiw9Yg5cDOXrZY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-SAAg8k5OOEeiFKrdEsF-Dw-1; Mon,
 27 Jul 2026 09:08:33 -0400
X-MC-Unique: SAAg8k5OOEeiFKrdEsF-Dw-1
X-Mimecast-MFC-AGG-ID: SAAg8k5OOEeiFKrdEsF-Dw_1785157712
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23B9F1805A0A;
	Mon, 27 Jul 2026 13:08:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B4DC19560A3;
	Mon, 27 Jul 2026 13:08:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] afs: Miscellaneous fixes
Date: Mon, 27 Jul 2026 14:08:16 +0100
Message-ID: <20260727130827.1100080-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Christian,

Can you pick up these miscellaneous AFS fixes, please?  Note that some of
these are derived from Sashiko review of some rxrpc patches[1][2].

 (1) Fix afs_fs_fetch_data() to set call->async.

 (2) Fix afs_fs_fetch_data() to subtract transferred from len instead of
     adding it.

 (3) Fix a UAF when sending a message if the call is completed so quickly
     that the sending code hasn't finished with it when it gets freed.

 (4) Fix missing kunmap in afs_dir_search_bucket().

 (5) Fix afs_edit_dir_remove() to get, not find, block 0.

 (6) Fix double-unmap of directory block.

There are also two fixes to fix the issue behind a work-around in bash that is
now being removed[3][4].

 (7) Allow filesystems with foreign owner IDs to override UID checks.

 (8) Use (7) to fix open(O_CREAT) on an extant AFS file in a sticky dir.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

[1] https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redh
[2] https://sashiko.dev/#/patchset/20260713081022.2186481-1-dhowells%40red
[3] https://groups.google.com/g/gnu.bash.bug/c/6PPTfOgFdL4/m/2AQU-S1N76UJ
[4] Link: https://git.savannah.gnu.org/cgit/bash.git/tree/redir.c?h=bash-5.3-rc1#n733

David Howells (8):
  afs: Fix afs_fs_fetch_data() to set call->async
  afs: Fix afs_fs_fetch_data() to subtract transferred from len
  afs: Fix UAF when sending a message
  afs: Fix missing kunmap in afs_dir_search_bucket()
  afs: Fix afs_edit_dir_remove() to get, not find, block 0
  afs: Fix double-unmap of directory block
  vfs: Allow filesystems with foreign owner IDs to override UID checks
  afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir

 Documentation/filesystems/vfs.rst |  21 ++++
 fs/afs/dir.c                      |   2 +
 fs/afs/dir_edit.c                 |  11 +-
 fs/afs/dir_search.c               |  11 +-
 fs/afs/file.c                     |   2 +
 fs/afs/fsclient.c                 |   5 +-
 fs/afs/inode.c                    |   1 +
 fs/afs/internal.h                 |  14 ++-
 fs/afs/security.c                 |  46 +++++++++
 fs/attr.c                         |  58 ++++++-----
 fs/coredump.c                     |   2 +-
 fs/inode.c                        |  11 +-
 fs/internal.h                     |   1 +
 fs/locks.c                        |   7 +-
 fs/namei.c                        | 161 ++++++++++++++++++++++++------
 fs/remap_range.c                  |  20 ++--
 include/linux/fs.h                |   7 +-
 17 files changed, 290 insertions(+), 90 deletions(-)

