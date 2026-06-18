Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4D2F7EFE
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797970; cv=none; b=u/e/0NeLt4qJS22r8A+WqPQ/nf0hPlcykFO7s34iKEEDgePdNVhmZTPEni0R/05ofMAlxmdsv2Riyiq/T2EUqlXRSfMxjZG256SXa2lmTv/mHuAZX7D/ExsJiFFavm/X2vcOyxy8UUDyqBrBI+4tkvMwR85H3+18EoTLq6/Qe24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797970; c=relaxed/simple;
	bh=CDRo5Sn8GoMnntxTGICc+VdYzjPZ8p+5fD2/m8ruIlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlnpZJapivCp2Rmb0hy+xsjFG+b+/MLYeHDmqjzgk118L2CO+wdHDjxNNog5sOveIxmEQKIlP9iKhWBY62rltq9LC3tWdPwIiZ6WDdOo95TlPZGarHvsBDhYTE/+4SeVew/2QNyaul52dRJvJSseQviMg87KEJe65kouslqtNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsCYutp5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsCYutp5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtGq+8xrlndkaebP7J0Gra2CXKff3gN3lEQhe92RAnc=;
	b=OsCYutp5/S+NmCCnDeX+xhAaYBJgdAyEuXHa2iV7KzrV0jdEFDNG88UxezrACmBmfr1Upl
	IooJ+UVCd0TNWsoIraWeB0YJis5APd2DYsMYtXpaKPNYeFomTNhxthYnJAfbAufjALusGl
	/LqidbtH4gGUlLXnuDidB4HovnEcxRw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-MBEWvUOcNo6LT6Pv3Fq85Q-1; Thu,
 18 Jun 2026 11:52:46 -0400
X-MC-Unique: MBEWvUOcNo6LT6Pv3Fq85Q-1
X-Mimecast-MFC-AGG-ID: MBEWvUOcNo6LT6Pv3Fq85Q_1781797965
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46197195605A;
	Thu, 18 Jun 2026 15:52:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 751ED1800667;
	Thu, 18 Jun 2026 15:52:42 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>,
	Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v3 14/20] afs: Use scoped_seqlock_read() rather than manually doing seqlock stuff
Date: Thu, 18 Jun 2026 16:51:33 +0100
Message-ID: <20260618155141.2513212-15-dhowells@redhat.com>
In-Reply-To: <20260618155141.2513212-1-dhowells@redhat.com>
References: <20260618155141.2513212-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is an addendum to the patch to remove the erroneous seq |= 1 in volume
lookup loop.

Switch to using scoped_seqlock_read() as suggested by Oleg Nesterov[1].

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Li RongQing <lirongqing@baidu.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/aifaeKvz3KemfzaS@redhat.com/ [1]
---
 fs/afs/callback.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 833ac3178ddc..dd7a407ea368 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -113,16 +113,12 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 {
 	struct afs_volume *volume = NULL;
 	struct rb_node *p;
-	int seq = 1;
 
-	for (;;) {
+	scoped_seqlock_read(&cell->volume_lock, ss_lock) {
 		/* Unfortunately, rbtree walking doesn't give reliable results
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
-		seq++; /* 2 on the 1st/lockless path, otherwise odd */
-		read_seqbegin_or_lock(&cell->volume_lock, &seq);
-
 		p = rcu_dereference_raw(cell->volumes.rb_node);
 		while (p) {
 			volume = rb_entry(p, struct afs_volume, cell_node);
@@ -138,11 +134,8 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 
 		if (volume && afs_try_get_volume(volume, afs_volume_trace_get_callback))
 			break;
-		if (!need_seqretry(&cell->volume_lock, seq))
-			break;
 	}
 
-	done_seqretry(&cell->volume_lock, seq);
 	return volume;
 }
 

