Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC63D6664
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768981; cv=none; b=F+ljY29YOPRxCLp54Bx2ug1LsJifwtCa029cE8cG2x9I+Pbig+XkC1AwAKPJH8DUgsD7QXwxMdqcSqDBlwxFFAi9vSTMoflxT+87WUREBGmpoxiPevufrqL3AmLxypj7O4F9Wbj+ZBryLGjh129RHBjS8YZekY+nZ5S6XJURm2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768981; c=relaxed/simple;
	bh=Ku+iUkufAwmtJpETezJUe09aZfxio81saVT3fFwz4ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1WaYbaaqqkyguSEMQ4YeAllQo4eGfqKD7oWU7Sz0BYybLFiWo00X50zGjH2N24PRW5otsKLt/10SCYFw9qYuCA5sKJumsUWeBZjGURi9gSXhXnF5/41yTAj+E27+5FlQNd1vUh4EyX9wpwskY2dYAAYf+QE4nnWDxfvlDOqzTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eackoovw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eackoovw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781768979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFX3o+6uVpWAIF9G35ytiuiiBM53y5xUy8RADSTHhfg=;
	b=eackoovwGUygdoeibtO9cMukxBYehdHuPTl7SmJGeX0g31wGFw85i48z81a5gV4O5AOqMg
	1fvGX2hKYLTkVGN8l5+GCibsGupd8oXUuP5tHQHdYIGQAOgDw8D4eahMuM7AjKGpUKLuEm
	Xh6FnGSaeE/o8yAi36rS6qNDgMbC64Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-iAAgnGNPPCmhcpiIufbJQg-1; Thu,
 18 Jun 2026 03:49:34 -0400
X-MC-Unique: iAAgnGNPPCmhcpiIufbJQg-1
X-Mimecast-MFC-AGG-ID: iAAgnGNPPCmhcpiIufbJQg_1781768973
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD1DA1956040;
	Thu, 18 Jun 2026 07:49:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7846180049F;
	Thu, 18 Jun 2026 07:49:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v2 05/17] afs: use kvfree() to free memory allocated by kvcalloc()
Date: Thu, 18 Jun 2026 08:48:48 +0100
Message-ID: <20260618074903.2374756-6-dhowells@redhat.com>
In-Reply-To: <20260618074903.2374756-1-dhowells@redhat.com>
References: <20260618074903.2374756-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

