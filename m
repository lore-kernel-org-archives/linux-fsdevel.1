Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C23DE43B;
	Thu, 17 Sep 2026 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641242; cv=none; b=Zg04LPQArwz657GU1eHRU/xp3eQ20qhmFXxvELxNIigrGOlaWCM/57VQjqOn/QVrrlONY9Qs01Ab1c3PzzCQ4+UQV04aaH9S+5/zOeA5UzPcFnFijxhWsDa6aSHE15VdJeQkW1hCfTHR0zZa+DyaW3WJBig6mSEt6WsmxqLdMw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641242; c=relaxed/simple;
	bh=Psny2i9rsPFUYgI3PdFgwjuJsgQg7wez9vfxuMxMXXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKJu+kTnXGn3e3zm7FfjBTCqQLmM/7J8lnUw3me1chs5E1gbSu1ZEi79d1WyFiLGodFefuI4yTQRl0GWOM/4Vsp1vAkilfJIJo+KLPjuXnorRfHUZqirM1KoOAGS4UGBx5TFRxp8IO7v5jH7AvQpBTO4Dj5vbcShSmNOkuCi9Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpwAa8y8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpwAa8y8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A0C1F000FF;
	Thu, 17 Sep 2026 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789641239;
	bh=ymfaQy9wcYFqS9g4/KKsWkxgVIeRNm+K8w0qzvcNXJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fpwAa8y8Hpg9sgMXLre6Ao2cqSngDIWctXChjkeRl1DSlY9FbWSaljCPKBuQtMVtm
	 EoT8DWcExawmcdr1XOZZt4vjTIzqSWZa5r23EElG6Q78VQyjwOyx/DrLzsjWUUiSyV
	 kU9UNMGTZ46R07FbAbwjHaXHK3aTxU/cS4Z7ujlOQNFKwSZ8vEaD+2s4ls0BXtTbbY
	 B6DnEC0lQM/eXnyh51WqUqpgmz/JG3nlWM4sSfQkf0fORz5rCVZLcq8HQNs3yD4cKA
	 LXPtVl0mnNHDILihyULlHzndOK9AQJSsZsphBoDvFVse6/1njjzYLRXYldX4WSQtV9
	 W0hGj27OTeWYA==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Yingchao Deng <dengyingchao@kylinsec.com.cn>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qinyungao@kylinsec.com.cn
Subject: Re: [PATCH] fs: fix misleading comments in read_write.c
Date: Thu, 17 Sep 2026 12:33:53 +0200
Message-ID: <20260917-lotsen-summt-hypnose-e6ffbabe7547@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <918177B3298981ED+20260914075337.1739-1-dengyingchao@kylinsec.com.cn>
References: <918177B3298981ED+20260914075337.1739-1-dengyingchao@kylinsec.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=brauner@kernel.org; h=from:subject:message-id; bh=Psny2i9rsPFUYgI3PdFgwjuJsgQg7wez9vfxuMxMXXQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStPiQUNbvl/gNztynr7p55KpHmcVtzccm0xbF3jksu6 8xVZ0o41VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARlreMDPcOnXvcv+2OaqVN sE7cve+KtxN/7y0+Fnj0p9HXhx9q5jAy/DM32vnLNv7OEZVVPXICc5fcSf485Zqdq4kz02bl2bm dPswA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 15:53:37 +0800, Yingchao Deng wrote:
> generic_write_checks() returns the number of bytes that may be written
> (possibly truncated by generic_write_check_limits()), not zero.  The
> comment was likely copied from generic_copy_file_checks(), which is the
> analogous function for copy_file_range() and does return 0 on success.
> 
> Also, no_seek_end_llseek() and no_seek_end_llseek_size() are helpers for
> files that do not support SEEK_END (they only handle SEEK_SET and
> SEEK_CUR), not for "fixed-sized devices"; that description was copied
> from fixed_size_llseek().
> 
> [...]

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] fs: fix misleading comments in read_write.c
      https://git.kernel.org/vfs/vfs/c/73a1ab6d7e14
