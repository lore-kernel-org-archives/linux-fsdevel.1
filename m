Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2802F6591
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797949; cv=none; b=tGk2iQIsdLjM+tqQ7H34UMV5lsz2WdZOrjWO1PyFwNDao2HaYWPgCleELty0ZAJxJHwG65b0LWYMmgv3VJNyoN/KsHsE7lRGBFWRVXq2mUKqxUQQ5UXP7bx9ZbCfRATWanQ/9YR3/0RsPg+77QLr+oZMcoS16VK1d6Q590WGY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797949; c=relaxed/simple;
	bh=qCZbMwp1OW2TXKC1sonQRFQ2DJkiYewc/7vnI2vOLJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4dObfAnokfInUTCvmr7//6LvlWdeZAb0h2Q0V5wBfD+abYPQ5EPyZHje95rXD9OqJoG/EyWJ3xlGi5ykv7P78K/RCcEWXLDh6fvC+wgOa6SB8SYoB48LuDzDydWF97BMF/1KjqlAQ2YHNqqX9I8ceF4n8FFUcpsVeXVkTJuLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJIRFl5Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJIRFl5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMVGSaJr9BRs+PB33hr9kQshem3jjHWSU14iYsrL8cA=;
	b=LJIRFl5QIcVPG5yKRwsSdS7V9DyxltmCan/ymXhH8Ms9L12IkmVa8pZk/yCFnYXTqs8RT5
	iJnbFeDY4cLJr9A2JpzZ5tFKGc4zHWYdg6fcATpozWijwFNiB3ge9XlYOdDyBsF3Rp8s1o
	jZHbv8bk6GvUV8GXeKgH1l/v2eneGPg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-iSWETyZbNDGhpxaNW6sr6Q-1; Thu,
 18 Jun 2026 11:52:23 -0400
X-MC-Unique: iSWETyZbNDGhpxaNW6sr6Q-1
X-Mimecast-MFC-AGG-ID: iSWETyZbNDGhpxaNW6sr6Q_1781797942
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEC591802667;
	Thu, 18 Jun 2026 15:52:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D975E1800667;
	Thu, 18 Jun 2026 15:52:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v3 08/20] afs: Remove erroneous seq |= 1 in volume lookup loop
Date: Thu, 18 Jun 2026 16:51:27 +0100
Message-ID: <20260618155141.2513212-9-dhowells@redhat.com>
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

From: Li RongQing <lirongqing@baidu.com>

The `seq |= 1` operation in the volume lookup loop is incorrect because:
seq is already incremented at start, making it odd in next iteration
which triggers lock, but The `|= 1` operation causes seq to be even
and unintended lockless operation

Remove this erroneous operation to maintain proper lock sequencing.

Fixes: 32222f09782f ("afs: Apply server breaks to mmap'd files in the call processor")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/callback.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 894d2bad6b6c..833ac3178ddc 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -140,7 +140,6 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 			break;
 		if (!need_seqretry(&cell->volume_lock, seq))
 			break;
-		seq |= 1; /* Want a lock next time */
 	}
 
 	done_seqretry(&cell->volume_lock, seq);

