Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB132B9A9;
	Mon, 18 May 2026 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102581; cv=none; b=PKEtt7fEmMb/oW0sEnCnKzodwGfBGMSHTCTDCLs/nOf6yOrRpN//fr1G0l/08iluGgovllLbNqfXT7GQf24YjMWzsHvFbCVIcPGBQs/HT6pZIH3pSDZCEsg3Kc5/UxZPv3VYArFDd3L/2LeCUVIkifGKKxTLmAOlVLT8NPo5Flc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102581; c=relaxed/simple;
	bh=uvubsGVibINE1QWMyaAnVcOMdb8FbfEzko7MfU1i8fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiegymoQNpJwa3YW96ewbkyv85geSWcr07+TdhfW+Mr4OEiLENcnGUfghkCOlKLaF8CuWG5Pg56ywhZ9yalCKKCWk/4ACWxg2rqBEUhiPf+davAE/CP2IK7LWevFn5ZM/qtpxWfaH9r1kuz1wK9NFhWg2XlMtM7xwibbPkW9QMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNtoyum9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNtoyum9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FD5C2BCB7;
	Mon, 18 May 2026 11:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779102580;
	bh=uvubsGVibINE1QWMyaAnVcOMdb8FbfEzko7MfU1i8fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNtoyum9mRreSg/h3moPE+VtzIrJg5kRK6PTHwbP1BmKyYlDuIyM0RV9uxG9ZX77A
	 2VE2whUceMm4czqNr3gbBhgt2f8zC4kNpVOeqd3AkSQ3LlfYI5zx1JOEFeewakd83X
	 zsKJpewxUr/gaWdLAsd2O2DQaNBXTC+RKMU5+o/F0EdnGDe65H991wKZVQQjE2Zwye
	 3xauKWlbA0TSQDKc8Dz0vb+U/xEJ4p3vqxrAq1r1D6drveKrSPfS2GbezXKDDm6KFb
	 yxT3MCRyMBh/xZqsQsm6+7r1YyJzssCPk9MwdNFh/LfZUURzoroImPXb0+XafcTpgm
	 0O1FmypqmkEfw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [MEH PATCH] fs/pipe: write to ->poll_usage only once
Date: Mon, 18 May 2026 13:09:34 +0200
Message-ID: <20260518-simpel-traufe-38c3fb38ecd3@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516021852.256932-1-mjguzik@gmail.com>
References: <20260516021852.256932-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=brauner@kernel.org; h=from:subject:message-id; bh=uvubsGVibINE1QWMyaAnVcOMdb8FbfEzko7MfU1i8fo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRxfS4oDSy8+/rKQ9m1FWaTD2jKmRzY/C4j5m/mdCEP+ bTb8rOPdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk4QtGhhXVUnlzblQdlz9y fN9nmd18YvO8bHTeS8uf2CDy4umWXGZGhikhtikp5hu+f52oIMZbLhaWLaSq19VzgX/NTMnlf4/ UcwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 04:18:52 +0200, Mateusz Guzik wrote:
> Both GNU and BSD makes share a "token pipe" between their instances, as
> a result a -j $BIGNUM invocation results in multicore perf problems in
> the poll handler.
> 
> Avoiding the store will reduce it a little bit. However, the crux of the
> problem is the locked queuing up in poll_wait().
> 
> [...]

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

[1/1] fs/pipe: write to ->poll_usage only once
      https://git.kernel.org/vfs/vfs/c/e125daf61ff6
