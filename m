Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31553BA222;
	Wed,  1 Jul 2026 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903408; cv=none; b=O4psNadLvRov1nbNa4BNnlkaFu5ehtAgid2wcsoH2YLgnZsvazT4JaQMAgE2/CCq317uzqfTr4kW0Kgs3kad9gVz4NdhAVlLiF9iR/xJU/4N+7xZXnFB7lj+vbrkIGibsOMA4sI5lfh3G7XiEPMfcYrq43SYdqQ5AFxBLCMzlcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903408; c=relaxed/simple;
	bh=6k/C8rIh7OUYOC69oPP4N8nbmW6xvYoEYFJcRzo500k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QxCMRt8nikmZp4KDQ69HLS5iNte7AJMdX3T2G5Ma2aBhOCduj2FqAT7ermpRuLv/gXjps7J5PN0z8gQai6S/WFz+PiLiAEjQDL2f0F6Askz3kQGSfyNDBYliEps25PVsEJIKjTrUz7XKSgT2Dv1pFKwnmIC4dqRJXhATFZWlMaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGWo5WZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGWo5WZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6EE1F00A3A;
	Wed,  1 Jul 2026 10:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782903402;
	bh=wRWB1NsLwMCiIVJnHhDw8m6oPas/5/kIQEKp45hAO4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eGWo5WZDAeMg/TP9UHLk6FHe8JPQ/Z7qV0txfowDj1GPfjSKY4SY2L/Pk9TCLYA/5
	 sb7PlEjYuQ1/k1ISlgXOUYy501OjO35MCLeEzSyLCPeRCnnNFgcHES/o35vQBbjmHh
	 5sQytBnUjwfeMZzzXR9uQ117bJLM1PcMeBakCvnL4MDnYSrI+UPJjrWKWA3gJOwTo5
	 844+1r6dxDmVgUK9noQCDTDCFwcHUDy4Vcg7Gp1UIyOqXbWt3F30Qbp1V8UE7TMFjb
	 tXpEYig9O+hOO5W5/H5FN05XpO2NzA0dw7SYZackaD8p7saJ2C/b2pb6pXIXZ4eE5P
	 JWGujM9IGmlqg==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jori Koolstra <jkoolstra@xs4all.nl>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260630105400.68459-1-jkoolstra@xs4all.nl>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
Subject: Re: [PATCH v2 00/31] vfs: pass S_IFDIR mode to vfs_prepare_mode()
Message-Id: <20260701-vorspannen-zutreffen-unbeeindruckt-29ea949f9d5c@brauner>
Date: Wed, 01 Jul 2026 12:51:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4729; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6k/C8rIh7OUYOC69oPP4N8nbmW6xvYoEYFJcRzo500k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5fMo4wvm64/iXT4xuj/uuzale3C8i5+CUEiCUy1c67
 cNM5tT6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlEn2X4ydhz1m1JlHfCW4OJ
 4o99Jk18VMfOeHrXjtBtezoVZDum5zH8d62cIOjob6gg1c7QdsbkkfLxpxsNRJd6smtFHgxk+6r
 OBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 30 Jun 2026 12:53:29 +0200, Jori Koolstra wrote:
> vfs: pass S_IFDIR mode to vfs_prepare_mode()
> 
> There is a comment in vfs_prepare_mode() that says:
> 
> Note that it's currently valid for @type to be 0 if a directory is
> created. Filesystems raise that flag individually and we need to check
> whether each filesystem can deal with receiving S_IFDIR from the vfs
> before we enforce a non-zero type.
> 
> [...]

People are of course free to annotate their patches with Assisted-by
tags to point out that they are using an LLM. But I'm refusing to do
free in-kernel advertising for specific companies. So I've changed all
tags to read:

Assisted-by: LLM

which is good enough for all purposes. Nobody cares what specific sed or
coccinelle version or whatever else was used.

---

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[01/31] vfs: pass S_IFDIR mode to vfs_prepare_mode()
        https://git.kernel.org/vfs/vfs/c/efdfa808046b
[02/31] 9p: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/cdece9964e85
[03/31] affs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/a8b708c9854f
[04/31] afs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/f5522bef1e46
[05/31] autofs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/31468de07502
[06/31] btrfs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/119ace91c0b6
[07/31] ceph: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/2a3471957fb2
[08/31] ext2: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/59d70c116933
[09/31] ext4: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/583b53b0b470
[10/31] f2fs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/9822629e4207
[11/31] gfs2: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/cda6023f474b
[12/31] hfs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/c9c0d511a820
[13/31] hfsplus: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/698ce0b15c50
[14/31] hpfs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/e3ec849de731
[15/31] hugetlbfs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/d6c1e7d1ddfe
[16/31] jffs2: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/2b8c9ca36328
[17/31] jfs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/f6ad401d7f0c
[18/31] minix: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/3b4857471b66
[19/31] nilfs2: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/2183594ad607
[20/31] ntfs3: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/fc70a07e2702
[21/31] ocfs2: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/b12ec01ea00f
[22/31] ocfs2: dlmfs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/840de92490a2
[23/31] omfs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/2f2983204488
[24/31] orangefs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/7643456f3468
[25/31] ramfs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/86f91a68fb25
[26/31] udf: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/d36d77de05c1
[27/31] ufs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/6449e995b4b2
[28/31] nfs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/0266eafe7e34
[29/31] ubifs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/9fc38090ccbc
[30/31] xfs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/57162848e543
[31/31] ntfs: drop redundant S_IFDIR from mkdir
        https://git.kernel.org/vfs/vfs/c/bec2272283f9

