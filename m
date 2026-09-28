Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63EB24BBEB;
	Mon, 28 Sep 2026 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629808; cv=none; b=RlQpNIiHsZvOtOg1XsRj4/1LJPnS+7QVB8okk18MSR6PMvom58tM+8vsi6NJ6LIDUscFQ53ipmOUXfSkXj7CgBsFVFEhta2kgbsnGUQUZu9k9Pz1iohBmVmq996gerGF6jBpHqKdBdYSMkbSuFlucAT8OcSX5jRjIzJtwCBAtBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629808; c=relaxed/simple;
	bh=GIYrE1pTz9/+f8wq3p19aqgX9eHhbtft9ADIzykUdys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eE5lW6TVHpc6fjmlHlAZy2WU5PvObc+k+6ojMkezktxGvsRESFy0DaWzRFrq2g/jmtdkFuL2t65USbAruE2nkMfClOhrF2DSE3mZHR10LuqWHPQWFLSMI4HffeONYb7hySn0I0ofu5VD7i+par/Q2rql+MTScUir/T3bJvqB+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gm43QppQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gm43QppQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0245lrNpAAWfFFBXjxyYX4pNahY2xnBykZJW+gghIuU=; b=Gm43QppQX4LKQDhK0LTr6H3miD
	ug+ZNocsctqsIvudc3UdkWWoCGrOo9623Adc5EKbENSWD7E6t+xyReTmN59DxCckvcydxOoOnIGBX
	jR2RqgbOZPpPr7PqCA8Q6b9soYZLl7vacyL+XcJsViR/dGKi2ujcmN+sdocu7VRzSIB1nw8SnI+5C
	qwnKHml0u4eDThAkiSP+pqqj96jm/u3zJZGDuuR4HhTfzB/9Z2v297LAvsZvTmUX7w8FezjM++b3h
	6Aw9MHcXq3aDJGVVJB6Y7uedoaWeGUyk6pv8jED30P0wvjNwOjHDbtpmcli1VaicUOPwqBmHM0WwC
	PPC7NtlA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBIbt-00000001eip-2hEa;
	Mon, 28 Sep 2026 21:10:05 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] VFS: d_duplicate: repair comments to avoid kernel-doc warnings
Date: Mon, 28 Sep 2026 14:10:00 -0700
Message-ID: <20260928211000.1539250-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a typical list style for comments to prevent kernel-doc warnings:

Documentation/filesystems/api-summary:20: ../fs/dcache.c:2029: ERROR: Unexpected indentation. [docutils]
Documentation/filesystems/api-summary:20: ../fs/dcache.c:2030: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]

Also, modify the spelling of "whiteout" to match all other uses in
the kernel source tree and to be consistent on the same line.

Fixes: 33d76519f0cc ("VFS: add d_duplicate()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org

 fs/dcache.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-next-20260928.orig/fs/dcache.c
+++ linux-next-20260928/fs/dcache.c
@@ -2025,10 +2025,11 @@ EXPORT_SYMBOL(d_alloc);
  * @dentry: the dentry to duplicate
  *
  * Some rename operations need to be combined with another operation
- * inside the filesystem.
- * 1/ A cluster filesystem when renaming to an in-use file might need to
+ * inside the filesystem::
+ *
+ * 1. A cluster filesystem when renaming to an in-use file might need to
  *   first "silly-rename" that target out of the way before the main rename
- * 2/ A filesystem that supports white-out might want to create a whiteout
+ * 2. A filesystem that supports whiteout might want to create a whiteout
  *   in place of the file being moved.
  *
  * For this they need two dentries which temporarily have the same name,
