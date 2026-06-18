Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764D340400
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797982; cv=none; b=LF4zvkfD5SNPGzBgKvV4GFWqMQm4WlqvYYF854Tz4SqePYp4h7a1YhoqqHW19KxD16Q3I6EUwQlDF9wlceaWAkfXQhnf5a81bi4rtJ5S/iKP3xZU1o4+rAgta6ivar0S3SWilGcYWMVlueCjaJExxpnnxlPDL/PdjFq8aM0n1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797982; c=relaxed/simple;
	bh=GuAnvlb8FEY8sez1wbAfUs6fiMrA6S5hlCwzTfveE14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frWxymblHYfSA9RVpLvhg5NxLYkIxy/UiKrQLHbJKgFJ7Yy6AHWgAM66RCb04I95/YKcjW8vdYFgOL+jMJRbYa/S9sUCwzd6H4pw4IqaDiSRz8ueZH4XnNxd6v8q4yWNHFhoLHMjW6oBhhu3xkZsvWK05NFYLcTREG9BkGmwV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBpI5w7M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBpI5w7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OW1K1BXP4XEqieQzQiZKHQvagjteaHvJHIAh6dS1QFg=;
	b=EBpI5w7MuqEAvWzpZag8B9VK0QWmsukxyexBj62F9JLtzgBVhAs/2yyUKPiaZ47WAKm0SD
	IFPVjn3Z7Omh4AtpH90aiJd8HEL+50+g6H/3GfNIhmYxQTGJvBVkF2HMwoGrhKjaz5ocyo
	A7SXU/Wo24pX7CgzEXU1178HNCn6bdA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-o4WipPQENo-67Htnytaz_g-1; Thu,
 18 Jun 2026 11:52:57 -0400
X-MC-Unique: o4WipPQENo-67Htnytaz_g-1
X-Mimecast-MFC-AGG-ID: o4WipPQENo-67Htnytaz_g_1781797976
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D690D1956040;
	Thu, 18 Jun 2026 15:52:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E515A30001BE;
	Thu, 18 Jun 2026 15:52:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/20] afs: Fix vllist leak
Date: Thu, 18 Jun 2026 16:51:36 +0100
Message-ID: <20260618155141.2513212-18-dhowells@redhat.com>
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

