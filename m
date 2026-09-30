Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AFE479868;
	Wed, 30 Sep 2026 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808215; cv=none; b=o8WsmxkBRUt7Tf8HxAmKEr19UqV30TJ5ZO9goj+QlKudmPcs8Q6EckjKly/OhVB8giAkMVyMAP1xChlljuuqFexioeGGvACk21U7ZAyOO8Lk4hOhmnAyCkBeyzYl6SWuqW6hN4jc2zliUydhXbYzgOSTuN8DSgWcfsM45xrj6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808215; c=relaxed/simple;
	bh=k2EZvMjgU1AOsrkzupdDgAwgYiqe9xAlt4XkCWZV8U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWNwn5/KLtPLWx5ubg5zgDq14ObFyArNivA8djWw5t7U1Pu2KX/jjcoT/0dyxW62xWvWnr1Io2Mfp5b7CivVCMCXBLW2Jp7mQHc948Eua/pcmPL7UhbfD2i/Ni+hwsc22un2WWNatX1wD0wAseYziXLv1sTpswWx6qumdptoMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zDC8RQek; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zDC8RQek"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pOWw+7uvQjF+jT2TP2lMifGNHqK20NDyyjkYpdOXvws=; b=zDC8RQekwb7mLXEzPjrn/U48/C
	7+nhLzI4hChCTnRQupOYVprnLVot3emnxt/FrK4taqqYfywZNdWeQJEYF+wSq+s17KcCpLnKR3IOc
	3eonU+f07qEitBJRoqdTzxV3/nxDPsWnoZNQ56ut3t2dAdp37LVm+J30JkmgN2lLIYWEmBhlszXyl
	CnSDOJJ/m2cPPRiA7icQXkJs01a5iCLqhPXgNvDa10lvebzTvFdLVAdiAfcbqKjEFVrO+BrBaVrcd
	9nI0i9bs3lf/zsmYIFSGhT6y2M7I1PyFRsU6bMW65BCy7IVxFH8w2Zemr4T65gmp9Jxm8TCekV3Sb
	4OmNQ0dw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC31P-00000007OyD-2ZIr;
	Wed, 30 Sep 2026 22:43:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] VFS: d_duplicate: repair comments to avoid kernel-doc warnings
Date: Wed, 30 Sep 2026 15:43:30 -0700
Message-ID: <20260930224330.2110958-1-rdunlap@infradead.org>
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
v2: dropped Jan's Reviewed-by since the patch changed.

Cc: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org

 fs/dcache.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- linux-next-20260930.orig/fs/dcache.c
+++ linux-next-20260930/fs/dcache.c
@@ -2025,11 +2025,12 @@ EXPORT_SYMBOL(d_alloc);
  * @dentry: the dentry to duplicate
  *
  * Some rename operations need to be combined with another operation
- * inside the filesystem.
- * 1/ A cluster filesystem when renaming to an in-use file might need to
- *   first "silly-rename" that target out of the way before the main rename
- * 2/ A filesystem that supports white-out might want to create a whiteout
- *   in place of the file being moved.
+ * inside the filesystem::
+ *
+ *   1. A cluster filesystem when renaming to an in-use file might need to
+ *      first "silly-rename" that target out of the way before the main rename
+ *   2. A filesystem that supports whiteout might want to create a whiteout
+ *      in place of the file being moved.
  *
  * For this they need two dentries which temporarily have the same name,
  * before one is renamed.  d_duplicate() provides for this.  Given a
