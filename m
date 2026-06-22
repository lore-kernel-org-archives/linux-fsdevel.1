Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C2636BCC0
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119391; cv=none; b=HgcxqFSoJ081Ysj3npTjug/5g8cRsBx3ZyeaitF2TDxAwOUy3Vz4glKAdNpLAokYR9Yd5weUIwWssWxdHp2WcnU5MeEXifsPhlkci9AujHzearszCZnpFWon1eRhIHe/fDPoso6+TPkUSq3B1z0iej19XB2tF3B5vfs8rELrE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119391; c=relaxed/simple;
	bh=5yGL3PEJFf2X6TSkKCo77ZK11ii9FSksKLLHtbLPJIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGtbM/wT2xQPq4cULgN0RVW06YuNM8Gmdyx7NOImBYGxwRpPpiSeGm7xID8XWPd2LGVkRqqqUk/JD9l4i5LWm74U1dB8Es5Mth3qiNkUPbpZdku7t0IFi2v/A4l8hapGrdjBKX1S7F7tcS4973zHR7iWrOh9Q/OIu5yYBJH66jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUDrQE96; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUDrQE96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782119389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIqFmNE1LEqFQYtf7qHKkz6E/HgqKNnGDlkW0ueT7Q0=;
	b=VUDrQE96uwd12IocYVuIqURNgTg9r7MXkiVrCqsI6u8RWheKxRQxTRwOY/AC6zx4ZG9jEz
	k0ml/PKK4k2mx5XcT6QUmiRiPSANubVFytk/YetWMEfPgIBzkL4QKlM8j2vl4VCjFIftEq
	N07gltSbsAocE8MsRWOEf9/vMGWB144=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-gWd3FKJZPxinpKX-Xh8xtA-1; Mon,
 22 Jun 2026 05:09:45 -0400
X-MC-Unique: gWd3FKJZPxinpKX-Xh8xtA-1
X-Mimecast-MFC-AGG-ID: gWd3FKJZPxinpKX-Xh8xtA_1782119384
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0964A1955F01;
	Mon, 22 Jun 2026 09:09:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.242])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E183F18005AE;
	Mon, 22 Jun 2026 09:09:41 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuto Ohnuki <ytohnuki@amazon.com>
Subject: [PATCH v4 09/21] afs: check for duplicate servers in VL server list
Date: Mon, 22 Jun 2026 10:08:43 +0100
Message-ID: <20260622090856.2746629-10-dhowells@redhat.com>
In-Reply-To: <20260622090856.2746629-1-dhowells@redhat.com>
References: <20260622090856.2746629-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Yuto Ohnuki <ytohnuki@amazon.com>

The DNS response may contain the same server more than once. Check for
duplicates by name and port before inserting into the list to avoid
duplicate entries.

Addresses the TODO comment in afs_extract_vlserver_list().

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/vl_list.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
index 003889cf0f18..8e1cf6cdcf71 100644
--- a/fs/afs/vl_list.c
+++ b/fs/afs/vl_list.c
@@ -289,8 +289,20 @@ struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *cell,
 			afs_put_addrlist(old, afs_alist_trace_put_vlserver_old);
 		}
 
+		/* Check for duplicates in the server list */
+		for (j = 0; j < vllist->nr_servers; j++) {
+			struct afs_vlserver *s = vllist->servers[j].server;
 
-		/* TODO: Might want to check for duplicates */
+			if (s->name_len == server->name_len &&
+			    s->port == server->port &&
+			    strncasecmp(s->name, server->name, server->name_len) == 0) {
+				afs_put_vlserver(cell->net, server);
+				server = NULL;
+				break;
+			}
+		}
+		if (!server)
+			continue;
 
 		/* Insertion-sort by priority and weight */
 		for (j = 0; j < vllist->nr_servers; j++) {

