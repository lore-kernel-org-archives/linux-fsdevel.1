Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D673382CB
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916471; cv=none; b=E7G4PmRkF3W4i6FCX0zZYetL/Y4zAeVQsq0KwexG3CUtkab45H7rZNu6zaQzF6DZ9y7W3Lbfsnw2SY9abPkKfyvK0Z46+VP3v+LzassaPfb5gyBL1fg8azK+L5qv9vk9F+PD2zAXZMYvtBOkzIWUzGvi+KFkCTw7hOJj4AYRkhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916471; c=relaxed/simple;
	bh=zCn6k7fVSwDKNjYQcLsJhgnoIKgVJdzHCvisjw+2l4Q=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=CHv8DnBV5u3noPFSqb6w0np3SdcfpQzm9ETLUUL7ye8SKUkCW1q2f5TfBmCe2hYOML1/XY+o5PTZZiYnwlLRCQjHn3nwpe8AYE+I8dWuNiLSDL0qoLFwrAV4oyEeHqTQf9GRvedFEgvZibWyrltJK9ddY5sga0RAgKgnNUMTHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONuRDCyr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONuRDCyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780916468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jt0WpMXiaZz1AuYcn2oxrTzIXB0k/HjkL2rexRdmGyw=;
	b=ONuRDCyrK6YRVJQ5JiYgD6VCX8/DjhizNGIqM9SFH3VBN6rsKDF4/CA3Ow89XjOZSBqTaG
	MZokDy7SOWMYbdhQVKkf3uHeDYWqqW9pTdAZnS5fGjTyRBcHhZz5hXuTNgEmZ6ZcNQI004
	fDMOb20jliGmK9E+3LTRCblUwbyYYow=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-IxHbEggeN7ycyd0rUrVZvw-1; Mon,
 08 Jun 2026 07:01:05 -0400
X-MC-Unique: IxHbEggeN7ycyd0rUrVZvw-1
X-Mimecast-MFC-AGG-ID: IxHbEggeN7ycyd0rUrVZvw_1780916464
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 341301955DA0;
	Mon,  8 Jun 2026 11:01:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.43])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F04771800361;
	Mon,  8 Jun 2026 11:01:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix decision whether to disallow write-streaming due to fscache use
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <419379.1780916460.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 12:01:00 +0100
Message-ID: <419380.1780916460@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

netfs_perform_write() buffers data by writing it into the pagecache for
later writeback.  If the folio it wants to write to isn't present, it uses
"write streaming" in which is will store partial data in a non-uptodate,
but dirty folio.

However, when fscache is in use, this is a potential problem as writes to
the cache have to be aligned to the cache backend's DIO granularity, and s=
o
netfs_perform_write() attempts to suppress write-streaming in such a case,
requiring the folio content to be fetched first unless the entire folio is
going to be overwritten.  This allows the content to be written to the
cache too.

Unfortunately, the test netfs_perform_write() uses isn't correct because i=
t
doesn't take into account the fact that the object lookup is asynchronous
and farmed off to a work queue, so there's a short window in which the
cache is doing a lookup but the test fails because the answer is undefined=
.

This can be triggered by the generic/464 xfstest, and causes a warning to
be emitted in cachefiles (in code not yet upstream) because it sees a writ=
e
that doesn't have its bounds rounded out to DIO alignment.

Fix this by changing the condition to whether FSCACHE_COOKIE_IS_CACHING is
set on a cookie rather than whether the cookie is marked enabled.  Note
that this is really just a hint as to whether we allow write streaming or
not and no other aspects of the cookie or cache object are accessed.

Reported-by: Marc Dionne <marc.dionne@auristor.com>
cc: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c |    2 +-
 fs/netfs/internal.h       |   12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 6bde3320bcec..2cdb68e6b16f 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -277,7 +277,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct=
 iov_iter *iter,
 		 * caching service temporarily because the backing store got
 		 * culled.
 		 */
-		if (netfs_is_cache_enabled(ctx)) {
+		if (netfs_is_cache_maybe_enabled(ctx)) {
 			if (finfo) {
 				netfs_stat(&netfs_n_wh_wstream_conflict);
 				goto flush_content;
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 645996ecfc80..d889caa401dc 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -239,6 +239,18 @@ static inline bool netfs_is_cache_enabled(struct netf=
s_inode *ctx)
 #endif
 }
 =

+static inline bool netfs_is_cache_maybe_enabled(struct netfs_inode *ctx)
+{
+#if IS_ENABLED(CONFIG_FSCACHE)
+	struct fscache_cookie *cookie =3D ctx->cache;
+
+	return fscache_cookie_valid(cookie) &&
+		test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags);
+#else
+	return false;
+#endif
+}
+
 /*
  * Get a ref on a netfs group attached to a dirty page (e.g. a ceph snap)=
.
  */

