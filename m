Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFAA39C019
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119373; cv=none; b=t4GWQb6zxzoIYBWfYXV0Mu/WuK3GCtG4NVDuehwbkG97rHPokxoGoZThNgBIppKrwW9PecfkLEun6Em/89PGIIin0xM2qxwXWFfXrzmvc62TrDZ9dn9uWvKtRgWR7HFRTq6XqA+eQSWS/8dwWLBZFNRafYWtj9iBsBjJiTLLsIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119373; c=relaxed/simple;
	bh=iQtx8dJ1H75UyPTc9jNPVBqavNS4Gkuvx4tGLdQKHJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5HgodiN6r7cwhpmZhpspNiPgDC0Cb93dMDSaolwrUfTaCg+ksDpJRCNsFWkWko4NM+ahmn2fwtPOWclA+kGW2pNq07KVoHhp9ALo3p9R4wBVGJx1qSYVQ8Qiukh+sWbXAlpnjOULQF0hq+z7T1/Gv9Tne5dGuT00OxMqY/fliA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXDg0inh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXDg0inh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782119371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HKD12eeMPKp0iBSty4CB/WcgM2VDHkm0pAmvTc2/RI=;
	b=JXDg0inhBoEsS839WF5WE1jKhimrbG6DTBmzcbVLbl0blMCE2juEYTipPbT5LHU1KeL5sH
	+ZoB76yplhDOwP1A3gbZ0cToFrtk4VJjc3+7Q+dX6Tt//tueXQjvqTZz5Pp0CHii6kZ6Ap
	9Zsc1NSigsnr1gAKAjn1SjJzLfesVHo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-KECnKP3sNXKR6vbDI-_RPA-1; Mon,
 22 Jun 2026 05:09:27 -0400
X-MC-Unique: KECnKP3sNXKR6vbDI-_RPA-1
X-Mimecast-MFC-AGG-ID: KECnKP3sNXKR6vbDI-_RPA_1782119366
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 578ED1955E92;
	Mon, 22 Jun 2026 09:09:26 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.242])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 155E11956096;
	Mon, 22 Jun 2026 09:09:23 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepakkumar Karn <dkarn@redhat.com>
Subject: [PATCH v4 05/21] afs: Remove setting of AS_RELEASE_ALWAYS for symlinks and mountpoints
Date: Mon, 22 Jun 2026 10:08:39 +0100
Message-ID: <20260622090856.2746629-6-dhowells@redhat.com>
In-Reply-To: <20260622090856.2746629-1-dhowells@redhat.com>
References: <20260622090856.2746629-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Regular AFS files correctly use afs_file_aops which have release_folio
set as netfs_release_folio, so AS_RELEASE_ALWAYS is valid for them
when fscache is enabled (set via afs_vnode_set_cache()).
Symlinks and mountpoints in AFS use afs_dir_aops, which does not provide
a release_folio callback. However, afs_apply_status() unconditionally
calls mapping_set_release_always() for these.

In such case when memory management code attempts to release folios,
filemap_release_folio() checks folio_needs_release() which
returns true due to AS_RELEASE_ALWAYS being set. Since there is no
release_folio callback, it falls through to try_to_free_buffers(),
which at present expects buffer_heads to be not null. For symlinks
and mountpoints without buffer_heads, this causes pointer dereference.

[dh: Added more bits that were missed]

Fixes: eae9e78951bb ("afs: Use netfslib for symlinks, allowing them to be cached")
Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/inode.c    | 7 +++----
 fs/afs/internal.h | 2 --
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index a88995629d72..54ac6ec21daf 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -52,9 +52,9 @@ static noinline void dump_vnode(struct afs_vnode *vnode, struct afs_vnode *paren
 /*
  * Set parameters for the netfs library
  */
-static void afs_set_netfs_context(struct afs_vnode *vnode)
+static void afs_set_netfs_context(struct afs_vnode *vnode, bool is_file)
 {
-	netfs_inode_init(&vnode->netfs, &afs_req_ops, true);
+	netfs_inode_init(&vnode->netfs, &afs_req_ops, is_file);
 }
 
 /*
@@ -126,7 +126,6 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 		}
 		inode->i_mapping->a_ops	= &afs_symlink_aops;
 		inode_nohighmem(inode);
-		mapping_set_release_always(inode->i_mapping);
 		break;
 	default:
 		dump_vnode(vnode, op->file[0].vnode != vnode ? op->file[0].vnode : NULL);
@@ -136,7 +135,7 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 
 	i_size_write(inode, status->size);
 	inode_set_bytes(inode, status->size);
-	afs_set_netfs_context(vnode);
+	afs_set_netfs_context(vnode, status->type == AFS_FTYPE_FILE);
 
 	vnode->invalid_before	= status->data_version;
 	trace_afs_set_dv(vnode, status->data_version);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0b72a8566299..785c646856d7 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -750,8 +750,6 @@ static inline void afs_vnode_set_cache(struct afs_vnode *vnode,
 {
 #ifdef CONFIG_AFS_FSCACHE
 	vnode->netfs.cache = cookie;
-	if (cookie)
-		mapping_set_release_always(vnode->netfs.inode.i_mapping);
 #endif
 }
 

