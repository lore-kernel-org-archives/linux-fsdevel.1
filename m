Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35284438FE4;
	Fri, 14 Aug 2026 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713242; cv=none; b=jHzqzn57wXaVmwJB//8wLuTLmsYfnljM0I5HCDux2phDB6E3+B+fSqNMt6pQhyzjzOhdXUzjHC3JkLsSu7g/J6u4hVIp5WJfTDsinebnV7ZXAmNfPENsin/2l9v3VujDIFvECIOPg6RswtRapbQ+LiTZ/22g2Qwkx/dJ2LL6NCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713242; c=relaxed/simple;
	bh=IJDE/E280SdgkV4mw7Xd1rPXfQVSVF/VJMF6YMWPumM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbhkygmzOm10+euwCDVEx52PNeCHqYe19JNrsionC4CE++/xYlNoU8NXzLry1btqTGutFbcTEnoezs+QCjYWmDa25bi2pe7tw0ek7TRmN1pex8bXCqS4MZNYNKClY7BqjC901W5/zQHC0zuGhrt+o3MCif1kkVS1TNJMRneAul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyXp43qt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyXp43qt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90031F000E9;
	Fri, 14 Aug 2026 13:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713241;
	bh=O98EfA5QI44KHBX8t0xwcUfPdJjFTrEn2b0+rM+7VBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hyXp43qtCbZuH69fuQQGmTd90K+MBz+5hYY/lEwR2dAKXXGWquyBuR5uQlCx7VpDv
	 h0Rh6mO9si5R+8SdDikCM1AdqoZ4WKXljzTM8hA4v7WM7LmmXFsXjq5RLgG1jFkeU/
	 /MDOMDqp/XNNeXRlz4/ag4QDyvVybmmQQMLIf20hNo1AcCZ9fKxhxxDj1mzWpowTR9
	 razTEhfiTijzmsMYHdBqZQrfLKV24/xuqjhFFywg+f3yZEnLaJt0v8pN+tCwhfs/0G
	 DaxZXpEX2R6Vrr6oKNWdK08EyMyHGLTWnEGkZKt8K9UyQsBx9WCH0B86MBp0rag4ZS
	 5GCoTm5kodZ3Q==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 13/18 for v7.3] vfs mount
Date: Fri, 14 Aug 2026 15:13:45 +0200
Message-ID: <20260814-vfs-7.3-rc1.mount-34bc04d28755@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599; i=brauner@kernel.org; h=from:subject:message-id; bh=IJDE/E280SdgkV4mw7Xd1rPXfQVSVF/VJMF6YMWPumM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi3QnqoXv5G75f6B3vXeT0haGBe8Mr//isJRh+v2Y9 12poMShjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInYvGX4X1AQv+cP259Sm8X6 DH+rTA+XLytcO/vDFoNVFVWLqoTD5zH8s57k9C670r7t4s2ci/+yuA5O3b+v/eyWZRW5Pq37bLi e8gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

- Make the legacy mount API notify pollers of propagation changes. Changing
  propagation via change_mnt_propagation() or MOVE_MOUNT_SET_GROUP update the
  propagation relationship of the target mount. Unlike mount_setattr() neither
  path touched the affected mount namespace. So pollers of
  /proc/<pid>/mountinfo were never woken.

- Also remove a redundant panic() in mnt_init().

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.mount

for you to fetch changes up to 083e8742e301a24f0c458696b45b481345888b85:

  mount: remove redundant panic() in mnt_init() (2026-07-22 17:57:45 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.mount

Please consider pulling these changes from the signed vfs-7.3-rc1.mount tag.

Thanks!
Christian

----------------------------------------------------------------
Guopeng Zhang (1):
      fs/namespace: notify pollers of legacy propagation changes

Hamza Mahfooz (1):
      mount: remove redundant panic() in mnt_init()

 fs/namespace.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
