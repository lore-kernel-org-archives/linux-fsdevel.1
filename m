Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F83D966B;
	Wed, 13 May 2026 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660063; cv=none; b=FXD6PYTSgtx5GN4RrLSh2CmSpku4GM20LrVqCDU7QOL/+1aTcZ4u3YXrPaaK0CudNSHi2jHxq1+KfSDYZCL5PR0CkqpgioiJthROl5ZHuk3+xxv0CoXDBce2S9kRZiW/vdvKEWenbe7E0ao7vXGnifNpWs/lFGD/Tm/dBLH5jZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660063; c=relaxed/simple;
	bh=pVV7p4dwIXvhzhLjg15L3+KRM6594W3MEBe+1QHdnfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K9nriiz1a/alPDBFBdBAbscwN++PhbKwQXrpGel8DlXCNblvuqGT7RZEIu2t2SHBIXTuwADsQm4iVnU5xfnOfSXQbrkvIvgIToi8MJuig5IDrfbwmJVdoJiVjdSjvpu7pP+NqVTnPSmOMrugCnCee5kIu2/FwnUYXmyhhw1K0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqc59cAF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqc59cAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238ADC2BCB7;
	Wed, 13 May 2026 08:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778660062;
	bh=pVV7p4dwIXvhzhLjg15L3+KRM6594W3MEBe+1QHdnfs=;
	h=From:To:Cc:Subject:Date:From;
	b=oqc59cAFWA0BQIKWBd4gFd70hBIS4FbmhNukCawgnh+cIfqDO9T/tz1hQlrGAWELS
	 KclpsEY6Ltdzc06eHacFfL6EH8cr4QeaL3oSIElfd0gqPc+23nWZwepEWzA8MYpBSb
	 9JW/V8Bqvv6rE7Tc81t94kZDdIYLUwLnWS1VSj+8qZdm/wUW6ok9zWotiGhlbV2Usl
	 K52GFwYhiBM84yIPKnRRrkeP+/kl0l4w7cgtERwKUSYN1RYIspYnwo9TP4NbAO39hj
	 SPuIOR1PR+/cEwOK1ltcNptLb2O9r3qL14/HIdrt78Xt+oIlFQ+RctnsvaEad7SoSn
	 RuL0ufYtraX9Q==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] userfaultfd: ensure mremap_userfaultfd_fail() releases mmap_changing
Date: Wed, 13 May 2026 11:14:16 +0300
Message-ID: <20260513081416.495963-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Sashiko says:

  mremap_userfaultfd_prep() increments ctx->mmap_changing to stall
  concurrent operations, but mremap_userfaultfd_fail() does not
  decrement it before dropping the context reference.

If an mremap operation fails, ctx->mmap_changing remains elevated. This
will causes subsequent userfaultfd operations like a UFFDIO_COPY to fail
with -EAGAIN.

Decrement ctx->mmap_changing in mremap_userfaultfd_fail().

Link: https://sashiko.dev/#/patchset/20260430113512.115938-1-rppt@kernel.org
Fixes: df2cc96e7701 ("userfaultfd: prevent non-cooperative events vs mcopy_atomic races")
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---

I split the fix from the code movement series, will be easier to
everyone :)

v2 changes:
* VM_WARN() if mmap_changing is going negative

v1: https://lore.kernel.org/all/20260501145433.156211-1-rppt@kernel.org
(patch 1/3)

 fs/userfaultfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4b53dc4a3266..390e4b7d9cb9 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -786,6 +786,8 @@ void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *vm_ctx)
 	if (!ctx)
 		return;
 
+	atomic_dec(&ctx->mmap_changing);
+	VM_WARN_ON_ONCE(atomic_read(&ctx->mmap_changing) < 0);
 	userfaultfd_ctx_put(ctx);
 }
 

base-commit: 972c53e0ec3abfc6f5fe2cb503640710fb23cf95
-- 
2.53.0

