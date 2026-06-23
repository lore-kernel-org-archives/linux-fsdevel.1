Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD441E834B;
	Tue, 23 Jun 2026 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209352; cv=none; b=dUsZGBjwLEoHyLGfN3Ww4iL8wbo90HxB40jXmMLINxE6RGpwVPUG9uVvNsThzxJumKdog0tt5OyjI0M/EfXLrMlI1bVwLuvlbS0a/9fJih0vHcY25q0jq09IC1EAuQO2u7J+7sxAAVNV5qGlDDNO6qwY9T7zs1owq8WfCu2V8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209352; c=relaxed/simple;
	bh=hWGg7tVMAsEJg8CVKmY/1kdhkArSnRkE1mj1odq5R3w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tjHp6QHXYIlJ0imH1UXMSAkCbXP4FxvJXKB93NcBMXuB9VXK6tS/3U6HuKiV6PWCINTiDcrJsYeTLsNO52kxIwPx0fY1eccKDUSAGhSsLNPAMnv5kMXFgoDmcVz0peMw4hANx2mx9vTFBrFE/DSdEFjYTFrUxhB+FQDaIibF9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyeN+iCj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyeN+iCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C857E1F000E9;
	Tue, 23 Jun 2026 10:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782209351;
	bh=2gYnoY2ltdCJF+NLbGgoD7rO6jo0kwTXFJhIHca/gxM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KyeN+iCj81nUbiZWCDSdItRRcY+Q9kRqz03UV2kj+oxIcgnyB0gtjmIrhstKxrT0z
	 hLUSzl86El+ZVS9TD9ch4cSV2p7Y5JyAwa0z1IeCKtWfMQaOccjBBmN8TEAxklrLly
	 ZVIDFP6kq1pf00eBG9ItWtZNsJphPqVnY/sN7Of8gsUiV1A8cj+ew8Sl1l8tlWvS7b
	 a5oELP5f7zh56yG6/HoA5gxgFT0Iye6yikLstr0OiaJKtxWqFCqCPp0px9o922FmKW
	 2fqzgFVxyXxKday9xImwX2O2ak2fSxB3sWXpSVjhScAA3m9J9Ch7dS6ycKR7i3/sth
	 +zxKVVlXXuUWA==
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Maxwell Doose <m32285159@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260605035251.89305-2-m32285159@gmail.com>
References: <20260605035251.89305-2-m32285159@gmail.com>
Subject: Re: [PATCH v2] fs: efs: Remove unneeded debug prints
Message-Id: <20260623-orten-umgedeutet-laufschuhe-60bedf767742@brauner>
Date: Tue, 23 Jun 2026 12:09:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-df257
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hWGg7tVMAsEJg8CVKmY/1kdhkArSnRkE1mj1odq5R3w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZRbs6BZefufGx/bvSo8VfPn4Ovq/QwBiWIf7cOX/tn
 Fe7MupTO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYybTrDXylmj8hc991nHhp2
 xGz+mLrS152z6Nar0vDlC9x3mdaUqTH8z9PTZVtVM5vr86l//xI13v1o3vRxdlDmulerv519bOs
 WyA8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 04 Jun 2026 22:52:51 -0500, Maxwell Doose wrote:
> fs: efs: Remove unneeded debug prints

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] fs: efs: Remove unneeded debug prints
      https://git.kernel.org/vfs/vfs/c/1fb3f646c9d1

