Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12DA37B00E
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878037; cv=none; b=QOU3C51JzACrLXjPXR/EUW+gm2BIzfHEksLnogKDkKdedOx5334EZbRoWTRCqSmD9qMhSLkLnueO8lGYj/ozSpi6PMSahWycSP/0z3YwULmpCMBBlzxJw598TSWrcrf42lk9OStINuLl1oG5oN2fWN8SjbDAb/1rq3obvcxhj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878037; c=relaxed/simple;
	bh=RdvGg5oUDGJEEdfGJGQ/pnwBlwSc3oIQFuXQ0iNSvAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMCzfcTC6hYrXs5crVH0dFE3ULzpCjj7Bi2Of3KF0EX2QNAn/T+IT72FtCIH28rBhscREC0Vibxa6vZ0FLT2UAvLtc8m/V9U3djI1LbaAkGTEp98oEZcO0jT9kHWdHVwAePsCBOr6eL/eUsR6PXbPen6yYixCbd5xVSjHwWHq5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIFOASjB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIFOASjB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781878034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCH9AytniZX5CSjSRd/+qJL1T4JneHVxw5zGHZC2I1o=;
	b=TIFOASjBAdrr8Hw/MJJYn+7V3hXPLHPNVsXI7gzRJpFrTjaqDpz4kvuNhTRnVhpcO0zv4O
	ifVxyZvQs/Dbkz+MfxnXOyL4E20ut5BbiyA819nbQUi9BSvv0/cy15py8zb4JkBvg3D9vl
	tIckZywVevoF6ttxAfBkXo8PrQA+9Mo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-rbFu6V7FMce8_slh70AaNw-1; Fri,
 19 Jun 2026 10:07:09 -0400
X-MC-Unique: rbFu6V7FMce8_slh70AaNw-1
X-Mimecast-MFC-AGG-ID: rbFu6V7FMce8_slh70AaNw_1781878028
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81D9B1801F36;
	Fri, 19 Jun 2026 14:07:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A151518005A4;
	Fri, 19 Jun 2026 14:07:04 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NeilBrown <neil@brown.name>
Subject: [PATCH 03/11] cachefiles: Fix file burial to take lock when unsetting S_KERNEL_FILE
Date: Fri, 19 Jun 2026 15:06:07 +0100
Message-ID: <20260619140646.2633762-4-dhowells@redhat.com>
In-Reply-To: <20260619140646.2633762-1-dhowells@redhat.com>
References: <20260619140646.2633762-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix cachefiles_bury_object() to lock the inode of the file being buried
whilst it unsets the S_KERNEL_FILE flag.

Fixes: 07a90e97400c ("cachefiles: Implement culling daemon commands")
Closes: https://sashiko.dev/#/patchset/20260616100821.2062304-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: NeilBrown <neil@brown.name>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index a464c4646c04..d4309dfb55df 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -375,7 +375,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 					    "Rename failed with error %d", ret);
 	}
 
-	__cachefiles_unmark_inode_in_use(object, d_inode(rep));
+	cachefiles_do_unmark_inode_in_use(object, d_inode(rep));
 	end_renaming(&rd);
 	_leave(" = 0");
 	return 0;

