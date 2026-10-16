Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04D6396B6F;
	Fri, 16 Oct 2026 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142109; cv=none; b=Qf5ZhTyjp8onoUArZaiM96BTBMzhIzek5TZJfEwdUXzdx1VDunKZJU0FC+nYoXpTMHVU33AZzmX/fBNcRl2vceDpFJG5loc4eaWWKaoTbLWpeJEfz1Rh6n0+0xRvWZkk598q+N8qFrxZd7deeFWvoT9F7hgbwHzzFiqz/of+IUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142109; c=relaxed/simple;
	bh=DpwXSNLjOkbhae/t72GTMNnuNQIYt56pnEUi9pGnrmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PdQi6+8hMtXjiQ6j+IgZUKxEhYw0p8r7n6NkxWGJ83wFcwS1K6nIiaBoPgjlCtUqGx4h75EsD6SPqwzPkfoZi1OgsNtjhFAzbqBR/n8FHTdmg4p9Il2BouaNhhEos5hU4PbVYdr42ukOp++UcpTgBGBFPhoY/E94Ed3tVpFjQq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BijNOPlD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BijNOPlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971AF1F000C4;
	Fri, 16 Oct 2026 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142108;
	bh=2duE3Fz7M+hYHfdgfm7ZmSAmSCrlM6S85DYpFCGlJpg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BijNOPlD+/UGHpM4P8LI4C9drx32BboSqs96mmRZh9FW9a0JyUz0CrQWEfl40q4k6
	 DYFCrrYufV4u7SIg3/nNVRNKJXRuu+KWD95YavRumPNKDKEUDoJ3+oZjrg2yNK4LBp
	 KVC2Ywmdviyu+5XbFqQB0TrH4b11qoU+DRfL4ifuEBvuJpvjccZog70/uOCP4S3E1v
	 RPHh84qRQCrrGzIiZRL5TioXXwxDVtZGwhoZ39fFyctuYKdU82HPHqjcelpP0UavLD
	 zVA8IEWcYH6KOa5tAoEA+Yn3up5m+CjdqzobeNB9Bwpm+VIehM7fF1mbvLoMFk/sVI
	 /Cw7xFyUzbo8Q==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 linux-doc@vger.kernel.org
In-Reply-To: <20261001021745.2160005-1-rdunlap@infradead.org>
References: <20261001021745.2160005-1-rdunlap@infradead.org>
Subject: Re: [PATCH v3] VFS: d_duplicate: repair comments to avoid
 kernel-doc warnings
Message-Id: <20261016-fragst-gefolge-bestialisch-6aae32847929@brauner>
Date: Fri, 16 Oct 2026 11:15:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8

On Wed, 30 Sep 2026 19:17:45 -0700, Randy Dunlap wrote:
> Use a typical list style for comments to prevent kernel-doc warnings:
> 
> Documentation/filesystems/api-summary:20: ../fs/dcache.c:2029: ERROR: Unexpected indentation. [docutils]
> Documentation/filesystems/api-summary:20: ../fs/dcache.c:2030: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> 
> Also, modify the spelling of "whiteout" to match all other uses in
> the kernel source tree and to be consistent on the same line.
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

[1/1] VFS: d_duplicate: repair comments to avoid kernel-doc warnings
      https://git.kernel.org/vfs/vfs/c/31fbbc8bb1ca

