Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5735E1E1DFC;
	Sun, 15 Feb 2026 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771129743; cv=none; b=o/8MRNXW1VfwLcSFsaMQmBBodYhKccTG0mXwHXR1KWQZJ/szWujjFU0rzJV6ukoNRge0jwHAgVYuZnppbM7A1RU8I1N549R8lbRknwxEqkOTnV0yA0rJzNXFO86dnuKGzR8PU2STv7LlNFiRi1bh3KWDT6/DixedC8FISgzG+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771129743; c=relaxed/simple;
	bh=JbWq7wgnL2qN9z7FEVzvPfVqM+jeBcalhVpTviJeWYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/o2lSH5G62zDhsv7q23WuAD6x7jw3f6+Dtg2E7I2yc8i9BkixyQs/oDDSIT3+zCYgwUhoxJaAXsgSORtX7271My0sZ2E486dBy7eaS6eX8OpyL0YBpIddDkwqZMvRwfyA+rQptgkF0ITqVpDpnqROERGmdGnr2aYnuhDTRd5Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/E8BNT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/E8BNT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81575C4CEF7;
	Sun, 15 Feb 2026 04:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771129742;
	bh=JbWq7wgnL2qN9z7FEVzvPfVqM+jeBcalhVpTviJeWYo=;
	h=From:To:Cc:Subject:Date:From;
	b=b/E8BNT+nlIBwPTgmspja+zoq74WJ8XpFw1QR0S7AGNQNHztTIVz3CesCzlUAJQBA
	 GrThV5g5QELcvzt9dmWa4EpxzDFNKu4cLljjL7W+hfqbomJ7pLRjkY1ah0Hs6eiGb8
	 vY1UHBtX/ZhhfaH/AdroHEFa834dGk6hzvwo+nugOm02RH8szSU4CVsDZ5s16RtyXL
	 Q/rEYSO3TrbFn5g7Z+ChAw31OYXMG3fetxpXEsq8cxzgSeF7GlM/FOHrvvQo7ODXdY
	 oxwYOX5TPvX9VWh6JfxSwtE9GvVqZ9XRD9sgNr75loFfbyb+mFQ7op+sK7pOvYQqEe
	 gh6lu5Oz/B9Bg==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3 0/2] fsverity: remove fsverity_verify_page()
Date: Sat, 14 Feb 2026 20:28:04 -0800
Message-ID: <20260215042806.13348-1-ebiggers@kernel.org>
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

Changed in v3:
    - Additional scope creep: verify the entire folio, switched to
      several more folio functions, and stop clearing PG_uptodate

Changed in v2:
    - Made one specific part of f2fs_verify_cluster() large-folio-aware

Eric Biggers (2):
  f2fs: make f2fs_verify_cluster() partially large-folio-aware
  fsverity: remove fsverity_verify_page()

 fs/f2fs/compress.c       | 11 +++++------
 fs/verity/verify.c       |  4 ++--
 include/linux/fsverity.h |  6 ------
 3 files changed, 7 insertions(+), 14 deletions(-)


base-commit: 64275e9fda3702bfb5ab3b95f7c2b9b414667164
-- 
2.53.0

