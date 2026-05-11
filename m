Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120E3FE67E
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511454; cv=none; b=sFB/IVDCARKV1T+Zs3H+OTgJ+AOsqbB4yzjY9vQi67/OqsHO5ZHUeFcLl6dyspPkntyMXc5+gx7YtzGdbnFFAQ9MR5klY9BaZVnlQuTFP3wyhudMMZT/GTY0MU6Heq9GihsM4uS8ExvhOmTGmIytRcrS+SG14FNl4xZtlFPmHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511454; c=relaxed/simple;
	bh=GhDXtWhXv1Pis9PPJuOpUzCtZVaIFCQzs5VQ5Dc8vuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTaMsqzgxD0vjFmLzDDVqR24Jv031WwuMQzDaQcVEz/RjLCQ0u6eOkVpgsW/6RbvHgIrptgZ4aEfpl050llZwpJTyHhENv5u/m7zxuwcXG8aBa4IbOSAmSSKNjiew4gGdFxHtwY3T3gxZe19fz+6tUpv1W7TGi7A3VpAtU1d/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoiR0Rq4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoiR0Rq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA34C2BCB0;
	Mon, 11 May 2026 14:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511453;
	bh=GhDXtWhXv1Pis9PPJuOpUzCtZVaIFCQzs5VQ5Dc8vuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MoiR0Rq43CQa8zJedCf/tc9VsPJOhdl4bYtxYTY0Fe91cjxkzwlReXrkxiqbIODWr
	 +lUfjnRp/MQwjzP+86uT7chvIj2EiHd9wxuQPFnFOTHJ5LVuJFB6qcl/MCeDAulXOY
	 3VBQkt1/h81w5QYuljYCunX0XYeh/K7C8d5EzUWwz4uq2B/+KDsf0jywNknyJydoP3
	 nbDljyGTEzaYFgKxp1I1kdclPqCMVpRG7AdtfbufJEUoIBiT93RLO8gheecD41Q3w4
	 G7X3lLRchVTN0Jg0ZsODZZH47Hk9mPrP2x1/MTm2ACUTzUzBei3f7nG5f1AT2vswEP
	 4BgQDg1fEYG1A==
From: Christian Brauner <brauner@kernel.org>
To: djwong@kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	willy@infradead.org,
	xiang@kernel.org,
	hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RESEND] iomap: remove over-strict inline data boundary check
Date: Mon, 11 May 2026 16:57:26 +0200
Message-ID: <20260511-banden-sirenen-86654d8201a6@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511141151.6021-1-linkinjeon@kernel.org>
References: <20260511141151.6021-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476; i=brauner@kernel.org; h=from:subject:message-id; bh=GhDXtWhXv1Pis9PPJuOpUzCtZVaIFCQzs5VQ5Dc8vuo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxvouo2j31wzOR+7ahDebBLeosCxK1ta5e+bure/PsH 5ZnTV9Xd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkeQQjw40pVxdHztuyZqdm NV9BnL0/67293w0esF/58sLi93nXLk1Ghve3CndcaHiyTrWiX+pMX1fVw6Sfb0VfWb7me+YT3/2 hkwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 11 May 2026 23:11:51 +0900, Namjae Jeon wrote:
> The current iomap_inline_data_valid() check ensures that inline data
> does not cross a PAGE_SIZE boundary. However, this is an unnecessarily
> strict constraint. If a filesystem provides a valid iomap::inline_data
> pointer and iomap::length, we should trust that the caller has mapped
> sufficient memory for the range, even if it spans across page boundaries.
> Removing this check allows filesystems to point directly to their
> internal data structures without forced page-alignment or additional
> redundant allocations. This remove iomap_inline_data_valid() and
> its callers in buffered and direct I/O paths.
> 
> [...]

Applied to the vfs-7.2.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.iomap

[1/1] iomap: remove over-strict inline data boundary check
      https://git.kernel.org/vfs/vfs/c/5a78a15537d4
