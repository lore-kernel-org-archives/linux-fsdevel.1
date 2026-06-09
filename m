Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29003EDAD7
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993097; cv=none; b=E+PsJiQRfrY5MGaibu4Qfffo9XkbFx+gHeuswVhvBSDBfPtgakQ3tfcHPWVa93A1PSzSSBVgJTAyVwuyj3omwS6mDAWWYzd/6plEJou0dwSlDB9WMUdZuEK0TEgVZaSAGtilBCL5hKU+8qv0bhgZzEszJwCaQA4GUleVKvPyMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993097; c=relaxed/simple;
	bh=Ku+iUkufAwmtJpETezJUe09aZfxio81saVT3fFwz4ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jILGSSjm0Ou//LMGmcP0Tj2T/kqzgYi7TBP9ObjumQExpKUOF5pdX70sSA7wylv24VvTp4BiZ+n2GVQr1HiS34uvWlBSJ3UWy7hDYFIdqB+yO0spXAc650l4srYSw6owyhkaDECed++rwtHL5jsPr4KeXURRo1tZb0bZNBo7PXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRKGax6R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRKGax6R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780993095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFX3o+6uVpWAIF9G35ytiuiiBM53y5xUy8RADSTHhfg=;
	b=LRKGax6Rmeq35silETaV6s05gLkCowCAopv1x51u9yjUu4OOBvK5wcGlAX5v7RBKhU6PAW
	IY48oNfdwHG6gz0B/fJio83LNFH52jmG6JfbTHr+rNBNnaUwemkGb/pMcKTZSkz2dsm0c8
	7+Ihd2AhONKD5PfGM10pV0a37Fh/qH0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-8FbRHOJ8PIy0DzUDzkZw1A-1; Tue,
 09 Jun 2026 04:18:10 -0400
X-MC-Unique: 8FbRHOJ8PIy0DzUDzkZw1A-1
X-Mimecast-MFC-AGG-ID: 8FbRHOJ8PIy0DzUDzkZw1A_1780993088
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E792A1800BD2;
	Tue,  9 Jun 2026 08:18:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.43])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 16F7B195410F;
	Tue,  9 Jun 2026 08:18:04 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH 5/7] afs: use kvfree() to free memory allocated by kvcalloc()
Date: Tue,  9 Jun 2026 09:17:35 +0100
Message-ID: <20260609081738.770127-6-dhowells@redhat.com>
In-Reply-To: <20260609081738.770127-1-dhowells@redhat.com>
References: <20260609081738.770127-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Zilin Guan <zilin@seu.edu.cn>

op->more_files is allocated with kvcalloc() but released via
afs_put_operation(), which uses kfree() internally. This mismach prevents
the resource from being released properly and may lead to undefined
behavior.

Fix this by using kvfree() to free op->more_files to match its allocation
method.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_operation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index c0dbbc6d3716..20801b29521d 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -348,7 +348,7 @@ int afs_put_operation(struct afs_operation *op)
 		for (i = 0; i < op->nr_files - 2; i++)
 			if (op->more_files[i].put_vnode)
 				iput(&op->more_files[i].vnode->netfs.inode);
-		kfree(op->more_files);
+		kvfree(op->more_files);
 	}
 
 	if (op->estate) {

