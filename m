Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9837A49D
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119415; cv=none; b=CW4x8CT1447nFEYUjTUVH7jJ7ANSULtesOnkyw6ghyCOj5DBTB0Xfw6cn4wj+xr8MpPZZmEgvm0hmXfIvWphiJdI+E53UaU2wDUzrMAE+oXD/RGSiBodJdHvfz/v6xRVrH1jLp963wQqLoFjNWzqDC2Y8AG5Qb7dE1DNNG98nBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119415; c=relaxed/simple;
	bh=emZ0QDE8xtwAHSOOHBkl2wF5xEV74Ei+8u0Wic4KOzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY7jFlHyyZ7C2tQKYp89NuV8phrWJfoGxgD/muER3/DKMA1srUtWf8YabrrXxPNjgX88bQwmDx4V+PssmZ1cppIgwQJGeUiysyCv492B77BVOhlrh6ThWpLOL20BTKtY1hGSpp5MqzU9TmXEqF5mAkzN3jjgDS2ovBj2QadHDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mu6ynbOT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mu6ynbOT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782119413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHyOfb8VJSFVtmkEeEvssOoq5TzHE5avjjCbE1NwPK8=;
	b=Mu6ynbOTZCyxZX4KElfPuNDtilXvajo3F/aL6Gp5ZhVWyv0W54JUrXomIi/7bFfeOuKkz0
	CoIkIX2yvKWLXGHiV0dxwokNPlcJOF/sXeLlI54ZI1IzYcPmVrIG0oFBzFphS59sYQR3Eb
	dN0kmrzH0r7uoJ9rJbrHn6Fh6TLLkEI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-tGA2uRdYO6a6t1E04Ch3Ug-1; Mon,
 22 Jun 2026 05:10:08 -0400
X-MC-Unique: tGA2uRdYO6a6t1E04Ch3Ug-1
X-Mimecast-MFC-AGG-ID: tGA2uRdYO6a6t1E04Ch3Ug_1782119407
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F65A1955F2B;
	Mon, 22 Jun 2026 09:10:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.242])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90B073001D84;
	Mon, 22 Jun 2026 09:10:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/21] afs: Fix missing NULL pointer check in afs_break_some_callbacks()
Date: Mon, 22 Jun 2026 10:08:49 +0100
Message-ID: <20260622090856.2746629-16-dhowells@redhat.com>
In-Reply-To: <20260622090856.2746629-1-dhowells@redhat.com>
References: <20260622090856.2746629-1-dhowells@redhat.com>
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

