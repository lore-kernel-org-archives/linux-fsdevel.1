Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9A3EBF02
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993105; cv=none; b=Dh4PVQuKbbfVot4KQiZyVGke+ZzbBkW3UTOUQGKEJ0I1UdC5Bm93BwzYAmV3GJf4BUhQj3F0HucuG1KyJLlBIuK1PAefwssHPNE8nh+Ze+AKlEz1lVSP1Pduh0MjIp+1+brXj+7q8KTzS6v636H0oRah9W5WsiII1uvBREfHsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993105; c=relaxed/simple;
	bh=5yGL3PEJFf2X6TSkKCo77ZK11ii9FSksKLLHtbLPJIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XX9O6brpkWcJRTFkpbyqky7fwzB1mvfxUiTE4No06T9FtnalXBfaa2F0mCca5Eww2oH2PjoVpu4xDhvJxKHlpm2OCcwE0hI6gBwigYwsR9uLu1Xelq43+J5uPrIT6eTdfkeXzHjBXHMBsOl94ECojuLRK4Dilbya90uEAkMvypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKtHv8kD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKtHv8kD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780993103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIqFmNE1LEqFQYtf7qHKkz6E/HgqKNnGDlkW0ueT7Q0=;
	b=UKtHv8kDrSyK7ToBX36/xUcjQk1nf71+jj72/rTOuhWIcT+0Hg1kedFJMt2cB4nPdEVTPD
	ql1bDYqVxNRLFWGyQ9VHiFs18X+d4kQckSxIh8ZALlPV5i5K5avRKI7e2t749uACDR/5zU
	ckB6m3j+uHz49rIHskVsa2LpAP1TX7I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-bn7MpZOKMKeENCl_1pK13Q-1; Tue,
 09 Jun 2026 04:18:17 -0400
X-MC-Unique: bn7MpZOKMKeENCl_1pK13Q-1
X-Mimecast-MFC-AGG-ID: bn7MpZOKMKeENCl_1pK13Q_1780993096
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08D5C18501C4;
	Tue,  9 Jun 2026 08:18:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.43])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D77E13008B35;
	Tue,  9 Jun 2026 08:18:13 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuto Ohnuki <ytohnuki@amazon.com>
Subject: [PATCH 7/7] afs: check for duplicate servers in VL server list
Date: Tue,  9 Jun 2026 09:17:37 +0100
Message-ID: <20260609081738.770127-8-dhowells@redhat.com>
In-Reply-To: <20260609081738.770127-1-dhowells@redhat.com>
References: <20260609081738.770127-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

