Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF94B1D03;
	Thu, 17 Sep 2026 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641527; cv=none; b=CCH6WRYf75pxaiIq2Zv5z3G37LPQhYAZKh/ZVDC9X9O4rSMB/IK9CFldJC4dBe610bo1oxQ4I3WBQvKXw4h6CbrAgUazOVPEHv3kPot/98lCxGmtJpnZrqLaWqAei7f8gKVJvSo9lbpDOZMt4CYzFYEAKy8dMlbzOKQ9dFfsXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641527; c=relaxed/simple;
	bh=+e8ivKlnBMQPp/74A265SdtXA1ySKPgZK0U0ocD3K9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmLSl861fI8mc/CBVOg/7XsQjtWj0nmq9yVLYt510XGJ4qbbqRPGDLBBEJ3kFBM2+sQd9QSNOpoxoZ8xpCzdIsq+O54aMNk7JYEyO8ifQ6X3KBmomoynUpqwuMP0Es7jIA2x3wbx09I5GfxhJeaVA9ZzOKVutjXGwRSe8vLJc9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIyzUvYD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIyzUvYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240D01F000FF;
	Thu, 17 Sep 2026 10:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789641520;
	bh=5BdtM5RFjq45N3Wq6rpkk8N4Ygx17v9QoRxQrf6BQWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kIyzUvYDykmTGvB2Q60URskBsFUxQ4nb8cLoP/wkLsveMoYw91RBGkC+si3yWl+AJ
	 YTcbJMItLSsa8StskZl+MAi8Y3ZJC65E2m8KhSNwDKETRGa9UIKiHlmI0fR3vKtGi/
	 Rfm9MLEtLZx4UlRbA6p5aSbRAlEOa9Gr4I8nzj50+f82zFD+XE3sk+O0cfz23A3a4K
	 muuJvtP6lOHCFwM4ofBw11BoP+mVaJqF6wn2OMLfw6cBg7QSGgI70UzUEtP1tWOZY8
	 SajEaJ3ZJ1XL2XgT2UkIYqpg+ijVz4vls8BkzzvnDMx/zAmCXtDoErw/3g179krBfP
	 WbwfbL02sx00g==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 00/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Thu, 17 Sep 2026 12:38:33 +0200
Message-ID: <20260917-feilschen-tauschen-fahnenflucht-7d41b8b49511@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913185016.523376-1-jkoolstra@xs4all.nl>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2639; i=brauner@kernel.org; h=from:subject:message-id; bh=+e8ivKlnBMQPp/74A265SdtXA1ySKPgZK0U0ocD3K9s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStPqx1yO9EvWdO0EvlCxtF1prE9qx7UPV53g/nNN6uj xcfsgct7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI2DpGhgdyN3a0dUQLWtX1 9OTLxPe0PD0bPLf+z93917+vctZp1GVkuFd4RWzJRxe9v7rWH88yN1us5n/M4sv+YN67b2qSa46 w8QMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 20:50:04 +0200, Jori Koolstra wrote:
> Finally got back from holiday. I know Neil is also attempting to make
> changes to the same code paths as the O_CREAT|O_DIRECTORY series touch,
> so I hope, now that I have a bit more time, that I can push this
> forwards before I have to do more rebasing.
> 
> This series implements new semantics for the O_CREAT|O_DIRECTORY flag
> combination for open*(2): perform a mkdir and open the resulting
> directory; return a pinning fd (which mkdir does not).
> 
> [...]

Applied to the vfs-7.4.lookup branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.lookup branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.lookup

[01/12] fs/namei.c: use trailing_slashes()
        https://git.kernel.org/vfs/vfs/c/614d27b66efd
[02/12] vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
        https://git.kernel.org/vfs/vfs/c/2eacbb993f65
[03/12] vfs: lookup_open(): move setting FMODE_CREATED down
        https://git.kernel.org/vfs/vfs/c/db4a1ea6a55e
[04/12] vfs: move ->create check in lookup_open() to before try_break_deleg()
        https://git.kernel.org/vfs/vfs/c/27ab83a2c268
[05/12] vfs: lookup_open(): use vfs_create_no_perm()
        https://git.kernel.org/vfs/vfs/c/900d6abddd54
[06/12] vfs: lookup_open(): lock the parent as I_MUTEX_PARENT
        https://git.kernel.org/vfs/vfs/c/0567a62f5ea1
[07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
        https://git.kernel.org/vfs/vfs/c/596e3a392d61
[08/12] vfs: change ->create/->mkdir operations unavailable errno
        https://git.kernel.org/vfs/vfs/c/dc6315c50724
[09/12] vfs: move O_IS_MKDIR check from lookup_open() into individual filesystems
        https://git.kernel.org/vfs/vfs/c/885bf5afa273
[10/12] vfs: refuse O_CREAT for directories through a dangling symlink
        https://git.kernel.org/vfs/vfs/c/c7a93442a9b2
[11/12] vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
        https://git.kernel.org/vfs/vfs/c/093f13c7a954
[12/12] selftest: add tests for open*(O_CREAT|O_DIRECTORY)
        https://git.kernel.org/vfs/vfs/c/76208ee704c2
