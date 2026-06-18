Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9403DC84E
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769018; cv=none; b=PzxZICv8GD8roLTCxd3aPj91zTQhFcvQWhk73tSVOD2521lkXX5MfBzqo5RKhkdJGeOQXAypQQdE2FwDtKJfqpjc8IMfUbnC73TXTnTtBK8jWnFOshvRydrgBJ6Jas3zQjbG8/wIS28xzkRn8zH0gqefznlZfr/n3avvvO/Et2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769018; c=relaxed/simple;
	bh=MopBqCqn3nkNYCVQgPZBfIkRy/2a0r1g0gJ8EpIyCJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSrUYc61lbmZLV6wS2tQrwQNR5JWQCb10l3JgmkjZD9e+RCnal2P81yc/uMGsCvOaIEeWNKLm4TPSYn2/rV3+QGslxGLDdragpjbUjFq3lbHl3o+5QKaahgFkUhnCQDV90iG/ceubSqi2BzorjqfG9lM+CEeDm38IheMmaoe6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EG6mHHxK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EG6mHHxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781769016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PNP/ou5XP8tinfdyqfK3QNTlJa+o1fG7mqXcA52F5g=;
	b=EG6mHHxKd2HrDvDWXaaoDYUauM2NZV4ATDSaUFSUsSyFCv+WMq3m/I0mKSj4GR0p0NG2Hh
	w5AnNKIkkS38QK6c30DqPVMM8LP1z0gwWEsej/q5L4cRCpVisxPRHqyy24yJa33ibKFhqA
	doPzNjkIHuXOjQiFANHKT1aGL56zyis=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-FArUNSkZNMOrBMKYDKeoOQ-1; Thu,
 18 Jun 2026 03:50:13 -0400
X-MC-Unique: FArUNSkZNMOrBMKYDKeoOQ-1
X-Mimecast-MFC-AGG-ID: FArUNSkZNMOrBMKYDKeoOQ_1781769011
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF9F11956040;
	Thu, 18 Jun 2026 07:50:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D2051688;
	Thu, 18 Jun 2026 07:50:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepakkumar Karn <dkarn@redhat.com>
Subject: [PATCH v2 15/17] afs: Fix leak of ungot volume
Date: Thu, 18 Jun 2026 08:48:58 +0100
Message-ID: <20260618074903.2374756-16-dhowells@redhat.com>
In-Reply-To: <20260618074903.2374756-1-dhowells@redhat.com>
References: <20260618074903.2374756-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

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
index dd7a407ea368..0035f51ce24a 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -134,6 +134,7 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 
 		if (volume && afs_try_get_volume(volume, afs_volume_trace_get_callback))
 			break;
+		volume = NULL;
 	}
 
 	return volume;

