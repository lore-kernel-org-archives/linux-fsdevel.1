Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BE724A047;
	Tue, 17 Mar 2026 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757157; cv=none; b=KxcXb0XaK2CP92QuW4e2khNFe0S+Ikgz9R1G2wA4YPXPXJn9LAImGGQdPdOf6NUJqgywfh9pCtz5ml1JKjy0err2hT5MxHREr1HLiycgbtPvLAlfcwD63+fOlTaaQDhgmZiJUsXO67VeTiV1HDg8Xf/ZiUrFKzho966h2dAnUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757157; c=relaxed/simple;
	bh=MYUe17LKbTgC+9Rp6jZdDGLi7btW1wfi33VR1ZLUelg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUrLUyF4cm5Y/k4aWnvksEF2e7NOOr3stv3gc8BXQS9/pcFme2ghujehvfTv/E7aeQZ6KGgPTCFHdX15qDncYW59Om7fQ7g9kgw/jHk3QSNQD56zauj0kB3je3LdP8cGJeoOFa6bWyU5PdzUyaLJo1Akc/9IH2ZLyYhrz34gzoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djceGrUR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djceGrUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201E5C4CEF7;
	Tue, 17 Mar 2026 14:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773757156;
	bh=MYUe17LKbTgC+9Rp6jZdDGLi7btW1wfi33VR1ZLUelg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=djceGrURTG/3x+nliazgxGG03qkfVKCMFpGaXoSlIcEEfMXkiZXrRSsvaJaOb5ui1
	 lUykStQG/nxCiCgPQSyyY/RuBn6eKFqJjLMFkGTf2p+uLbSGWBI1xQb/Cxsk+Wic4F
	 nSQa6t2XiegLU4YDHfrFxyiUvLTiD3kdGRm9/x3JIXfHtYvMiTzYPoP8xq2b2NbG5c
	 pv99xcfgj+OCCaxe8ZK6fA4zpPqeuUipLHPU2GD26IXJLG2ln5CPM0Jsd5nAQQgdNB
	 DO3a/R/lJtjGAwiRVhhzSa4Is5yNw79Py1QvqoEiTriTXEEWTh2xKbwdHj+WZ//OLF
	 E0hfStG6xwxVg==
From: Christian Brauner <brauner@kernel.org>
To: Kit Dallege <xaum.io@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] writeback: fix kernel-doc function name mismatch for wb_put_many()
Date: Tue, 17 Mar 2026 15:19:06 +0100
Message-ID: <20260317-geleast-schwester-a02b21a00216@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315170931.65852-1-xaum.io@gmail.com>
References: <20260315170931.65852-1-xaum.io@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=brauner@kernel.org; h=from:subject:message-id; bh=MYUe17LKbTgC+9Rp6jZdDGLi7btW1wfi33VR1ZLUelg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTuTLrvefxNy33n00LL1nDGrjuvK6vyUrTh2NGW29+Wy 6gKK7P3d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkS5rhr1RzlOLxso9r8mYH F185mdSpIPeq/mtSl9y581tbdzDZujP8s9gdP+uTZeGvV+dbVVJ1TmyIM4/60r4xfA3HFbbel4F MXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 15 Mar 2026 18:09:31 +0100, Kit Dallege wrote:
> The kernel-doc comment says wb_put but the actual function is
> wb_put_many. Fix the name to match.

Applied to the vfs-7.1.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.misc

[1/1] writeback: fix kernel-doc function name mismatch for wb_put_many()
      https://git.kernel.org/vfs/vfs/c/2727d44f5d5b
