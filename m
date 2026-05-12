Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E93A71B3
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589360; cv=none; b=W3I6VXvl8UqoZWLGDcfE/5rVi41ZeEwRm2K069EBnYcn4eT28Tz5CsmFfPhPchrBzAmqOt6fzh/ilMYDVJOeTOidocYjRJ3JOAeaQGO4VTcJ/b/dz7JNCEpOe+6QySKgL6YchwfrlJM7HYz7/T0AAtIHRUCWoj04wPwyj7kG4Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589360; c=relaxed/simple;
	bh=coEsLwb8B7M0CzoNtVvIEKm/Jb2sGyKz9R7NakrtZTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHPug8r3DW19fuXSsrLzwIV8JOspALrit8n8lJuYFL90az9vgwHz89w4MC2InRfHkLb2XpxKd/Pe107Jj1epX2w8UOROk82mbgOqTUgWqTsN5bdYlDD5WJ3/EYl7NVe9TiGzgoz1VmY2IuXEVYX8/r5ATvKKPbzo3xKWZOG1VyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTLcwuFo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTLcwuFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778589349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5NDYI/CE4LhuyVlcxn+PhP3ASA3wkIY5IbeljCO0j4=;
	b=UTLcwuFoYNi5ocQ91D+P9bFvIWEoZ5yFWV2yiyAudJiNsDCHCAIwvKzmZLbCYYTWhxZhcZ
	g+El+b9e0qJwFuzPlFaxv7BOYc01fRzIeJ/HVKLfgfBy8f+pkvBs0GrewKCPOV7ncUc7uj
	datHOtrLYAY+nKfEIyJdD4IJkohpAg8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-dHZMrYBXOI602yW-ZyENmg-1; Tue,
 12 May 2026 08:35:48 -0400
X-MC-Unique: dHZMrYBXOI602yW-ZyENmg-1
X-Mimecast-MFC-AGG-ID: dHZMrYBXOI602yW-ZyENmg_1778589347
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B48E1800619;
	Tue, 12 May 2026 12:35:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 387F71800352;
	Tue, 12 May 2026 12:35:43 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v6 20/24] netfs: Fix partial invalidation of streaming-write folio
Date: Tue, 12 May 2026 13:33:57 +0100
Message-ID: <20260512123404.719402-21-dhowells@redhat.com>
In-Reply-To: <20260512123404.719402-1-dhowells@redhat.com>
References: <20260512123404.719402-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In netfs_invalidate_folio(), if the region of a partial invalidation
overlaps the front (but not all) of a dirty write cached in a streaming
write page (dirty, but not uptodate, with the dirty region tracked by a
netfs_folio struct), the function modifies the dirty region - but
incorrectly as it moves the region forward by setting the start to the
start, not the end, of the invalidation region.

Fix this by setting finfo->dirty_offset to the end of the invalidation
region (iend).

Fixes: cce6bfa6ca0e ("netfs: Fix trimming of streaming-write folios in netfs_inval_folio()")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 24b20e80e9a8..5d554512ed23 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -262,7 +262,7 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 				goto erase_completely;
 			/* Move the start of the data. */
 			finfo->dirty_len = fend - iend;
-			finfo->dirty_offset = offset;
+			finfo->dirty_offset = iend;
 			trace_netfs_folio(folio, netfs_folio_trace_invalidate_front);
 			return;
 		}

