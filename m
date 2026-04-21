Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A86317143;
	Tue, 21 Apr 2026 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772869; cv=none; b=OZKZvRZOLgUnJhAGMO+7bAhwStVP23ZBLOZTLnMKkD0t0ipodIYM3BPumuweb+K7sCqs/68T36thvOiwB5CUeXjvXU399FXcSZgO5bAhcXSqrykiFhmwQLDr3x7DFzLkRf5NAZ64pORZyV8z10P/ijqpQK6j+W/xSt1cJPuBi/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772869; c=relaxed/simple;
	bh=Q0cn4gfQNdtqAez/VVKu4LkIWz0ZXbDINvgq7DEkwHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/l7NO0bNXv1OECt3nBZLBhlgE02HH4GRv7mPUaPoSuaqaGbUnpyUjG3RD1nNLwAXEEZKOxR8QqII/MVeutIGPqBPsbwSMNwHoS9Rut0t4cPsFzvKm8pdXiBAu45ThWtm8NHnntncCEpJ9yi7ZhanjXr1PgA9qR95tEtdFaGP1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtRZMM/0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtRZMM/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C74C2BCB0;
	Tue, 21 Apr 2026 12:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776772868;
	bh=Q0cn4gfQNdtqAez/VVKu4LkIWz0ZXbDINvgq7DEkwHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtRZMM/0Ms4vptAuDL5tWQ76GYA2a1iwneXVREAiyBB+IthNr09Vq+HQrRi/EB42N
	 xGF3ol5RwRlJd9bORsTG5FJBuuMBYfZZezof6p25qhSJJsIzLXpsXk5b5DV3hOCiNz
	 VKNBGRU/zAXxcsVLOUf86hGQ7fp87A+C8VwHngfyndecT7Vw0t7F97ggSPAnd7eAsE
	 RpVW0QNaunw9l0OfUvwo6uNLd2/+il4uEes7qtn6OgimKFSMwOeZ67CFM4EZPy+SND
	 NPGqrsxh/JYVGGRFqcFQUoBlpLXYa0H82DvoTLf9mG4PGSGWd1hKqcPDJinwVRXoMk
	 ThlL1W4J/x0xA==
From: Christian Brauner <brauner@kernel.org>
To: tahsina13 <tahsinahmed217@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] dcache: fix typos in comments in dcache.h
Date: Tue, 21 Apr 2026 14:00:58 +0200
Message-ID: <20260421-mahnung-ebenfalls-6fea5afaa38f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418184704.8040-1-tahsinahmed217@gmail.com>
References: <20260418184704.8040-1-tahsinahmed217@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=825; i=brauner@kernel.org; h=from:subject:message-id; bh=Q0cn4gfQNdtqAez/VVKu4LkIWz0ZXbDINvgq7DEkwHI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ+T/ufPi3jaPW2lD9blXK+xP699HxXxy0fxnLfVzNMH Ka1qHBv7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgIRxvDX+lr29fcVHh860Nv /lLbxR93qW/bsUzh2qUZwgm+JXbeBcaMDMfkjzRd6mli44v8d1DM7s/rsKQvr4/zGx7YttAjpEk hjgsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 18 Apr 2026 14:47:04 -0400, tahsina13 wrote:
> 


Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[1/1] dcache: fix typos in comments in dcache.h
      https://git.kernel.org/vfs/vfs/c/66814af18595
