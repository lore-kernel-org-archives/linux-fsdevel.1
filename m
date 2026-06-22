Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37D3A7D81
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119430; cv=none; b=QKkqT6lWT5sM9gScJV1HDd94Xt9sffnG/RWvMSJwOGyQ9YZMwVp1CzEgeAcf50RymH2VIaFZYbIZ/zDzkgc3xcWK4pbkyCl2VaOFPAB+iQgudebCIXD3Ev/l+hRyAXOJ7PfVhBSZMwoNbZaujDj6UWSme+cettwe3SioAgaqj8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119430; c=relaxed/simple;
	bh=0HmkqP/RuhjLxCSpGGAOzCvPlOP9+EPBd7TYOa9/lMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlHP35ViWjuJHN6D+F1xXVffbfUmmaa7xUIPKlGbW9DRsLWbs1sKFFkETxj2Eax+lHCupxJVbGefhLmvH+twZcpquXwjY2o4zOlPP4M5Cv4EVf9mtuzPizLV1Z9msksUhqqHsSktvOCDPnVzGO9S5ancnyxdj8gS1j6kbWrhElw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aV5DkWyG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aV5DkWyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782119428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iw9uGhm3LO9PdxkRoOT9J8m9qRxzmFyZf0B6bVDSkuM=;
	b=aV5DkWyGZDXkgNtojCkvwgPFjBoulnsj+dLCVUtbtacAFJ8e524k7Bpd4mCygJsiuq5dXd
	2id2cnBE/5OKjiD4ntyP8vQ70a9Kj9zxtfNigygFhKSVwNowOYSI48XIIjOv04P+95l6Dl
	JEHNW11XzGjDlYletmgOO9HTAGMELmY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-VoJ3GrymNtuOi-Svw5F28A-1; Mon,
 22 Jun 2026 05:10:26 -0400
X-MC-Unique: VoJ3GrymNtuOi-Svw5F28A-1
X-Mimecast-MFC-AGG-ID: VoJ3GrymNtuOi-Svw5F28A_1782119425
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F1891800596;
	Mon, 22 Jun 2026 09:10:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.242])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6FF4A180058F;
	Mon, 22 Jun 2026 09:10:23 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 20/21] afs: Fix the volume AFS_VOLUME_RM_TREE is set on
Date: Mon, 22 Jun 2026 10:08:54 +0100
Message-ID: <20260622090856.2746629-21-dhowells@redhat.com>
In-Reply-To: <20260622090856.2746629-1-dhowells@redhat.com>
References: <20260622090856.2746629-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

