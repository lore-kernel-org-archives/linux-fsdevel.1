Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41382F3C1F;
	Thu, 28 May 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970625; cv=none; b=cVrwUY3MRCO0joDbLdcUmLAffFrGlJCEvIDNB5Q+xGGYYC0a/F7q3lZGkfyAv5x1ShEKPUz3EZu3vJ6Up+mWmaMUN7N8/f3z+nvoUO1LTVvp3NQQ/pvyPtawb99gWUzN7gkle2oJo/2Wj5Jt/QsEMhzPGH15p0cTR9juErRfXyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970625; c=relaxed/simple;
	bh=gBfwTC5Ydvbf2XTO/cJzlyP36onHgXi23TINsyJDeLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzQsbXwZXGPt4JHHphJpUc4QkmWGlRRU929/1qxiEg8eIFnXgKqUcQlA9ZsaTgYzL2e7HHPZgu1RvE7POyyO59Wfl8f8o2FB6S7GmLtRBWsGOk/pCUUHpa1K7tAGCHFSWU/q+3+WwDwcU4/K+58xKMD/acF8+oQ2kGtXjjBkqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDsg4qUS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDsg4qUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D514B1F000E9;
	Thu, 28 May 2026 12:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779970615;
	bh=eiFiIQ1xbG2OWKcBakxacQ1Ou7t+oA3vnBzLeU+fdXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cDsg4qUSX2k7jMGxpkEQgk7FINWLB1Q3qxX7JZXJTTOFO3R3AcgCgUNkPpt0WUDIf
	 q77In960dI/GIQZPxKnEilaJzFy+9ictr28S/L3gkoQTMBsZ7ldv21Hxsn4fXxoLhQ
	 mYkQ4t60Y/ecAVMoFCZ0DI33NOHG+ak2wI2U1CiwmLynxWKdeIO/JPtgbjtq6rCbx+
	 SLjF3giWVJPgGJyn4o3/xwFqo/oT1uMy40z7ywByboqwoWzQxpFvNpLhQ9NE66QkkH
	 2HGxHNRoqZIqXS+uJ6Lprjct9KaBJVxt/T8hSxbTzucKB4edAsuU/cjz0EDDP2Bv9N
	 raXx0egiQ/u3g==
From: Christian Brauner <brauner@kernel.org>
To: Arpith Kalaginanavoor <arpithk@nvidia.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	stable@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/qnx6: fix pointer arithmetic in directory iteration
Date: Thu, 28 May 2026 14:16:44 +0200
Message-ID: <20260528-parkbank-entmilitarisieren-wirtschaften-d432158f54ef@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526123858.1683035-1-arpithk@nvidia.com>
References: <20260526123858.1683035-1-arpithk@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=brauner@kernel.org; h=from:subject:message-id; bh=gBfwTC5Ydvbf2XTO/cJzlyP36onHgXi23TINsyJDeLg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRJGBmHRglyfy+6tJPVwvlG7+TSHI/yb9bHpdiyGaefr Ou6GavTUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJH0REaGdecDq6uVZvBH+r1q ZpRz2ty3vZ1Vis3arrPUq0Fw/hsdhv+li3dlbKzr+FjckC/1Z0G1o2rge3bJ0HTpmU8vxvBOWs0 BAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 26 May 2026 05:38:58 -0700, Arpith Kalaginanavoor wrote:
> The conversion to qnx6_get_folio() in commit b2aa61556fcf
> ("qnx6: Convert qnx6_get_page() to qnx6_get_folio()")
> introduced a regression in directory iteration. The pointer 'de'
> and the 'limit' address were calculated using byte offsets from
> a char pointer without scaling by the size of a QNX6 directory
> entry.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs/qnx6: fix pointer arithmetic in directory iteration
      https://git.kernel.org/vfs/vfs/c/89c4a1167f3a
