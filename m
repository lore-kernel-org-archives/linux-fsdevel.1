Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2483D8100
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768990; cv=none; b=VZyBLAzLrF5awweTbdy36MmURulW2AlIm2nihJfeeMifxKl3I/qmDl++JxvFXnr0kNBhGqpWTSxtFqJ7q74Gd3yVK3un9PuZBvlai8buSboWdOjT0TwhHMphKNYQQt8RJnAInLwG+DNIJgHzOhKs47XA/B0+4MWWDdNJXmMFZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768990; c=relaxed/simple;
	bh=5yGL3PEJFf2X6TSkKCo77ZK11ii9FSksKLLHtbLPJIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhjynDAcI4MNVRkZQcTpeD92KkGe1qA3R93gtoBh2dnZqDYKAFefgXeriKOlyNVWOqNmROez1XqVNGPr5Pw2MZSUUCtzI9a7Bj6+xZnof6wRUQc+FkJSWNpCNESge0cieomgdjcqOR73at1qnNAON/AKuDH9N2xWDXLmK+kQwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CejHXiI6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CejHXiI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781768988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIqFmNE1LEqFQYtf7qHKkz6E/HgqKNnGDlkW0ueT7Q0=;
	b=CejHXiI6aLk9Db6f3RCpgnmqrWj691DRHZ8XvTZMVeDhePd0MFIAd/wCCn9Ki2RZPUV7eV
	pLLtQAYtuZtzfbbDVKPAEFvoLCcUVf0VJETH9nL/b5eTCuGicbInnP1LF8Me6J9J97B0eH
	gJf5SZeDYVAIX9cyu4Ki1YWjk1/f8Nk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-TAQYa1_RMDSdnTeHMVuiAg-1; Thu,
 18 Jun 2026 03:49:42 -0400
X-MC-Unique: TAQYa1_RMDSdnTeHMVuiAg-1
X-Mimecast-MFC-AGG-ID: TAQYa1_RMDSdnTeHMVuiAg_1781768981
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1CCC1956044;
	Thu, 18 Jun 2026 07:49:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0DC31956041;
	Thu, 18 Jun 2026 07:49:38 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuto Ohnuki <ytohnuki@amazon.com>
Subject: [PATCH v2 07/17] afs: check for duplicate servers in VL server list
Date: Thu, 18 Jun 2026 08:48:50 +0100
Message-ID: <20260618074903.2374756-8-dhowells@redhat.com>
In-Reply-To: <20260618074903.2374756-1-dhowells@redhat.com>
References: <20260618074903.2374756-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

