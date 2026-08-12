Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4552FFDFC
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519035; cv=none; b=Oj8z9fnwSZjB3+26QIDqRx3wWN4hbWwUDS3L08M9Cddmw+cNpjGMIPtquWgl0nKtm8CJy/eAF0Eoba8TgluYMkf+MZzn1agxYva4MkG6RDfesWTydE84sHe/Cxx87GDF47m7izeh/w5pOLOagPaJrGw4qD+5LEIu0/iM4gqazqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519035; c=relaxed/simple;
	bh=lKpCCT/wpnppBu0jIvhBI4iAFqlPIvCmsBaUpRehejM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KlRow+lH4ep+USYqdQUGul0sUPa5JvNEB4Jd4/eCeTVAJnOrFGvy+1f8LbPW6KZotVBIK2qKOskVD/CLoqzDu+K8tEsWgShQd71o5pnoEhQ+i6Sv5Kmie0O5vLfmOCuoiNkfz9C7lgYU4JzsDkMoxP2zqzXdlVMf+PkwRKKFh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/56vJ70; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/56vJ70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99B31F000E9;
	Wed, 12 Aug 2026 07:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786519034;
	bh=CO0aMpRhWBjhcgT5DD0F905G+Qczdw2QSiDss6WyEFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=i/56vJ70qmcvSwlmbrHPckr3b5dLNyGRQgUL2dBwAAaql5StaXQXR7rsnTzaP12aP
	 JM4IZNv1+Ny4W3k8jDj2hPORr2QDZha1Cpo05z3DMJ7XdGyrfH37KiX0DGkgbagAop
	 9g7RGaKsmOoW2cwLAXuX2Z8nBV01B9LYbNZYYaJpX8wjp1SiCy+nSnyNQJYiFLU/Fs
	 z7Ysy/8TlvkcoESMbRHgJOCxW5muHNfrGTGY0gPx+Jwf/nuRz7lcGQNV7dmDVnd5ie
	 T43DN/LbBDbzMV5GeEzwd7TFtvzzrGBxbyt8Y5sOFb7hxFd3gSVzk+RU3meJyDnSUB
	 AL2cGRkT6HXbA==
From: Christian Brauner <brauner@kernel.org>
To: Benjamin Wu <benjamin.wu37@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
In-Reply-To: <20260810063704.355933-1-benjamin.wu37@gmail.com>
References: <20260810063704.355933-1-benjamin.wu37@gmail.com>
Subject: Re: [PATCH] docs: fix grammatical error in iomap docs
Message-Id: <20260812-epochal-erdtrabanten-filmmaterial-2cc625c5c0f4@brauner>
Date: Wed, 12 Aug 2026 09:17:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lKpCCT/wpnppBu0jIvhBI4iAFqlPIvCmsBaUpRehejM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVyP5csylHeJ3WfKZloZ573yyT03QP8dj86wuX2os67
 wU5jDNDOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyiImR4Th/lGWP9cmLx+/X
 7AzyT1j2eJ7CGsUNUlmT9lR2yf2YcJCRofXui+LMlEcL7Y8tYCvjSp9x54DM4YZVpbnpWx6JH/j
 RwwkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sun, 09 Aug 2026 23:36:31 -0700, Benjamin Wu wrote:
> docs: fix grammatical error in iomap docs

Applied to the vfs-7.3.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.iomap

[1/1] docs: fix grammatical error in iomap docs
      https://git.kernel.org/vfs/vfs/c/7c7fe554f40a

