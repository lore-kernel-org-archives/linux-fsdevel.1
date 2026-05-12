Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CB639060D;
	Tue, 12 May 2026 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589718; cv=none; b=RSg4aItGTFqXVtPM/QgfkiC6MPs0QfKW91G+W/Bp3zbLjQvW3hotLk1ADa6SRnpcb4YZbLxK3H/G/JIjOvCdpaIWWOVasmrbCk/ZWi/Jo4SH8Skgv6v3ITuY1fDN8uq33wRvrKEhC1wllQOTkh5vmZu4A/UNzHXXSrZWqCfm8C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589718; c=relaxed/simple;
	bh=R+g88YtttSA4NlQOajhEjCpPmkEARxU83m0K9UzE3kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQNzITBoBuGqeZQdwtPNYaGN8zvHO1xYr4wAYVTcNy4Bzx0AR9rYqet5C8BiB6/Z2v1yRKQBOS8GzkYVNtjthBEQssm70ccMOhqNy1N0mdDBJifSjWb5q/CRY2lKTHPgdq+0u3fbHLY67A1KnIehavUw1CyleVZURt3wKcOStyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReJbIhfJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReJbIhfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CE0C2BCB0;
	Tue, 12 May 2026 12:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778589718;
	bh=R+g88YtttSA4NlQOajhEjCpPmkEARxU83m0K9UzE3kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ReJbIhfJ1myLwe/Y+BNt7M52TgfEhb0Za2JoYSR9wzkuUckh78SX3pp9sNmNnw4zB
	 rP0OE2ixKLnfB+ykAr9IwL3FfOfkIskhYP0Ss+Jg8n0Sfaxvz4a+y0yDzOQ5L19dAC
	 +ahyHwj9bxMTjG3sistMLh7mYGbX1pRE1/wH/xmdxOq+aFJ1lBuSyMNO1eDovF8Kqv
	 3vSnl9N+2SpEBK0I/DKpjSHXYIlw2A9h01fliwJdWH8grQNfyhCxGaLgp7/4uYboCj
	 P33B2dgZlmundMVuUh1aTD25w8Cv95NNQWsc7K8LhNN2pQp+7h6luswWn4t5VhmkCU
	 KZZfr09qZjyjw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	clm@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH] fs/select: reject negative timeval components in kern_select()
Date: Tue, 12 May 2026 14:41:51 +0200
Message-ID: <20260512-kinopublikum-hassen-0cfadf105921@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429-timeval-v1-1-4448e2588bbf@debian.org>
References: <20260429-timeval-v1-1-4448e2588bbf@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=brauner@kernel.org; h=from:subject:message-id; bh=R+g88YtttSA4NlQOajhEjCpPmkEARxU83m0K9UzE3kA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxKwjOdug5qG6x/ETWb/Py5fLnT538rL5X5a61FHOl3 m1ZudJjHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPxqmX4H5x2LvSq89L3QUc+ ip/dOrPs2saGI0+r8hwEz901tzNZeouR4f6uq3wva+fOOVVbxhlX51D5qsZp58wU4QTdv/kzehU UmQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 29 Apr 2026 06:09:37 -0700, Breno Leitao wrote:
> kern_select() normalises the user-supplied struct __kernel_old_timeval
> with
> 
> 	tv.tv_sec + (tv.tv_usec / USEC_PER_SEC)
> 	(tv.tv_usec % USEC_PER_SEC) * NSEC_PER_USEC
> 
> before calling poll_select_set_timeout() -> timespec64_valid().  Both
> operands of the seconds sum are unbounded user-controlled signed long.
> A crafted pair where tv_usec is a negative multiple of USEC_PER_SEC
> drives the sum across the wrap boundary - e.g.
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

[1/1] fs/select: reject negative timeval components in kern_select()
      https://git.kernel.org/vfs/vfs/c/859c199bb3a9
