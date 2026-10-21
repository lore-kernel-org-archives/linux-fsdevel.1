Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579873;
	b=q2x7Ud746sbGMVFF8QB1NUj8a7my5dZ8mw2hdCe0sWMF96Ns52Gw1QEGN7D6kcbs4Oa9
	 H8yrapaL9RZ96HNomVMmJLphQQd9Wi/oodVocbZj0AhiWag/oUuGlG+zp0YU+wdmRIkCH
	 rhpIX30sRXhJTcuwBieN2aVZ6io0WEQH5Nr2MbJHjUpbJDCZ0HJFlndoJDM+IAyeVtkLS
	 pDqQxJdzCEwhc7W39elzKalHh2LpHuHd2H8MScBuWN9xpjJ1RRqg2rDfAuFdgWKHzdsBj
	 STMrzElES+PzXXanFgtIPwZWEYa5/qNFmlp5oifaIXwQEMai6RgdYTuo7/iB4JxjKmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579873;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pv/mWp8e32UIW/KhC7RMCBsIZF7VkdvId6YoZeXvbL8=;
	b=PhCwbVrtP7vdi9kIVBqQkW9/mKQGUgitDqgrqoM2YWQ15grsSbKY8u7b5n4PEZAGynJb
	 LdZO3aoeTGRw6T3H0Z/XrhanyXWJin+vA8ltW9mMaDWh2YL/yVClNaY7zWF7L1yfY/1bZ
	 3v7IGdf1z0lW3B+wuCVZUgW+OH0DwJ7o3VNz2CdDKtO6CVMdkhYZPOpfo0l79AKa6JqYR
	 4H3TXSs7qNVF2pfrwPBbzt76FjcyIqgha6/cz1A5voYUUKnVc/CFjDb4n6LuYEP++F4S+
	 kvbih+9FeL3M5k08mRHXK8Ah/X9uIiF9eGLQudGJt9wbg6Cy6pC4ez/kzA34rfp42dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjGcpl8L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD77606A31B;
	Wed, 21 Oct 2026 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjGcpl8L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8FB1F000C9;
	Wed, 21 Oct 2026 10:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792579873;
	bh=pv/mWp8e32UIW/KhC7RMCBsIZF7VkdvId6YoZeXvbL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SjGcpl8LZWnLPQ4NhFcS4lP8VNZ3Dq4g+UwoYE5SMjabraUbfmpFaTB+6jX2UzclR
	 yF1gQ4GKMWzFsfP/8/6qiaFCNXinU7Js67IotpXsL2/fOIJCb0f0BcnK4Kp76bOaI9
	 H83Sq9JjWwabNYGIZhpRozC1V9eogjaLLKXsVPKV1hRCCw++drsq7msrGGqET87kb1
	 +CnqV1RuhZMVZCQAXCZWyh5KwZ/V1pYKeJi28kQ9OpMk/0QUB2U7n+vKXmlAOxw6kt
	 78AOJktL2CmwllxwiXMi0Lm7pjagRTSaC5xH03aEk7WCmEqaWPt4MMcMvPWyvIbVf6
	 ViGcjVMionarg==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, 
 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: jack@suse.cz, willy@infradead.org, hughd@google.com, 
 baolin.wang@linux.alibaba.com, akpm@linux-foundation.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+399510418a0b0cf1fc29@syzkaller.appspotmail.com
In-Reply-To: <20261016171718.243099-1-ngocthang2710.1999@gmail.com>
References: <20261016171718.243099-1-ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH] fs: annotate lockless file position updates in
 sendfile
Message-Id: <20261021-bemessen-kilometer-ortseinfahrt-907210419f27@brauner>
Date: Wed, 21 Oct 2026 12:51:06 +0200
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=brauner@kernel.org;
 h=from:subject:message-id; bh=k6klOoG1mIa9pd9DWLIybiterbHzOaQ9v13BkaR/ILI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdmCnz4Oyjt8tfxv1ln8J2+M788mpnr5In058G+Z88y
 ZeSm8/v3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRm8KMDG37q6XkX0y8q3Nz
 oUCJ95KpV/asmjExc8FtHtvoeEGVRWoM/8vX+V2pVZ1U9vKBhvGEoIvh7TcqJtednJjz7dpZybB
 ERT4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sat, 17 Oct 2026 00:17:18 +0700, Nguyen Ngoc Thang wrote:
> fs: annotate lockless file position updates in sendfile

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/1] fs: annotate lockless file position updates in sendfile
      https://git.kernel.org/vfs/vfs/c/f43bd96c7258

