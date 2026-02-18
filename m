Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536472BEFEB;
	Wed, 18 Feb 2026 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771376846; cv=none; b=ZZoma6THPr3oIyTxxR1dpu9JWa1rGVMYWQT1/Tk9MwXEoE7bggawzBffK5HT+Uh+IHKV0Y+9WrhJLYEMq06BrS1/ePwBRqt79oAZV5ELIYkxtXsMHYJ9I5LeLcDXlYenfMpPW+oEq5ShxxvOnGJBsjeKqzuRzcxwCj480Br8tXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771376846; c=relaxed/simple;
	bh=X/yfr8WHeaSkcZAFT81kIwzbFHKp17KQujASvuEnUZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXbkKMHpZXCrjt5BhGUXq581LdI9n6Qtp/RCQa0P+mUm+SpPLDABDLhSWQFDNE+ddpz5YNWAR448XbLGUZ4+IZP/D4XoiUCamQaDakxcXkj05QXgpEQWdulAP0kqHB4Tz3V/aRNVDb+SXGoZUTtYqsoX+rquAH6zeDROkFcDVRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbzbNl92; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbzbNl92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D40C4CEF7;
	Wed, 18 Feb 2026 01:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771376846;
	bh=X/yfr8WHeaSkcZAFT81kIwzbFHKp17KQujASvuEnUZw=;
	h=From:To:Cc:Subject:Date:From;
	b=WbzbNl92alzjhUHtJoa1oJTeRoBkDtW804+fnYL+QtQH492kJT1uu2dvIY2jOncEB
	 BUUqa/zR24ZYz5WaKq7dpvNFbOWNJ415LhpCs73TpTpm1wshlA03OLH/CNqSNvurPi
	 Op5tdXe06unR/mY+AJzNjcLN9BjDdsuxR+yeGoHuVtSHIxM2MA2SJGFFx6y2nt+dJl
	 Mmlc8q965nmfB6S7lha++CAw+15GCsPO3PVs92le649KXt9E9oV7ZAPv47irTVP+Yy
	 K6wL4Y3TLZFvOIqSXGjzhpN7yKNG1geDNl4LRhVD+iU9+KcBvccN0zvQRcTtReFit+
	 5yxLYp0Vb1zGA==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v4 0/3] fsverity: remove fsverity_verify_page()
Date: Tue, 17 Feb 2026 17:06:27 -0800
Message-ID: <20260218010630.7407-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes the non-large-folio-aware function
fsverity_verify_page(), which is no longer needed.

Changed in v4:
    - Split ClearPageUptodate removal into a separate patch

Changed in v3:
    - Additional scope creep: verify the entire folio, switch to
      several more folio functions, and stop clearing PG_uptodate

Changed in v2:
    - Made one specific part of f2fs_verify_cluster() large-folio-aware

Eric Biggers (3):
  f2fs: remove unnecessary ClearPageUptodate in f2fs_verify_cluster()
  f2fs: make f2fs_verify_cluster() partially large-folio-aware
  fsverity: remove fsverity_verify_page()

 fs/f2fs/compress.c       | 11 +++++------
 fs/verity/verify.c       |  4 ++--
 include/linux/fsverity.h |  6 ------
 3 files changed, 7 insertions(+), 14 deletions(-)


base-commit: 64275e9fda3702bfb5ab3b95f7c2b9b414667164
-- 
2.53.0

