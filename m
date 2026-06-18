Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF02DFA25
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797936; cv=none; b=htjzMGUGSaN90rzgnZtyqmucjGe5CIfuCT7PZAjYy+LdRznGPo1reQtvMz3EFXOQCWEOF050mIB1LSDTpSMNvTnaKM6MqoJRW/ISZPkHGHd7V8f8gXlxNwHQPQp0yAU/HgHPV5H+DliS0htZoYqdNvbZj47/YNH7lP6LSN5mGZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797936; c=relaxed/simple;
	bh=iQtx8dJ1H75UyPTc9jNPVBqavNS4Gkuvx4tGLdQKHJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxcwhfJNC6bipiyKfFAfDe2q5YTQJ0mWw5EOCQK5dLBbS0jZcv+G7KwDoo/lOP/WI9sUIRcyfUrFJ6FJvM3GB+5vrU+Eo97ziCPsh82io6tQKGSBcwuVJcIWeqKf/YHG9+IEandyC0JhsKpxjcraWJKI3+2Jlky86RV52Se/uxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IfKEM44q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfKEM44q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HKD12eeMPKp0iBSty4CB/WcgM2VDHkm0pAmvTc2/RI=;
	b=IfKEM44qvN5QRqtWtFiGZanf0Yxxp2sqwSbUjtsTkMoJ1m7B2ceBXwg65goHBh6hf1fDPp
	7UiThaP2TqzrPrapFigLZRnGkpdAaIS89WW8tNl4PCmuoLkmJSU4rCuwjQLD3wWxcQfQQq
	ep0LxvcfP9HDcwfIAsE/OYXCva11blM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-jQ_rIUKeOxK8w_kA_zOw3w-1; Thu,
 18 Jun 2026 11:52:10 -0400
X-MC-Unique: jQ_rIUKeOxK8w_kA_zOw3w-1
X-Mimecast-MFC-AGG-ID: jQ_rIUKeOxK8w_kA_zOw3w_1781797929
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70AFA19560BB;
	Thu, 18 Jun 2026 15:52:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7F5A180056E;
	Thu, 18 Jun 2026 15:52:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepakkumar Karn <dkarn@redhat.com>
Subject: [PATCH v3 05/20] afs: Remove setting of AS_RELEASE_ALWAYS for symlinks and mountpoints
Date: Thu, 18 Jun 2026 16:51:24 +0100
Message-ID: <20260618155141.2513212-6-dhowells@redhat.com>
In-Reply-To: <20260618155141.2513212-1-dhowells@redhat.com>
References: <20260618155141.2513212-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
 

