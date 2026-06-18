Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD9E2D7DE9
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797979; cv=none; b=nAVw0vzgTHZyOXp5wVmqpiUxpsIooo+G6DcEjEGd8v0AdECSm/su2SPLZInDe6qk1Sb0VIRZrW7EBBPAAj07RFlqA9L0YEh0PilINKA5G0WtInKgt0RusTJlFjWKJcCMNMsUq9v7Xqx7ml50QbKqLbyA7iMtImEJPohHH8A/mac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797979; c=relaxed/simple;
	bh=4Fuay67XwiOklTEly0gEQjwYrrWebeys8qbnLlZTUXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fznvzi8vGpYcbTCIdiOHH+ff3slL0raQDe5/mR3YibOo18ndrCNgIbCH3bNW9N+KlggUQ7KoW2Nn4Xm3qyhYNs3cbsVvph43XuTy+smioFkC1ET2itWd7br5rTFpqNzoES5T80GitAOEmbBkQCmp3EngMK+Lsmu70vYVHi9f08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijZT3MbJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijZT3MbJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ED6N2Drlsei75IIZPCydMGtt9kEdxgMUpbSFFwguS/g=;
	b=ijZT3MbJTeDcUWIhfoyALpAECVbcxRAJN3zCEz1Soiysd2uJWro9m1j7RlyZGDkPbAvTgW
	lgdXNguJ2trKKHfiZXWRBFdRJgw06/znHR1WAKdDtoytQYW8HTrt9KWrxlZIhtbDONuV4Q
	FCZF6Z3SDT4h4xqEbHZBU0ZErcpr5VU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-lCelPz97OveZUWS6QN6qmQ-1; Thu,
 18 Jun 2026 11:52:53 -0400
X-MC-Unique: lCelPz97OveZUWS6QN6qmQ-1
X-Mimecast-MFC-AGG-ID: lCelPz97OveZUWS6QN6qmQ_1781797972
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6167619560BB;
	Thu, 18 Jun 2026 15:52:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 397CD1800667;
	Thu, 18 Jun 2026 15:52:50 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepakkumar Karn <dkarn@redhat.com>
Subject: [PATCH v3 16/20] afs: Fix leak of ungot volume
Date: Thu, 18 Jun 2026 16:51:35 +0100
Message-ID: <20260618155141.2513212-17-dhowells@redhat.com>
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

