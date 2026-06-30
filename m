Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C97277C96;
	Tue, 30 Jun 2026 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859034; cv=none; b=UGn1jz2X0KKN3Pe6jwzxj2j6M+UAkNucRDZHRBONaGPFO9lq31b1dVkZpJwg3ztVUTCJyZ2CWZOLmDKHql7I/OqS0aWHTxAyK7eOnphuIZI/C3tnqO+hY0pTF3OYMzsCZKq1Hz/GYSdyYsVMBmvFZ3dxKlICJo/4fpXtC/yJYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859034; c=relaxed/simple;
	bh=fWniH1QOQ/DveSc6o3Tr/RL20umC964UaKjzWl6Nf7U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=fziKIkB5/sTTvsIo0vcV5uX5QyPSgKLj1usdK2Il3WBoekz97KCElHYD0hxWJ/RBfrdCfnbEywnfRbna0LwPXMJkQLIcTlXec8c8iXGa1+VgV3mST70kt1NXgGjEaNJufbOLpE3oDRwfTcmizB5eGF3udJBsJnUTlx9ugvUd1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gS3HLxCV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FCvEeFM1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="gS3HLxCV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FCvEeFM1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 847E57A0150;
	Tue, 30 Jun 2026 18:37:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 30 Jun 2026 18:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782859031; x=1782945431; bh=WFJUju+3U9YYQkCdorbclOXan3wNXM5yWhX
	ihjT4uhE=; b=gS3HLxCVfud0JpRbbIc5qZhYI7nrMJSYGYtR1rxqQ0l0CU6FqL8
	ppc/CvqkQBQlQEi6r4dJzSXQzZIMsSilqVlYKQ6Gfdd8rUojedtk9+wIMIMRgCTl
	036wtCismlw0HZeuP7cTVyXuasEg9591ZmWJ5C4IZVsrL7QeVMZfctj/b9LkBMCp
	OD0AH4w4WLv3zgnM9qRPnM23ON+vrdMF/6AEXkdwpBh2rmpubNAsfEX8DYn+LLbQ
	Xn9mi+Pba1c/9nFPsUGuIz9FPknuJfAxhptyop5+QHlNpSXYAInoAncZzEOscPGR
	SQsGvchJqI/+VLsp4mi3TTsjXSHoK0EOsQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782859031; x=
	1782945431; bh=WFJUju+3U9YYQkCdorbclOXan3wNXM5yWhXihjT4uhE=; b=F
	CvEeFM1tEZmw8yEflmIiTXGIpIVrTaja7uqlzQ/1bScLpgSi04kKylOheHBR2rUb
	dWOfXiEMp2fUWj1GdlKlPhdD9FgG9Lf2zEPNUu+S48Et3GS7kPt474V00OK8aqEg
	GqXa8SQLMGgIQY+4VanCZj+5mMit7AkPMc8NkOIUJ9RMhCbrzhBeAT9Zmh0pT8V6
	d1FIcQm2zfURcJ6sFLn7cI61FdN4WrbQGbUbR8Ma7MR8UJVn8M5nih9uz5ZxJmtO
	Bj6jYe4y5OovCP7xowq4NrDam8XhZQvHyhJjYZGgLCDgtgIhV+G/rjiaVkQNy9Bx
	qDikHq+tXA50kmXDxRLUQ==
X-ME-Sender: <xms:FkVEas4VxPYhO6ekB930fVWauuhEFZ8-c_2evspuyzrLS1U3HU6LrQ>
    <xme:FkVEagJhyvlAOjYvtHpaG-rLihXy5DN2OTQXj5eSOV1xM4i4BZUU5T2DNQvkH2-aK
    r632tohQsfLBaq88HsL_RY17wwAWBrr_oSsiMoUCGITKVZD>
