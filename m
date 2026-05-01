Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2A33CEB9A;
	Fri,  1 May 2026 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647282; cv=none; b=QhaeUJqPyGGv5BizmnQfUl80yGSbJVdpdY44J9V46S8ebrmWwQA3JLnfGyWt36YhrxeWI3OfhrLMdFEqP4iGTLwbhpfkEj3Ie00OOeyxBmk1TyFs2/LY6wUzBCW5A79Wrem60xdA4TlB5BJYyMbBGEr9MT7eED7Skw1FxBK6Npk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647282; c=relaxed/simple;
	bh=sIdxJn2uWKCUgOB/jcXwOeB6VnuZjhcEA2rnh/yGasw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7KsJt+edC59tUhj704kTOg3t3ve1qGh6MmpkMaiDAQxZOUu4f07ZseDqZsB8i5/UBRQMHKG3FgZYksuCBpA3Tuex5jNXe8kTpGCC9XCoEztoB0UCqTjrSVla2VCc3tt6Jz5pstnvrhQFCMfZ7S0lhgdKg6rrEt2OgwvJSV/Dq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCWpnuFT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCWpnuFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC207C2BCB4;
	Fri,  1 May 2026 14:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777647282;
	bh=sIdxJn2uWKCUgOB/jcXwOeB6VnuZjhcEA2rnh/yGasw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCWpnuFTXV3upoj4UjPdpW1McawbKlnlCFBEeLNisCH0zC9aWEqdLEdLMJKuQcw+n
	 bKBiKeo9aht3nZsrkK+rDHGoJzxDQPmcu12UOUCZIoWPKTH9WjcYywhpGlTbayCTe8
	 /tGF7q3lBktif4gkzAfQ+rYgdYJgizImzBILlUHRN0vfXeYsBSqEBLfo13RgnBAGrY
	 jSKK8ythzvY8zLjL4DxRRCKaA1RHIBV5XkKszVHtqNr/OQI01bbn3362NHvfMg1Scd
	 D0sAx3Jarg7VkGo3UTYZOjrTK6cimClDGb5e68fLG82Zq/ploz5vbriOdXTXGlJ7az
	 RlGxBVemjSjBg==
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
Subject: [PATCH v2 1/3] userfaultfd: ensure mremap_userfaultfd_fail() releases mmap_changing
Date: Fri,  1 May 2026 17:54:31 +0300
Message-ID: <20260501145433.156211-2-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501145433.156211-1-rppt@kernel.org>
References: <20260501145433.156211-1-rppt@kernel.org>
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
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 fs/userfaultfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4b53dc4a3266..ef963a58f1a1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -786,6 +786,7 @@ void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *vm_ctx)
 	if (!ctx)
 		return;
 
+	atomic_dec(&ctx->mmap_changing);
 	userfaultfd_ctx_put(ctx);
 }
 
-- 
2.53.0

