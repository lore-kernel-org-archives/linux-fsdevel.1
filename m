Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CAE3C7E1B;
	Wed, 22 Apr 2026 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862939; cv=none; b=Wlk8IkfAesQpnBOwo1y/b3wFfLwEPAb0OyXaQBtVTtAmw3GbmUH/QvfLdZrM4p5/BcYwdfdbvgpwJfmOWmKXc9zp4b7PNgmHhtZQi1N++hLvVpUSknqGQhUJW4cILMRW4SwuVxn+kR6GGghitomXPDXjsKgu3vjtao90Uil7t6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862939; c=relaxed/simple;
	bh=MsEjAtnnDDmGtudE/ryFeuzCV2RF1wmJ05Mm12jQZl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lze+U3uTxS980yriuCqjkwxd4fF9vOQGct4P9HuqZ2GwKxPg3juff0PKk+qU0rfZIpziNvIRRkoLVTwdN9O9YaOIIsL+ZUJg8ZQK5/u+hs4ij2X3yOA//YiHW2yUAc8mdT+frDiEmraOGXpbgcO7Jk6onI8uV9PCcd+kjOPu1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7BCMAYi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7BCMAYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FA1C2BCB4;
	Wed, 22 Apr 2026 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776862939;
	bh=MsEjAtnnDDmGtudE/ryFeuzCV2RF1wmJ05Mm12jQZl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7BCMAYig3dsw/2rXTAxDerMGXDd8EVst/uZTOCHGXDsw9pRoLVfvV4XKnyGeSoUa
	 22tZaUiUdcDAgDKJNJlrqlLsLIw/B/jV9WlEuctagGZ3Ect3n+CYOrB9Z7DNH52dkg
	 4BpIPKjcsbc8VmhhhzcIzKrJ7I5oluqqiDE+KOByERLeX4kl5kXxUzdPeQ6Bmu01eX
	 0omv7QdpYtxLyHHRwRYevpnbu1foYcBIoDiDG1AuwTvijqkgoJeje7g6pjvrySbIeo
	 pEFufK9BobAvjC/i0jhIyOUQI1kz8HAlGWje7G2MiOaEt5n4rfMQvVfZI0aE27rN4a
	 Ti3uZ7M4aaHKQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] assorted ->i_count changes + extension of lockless handling
Date: Wed, 22 Apr 2026 15:02:00 +0200
Message-ID: <20260422-wortgefecht-tummeln-e95204f0437e@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421182538.1215894-1-mjguzik@gmail.com>
References: <20260421182538.1215894-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=brauner@kernel.org; h=from:subject:message-id; bh=MsEjAtnnDDmGtudE/ryFeuzCV2RF1wmJ05Mm12jQZl8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+OHYtRuinf8iUjmwn15B5H6bNuxa0x3DP95+31/SfL FFuvh8p3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARK3mG/54fTTem7RL/bKRQ kuDoeGbl84sVa62vB+o17IppLC++9p7hf4r/9CsnUt9FFD84ly3nfNLYMfacoCZTemXquowV9UF NjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 21 Apr 2026 20:25:35 +0200, Mateusz Guzik wrote:
> The stock kernel support partial lockless in handling in that iput() can
> decrement any value > 1. Any ref acquire however requires the spinlock.
> 
> With this patchset ref acquires when the value was already at least 1
> also become lockless. That is, only transitions 0->1 and 1->0 take the
> lock.
> 
> [...]

Applied to the vfs-7.2.inode branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.inode branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: master

[1/3] fs: add icount_read_once() and stop open-coding ->i_count loads
      https://git.kernel.org/vfs/vfs/c/11abd8ebfe89
[2/3] fs: relocate and tidy up ihold()
      https://git.kernel.org/vfs/vfs/c/f16fbfa2a006
[3/3] fs: allow lockless ->i_count bumps as long as it does not transition 0->1
      https://git.kernel.org/vfs/vfs/c/e22934526e6d
