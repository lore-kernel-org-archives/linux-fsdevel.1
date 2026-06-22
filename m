Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26A3A7186
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119421; cv=none; b=YDUN3aUvVFy8SWncXEiYPKMOEtpmIGieKCGAamWf2+S66eIWjrrg+fedcgRxOX1JKQKt9tRzIi1fuxEzgreS7uTf1YLJqSFDTw1xgQqorm92ReXU4DE0cmGiPgveLYzEyk5WwBxvcYvT4moCdFDjcUvTQ9wN5t5J/x61Bc89f9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119421; c=relaxed/simple;
	bh=GuAnvlb8FEY8sez1wbAfUs6fiMrA6S5hlCwzTfveE14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NX6hWAs6E/xEwt/t9DaTqU8d2OFqyAHjA2zYSLF8Un+RwRglQSvAttNAvBAlnu1iyC/8Wo9ENv4lymD287Ni6VUkXpuardIWDtXloRd7c1etR0j+Hr0AQlN5dXgViPTsPMhFvyfyH9W6Gw6CbDj1jZIk3Sm/+CihfT8eIKHq1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A099O6rE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A099O6rE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782119419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OW1K1BXP4XEqieQzQiZKHQvagjteaHvJHIAh6dS1QFg=;
	b=A099O6rEbtnCdSWDoQgmE0QVVeB6IfAQq0w1gFOiCpey62nQXWe/MeOfqsbVhRKnqyyfmV
	vn53s/iFqGTPtagg1IkUX6f74zM/qA493a3WxDsbjKr2ELdG7FL1Y0ii/Ou/dK6QNfEyx6
	vJgrNatLLU4F7y7j3kht1trGDx4KV64=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-uW79c5kQP66dao7ZWgmfPA-1; Mon,
 22 Jun 2026 05:10:16 -0400
X-MC-Unique: uW79c5kQP66dao7ZWgmfPA-1
X-Mimecast-MFC-AGG-ID: uW79c5kQP66dao7ZWgmfPA_1782119415
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8685180034E;
	Mon, 22 Jun 2026 09:10:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.242])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E95FC18005B5;
	Mon, 22 Jun 2026 09:10:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/21] afs: Fix vllist leak
Date: Mon, 22 Jun 2026 10:08:51 +0100
Message-ID: <20260622090856.2746629-18-dhowells@redhat.com>
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

Fix a leak of the new vllist in afs_update_cell() in the event that it is an
empty list (nr_servers == 0), in which case the old list isn't displaced
unless the old list is also empty.

Fixes: d5c32c89b208 ("afs: Fix cell DNS lookup")
Closes: https://sashiko.dev/#/patchset/20260609081738.770127-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/cell.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index e0fab1609f27..fbb8a43aa7cd 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -547,6 +547,8 @@ static int afs_update_cell(struct afs_cell *cell)
 		rcu_assign_pointer(cell->vl_servers, vllist);
 		cell->dns_source = vllist->source;
 		old = p;
+	} else {
+		old = vllist;
 	}
 	write_unlock(&cell->vl_servers_lock);
 	afs_put_vlserverlist(cell->net, old);

