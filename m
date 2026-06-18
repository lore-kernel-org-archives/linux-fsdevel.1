Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626CA3D669C
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768977; cv=none; b=lULLi0jmeaW2sX9OK48pClNNuyckfiR6OUlfaCt2IF4knivLSGnazKiHW5MJO4/RKDS9xyfFsXMuDCRuvzDYyAMeeAfSGC1j75uJ7YJg1VRZN3KSzWNcrEldHdCumH00WSXIu1ygH9VK5vtJYEX/0bkaYj4K8EkysdnUgVyImMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768977; c=relaxed/simple;
	bh=rEAJILyxD7sMPEejWjVgehmQCWVRSy8KW1d0CkA5HEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMGxLc6Op1g1NgFLJnuO8bReJtpA2dpIBnHzbXJ/1ax7v1pFX45Fhlkj1JPlYtyRybefejhg9BiIRwocVxooe4Vp/YH0CDYpZeWxqvTnRb8WAyTAgm5FYbWNIB+Dl3WbFVIko5kT4ukcVWC52RSxvPvx9dSbHTcwE7TlkSTQvt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqBbP2kF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqBbP2kF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781768975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ad4bOx2SpIIPU8J+eqnXFfIiUmSYQ9scsCpmfgKcDgY=;
	b=JqBbP2kFuNWvtg9ZU7CPKaUNJgVb6kg49t3ierjZ0sVUAlrUNc05oWQD9/Z4/DXg3jyMoo
	GKb/DQ+UABYNoLf2puvdyYv+xe6FtxHqQF5Fy7sjWS6TM5bc5kcOHjs8Tq9A3sMax2iTEX
	Mf49zS867JlP/8BmPwMCxhz2P4R4VaE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-7PcavM6yPoa5c2ozc35HaA-1; Thu,
 18 Jun 2026 03:49:29 -0400
X-MC-Unique: 7PcavM6yPoa5c2ozc35HaA-1
X-Mimecast-MFC-AGG-ID: 7PcavM6yPoa5c2ozc35HaA_1781768968
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58DDB1956040;
	Thu, 18 Jun 2026 07:49:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBB1A30001BE;
	Thu, 18 Jun 2026 07:49:25 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepakkumar Karn <dkarn@redhat.com>
Subject: [PATCH v2 04/17] afs: Remove setting of AS_RELEASE_ALWAYS for symlinks and mountpoints
Date: Thu, 18 Jun 2026 08:48:47 +0100
Message-ID: <20260618074903.2374756-5-dhowells@redhat.com>
In-Reply-To: <20260618074903.2374756-1-dhowells@redhat.com>
References: <20260618074903.2374756-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Fixes: eae9e78951bb ("afs: Use netfslib for symlinks, allowing them to be cached")
Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 3f48458694ba..21ac098d03ef 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -126,7 +126,6 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 		}
 		inode->i_mapping->a_ops	= &afs_symlink_aops;
 		inode_nohighmem(inode);
-		mapping_set_release_always(inode->i_mapping);
 		break;
 	default:
 		dump_vnode(vnode, op->file[0].vnode != vnode ? op->file[0].vnode : NULL);

