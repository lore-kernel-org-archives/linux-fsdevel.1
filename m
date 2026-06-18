Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43062F260C
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797940; cv=none; b=OZL7lCA5HVTVqwzJZrFTAG+IcgXIrgyWNNwZxrVCbp9q5uGpqb8cwSXnPl3GvbGdGslvry37FK6lChZd1H3CGy3sVtGABnG1o5EsQplBMSyPM4VPSBM0U8Ateoc4pj/jod+bXOlFJ5pScud/rvudi0RMZasB1wndNkQ7k/zJPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797940; c=relaxed/simple;
	bh=BzAy9vOlIl1GkEbdmZ/Yvd0aG0LXsNqv7b45yxqnrto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmZVBWghb+N7tEFzwd5yZd8cwZFQXTtxNrEtK4nBDnUH5iqvOsRnIUIe+wwU22UguwP1ikFsQYKQelvRYIcHQtNjcmlRPjTJhdW/g7TrvI/6mkiPLjHNUPsmyPxTmaiHgN3IqTTGur16nJlylQ6c0pLk+wyqAiyHw1yDr0Sw1+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BX9NzUQP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BX9NzUQP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WT83b6gXE3N1B9YG199zJ4htShGRe10XfT/ZY1w3/Wo=;
	b=BX9NzUQPhvrGTbxlShWMp1Wf4WAW7U1iUrVnTT7zCRNFj/KyBBC13LH+6D+51qVb4WPUyd
	Vwkib028510YqHxcvce+rwWz0QL79ZkWFaBXhYcygvaVN9LAfQItrUFCvnDYQ3Co3UrXYJ
	wOHgxYg4M+/lJM0UddGaII9Lr3UkSeE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-Ah3mmNyXO0mlF0YQpIOkZA-1; Thu,
 18 Jun 2026 11:52:14 -0400
X-MC-Unique: Ah3mmNyXO0mlF0YQpIOkZA-1
X-Mimecast-MFC-AGG-ID: Ah3mmNyXO0mlF0YQpIOkZA_1781797933
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E21F195609E;
	Thu, 18 Jun 2026 15:52:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5632C1956045;
	Thu, 18 Jun 2026 15:52:10 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/20] afs: Fix directory inode initialisation order
Date: Thu, 18 Jun 2026 16:51:25 +0100
Message-ID: <20260618155141.2513212-7-dhowells@redhat.com>
In-Reply-To: <20260618155141.2513212-1-dhowells@redhat.com>
References: <20260618155141.2513212-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix afs_inode_init_from_status() to call afs_set_netfs_context() before the
switch to do file type-specific initialisation because local directory
changes don't get uploaded to the server, only stored in the cache.

This requires that the file size be set before, so move that up too.

Without this, NETFS_ICTX_SINGLE_NO_UPLOAD as set on directories gets
clobbered.

Closes: https://sashiko.dev/#/patchset/20260618074903.2374756-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Fixes: 6dd80936618c ("afs: Use netfslib for directories")
---
 fs/afs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 54ac6ec21daf..51c28f148845 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -93,6 +93,10 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 	inode->i_gid = make_kgid(&init_user_ns, status->group);
 	set_nlink(&vnode->netfs.inode, status->nlink);
 
+	i_size_write(inode, status->size);
+	inode_set_bytes(inode, status->size);
+	afs_set_netfs_context(vnode, status->type == AFS_FTYPE_FILE);
+
 	switch (status->type) {
 	case AFS_FTYPE_FILE:
 		inode->i_mode	= S_IFREG | (status->mode & S_IALLUGO);
@@ -133,10 +137,6 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 		return afs_protocol_error(NULL, afs_eproto_file_type);
 	}
 
-	i_size_write(inode, status->size);
-	inode_set_bytes(inode, status->size);
-	afs_set_netfs_context(vnode, status->type == AFS_FTYPE_FILE);
-
 	vnode->invalid_before	= status->data_version;
 	trace_afs_set_dv(vnode, status->data_version);
 	inode_set_iversion_raw(&vnode->netfs.inode, status->data_version);

