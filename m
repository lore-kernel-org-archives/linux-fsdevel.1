Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92E33A029
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797974; cv=none; b=jWaKk8paBbWqniLdYI+EvZsQ7BujA24Z/ruzBV1Iurmv9B03uoW2AjqIonC6H+DKGcB5nTyRA8kYjT4EVAmf1oSyBHrest86PL4BHsLWcewCgkZXW2SCpUJZMffgLDSUJZiI2G2U7ix9HNl1L4/ypp+83BtP5Vgqqx12cd6kb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797974; c=relaxed/simple;
	bh=emZ0QDE8xtwAHSOOHBkl2wF5xEV74Ei+8u0Wic4KOzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zfzu4rBYImLrR+iYM48HsRk8NJKSh+NyUnDvpWfRmAHK+hZBpJJ2gswhr0cvpO4VP8D2KHg8ny79ZOpu3E1uKFvvhsGgfSQ0hev3cFhiNxA8NS5bHv69DolC6KMc24lvAX0wNtN2Iq9igVwcUWdn4CrnyIwC8keL5zDI6A6ciNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLz0ToFx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLz0ToFx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHyOfb8VJSFVtmkEeEvssOoq5TzHE5avjjCbE1NwPK8=;
	b=GLz0ToFxjEdzFKEtMfU/TLNrsGBaqoFii8r9IgIxk0/lKTRVjYvc/sUtXgOGYFXbvq8l9A
	gHaC54hCcOBRRBPOKdObDZEPNeMaq+MEocT0nOWIMECJzVwduPG81/GnpXgmm0+3rfF1Cc
	T+PeuFVAuxqQVFovjW8PLThCyXqFW80=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-fq9xbJ9JPMGmYLWk5V9FoQ-1; Thu,
 18 Jun 2026 11:52:49 -0400
X-MC-Unique: fq9xbJ9JPMGmYLWk5V9FoQ-1
X-Mimecast-MFC-AGG-ID: fq9xbJ9JPMGmYLWk5V9FoQ_1781797968
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1AE81801BDF;
	Thu, 18 Jun 2026 15:52:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC9553000232;
	Thu, 18 Jun 2026 15:52:46 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/20] afs: Fix missing NULL pointer check in afs_break_some_callbacks()
Date: Thu, 18 Jun 2026 16:51:34 +0100
Message-ID: <20260618155141.2513212-16-dhowells@redhat.com>
In-Reply-To: <20260618155141.2513212-1-dhowells@redhat.com>
References: <20260618155141.2513212-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix afs_break_some_callbacks() to check to see if afs_lookup_volume_rcu()
returned NULL (e.g. the specified volume is unknown).

Fixes: 8230fd8217b7 ("afs: Make callback processing more efficient.")
Closes: https://sashiko.dev/#/patchset/20260609081738.770127-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/callback.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index dd7a407ea368..74853e0d0435 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -213,7 +213,11 @@ static void afs_break_some_callbacks(struct afs_server *server,
 
 	rcu_read_lock();
 	volume = afs_lookup_volume_rcu(server->cell, vid);
-	if (cbb->fid.vnode == 0 && cbb->fid.unique == 0) {
+	if (!volume) {
+		/* Ignore breaks on unknown volumes. */
+		rcu_read_unlock();
+		*_count = 0;
+	} else if (cbb->fid.vnode == 0 && cbb->fid.unique == 0) {
 		afs_break_volume_callback(server, volume);
 		*_count -= 1;
 		if (*_count)