X-ME-Received: <xmr:FkVEatv1bkOMrJsbG9Bk0_ofndFXOeRsAbhd2xKQHzeG4j7mM2f5CGGOwvz-0vMHf4nKlKAPZus3u0h2JrrFTj5-daRRaxs>
X-ME-Proxy-Cause: dmFkZTFVnTpHejSBQPZiX5iQvce4x6lZss3jVXMsGrGfQuBJVHvstV4zBvNHlstVmPuinD
    AZDb8PBbZWNmqC46CCCj9r91V8V7cUTeEDZUbRUIxfqwm1W5qz4BsqniSMQn12WtheY9I6
    TM3z30jJXqmq+zYQweOBjZt3lpDrTWlM3MdWBG6rDHj2jzdEgx0DT/5HT559t/kOQJMiYQ
    WYDe/aA2LMmgR9GjmLU2jgGJ/NQGTCT38q1mvUbkrkCR4szJMkWsqT4DfHhEgrXclucAwn
    7cXKjNNhAfqLa/4Pj8KTb+AujXPb8WWIXvJe0csC3fKykinay4u5mLju5r9c3S8Vym7nU6
    pTmXUZctQzhnxfrV7MNmR8MarKo2+2wsgqNlOfUlKbj5WtpTL1j202RGzuwc0EpFiwBET2
    PRSKcamDMyxV8tS0M5aeqDr5vjF/s4wVqngEJC18Ip2TsF5rOoXImj3+48UUbTNEqXZ1Gs
    Qf4eqgAh/mQEH1isRVxhsv0csiK5tE8ZRAPixIRKR0QgeTiXrMGmG2CY5n6vihEaZbcLce
    H8cTCZXRQVKyGnYt1bMkJ7P3bKnDcLWigKJ4gvFg3qjUAA0furNii0Kk4LWij2qcK8DjX7
    2e2n7pMlu9NHTELgz1rIje4fUSiJ0XaXjsGykWmGHAIPX/z+FYgYPSXlyNoA
X-ME-Proxy: <xmx:FkVEanLetIWs2XOrgbd7izn-jDGTysG2p0Tt7xfQCxv_HnbUh9SbNg>
    <xmx:FkVEau_2qaLe4Uc7fIaYoZxKk0FJh955e1nCoekoMbFi7pVUbz_Eyg>
    <xmx:FkVEaow92i6ecC-hDu-zHDMY1wegtFbUp-nM_OmGuDHAG5Nk3QH3iQ>
    <xmx:FkVEaj5YIp9DM1njf9h_wZbeZ8OxoPwlGhFau2gdjXgoZZgXeusofg>
    <xmx:F0VEathukEw16wHxAVucdRFB5tWlHrzWW9jh2yJT4aEXIHis25Xj4dEC>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 18:37:08 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jori Koolstra" <jkoolstra@xs4all.nl>
Subject: Re: [PATCH v2 00/31] vfs: pass S_IFDIR mode to vfs_prepare_mode()
In-reply-to: <20260630105400.68459-1-jkoolstra@xs4all.nl>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
Date: Wed, 01 Jul 2026 08:37:03 +1000
Message-id: <178285902311.27465.11536482082229795452@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 30 Jun 2026, Jori Koolstra wrote:
> There is a comment in vfs_prepare_mode() that says:
> 
> Note that it's currently valid for @type to be 0 if a directory is
> created. Filesystems raise that flag individually and we need to check
> whether each filesystem can deal with receiving S_IFDIR from the vfs
> before we enforce a non-zero type.
> 
> It is useful to do this clean-up ahead of O_CREAT|O_DIRECTORY.
> Specifically, in lookup_open() we need to replace the vfs_prepare_mode()
> with something that also handles dirs. I don't really want to push the
> odd
> 
>     mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
> 
> further into that code, and neither do I want this to be different from
> the regular vfs_mkdir() path. We can then also match on S_IFMT in
> may_o_create(), instead of passing a bool to signal whether we are
> creating a dir (and assuming 0 means a dir is really ugly).
> 
> It is a bit challenging to verify that passing S_IFDIR is safe, as there
> are many filesystems. Claude Opus 4.8 was used to generate the context
> for each mkdir implementation from which it can be judged whether
> passing S_IFDIR is OK. The result was then verified by hand by looking
> at how the mode argument is used in each case. To check whether all
> mkdir implementations are covered, 'rg "\.mkdir" ' was used and checked
> against the list of uses Claude found.
> 
> It is safe to do this clean-up except that three filesystems (fuse,
> cifs, and coda) forward the mkdir @mode unchanged to something outside
> the kernel. Mask S_IFDIR back out in coda_mkdir(), fuse_mkdir() and
> cifs_mkdir() so that what is sent outside the kernel is unchanged.
> Their maintainers can drop the mask once they have confirmed it is safe.
> For the other filesystems redundant S_IFDIR OR'ing is dropped.

