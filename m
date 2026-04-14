Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED853A0E8A;
	Tue, 14 Apr 2026 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160596; cv=none; b=OWoAszfjZGOg7qD6hOcHgw0jUj3hYu0PgLCbD+FFIo2ds8icHEDrC1B8gO1Gu/IEGUkiQLpS0xIVY39Tqas6QzuzATZJndsDTz+S6ODAyW3fyr39uFu3KLdvd1y4m5A2iFO18ndg1zsRJ4EZSHLkk/zl6TgYVnz4wRksAAS/U6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160596; c=relaxed/simple;
	bh=jZ/4N2SP7SNUXpBZmDRVXngLSy9TB8JcUBMo3JMsdVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eg8YuXX83v2HESihmLQAo1b+dbG5Vs/gwSBBQwFFbjfZ6wiu5NdV6XBKW60OE8FSsB3mkN9Q4Z/2+DvkomcajM0djqdQZ2zKuA4qCBAlhPWEwD7pitbP4a0O6Z9u2f1TYW9/eY4h3i5iPGfhBcAat784KJK26fVY3WbxrXjWDGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvHZKp+6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvHZKp+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBFBC19425;
	Tue, 14 Apr 2026 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776160596;
	bh=jZ/4N2SP7SNUXpBZmDRVXngLSy9TB8JcUBMo3JMsdVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvHZKp+6S4eWkqmmWaE8cT6NW+gNrArg2HzHHb176S14TQF987JsYL4UeewC1pfMG
	 45j0rwoIDZnKzCfHICZfHLXh3rDAWnO2AEQ44c9LHMX5+aZRoGuVl6zOZM74I3dNqy
	 Cx4zdEXvXl2/c9Mn3O4hrNlUr3BPPaRzqj7fZ01jR+vy5cN3lOtximDaY9SsqN2uQw
	 Mwm3w8npWKx9U6jlVgdkkMfg92CutW+Fa09WaSBxRQlPdaqXjZZKDlT7OZ8Yh23JG6
	 Eqx4txY3A0HpEpxGImQSaKA+ACoitTRDAisWVmAw/6ZGb+BSBlnt8jF9sPIBpPkbwJ
	 KrS0TCd0eGt1A==
From: Christian Brauner <brauner@kernel.org>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	viro@zeniv.linux.org.uk,
	jack@suse.com,
	bcrl@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: aio: set VMA_DONTCOPY_BIT in mmap to fix NULL-pointer-dereference error
Date: Tue, 14 Apr 2026 11:56:23 +0200
Message-ID: <20260414-hochrangig-vorabend-f973585b5791@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260413010814.548568-1-wozizhi@huawei.com>
References: <20260413010814.548568-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=brauner@kernel.org; h=from:subject:message-id; bh=jZ/4N2SP7SNUXpBZmDRVXngLSy9TB8JcUBMo3JMsdVM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTe4/eTKdy547xcUv3P2VHvxB3D94du+bmutYH7/L1TP Sszr3EXd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEMJjhv1eMb9STTfWVq1cs NV/yx75ZcWfdx3WCL489TlPwf6T95gTDX2GWK2f8n5w/ajO1efY6y/WXrcqyprV1OW8T2moznSV YnRUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 13 Apr 2026 09:08:14 +0800, Zizhi Wo wrote:
> [BUG]
> Recently, our internal syzkaller testing uncovered a null pointer
> dereference issue:
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> [   51.111664]  filemap_read_folio+0x25/0xe0
> [   51.112410]  filemap_fault+0xad7/0x1250
> [   51.113112]  __do_fault+0x4b/0x460
> [   51.113699]  do_pte_missing+0x5bc/0x1db0
> [   51.114250]  ? __pte_offset_map+0x23/0x170
> [   51.114822]  __handle_mm_fault+0x9f8/0x1680
> [   51.115408]  handle_mm_fault+0x24c/0x570
> [   51.115958]  do_user_addr_fault+0x226/0xa50
> ...
> Crash analysis showed the file involved was an AIO ring file.
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

[1/1] fs: aio: set VMA_DONTCOPY_BIT in mmap to fix NULL-pointer-dereference error
      https://git.kernel.org/vfs/vfs/c/66f2b15e0c07
