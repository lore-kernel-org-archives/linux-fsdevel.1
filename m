Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B63F36215B
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878030; cv=none; b=Y4Nzj+B0EEwoO96AqX/Y20duRM/ZEmkin7nS4tdFBMVdaj0eGID/KNQDk4IaM9djGCUHPyJcrEUObvPrN9dgDkiwKQHcZNFfScBfxNLob0qFkXGIhlqS6Dl5JFoYkD7G/t8MNeayowm3KxgoaxdXjfHQ4vk+ol9tdvWXU9rJ8vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878030; c=relaxed/simple;
	bh=/VMGqRXj2H1ZoJ9Len4yDIgpZpvQtbhJDErO1fIajO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBWzej7kuIRIAYHvGprcGO9LNEE/pNheicgr3K97uExPpAoQhZ/tY9d9cQDxIJJVR8nhIphu0gU7s0RlTpzwFIOVSSXQ2iB15s498IX/tw3flEbFDQYaiYICqm5HW+A2QIf/+Bh8lgcDLfpZLtY8pqpVFR5tBRAn2uZm1b4/T4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awoHeImf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awoHeImf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781878026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xzr+Qi6ZDs+0Riq2AVSQ7VxUd6HCUSx75f0+qxBdXU=;
	b=awoHeImffH2SJG4xO0zrvosRzF9+KSW+D6t9rBYwgE8b5yjiKXGuTIA6KarK+Q4blG8qVR
	FFwWQK3o1VAlgS9BqeGZ2P2JcYG/PxRReV6B2+cWijcdqGjmK9krYL7zJd2hHW9xe2kQjC
	9nwVhCkHvBpPJqQAtNkaW8O+lV90Lk0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-2FCaygFbMVWNeJZhqa1f0w-1; Fri,
 19 Jun 2026 10:07:05 -0400
X-MC-Unique: 2FCaygFbMVWNeJZhqa1f0w-1
X-Mimecast-MFC-AGG-ID: 2FCaygFbMVWNeJZhqa1f0w_1781878023
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F25DD197731A;
	Fri, 19 Jun 2026 14:07:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DAB2E1688;
	Fri, 19 Jun 2026 14:06:59 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] cachefiles: Fix double fput
Date: Fri, 19 Jun 2026 15:06:06 +0100
Message-ID: <20260619140646.2633762-3-dhowells@redhat.com>
In-Reply-To: <20260619140646.2633762-1-dhowells@redhat.com>
References: <20260619140646.2633762-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Fix a double fput() in error handling in cachefiles_create_tmpfile().

Link: https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/namei.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 2937db690b40..a464c4646c04 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -467,7 +467,6 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	ret = -EINVAL;
 	if (unlikely(!file->f_op->read_iter) ||
 	    unlikely(!file->f_op->write_iter)) {
-		fput(file);
 		pr_notice("Cache does not support read_iter and write_iter\n");
 		goto err_unuse;
 	}