This all looks good to me - thanks.
Reviewed-by: NeilBrown <neil@brown.name>

NeilBrown


> 
> Jori Koolstra (31):
>   vfs: pass S_IFDIR mode to vfs_prepare_mode()
>   9p: drop redundant S_IFDIR from mkdir
>   affs: drop redundant S_IFDIR from mkdir
>   afs: drop redundant S_IFDIR from mkdir
>   autofs: drop redundant S_IFDIR from mkdir
>   btrfs: drop redundant S_IFDIR from mkdir
>   ceph: drop redundant S_IFDIR from mkdir
>   ext2: drop redundant S_IFDIR from mkdir
>   ext4: drop redundant S_IFDIR from mkdir
>   f2fs: drop redundant S_IFDIR from mkdir
>   gfs2: drop redundant S_IFDIR from mkdir
>   hfs: drop redundant S_IFDIR from mkdir
>   hfsplus: drop redundant S_IFDIR from mkdir
>   hpfs: drop redundant S_IFDIR from mkdir
>   hugetlbfs: drop redundant S_IFDIR from mkdir
>   jffs2: drop redundant S_IFDIR from mkdir
>   jfs: drop redundant S_IFDIR from mkdir
>   minix: drop redundant S_IFDIR from mkdir
>   nilfs2: drop redundant S_IFDIR from mkdir
>   ntfs3: drop redundant S_IFDIR from mkdir
>   ocfs2: drop redundant S_IFDIR from mkdir
>   ocfs2: dlmfs: drop redundant S_IFDIR from mkdir
>   omfs: drop redundant S_IFDIR from mkdir
>   orangefs: drop redundant S_IFDIR from mkdir
>   ramfs: drop redundant S_IFDIR from mkdir
>   udf: drop redundant S_IFDIR from mkdir
>   ufs: drop redundant S_IFDIR from mkdir
>   nfs: drop redundant S_IFDIR from mkdir
>   ubifs: drop redundant S_IFDIR from mkdir
>   xfs: drop redundant S_IFDIR from mkdir
>   ntfs: drop redundant S_IFDIR from mkdir
> 
>  fs/9p/vfs_inode.c      | 2 +-
>  fs/9p/vfs_inode_dotl.c | 1 -
>  fs/affs/namei.c        | 2 +-
>  fs/afs/dir.c           | 2 +-
>  fs/autofs/root.c       | 2 +-
>  fs/btrfs/inode.c       | 2 +-
>  fs/ceph/dir.c          | 1 -
>  fs/coda/dir.c          | 7 ++++++-
>  fs/ext2/namei.c        | 2 +-
>  fs/ext4/namei.c        | 2 +-
>  fs/f2fs/namei.c        | 2 +-
>  fs/fuse/dir.c          | 8 ++++++++
>  fs/gfs2/inode.c        | 2 +-
>  fs/hfs/dir.c           | 2 +-
>  fs/hfsplus/dir.c       | 2 +-
>  fs/hpfs/namei.c        | 4 ++--
>  fs/hugetlbfs/inode.c   | 2 +-
>  fs/jffs2/dir.c         | 2 --
>  fs/jfs/namei.c         | 2 +-
>  fs/minix/namei.c       | 2 +-
>  fs/namei.c             | 7 +------
>  fs/nfs/dir.c           | 2 +-
>  fs/nilfs2/namei.c      | 2 +-
>  fs/ntfs/namei.c        | 2 +-
>  fs/ntfs3/namei.c       | 2 +-
>  fs/ocfs2/dlmfs/dlmfs.c | 2 +-
>  fs/ocfs2/namei.c       | 2 +-
>  fs/omfs/dir.c          | 2 +-
>  fs/orangefs/namei.c    | 2 +-
>  fs/ramfs/inode.c       | 2 +-
>  fs/smb/client/inode.c  | 7 +++++++
>  fs/ubifs/dir.c         | 2 +-
>  fs/udf/namei.c         | 2 +-
>  fs/ufs/namei.c         | 2 +-
>  fs/xfs/xfs_iops.c      | 2 +-
>  35 files changed, 51 insertions(+), 40 deletions(-)
> 
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> -- 
> 2.54.0
> 
> 

