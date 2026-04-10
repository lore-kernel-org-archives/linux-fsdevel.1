Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778B3DE43F;
	Fri, 10 Apr 2026 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834454; cv=none; b=jyUOIg9gIKKCZBDFpGeaTnT0dh+LxRkg2ZFRQObDkLyrblBTVkikQqIBHDIBx+kY6rVHqQ6gMQTvz7ARbgQD8vHRa2prGJAcNynupii7aOsLTOmlryDwXtSCs0sY9qlVrc4XSi+IVNFNzSix3m7YWiA7euBre8eYcho1/JbL9+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834454; c=relaxed/simple;
	bh=pio7ATvisDx+TYYPnCzAnhQm6KztBn+qNHe6SGjKC7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjMyYFkJsM8AcSpetbRGWV1Dzd16K5n8P3QBE2uti77CHGn9fFezYtq/Piy/9vk2HT/NUm/UhfBx05DZZ2CYU67obDcGCL0ixz7+Hdla+pVlTqY4cnzeilDN8bMty5dRN33ZdJJ3Tbnegz8fkkB7BzHkSNxY4/cCXZS1VnFqRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5YBKS/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5YBKS/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A0CC2BC87;
	Fri, 10 Apr 2026 15:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834454;
	bh=pio7ATvisDx+TYYPnCzAnhQm6KztBn+qNHe6SGjKC7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b5YBKS/H465cmUUWt9Izfusp946mdJilI0zhmSJlDJRjmQNOnQlR7yYaaccwvcZgM
	 zPGHExfei/09IC8atdCY7Nd5xgvQoLsOv1R9ZsnTAXxcCzhYuezR2H1tBaXEbDaDtS
	 DwHc0WS00yPPaeJ7WiqSCp+xcUhpGMpljHlndHVPBlRneJlcKO5TcW25NUkrQEDm43
	 SbGe1mEmGtVEjq7OIVxjketyoPlMnj26G+8dummJ92kaAuADGy6tHtmINeUbhNQwvv
	 wxQgmA4HD0q+PIeTkDezdw75hGorJoThNAbVkkEsUquoSmpgns6hWE3w+5aCLgZC7y
	 Dv5bESvQaCfhw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 09/12 for v7.1] namespaces misc
Date: Fri, 10 Apr 2026 17:19:43 +0200
Message-ID: <20260410-sardinen-lageplan-0caf0cb83f99@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410-vfs-v71-b055f260060c@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; i=brauner@kernel.org; h=from:subject:message-id; bh=pio7ATvisDx+TYYPnCzAnhQm6KztBn+qNHe6SGjKC7k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeFA1UEbnWkh9jkzJ3zq7bZzQYm/+sUhJP4HyRsKLs+ TTjZ8IrO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSP5Phr9ireRsUE/zy/71x 9StPjWHivbc6xPPE0Zmy1c1ud55ceM3wzy55409b/mOGjB/iLLcycccdiAmOjP52M+hIm4Dfj25 XFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Add two simple helper macros for the namespace infrastructure.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/namespaces-7.1-rc1.misc

for you to fetch changes up to 935a04923ad293cd89bf6ec23fc4efc9cf1a0142:

  nsproxy: Add FOR_EACH_NS_TYPE() X-macro and CLONE_NS_ALL (2026-03-26 15:22:41 +0100)

----------------------------------------------------------------
namespaces-7.1-rc1.misc

Please consider pulling these changes from the signed namespaces-7.1-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
Mickaël Salaün (1):
      nsproxy: Add FOR_EACH_NS_TYPE() X-macro and CLONE_NS_ALL

 include/linux/ns/ns_common_types.h | 44 +++++++++++++++++++++++++++++---------
 kernel/fork.c                      |  7 +++---
 kernel/nsproxy.c                   | 13 ++++-------
 3 files changed, 41 insertions(+), 23 deletions(-)
