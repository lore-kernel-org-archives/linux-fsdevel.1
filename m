Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438D1C84D7;
	Thu, 16 Apr 2026 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776376472; cv=none; b=gf6F+mb41kzg4aYOHBfd16uo689+VZ76kfHMvoOGLlAfiGbJBeO4GDHvl13TBbgfH5sLirOUrFWLhnQxapujNBBDBGJ2iUBLZRNrodLshadsK904QA6Z+9mezPgQdC1eUNgp8YRakq9/1nSs/RTX+N+WJisjKrVZ8TzsZsHQr2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776376472; c=relaxed/simple;
	bh=IvzokNZU8HVI1FLyaI1Y4sfq6GsgVoZgr0Jf8qSigG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KX+0E2Vfh2HOcPDNix/Mtwacaao3c+yTLt9+RDF98NtLd43QZ0Z+1J1hK7REWIp0KWsNO6EKjUHTUUzOd9DfKwQFsasdLx56sAFNkef4rASTYBkhi7d2e3JTpBmt/10/NXueyqh3w3ZqV541TxOr6ZJHGVdaFBdbmh2FwjanVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0jj5DEKO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0jj5DEKO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZOesIhG46fbiTDB9/6FAp5vM6rl3Q/JhUCdnlxKpBrw=; b=0jj5DEKOjSABN02NPr1trm2bC+
	5ArftSC1H5IIEp3xdho4BmuA1Gqo5xr07Bk2DriQqd8JDPZ1cbOGx3kf181AVMUbNZRjN0dUIpzNm
	Knv+lgnOCKJ78L1bVor1nAvAgMUY9GeJRl7hSZAZ+wddOKw99YJN5PzAXZylGPikDjb/zGL9y+ZRp
	jTey9HjMEh1sJswiMR2sBKye5sbT9OGktdJwnnQW3kkt3PIKQR9y4WY4vW0NjilSysw1WcbR6B3W/
	FPAW1Vwo6ZDu+dhXj8REYroTPTezIdKj3898qr8A66EBeDLWewF6nH4ZNGTZOZSj0BMQ8dydUe6Mt
	9cJonusw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDUfO-0000000374u-1pQ7;
	Thu, 16 Apr 2026 21:54:30 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] nstree: fix func. parameter kernel-doc warnings
Date: Thu, 16 Apr 2026 14:54:29 -0700
Message-ID: <20260416215429.948898-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct parameter name ("__ns") for function parameter kernel-doc
to avoid 3 warnings:

Warning: include/linux/nstree.h:68 function parameter '__ns' not described in 'ns_tree_add_raw'
Warning: include/linux/nstree.h:77 function parameter '__ns' not described in 'ns_tree_add'
Warning: include/linux/nstree.h:88 function parameter '__ns' not described in 'ns_tree_remove'

Fixes: 885fc8ac0a4d ("nstree: make iterator generic")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: rebase, add Fixes: tag, add linux-fsdevel mailing list

Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org

 include/linux/nstree.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20260415.orig/include/linux/nstree.h
+++ linux-next-20260415/include/linux/nstree.h
@@ -61,7 +61,7 @@ static inline void __ns_tree_add(struct
 
 /**
  * ns_tree_add_raw - Add a namespace to a namespace
- * @ns: Namespace to add
+ * @__ns: Namespace to add
  *
  * This function adds a namespace to the appropriate namespace tree
  * without assigning a id.
@@ -70,7 +70,7 @@ static inline void __ns_tree_add(struct
 
 /**
  * ns_tree_add - Add a namespace to a namespace tree
- * @ns: Namespace to add
+ * @__ns: Namespace to add
  *
  * This function assigns a new id to the namespace and adds it to the
  * appropriate namespace tree and list.
@@ -81,7 +81,7 @@ static inline void __ns_tree_add(struct
 
 /**
  * ns_tree_remove - Remove a namespace from a namespace tree
- * @ns: Namespace to remove
+ * @__ns: Namespace to remove
  *
  * This function removes a namespace from the appropriate namespace
  * tree and list.
