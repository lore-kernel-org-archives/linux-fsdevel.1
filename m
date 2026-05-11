Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860D93BED7A;
	Mon, 11 May 2026 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495361; cv=none; b=OggUOdFjKM6WMEYWPtMIfsSsPfdn4NZXCqWA9uw19XKUhToC0KdXIP9QeUXKPAxne5yR/+iR96M9b+td+jI5if5qnc8XftzqQmFxMdZgN9NcBs6qrsIJ8y8sgj/gDyf5X5Ad2pyWWoxvCm3U72rra2rpk1kYsBYiTrXkCjUBQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495361; c=relaxed/simple;
	bh=VotNyhm1MwvMauxDPSaV9We3YLaI0ZFdHQoR1EvgPMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4Z1xi5Q3+6XKWclE10/uqwXQdNvuBfLzEV/JNXKO1xx12eKVSqgpfjVL2S1rjypTt0F+o2VOAsFtizEqgdhGxQLczQVwRyUM1XxmgH/DXeZMH/hshzZDFYwbnk1ff7xpYfh0XRbCMxNJRNgqxX0BjUkGpae1cNX+2zXbDU5/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=up4NdK+I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="up4NdK+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0F3C2BCB0;
	Mon, 11 May 2026 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778495361;
	bh=VotNyhm1MwvMauxDPSaV9We3YLaI0ZFdHQoR1EvgPMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=up4NdK+IuaaLElmNw7bstzQbJouLS/r5gp+wz+j2miCI6OVt4rZo9+eiL2vQtTWZ4
	 Bij8Qd33AYqZ4QC+fkjk3bS2GcpEmly4e0BmcZsjI3P1f9mNqk6w+5qeXUJSxnhTtm
	 1Z+9fynEJ5ZAnyqjJIwZOmAJx5dRp/meA6TPz8TpkRvyiuxO0o9VQx4NEDM68U+9Bs
	 LaixPyzDLMCz+yc/vV8RWYoORz1rKtXauDgTWiUuGVch3ooYTLVDI0ek4FfuX0bpA3
	 Ch/9MkbCVJRlyct9kU5Niep8iN80r2EwjbYdhvr2tF2x2J9Wk1oc9+B9n9AeYIP0zV
	 yeIwPwyTOVbxA==
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] vfs: add O_EMPTYPATH to openat(2)/openat2(2)
Date: Mon, 11 May 2026 12:29:13 +0200
Message-ID: <20260511-kiefer-kaminholz-6b622863e644@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260424114611.1678641-1-jkoolstra@xs4all.nl>
References: <20260424114611.1678641-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=brauner@kernel.org; h=from:subject:message-id; bh=VotNyhm1MwvMauxDPSaV9We3YLaI0ZFdHQoR1EvgPMM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxrq/e/d2xOVjNPaMqbPUfoT1Fj1y+K7VcvqWxZLb92 /TLzMsaO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyyZ7hn25SdIZp1ZqnF754 /ipyTOTcU/loo5ReWcZk7dmFXIH5bxn+qZ1SeGv0kr+eK9vnaklF9PHrr1Y+OKbjGsBXdc9Q7zQ jGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 24 Apr 2026 13:46:01 +0200, Jori Koolstra wrote:
> I've rebased this on vfs-7.2.misc as Aleksa suggested. Also moved the
> O_EMPTYPATH bit to 1<<26 to avoid conflict with non asm-generic O_*
> flags.

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

[1/2] vfs: add O_EMPTYPATH to openat(2)/openat2(2)
      https://git.kernel.org/vfs/vfs/c/6703991ad3a3
[2/2] selftest: add tests for O_EMPTYPATH
      https://git.kernel.org/vfs/vfs/c/00f84ea205cd
