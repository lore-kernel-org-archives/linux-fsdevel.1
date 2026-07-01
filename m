Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B03C9881
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904070; cv=none; b=gMg0uVNYlEdAoqSIP9RFndb/OLWvO80/mNcI+Z2XKwa+h+Hjafdi4E5idmigHIASKrPtpIFBArRj3RQJBN45Y5VoJQcI6jaE5zfyLIfzQUtCFSH7Fu9Trv986K4LyjIJ9DajDLZI9FD3HhKU+xiB567HAHLm2hH/Vt9mogSxYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904070; c=relaxed/simple;
	bh=+DpHaNz5MICBLsZHkxrJjp4aP2LwkmKv7jFTR1+/z6Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MQHcoTdYCoC+6oN4tq7uJARyEXjWG94bJ1ekwgwVtvqzytbQ1nZwDt21ny0aLI+9NUG7UnGhz7C+un3bWpbRS2FRH/V1Idb+HXBRr78wM5vZpM17pOguChphrxUYaCldVNygE4aWRNEWXYGBl0Lv5C7rM0jUEmLWNS1klAHgyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ZECzprwn; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ZECzprwn"
X-KPN-MessageId: 137220c4-753d-11f1-a59f-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 137220c4-753d-11f1-a59f-005056994fde;
	Wed, 01 Jul 2026 13:07:40 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 13703cee-753d-11f1-b2fa-0050569977a2;
	Wed, 01 Jul 2026 13:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=TuHGBTAqg9dOHzBouloGe7pKw9k776/EbdZmQhmzgYk=;
	b=ZECzprwndyI5OAzptfiRLfZeJAE+a0mAT7lqTDiY4skgPkYHHwOVCwm8vfCpqEAwA3d0fjD2fe49j
	 Ld2l5+I7Gi7ceZKVCwPBP2nxaaT3vOB9GiMzLTDh4ygPNkcsJL8lw46fnkfiAxTFxR3/rMQeSMZcXs
	 SQvcNuuNjnvDr8LfYkv57/U5A04VhrU+kqOM9ivCF0rYds0/vyRCkfCxsBReRJmITYRDi0WpZyZSNR
	 Jn0+qaRhJZUbL8bU48+kFu8gn2JzhDtwcMTgTqPBfzHbyeUZzdaprfwfJw9YY50mjZTknkLqm3x1K0
	 va2GERgcg9FnLEaIwxKijsOvYyj9smA==
X-KPN-MID: 33|Q1Kb3ouTd0U3IwX7QCZ2qm7LMIWM/KkaVsHJmRozbx2rgxguEHW+knuAeK8SK2R
 1rzn2/wZHPhIc1nsBfbCqpG1s7JZZasFFFn5JvIaq9Oo=
X-CMASSUN: 33|rpQCR7pe5Fnq4DINgN6QKUwx4Q116BfW086JK73Z38m4ByaWe5gl6fGQ5I2VQe6
 A4W3PWY0fcw/hwq5McONFEQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 136500fb-753d-11f1-8edb-00505699eff2;
	Wed, 01 Jul 2026 13:07:40 +0200 (CEST)
Date: Wed, 1 Jul 2026 13:07:40 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1904623668.3623657.1782904060400@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260701-vorspannen-zutreffen-unbeeindruckt-29ea949f9d5c@brauner>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
 <20260701-vorspannen-zutreffen-unbeeindruckt-29ea949f9d5c@brauner>
Subject: Re: [PATCH v2 00/31] vfs: pass S_IFDIR mode to vfs_prepare_mode()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 01-07-2026 12:51 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> On Tue, 30 Jun 2026 12:53:29 +0200, Jori Koolstra wrote:
> > vfs: pass S_IFDIR mode to vfs_prepare_mode()
> > 
> > There is a comment in vfs_prepare_mode() that says:
> > 
> > Note that it's currently valid for @type to be 0 if a directory is
> > created. Filesystems raise that flag individually and we need to check
> > whether each filesystem can deal with receiving S_IFDIR from the vfs
> > before we enforce a non-zero type.
> > 
> > [...]
> 
> People are of course free to annotate their patches with Assisted-by
> tags to point out that they are using an LLM. But I'm refusing to do
> free in-kernel advertising for specific companies. So I've changed all
> tags to read:
> 
> Assisted-by: LLM
> 
> which is good enough for all purposes. Nobody cares what specific sed or
> coccinelle version or whatever else was used.
> 

Oh, I actually much prefer that. Thanks for changing it. I was just following
https://docs.kernel.org/process/coding-assistants.html. Maybe that should be
updated...?

> ---
> 
> Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-7.3.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.3.misc
> 
> [01/31] vfs: pass S_IFDIR mode to vfs_prepare_mode()
>         https://git.kernel.org/vfs/vfs/c/efdfa808046b
> [02/31] 9p: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/cdece9964e85
> [03/31] affs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/a8b708c9854f
> [04/31] afs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/f5522bef1e46
> [05/31] autofs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/31468de07502
> [06/31] btrfs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/119ace91c0b6
> [07/31] ceph: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/2a3471957fb2
> [08/31] ext2: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/59d70c116933
> [09/31] ext4: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/583b53b0b470
> [10/31] f2fs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/9822629e4207
> [11/31] gfs2: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/cda6023f474b
> [12/31] hfs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/c9c0d511a820
> [13/31] hfsplus: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/698ce0b15c50
> [14/31] hpfs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/e3ec849de731
> [15/31] hugetlbfs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/d6c1e7d1ddfe
> [16/31] jffs2: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/2b8c9ca36328
> [17/31] jfs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/f6ad401d7f0c
> [18/31] minix: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/3b4857471b66
> [19/31] nilfs2: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/2183594ad607
> [20/31] ntfs3: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/fc70a07e2702
> [21/31] ocfs2: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/b12ec01ea00f
> [22/31] ocfs2: dlmfs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/840de92490a2
> [23/31] omfs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/2f2983204488
> [24/31] orangefs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/7643456f3468
> [25/31] ramfs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/86f91a68fb25
> [26/31] udf: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/d36d77de05c1
> [27/31] ufs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/6449e995b4b2
> [28/31] nfs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/0266eafe7e34
> [29/31] ubifs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/9fc38090ccbc
> [30/31] xfs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/57162848e543
> [31/31] ntfs: drop redundant S_IFDIR from mkdir
>         https://git.kernel.org/vfs/vfs/c/bec2272283f9
