Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E553ACA5C
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802122; cv=none; b=HeerNKr9U7aFhJQAk6HhN3a8ZMzncqArlzUCO8NT1GRDR4wGB9NQZt1kvZcIScC9K6xgpFVNn9zr119Z4VzC4JtZY5bxAXRSH+c38uSdRcod1d7quzV8yWGCoJiVXffLd4XGPtoH84LodTk8CtHJbhmQoB2rHr6PRgDUGhcrWQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802122; c=relaxed/simple;
	bh=MYSPzdGHvAq1WootgbulOFD95hAFP42k6oZCW9G+8b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKe4Brs8B8DVEuTOXfscWFlMZuOkVl76QsUgPYyFfvJJnJTgUfR2FwRPy6kC0NXrP7nZCEIeN8dLI2FMKxyMMbhKySbkZ5+cOxCq8NJipufKoJj3X4YCEEoBdUhsuCNJPAXCn4sYhxDhXqlYPXQuc2ZIV3U/ykn8GoWPVY02NKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7yEkkwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7yEkkwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54891F0089B;
	Mon, 12 Oct 2026 10:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791802121;
	bh=86dla+81F3suTOLS52ok6cqcU2G1FZrSK0sW+VFXWFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T7yEkkwMSiReMceqyGA3nhecrnbDPlVSdz19p92FWrl2iftSzKqoxvi0qM9gmkwSb
	 0UunS9J28l9AZmxCipppAqaIykx/jJxI2cWqIod+Jcoz2/KaLQo80JfFY/MbfYPy6N
	 MDKEp2WcpbeSqWZ5DZ7PuHhiWH71k9v45FBVoVvRtXSk57ZDC3KEqu1nI6VUOxmeE2
	 O0axRlQEX2foTPnE20oXleoxS836XP88nfO+2753ZnL4P0wXDjSs5PXIylk39AD9tb
	 dqLQCsNKgMa1/sS3oVdqqU2L+TmmdivcTMAWz4nHGC80gCn/nZvvSgAdmFj4b1+aIT
	 qIV9+DwK1jpYg==
From: Christian Brauner <brauner@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Giuseppe Scrivano <giuseppe@scrivano.org>
Cc: Christian Brauner <brauner@kernel.org>,
	xiang@kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	hch@infradead.org
Subject: Re: (subset) [PATCH v7 0/2] erofs: share the superblock for file-backed mounts
Date: Mon, 12 Oct 2026 12:48:33 +0200
Message-ID: <20261012-inkubationszeit-hierher-pferde-402d3192f67b@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002163225.1258203-1-giuseppe@scrivano.org>
References: <20261002163225.1258203-1-giuseppe@scrivano.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=brauner@kernel.org; h=from:subject:message-id; bh=MYSPzdGHvAq1WootgbulOFD95hAFP42k6oZCW9G+8b8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd2c28cp4Nk/kF940plT7Hb8+NXfH7tcG/XyoMVqWfr toY3Hdw6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIymaG/w7a69eZTzn3nX1y qTZ31Radya+MBLIFfqzmfa2/iivAq5zhf8Gq2hW8a0S/Nq6dcFrq/cFs5wnJV53XijV53ln2+eT KtdwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 02 Oct 2026 18:31:42 +0200, Giuseppe Scrivano wrote:
> v6: https://lore.kernel.org/linux-fsdevel/20260812142907.1010046-1-gscrivan@redhat.com/
> v5: https://lore.kernel.org/linux-fsdevel/20260811071241.389589-1-gscrivan@redhat.com/
> v4: https://lore.kernel.org/linux-fsdevel/20260804060455.2928514-1-gscrivan@redhat.com/
> v3: https://lore.kernel.org/linux-fsdevel/20260801075446.2508805-1-gscrivan@redhat.com/
> v2: https://lore.kernel.org/linux-fsdevel/20260731160901.2276832-1-gscrivan@redhat.com/
> v1: https://lore.kernel.org/linux-fsdevel/20260730124120.1501126-1-gscrivan@redhat.com/
> 
> [...]

Applied to the vfs-7.4.shared.super branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.shared.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.shared.super

[1/2] fs: rename vfs_get_super() to get_tree_super() and export it
      https://git.kernel.org/vfs/vfs/c/64571ba65816
