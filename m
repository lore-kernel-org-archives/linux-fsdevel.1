Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73A3976A9
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119415; cv=none; b=n3wuEl3FTPGDrsVTtTBk4d8XAp5h5ePpZi/o7GUgRoJL7uqLlR/B/iEEnDdtatQGdxdUqWbqlc6UYN+VoCn+yJzCEHk7tu/gLPs/aURj5BaY3NQwZNj0J7Rnj0hseVzzVmzr9CZmOyn8hbmedL+2R+DXXTHj28TgMBnicKqSK0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119415; c=relaxed/simple;
	bh=4Fuay67XwiOklTEly0gEQjwYrrWebeys8qbnLlZTUXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vso00NR6K6TBRdLpFpkd0UvQGlCZTIwXzYKg19gKEDQfbVuwr+arPs/rHNop/0E6lCIQ4V24ua5hWDimYPduQ3JSdFS3kXfDV4FBKZ+rnD2MnKL92OyzdK0w7DMepscIw6moQ9fsMicHwiM3nfvVoWTGnObJ77RkF8UH3mSyIX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OW2fDa1m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OW2fDa1m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782119413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ED6N2Drlsei75IIZPCydMGtt9kEdxgMUpbSFFwguS/g=;
	b=OW2fDa1mZ2r/ptpBeVJemj8ZsgimzUBb5JWV07q3opV30T5KJBLhKieYGC0axrj/sdFvcE
	wru1el2JwlMcig7ks7Hdd23MApwNP73RlXfDSY6YUPjxls1c0nRPhPdr9/1jAp3Y5gqUW6
	lAQZrs1hG58+VHTGv7sBecghKO9+Jc0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-BL-dO_zFOSOyS3qYulLPnA-1; Mon,
 22 Jun 2026 05:10:12 -0400
X-MC-Unique: BL-dO_zFOSOyS3qYulLPnA-1
X-Mimecast-MFC-AGG-ID: BL-dO_zFOSOyS3qYulLPnA_1782119411
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DE6E1801BDA;
	Mon, 22 Jun 2026 09:10:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.242])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 276D93001D84;
	Mon, 22 Jun 2026 09:10:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepakkumar Karn <dkarn@redhat.com>
Subject: [PATCH v4 16/21] afs: Fix leak of ungot volume
Date: Mon, 22 Jun 2026 10:08:50 +0100
Message-ID: <20260622090856.2746629-17-dhowells@redhat.com>
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

Fix afs_lookup_volume_rcu() so that it doesn't leak a dying volume if
afs_try_get_volume() fails.

Fixes: 32222f09782f ("afs: Apply server breaks to mmap'd files in the call processor")
Closes: https://sashiko.dev/#/patchset/20260609081738.770127-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Deepakkumar Karn <dkarn@redhat.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/callback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 74853e0d0435..61354003c006 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -134,6 +134,7 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 
 		if (volume && afs_try_get_volume(volume, afs_volume_trace_get_callback))
 			break;
+		volume = NULL;
 	}
 
 	return volume;

