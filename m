Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A13A4F5E
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553990; cv=none; b=iDgBVO/3dlc77GO/F2zxoBEjoG3elgOl79gCLYviqU76LNh/b0jCONKS9E4LNeQ6sdu/2g7T2XzfAlgOaDdcoV0o0MF2LMj6T2qXPWFxDoVMcc9++8Mp1CmAajs/hXO+qYhq9ITjJcott0iaesASKBMN9Y3RVSCUdKIeHcnfm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553990; c=relaxed/simple;
	bh=TT4CR1lBNS4wuT31VFi9aReszKrm9P8YTp5u/1jWX74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0DVteJP8q4rfWzhqWMh7fAQgAaUUZy9d/IJ+FzttSK0E2kj+5G5AglB8g2QDiUQH1qWUXwVjGkxG4JNsBlrP3pwDibiyyGnTJ0/3ssg1frDwOtZ7O3vCAXaDT/naLMs2duT5IXlD+sY01YPp8kjSV6cHwoXy0nw73fXZfnBXVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLgvSB2+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLgvSB2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0942C2BCB0;
	Tue,  7 Apr 2026 09:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775553990;
	bh=TT4CR1lBNS4wuT31VFi9aReszKrm9P8YTp5u/1jWX74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLgvSB2+BWRNyn150mjJ2qQjfFS6mnfuufhmwpuHbIDDqket0lU1WnMLitiuH2SdI
	 lp+9SBaMtPFQXkXWXH9JyT7cbmQB6NqZbgRbrEB/DdLkb4nGoYRbSeqIl5C+nQVnxd
	 1Gim6anxhwPRYczl/k52B2iN8Hzr556XKIQQGsdXWrVrHo9rgs3juGQygTb8+2FNIz
	 vjwRmW3vx9u3MDpTUXCqUDYdY6884+6W7AEPPGxBXDeFt1LbJxxS0PViQ7HgXi6OMq
	 2CT7LNi42Z5AnYjvx0xip6I3C57Bs6gPmPq8gXfkXK7EPhKBlzQBBdIB7yrZihRo7X
	 gjfQrf/rAcYNQ==
From: Christian Brauner <brauner@kernel.org>
To: jack@suse.cz,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: attr: fix comment formatting and spelling issues
Date: Tue,  7 Apr 2026 11:26:24 +0200
Message-ID: <20260407-stock-leiharbeit-c3c82d2dd793@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403092709.83458-1-chelsyratnawat2001@gmail.com>
References: <20260403092709.83458-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=brauner@kernel.org; h=from:subject:message-id; bh=TT4CR1lBNS4wuT31VFi9aReszKrm9P8YTp5u/1jWX74=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWReOXvw/rQr7/+mPNd98+Nti0qKXGrFIqbK1w9TZr+p3 rVvctv24I5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJnJvO8L+qv0p0o/fRXGnm SyuF+iV+fEza7ro+rLXiR3UOb2TUzTOMDE/MJ57PfpH2/lTi+TccjxvqmZ+4RuSqW+7cveMRX9C az8wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 03 Apr 2026 02:27:09 -0700, Chelsy Ratnawat wrote:
> Fix minor comment issues in fs/attr.c reported by checkpatch:
> - Wrap long comment lines to comply with the 75-character limit
> - Correct spelling of “overriden” to “overridden”
> 
> No functional changes.
> 
> 
> [...]

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

[1/1] fs: attr: fix comment formatting and spelling issues
      https://git.kernel.org/vfs/vfs/c/4639f1cfba03
