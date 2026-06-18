Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6F73DD51F
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769025; cv=none; b=Lhe4M/hIoaRSyL5CRFBHePBBBEL2ht4I+GS4UljA0I9Y3pd2lJP9teB8Gs3e4crkmloqfE7wD5EtLKBgAkC6dmdLQF0vIHtO8+dn9s1fbt89WG7jiz6eWQIKLpkEIFRsOtwGZnYjekKrOe8NPXRRccK8QaP7FnumMULd8k+ThAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769025; c=relaxed/simple;
	bh=GuAnvlb8FEY8sez1wbAfUs6fiMrA6S5hlCwzTfveE14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGm6Uz71UZcAKbycD7/JPA2xSEhpUFdmUPfI/lhjvv4jYYR8g+zEhzlRf/9wHQE5C5PXLiZl5goafXTqDQhFgrCCURieD/a1mFCiHNAmxi3L7IskTuY95NLMTOWk/JQlcaJxNlEpCHe3GN/Ws6z7nR5CEt9f1O8mHYBZecWQvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9SDwJ00; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9SDwJ00"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781769023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OW1K1BXP4XEqieQzQiZKHQvagjteaHvJHIAh6dS1QFg=;
	b=M9SDwJ003xn+wxnTOVfKSotnEXdqR/SoVjA7fQu9Ny+5vzgvzoJxLBiwBhGWrD66xdkKtZ
	6Jt35dD21e5TyfLJbr5sCr7B08hi4UiBBbYH3FvpJTeLtaoKUERfOpUVsGEohvn1mdMutQ
	NfwscycyfAB/j5hUBMAdaswWqQOxVD0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-4lanDW1TPKi4-W1uL1DfhQ-1; Thu,
 18 Jun 2026 03:50:20 -0400
X-MC-Unique: 4lanDW1TPKi4-W1uL1DfhQ-1
X-Mimecast-MFC-AGG-ID: 4lanDW1TPKi4-W1uL1DfhQ_1781769018
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C434018005B1;
	Thu, 18 Jun 2026 07:50:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D677630001BE;
	Thu, 18 Jun 2026 07:50:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/17] afs: Fix vllist leak
Date: Thu, 18 Jun 2026 08:49:00 +0100
Message-ID: <20260618074903.2374756-18-dhowells@redhat.com>
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

