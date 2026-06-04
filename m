Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9E235C19F;
	Thu,  4 Jun 2026 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572927; cv=none; b=SjKYp0myULDdvj1yC5N9DnGO1K79uOIaGpSmmPZ61zfMzkI7jmNsFOS7YNcJZ8MwbDLwcFWqdbapv/fy1wGNlj+pOY7le59Ph11FBNEA69VnEay2nBKsyabPhfUzoaaILAoPBZUlKs7UuFAM98LrQ81/aDQttMC5QHk/Df4roSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572927; c=relaxed/simple;
	bh=uB2vWZz9gzpoTg/cjj1qT5IYL1IPVQ8q/l1u3tofe+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSRr3Ja8iBS1Pb7ZVXVM9U2o5ZF0kJW/xeQoiQf2DgwoMgGNliSrBpnWvmE8fw0UCYM92SS/c2U/scQMaN7fWmiLaOqIUJIyuiaoRss+hwkMH/pgWTHz/QvpTylZOXziJim8DBcp4+GOP5JMSmKZ07Vs+rGVzj7Jt0PtrhTsx/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMPlBz5c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMPlBz5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E391F00893;
	Thu,  4 Jun 2026 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780572926;
	bh=qRQBH4fIU+SoPHwieWglOZiXS4hW7GTte7+2P6QruYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LMPlBz5cYygxvAEwjMHMHYgZwKe2MVY5esStoJdl9FAJwvp2XEX5gtWGpVhHjidRh
	 IyFZKJjjjq5JVJehnt/mQRsYSjk4gYFENUxrUUsZPrdlTaK6tUNwGqid23MKGIVksO
	 L4twPQbohQ5hH5Sx7rG2zkQ0Yml6ZcSw1JtvYxQ73J7NpnAw4JaJVjpCkXfo5iLqrJ
	 Goxn9unseI8BoDbA3J+XM3ki7Ef3WWscAX7fmHqeeMdU2ImHKY8hzjoiyGxWffnTjA
	 YaI07kzY/X8qdHzJFyGwpwHTGuxn4ynDNTglAc9pOF94DQQgKYytVW5v73J1KtBN1O
	 4IRlyziNo+ngg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 1/1] fs/read_write: Do not export __kernel_write() to the entire world
Date: Thu,  4 Jun 2026 13:35:18 +0200
Message-ID: <20260604-wachen-laienhaft-kochkunst-874e2440768f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604095233.284067-1-andriy.shevchenko@linux.intel.com>
References: <20260604095233.284067-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1031; i=brauner@kernel.org; h=from:subject:message-id; bh=uB2vWZz9gzpoTg/cjj1qT5IYL1IPVQ8q/l1u3tofe+o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQpJv0KSVrU61LjGayotMGatSzDs/HszTPCr2pmnvEMr ZO9GPm0o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL2TxkZ5vlfyrnP+8V+dbJO /5aqO9ODmtZf0TCTlOHc1DrljoylIiPDJJv3xvdVvXQuX8006Zbc5bOjdf1tTvvnTkmvT37b7Rb DAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 04 Jun 2026 11:52:02 +0200, Andy Shevchenko wrote:
> Since we have EXPORT_SYMBOL_FOR_MODULES(), we may narrow
> the __kernel_write() export to the only which really needs it.
> With that being done, update the respective comment.

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

[1/1] fs/read_write: Do not export __kernel_write() to the entire world
      https://git.kernel.org/vfs/vfs/c/438f0c1fad74
