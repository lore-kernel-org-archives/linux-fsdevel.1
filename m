Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DEA3446C5
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797989; cv=none; b=IZR19hvu6sfaM3d0jZICALcWOAGn4+eeeeSJzEk/O/Czb32eWyR6HTorBk/bowJZ9XDlAHiYB8ogiuyEXSz8C8e0l0H6+IHjD5pVeps3TxWgX3cGvKxCoTN61Xn+RtJgoajEKAmpe0Pf95msocZXQqnQ4DMtBxG8Vtga3rmjlcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797989; c=relaxed/simple;
	bh=0HmkqP/RuhjLxCSpGGAOzCvPlOP9+EPBd7TYOa9/lMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfmM3/tc66rcE1X5b2GQ1bziNo2PzKr3Faz4RsCJVcfbX+/jIQ3I6ffwnNnR/g4tII2kUNkRzQ+ChAx4LzkZ4v/+B6FgavSxBQh8xFDU1eqwPFpG7srW4qkU0YfhVMvJfW/THXGkBMFKRVg+Xr6UlkNfv1RToRzwc6H22zi9MMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZp5tPCs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZp5tPCs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iw9uGhm3LO9PdxkRoOT9J8m9qRxzmFyZf0B6bVDSkuM=;
	b=OZp5tPCskXULVftt0BAV6M4F4h/f5SZqVKncMnxFhrXmj4a7FruFMYVoS6GFGqynHq5JYZ
	coUaJXkayFqcQJx8yw9sA5PDTIS8AG57VsaIcUWl+yKwZ8UajpqmLrRoXo+koB5xI/Maqb
	cafYyEDxErv5uWgEq0VQfgx6A9mHN9I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-Pkr2iWRfMSKRYsZX_wb3Uw-1; Thu,
 18 Jun 2026 11:53:04 -0400
X-MC-Unique: Pkr2iWRfMSKRYsZX_wb3Uw-1
X-Mimecast-MFC-AGG-ID: Pkr2iWRfMSKRYsZX_wb3Uw_1781797982
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF5D21956067;
	Thu, 18 Jun 2026 15:53:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DED161956044;
	Thu, 18 Jun 2026 15:53:00 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/20] afs: Fix the volume AFS_VOLUME_RM_TREE is set on
Date: Thu, 18 Jun 2026 16:51:38 +0100
Message-ID: <20260618155141.2513212-20-dhowells@redhat.com>
In-Reply-To: <20260618155141.2513212-1-dhowells@redhat.com>
References: <20260618155141.2513212-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix afs_insert_volume_into_cell() to set AFS_VOLUME_RM_TREE on the volume
replaced, not the new volume, as it's now removed from the cell's volume
tree.  This will cause the old volume to be removed from the tree twice and
the new volume never to be removed.

Fixes: 9a6b294ab496 ("afs: Fix use-after-free due to get/remove race in volume tree")
Closes: https://sashiko.dev/#/patchset/20260618074903.2374756-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/volume.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 9ae5c8ad2e04..4f79d25ec37f 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -40,7 +40,7 @@ static struct afs_volume *afs_insert_volume_into_cell(struct afs_cell *cell,
 				goto found;
 			}
 
-			set_bit(AFS_VOLUME_RM_TREE, &volume->flags);
+			set_bit(AFS_VOLUME_RM_TREE, &p->flags);
 			rb_replace_node_rcu(&p->cell_node, &volume->cell_node, &cell->volumes);
 		}
 	}

