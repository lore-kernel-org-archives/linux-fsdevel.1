Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC793DA5DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769008; cv=none; b=rb+dmolbuXEgVul4KZdrpkRJJoihrRV6cZRBZJQgWkXTzJxbsT5rVH0hobfKhl8q8a+iypVtdfVJTpSzjASHW/cPUqwcP/AAK8zipNdLqU3IX9ozJK4PDZrM/BPJS4K+xiOjDZi6xxVXvP4LdKTTFoDvlVpaghpg3qtwYGAya7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769008; c=relaxed/simple;
	bh=lHX7SXN9QcR7/+eiG4BAqSh70kmB53bcxrLZ23jf4Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5+AOgh5kbrFKCzTCkVIV+9VwUi3F4G4vmMYD6aRi784o4bdypP1uuHLq5FkQ5ba0kDSRhjC1iTl7EoR0FoSzW+5L0hD43OfzFIreaW22OQiFWjZGysWlHDJBOM3TpxhC1FFG6DE+JPP9yrx7vxTcpIlp0uALoRnC1VfIVKY8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0jNqyCz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0jNqyCz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781769006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PsqzbHKwELe5vH9eWvOGYV1oenxPW48nVMaThPyMZKE=;
	b=Z0jNqyCzPKkNn3VakFpGASl81M5/j4lGdMB0XuZnji5jnRs/yUXJ0eD6/LJ+S1W+/2QjQ7
	gQd4VdbT/HZjxzWGabGPmoi8saiEU48yW1YG4aS0BWL1T5GWXnts2gzJYlE+/WkGJfRiTG
	lwEZ0+jXwRvW5LOvGSJoSBzdpCkMZfQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-_i3KEpc5OmysdZ3BuEN3SQ-1; Thu,
 18 Jun 2026 03:50:04 -0400
X-MC-Unique: _i3KEpc5OmysdZ3BuEN3SQ-1
X-Mimecast-MFC-AGG-ID: _i3KEpc5OmysdZ3BuEN3SQ_1781769003
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6597B1800590;
	Thu, 18 Jun 2026 07:50:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B9D31956086;
	Thu, 18 Jun 2026 07:50:00 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepakkumar Karn <dkarn@redhat.com>
Subject: [PATCH v2 13/17] afs: Don't use AS_RELEASE_ALWAYS for dir/symlinks part 2
Date: Thu, 18 Jun 2026 08:48:56 +0100
Message-ID: <20260618074903.2374756-14-dhowells@redhat.com>
In-Reply-To: <20260618074903.2374756-1-dhowells@redhat.com>
References: <20260618074903.2374756-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

As an addendum to a previous patch, don't enable AS_RELEASE_ALWAYS for afs
dirs and symlinks in a couple of other places.  Turning this flag on for
those file types is ineffective as they don't have any folios in their
->i_pages.

Fixes: eae9e78951bb ("afs: Use netfslib for symlinks, allowing them to be cached")
Closes: https://sashiko.dev/#/patchset/20260609081738.770127-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Deepakkumar Karn <dkarn@redhat.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index c8df1764d414..54ac6ec21daf 100644
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
@@ -135,7 +135,7 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 
 	i_size_write(inode, status->size);
 	inode_set_bytes(inode, status->size);
-	afs_set_netfs_context(vnode);
+	afs_set_netfs_context(vnode, status->type == AFS_FTYPE_FILE);
 
 	vnode->invalid_before	= status->data_version;
 	trace_afs_set_dv(vnode, status->data_version);

