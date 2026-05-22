Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391D25B097;
	Fri, 22 May 2026 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453138; cv=none; b=kntu+tqmTa+0iG1yLEcg59mNwOJbouz4EwGNSN1TiAUrL5MDD4fyCqwO4q2LUtlWDqhE4gWSfTTPpu2vTDXB9XyW0Xdb64DgBCOLshwTmOTtx3VaJdbND/zaGwOm24D1aUuIyFMD30lnPK8nICg3xTbu8zTORlajFUrvtKrfmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453138; c=relaxed/simple;
	bh=Bgs5NCZF2LaVX1o1TR4xkMZMXmk2eUMzPFETrWEm5Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAVYLjIlJPn2PH7xT6XMdv1xQ/Z41+zH6x2gIrVp0TjAurfVduTgGzU7+pnzNd4C9yPsgp+OQ69+MD4jvgbNspAtzamGDtFw+eiy7CAoK9IBCEWVLKhdHdRWZWx8rQZH53rTzX6jN6eKNs7X4IER1cKibZwwkp7wvnC2mIU8nmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhpOuuCs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhpOuuCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4308F1F000E9;
	Fri, 22 May 2026 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779453137;
	bh=nkKU7Veh30e2hLaVfjOpTm4lE716g4y/Nzf3HA2f4Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KhpOuuCs6H58GeBWQuSk0c4EkqeG/EzvUVoTPrXGQaiOrTZ3fVpdKuHMuyWvhEL7h
	 7DA/+VYpxMCz6sCt/6K6pM3ExoOrc1ufG12yjt5DcMovbEdYCBF/e2M6EMmnzHCGPZ
	 ErARyj4jqGn/UkxA6yxvp7VBjgKVAmme6t+f1e7G+3kqABFUsd0+acyCBkliwPUYby
	 Qd45MGgK3aE/YJXhAQ+E2Om6FqFKKaAFZ36l9ssTpZ6Ky3BaC2S0Ny8aQ8cqC1SOFE
	 d9YtJmv3HxQOMaGgBZUOwcIrq8sdyT4FlaAp7YKK0YuJmEOb2mK9GBQabK5Bc6GC5l
	 v/rsBegGHdEYQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] eventpoll: add missing kernel-doc for @ctx function parameters
Date: Fri, 22 May 2026 14:32:11 +0200
Message-ID: <20260522-pfand-enkel-ironie-175e56267273@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519042314.124041-1-rdunlap@infradead.org>
References: <20260519042314.124041-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=brauner@kernel.org; h=from:subject:message-id; bh=Bgs5NCZF2LaVX1o1TR4xkMZMXmk2eUMzPFETrWEm5Ck=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJ+JzJzuaVd3rLvvGENLN+yIRodr/N9r3FvvMKVoj4G yWUVYZ1lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATKRfleGfUvD7w6bxc4UnKjMc t1Rc/D98i5e50vsMwW2TtbX7jr19wshwobpT5ZP7t5mSvFq7uqxcS+cuVun9+so6cofq/PbO0C5 WAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 18 May 2026 21:23:14 -0700, Randy Dunlap wrote:
> Add the missing kernel-doc comments to prevent kernel-doc build
> warnings while building the documentation.
> 
> WARNING: fs/eventpoll.c:1684 function parameter 'ctx' not described in 'reverse_path_check'
> WARNING: fs/eventpoll.c:2349 function parameter 'ctx' not described in 'ep_loop_check_proc'
> 
> 
> [...]

Applied to the vfs-7.2.eventpoll branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.eventpoll branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.eventpoll

[1/1] eventpoll: add missing kernel-doc for @ctx function parameters
      https://git.kernel.org/vfs/vfs/c/70a03a385de2
