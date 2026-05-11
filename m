Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F8379EFE
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484180; cv=none; b=qujhcWyIb5JdE5D3fhRykY4lgQUErE/WWDkhMXsIIun0KmczSkYxOyw8MMXgmUNrkz/9Xsect/iDECIhFfIObjOypgCbDX3s6fis7dHm9pb1gNOs44t0UunbV7fG6z7l8dYgqFFc9xGqMFwVAuiNSUQDwSNNbdq5MjIhCQZBoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484180; c=relaxed/simple;
	bh=TgykqGKwyj+99AynLPyDGe3tJ9yOnDW8JLeh7cFx4CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELzJuvDtoeJesVXereFynbLroUB82hPNe/peuM1M44Rz6FhSI6Fq8KToGGLCko6lwpWG8JKnLxELj0ywNNzl4nTDVGP7CKMZ9e72dlw4CTiSx4dBlGnAlSkNN/tUnBxGh64ChmOISO5B9w4pPvvIMlApuqFEORi70nxqFQLo0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4Ug6wrai; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4Ug6wrai"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JPQfOwO2GopQaPjKrEl78VUsILY4Y3su5giieVfntPU=; b=4Ug6wrai2BfbNANVuow6wS/aS3
	ivJDOkytyAqNIqGJanA8cAu0Qa07QI2gQcvegJwfm9DxkOAHfHKw0d9Hm9m4NIJpQPB+hEnrz0P4P
	qDu2AiVmySTTQoTXNGJQvqS7my1M9GUxk/IzqN8I6OfUoAWFBry4uL99J2qwsjPPqL9bNYUMXCt9F
	9wwDkX71AZR6ihPW2BKd+HuwRyETZvtkhuzV5QOyGnS+MD0+V0GlAbqh7wU/ZvtkGjEmsSm4aGPo6
	DlX6nvaXx6B+AG9Q0iTvzbZcMLZGNS5jibavPYuCR48U5+a48/mWjFMjYV8XHgkSmiIHt75HGBLFf
	5Rdt/9+A==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKyg-0000000Cam0-0d2l;
	Mon, 11 May 2026 07:22:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] fs: fold __start_removing_path into start_removing_path
Date: Mon, 11 May 2026 09:22:30 +0200
Message-ID: <20260511072239.2456725-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511072239.2456725-1-hch@lst.de>
References: <20260511072239.2456725-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Only one caller left, and simplified this way.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/namei.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index bc641838530f..4852ca208bd4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2955,15 +2955,16 @@ void end_dirop(struct dentry *de)
 EXPORT_SYMBOL(end_dirop);
 
 /* does lookup, returns the object with parent locked */
-static struct dentry *__start_removing_path(int dfd, struct filename *name,
-					   struct path *path)
+struct dentry *start_removing_path(const char *name, struct path *path)
 {
+	CLASS(filename_kernel, filename)(name);
 	struct path parent_path __free(path_put) = {};
 	struct dentry *d;
 	struct qstr last;
 	int type, error;
 
-	error = filename_parentat(dfd, name, 0, &parent_path, &last, &type);
+	error = filename_parentat(AT_FDCWD, filename, 0, &parent_path, &last,
+			&type);
 	if (error)
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM))
@@ -3023,12 +3024,6 @@ struct dentry *kern_path_parent(const char *name, struct path *path)
 	return d;
 }
 
-struct dentry *start_removing_path(const char *name, struct path *path)
-{
-	CLASS(filename_kernel, filename)(name);
-	return __start_removing_path(AT_FDCWD, filename, path);
-}
-
 int kern_path(const char *name, unsigned int flags, struct path *path)
 {
 	CLASS(filename_kernel, filename)(name);
-- 
2.53.0

