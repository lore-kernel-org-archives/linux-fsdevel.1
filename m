Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10AC36BCC4
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119385; cv=none; b=EvndYCmZQLMcxybtZHgyVBlkuc9fDJuraw0+Bg26vIMNMQvd3gY/hyl0McuCKrsiyzXT180iM4dAiQD1khnlhupDbicbgqg2w/jEvDclgfNhrRfrunyGnPIM1rIBZUSNUbgZNAYgzm+kiZ3CxHzofJCUns/qgvCOZ7vRWJ5AmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119385; c=relaxed/simple;
	bh=qCZbMwp1OW2TXKC1sonQRFQ2DJkiYewc/7vnI2vOLJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kbcbf+qchGsDLKGovgzMxfBk0y3rFSxj6fwN5iwMYkFcCk8Vr9hfQXlSoF2ptou/WzIZ3TdQvu25Lm3gE1yXjyYznhWWokeduwHk/EhLLlgRPiH+5L785ua80wNRx9fohAAF7Gvorh4BGo/uZb42a5hsZzzsxqUeviY+ex5+fwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtCkpx5E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtCkpx5E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782119382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMVGSaJr9BRs+PB33hr9kQshem3jjHWSU14iYsrL8cA=;
	b=RtCkpx5E/YjDLx8e1asMGSbjWSNDI3B7/KJkIqp9ntCVXO5CjoV7qsMolIGrzq/PTiSlcd
	3sOQ+9fgRpo53C7brU1O22bzaqZrRMY8/rfu94f4fqUnOGWqxQjatvKcGt8F/JtwKrHIQD
	s4qqYm9MI80GltZidNjW+RlptoddeEM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-G4kvWLfsMy-huNcWJi4myA-1; Mon,
 22 Jun 2026 05:09:41 -0400
X-MC-Unique: G4kvWLfsMy-huNcWJi4myA-1
X-Mimecast-MFC-AGG-ID: G4kvWLfsMy-huNcWJi4myA_1782119380
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39B1A195605E;
	Mon, 22 Jun 2026 09:09:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.242])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D744A1953946;
	Mon, 22 Jun 2026 09:09:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v4 08/21] afs: Remove erroneous seq |= 1 in volume lookup loop
Date: Mon, 22 Jun 2026 10:08:42 +0100
Message-ID: <20260622090856.2746629-9-dhowells@redhat.com>
In-Reply-To: <20260622090856.2746629-1-dhowells@redhat.com>
References: <20260622090856.2746629-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

