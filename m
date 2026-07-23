Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5D40BCC2;
	Thu, 23 Jul 2026 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796775; cv=none; b=IKGO8E2Lwi7IJE1i4K6bZaZ5hliBKOrxxsNLIeXREaer6oseKm4JU/RwyZyOx9QM+PQNDglkkp6rbh6lk2GHuMklX5IBuJS7TeYA4rZcxI5cnKwkSphEhaJWq11gRpxfxDD5dZGxNsh4a2BlOFvPG7cV43Sgnv6rr3Cwsd4LDm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796775; c=relaxed/simple;
	bh=sbOMIyi2AYey38qHQKkzSMt9BEc6W+3+4WDZvacPNm4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VKy//j6qlQPZyCSJRdxv9Lp3DPZ98wex9cgZPWtCUluR49UF7FtTy7BYFFt3GJXu8a1QH6mUOAevlZ7kBKXy8VaHUeHul6BzTLpRxbPl7C4xwWuHdDhE7rDAYOp/toK8KFf40nACVEtTll95e+y7m/toY1MRxxH5NG8g2RolN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaJMuSn7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaJMuSn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A0A1F000E9;
	Thu, 23 Jul 2026 08:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784796772;
	bh=nglNDvxurobk+OcyDzGKpFU0mAGgqoYGl8a1PEr4yzQ=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=BaJMuSn7mVVDwM5C9TRq2oRWQIBN1wtLOH0DDDSH9odM55+qCJ1ftG4t66U1kdM0K
	 94+RjGX9TLmTZZ6CwrLPovtYCjghftn20be+mLlVAPMAuGeXbu6vre0RrtB4vShx9o
	 jZuUH30mZ89WcNldwylJOwbHWl/bZad4MoyIoHQzntTzlMVRHa60Tja3XtpZSnOlzJ
	 VU/AXIFDBa5U+rtIfQNn9Hlh7L6ev3t79q+JVQsM8WXggJnU6ccOsB6xIEEEGUQwWa
	 EKmnTAn7l64mkELW7MVSfhdBG30yCUbYHI+cNN3AJvz3FjZ6/repd7JaAH2uPX+O4N
	 GMjwtEBtJSNSg==
From: Christian Brauner <brauner@kernel.org>
To: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
 d@ilvokhin.com, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
 riel@surriel.com, kernel-team@meta.com, Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260707190238.3478608-1-usama.arif@linux.dev>
References: <20260707190238.3478608-1-usama.arif@linux.dev>
Subject: Re: [PATCH] eventpoll: compute timer slack lazily in ep_poll()
Message-Id: <20260723-ausfuhr-trafen-aktienhandel-aed3dd85bded@brauner>
Date: Thu, 23 Jul 2026 10:52:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-35fdc
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sbOMIyi2AYey38qHQKkzSMt9BEc6W+3+4WDZvacPNm4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlXks82fP4nufmH5u6t0yrq/51O/ShjxmPY+pT3ai3K
 s2lckJ7O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyXpWRYWJd4OGS6oM50wzt
 tkov3GT//vmCknvLr0xnKtlwfKMgjy4jw5vqwFUXFVf3/FhmzeKj0/HT5OZR1R0XWHeZvE8Mvby
 Nmx8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 07 Jul 2026 12:02:38 -0700, Usama Arif wrote:
> eventpoll: compute timer slack lazily in ep_poll()

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

[1/1] eventpoll: compute timer slack lazily in ep_poll()
      https://git.kernel.org/vfs/vfs/c/d0c242dda99c

