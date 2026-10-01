Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397828E0;
	Thu,  1 Oct 2026 02:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790821076; cv=none; b=bcfigVK2nscKxn5tdqgueBBAVdL1Fqr/TuHxRcKKKHuS/MUWavYiP+b0srpB9mxBMkTyt3Df+Ceb68H4v3l1orfYI4uLlC6RYpCs/if2ptRYZXVkh1idJkFIaFGpWR0bMBpb8Tgoo8RbuWWURHBGTkXn3F9PthjyG0K1TnHGjSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790821076; c=relaxed/simple;
	bh=Gd/qQIUaP6lcuejR3No/uE5nT0/NKD67EUf/NMG3q00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2VTl5a62SRc7hYIL6bNjERPNHYzYavFHi8zK/GXjdEYKbwgpTpJx03bOz43L3vrdzhDa61mzlqdPgD5MNco1ulWKhdvtMFce9RJzIF1aB87+6Ozs1ESJJ2Z/20naM3OYeBFfcNf7bYc4Ton2qyXW9NAdnXp7RWj3ooTjajMA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rwocds+A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rwocds+A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lO/IozwWM9cMGiFtGYhrUTFCJclvAMMd7gfbaxtHYYw=; b=Rwocds+AGpm9XGoXxnOxhHrf5Q
	vQkyvKwJXB/5iI5jzord4507G8hpkyrvMQfO5Ymjo92b4ZDobOAasizCkZXVYFoTsRH5KelesXcmd
	I/rjqBCVkl0tmJLrOaX8JcfZwhiFPZ8g1T6ShKNOJLcVu0l92STByvomSNONeHzSpXj5e9DHxYjfL
	GVbRO4brHvI08+tDEErrP1S7ACw4IBOYu+cucS6s8FqT3sMrv1P0qcnSPhCsDe/UPWcC2EVS1E794
	xm6zp0Lt6e0FgSySSitBOgzL30J55Pt0LHZD7uTy+N1KE+Pbb6IbNJ/iKAkxhpk/pBAKbPyqn2dEa
	mww9HMLg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC6Mk-00000007bJi-281u;
	Thu, 01 Oct 2026 02:17:46 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH v3] VFS: d_duplicate: repair comments to avoid kernel-doc warnings
Date: Wed, 30 Sep 2026 19:17:45 -0700
Message-ID: <20261001021745.2160005-1-rdunlap@infradead.org>
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
v3: use one colon for the list, not "::" for a literal block (Neil).
    Add linux-doc etc. to Cc: list.
v2: dropped Jan's Reviewed-by since the patch changed.

Cc: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

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
+ * inside the filesystem:
+ *
+ * 1. A cluster filesystem when renaming to an in-use file might need to
+ *    first "silly-rename" that target out of the way before the main rename
+ * 2. A filesystem that supports whiteout might want to create a whiteout
+ *    in place of the file being moved.
  *
  * For this they need two dentries which temporarily have the same name,
  * before one is renamed.  d_duplicate() provides for this.  Given a
