Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB8B37107F;
	Thu, 16 Apr 2026 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382752; cv=none; b=lxd41CaMYE+Wt9rKPtpg32vtBD2O6eyLVedTYL0Udm40yZHlIeCz2f6UUr3hzoSXJfFn2FZgtt8zW4HIFYUg9UblcJpobXHL9pQPlp+Alz+jLyO3EeU4N8/O86rDPxCyxLXAz8zFV9p7Hlf+KTfkqWAVLsFNeyDtua2OIPVFamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382752; c=relaxed/simple;
	bh=dbCn0QyadWy8peiSZgFjzIcriOOJw7MvAOVPt9CbP0A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=U1qQrfqi0muEtu7o8wSYCPGPE+xcS5Z6eVRkqPEUDAmSH/A/1hHkW1Te2AqcVGlObgp487uRFAnBju/a6BvYJJPmGiLLEVK4Lhp5CP9EkJYgQ4AoTCe1YlNmO9lHMfgvDGxkqDZS3ZrbLuzVsNjaFis2UJI5SSBYQBWZAK2rs6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BJbSUP/3; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BJbSUP/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776382741; bh=x8lSMyQW0nY+ncxbEC1ARmIkx6jy5hZktRc4r246Vz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BJbSUP/38JDznI+FFF1vk95PxkK4YoCC8DZo7aNRLdIzqAOrpvHVNJmb33sF+wmu9
	 y5FGa2nf2L9iBEov+G053Dcm5yrAJ5tzP/sdyjvrx43lK25pw0M8Cs5PfU2ek0mDai
	 RyhDk/OEC8mx7jWQMMDhcN56BRpW/F4FfQ2s3qWI=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 9B9880F1; Fri, 17 Apr 2026 07:38:57 +0800
X-QQ-mid: xmsmtpt1776382737tw4adn6bu
Message-ID: <tencent_B176296323B84453B767B76D66D513600305@qq.com>
X-QQ-XMAILINFO: OQac6g2KrvnWdXA9+SDiYwrfvrV3s7exNUuD96keW3lTekzR34TLuJicFhQl0n
	 nSfRHOlfu6ptxV99zGzefQ/cFeZ1a5HZiAc0QKZW7nnyK0y2JUn0jC99kWl07FnDcCpVzrNPiWS5
	 SzmM1rih33/5xV8lf2o3SJNX39Of1yxdPWHIriFeEGZSrQUNUS1I1qBrg89WfqjHi1/UWyo9dAOv
	 VE3sBu+/e1TvtGR+J+QOmo4+yjFKde4bbICorVzIrktfcMan2e+eQl/8jI0q7p3iKPdmOKbfHurN
	 mX/5qLkdIZqnJslAsCGZhrTiOhTkbWfvymBhcHPQxeURmwTKQO5zs95bWNWKx0OcJ3hbiaEKvvVM
	 Uo3y6JApL+D8tEvR66ZvidiFzZO1c7gmhjrOWiOtucIAwYUa0myAZ+2qKIzkhQKHyZ5MZwtL4bV8
	 +7cNAn9OH62STbHMOSsQFKKGLOBpkeXxpDyqlgfTQfgybRmfmPzJ/GBkVq1uT6scikA+TQFNateM
	 mFWP5HBxDsI9WJwQGWvqsioNL7XSZjYcF6TzqOpaKD3aE0WX684L1ZVCu32kjDKp2Oosmiu+LasJ
	 ItzmHGQk0fj3Xym+SjmBodIel+8QfgUIRFVmiPwO4uuGmJWiwgnSXMUEDWkkqvPRPlNktjqeZ8QX
	 UcHh7axED9UVFO9hvpJJf7823Ezfy8KS1nBLRbAwOEoVJFdqFsuTsLTXADTNCzb3kiu46Zq17Ezy
	 8VYxkRgQ2uyYu7EG0TgNH2vWCgutdMQqCAiZl6CjfvZ08IqU/gaLlGAHz99kBL6701/imU6ioIkU
	 9x4muAwYtQ+saK1MuHUKbDuYedIDM6T5AXFT041PJnNEVmc4BfBjTd9HLPqlfWrax5GZUkq1rVEF
	 W25vnaqAK2dixUhuHYerTLVGKyhKyYxVc7hmQqP5pl0uaXD+4feTJkmIcMiSHIIv6S82L9nY1PIM
	 wLOTIKkEZGIZfqH5wEhSahSNxsT6DntplIXLthc3Y9Nu6+cE4bvKF7dW6mNVvnMk0TUtOXc977nn
	 ZOqRLRTSWRqv3t3zyvYTUS7OUs/9k=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Edward Adam Davis <eadavis@qq.com>
To: vdubeyko@redhat.com
Cc: eadavis@qq.com,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] hfsplus: Add a sanity check for btree node size
Date: Fri, 17 Apr 2026 07:38:58 +0800
X-OQ-MSGID: <20260416233857.394632-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <691e1d088f6461ac639716951274ede51e6f6520.camel@redhat.com>
References: <691e1d088f6461ac639716951274ede51e6f6520.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 16 Apr 2026 15:16:15 -0700, Viacheslav Dubeyko wrote:
> > Syzbot reported an uninit-value bug in [1] with a corrupted HFS+ image,
> > during the file system mounting process, specifically while loading the
> > catalog, a corrupted node_size value of 1 caused the rec_off argument
> > passed to hfs_bnode_read_u16() (within hfs_bnode_find()) to be excessively
> > large. Consequently, the function failed to return a valid value to
> > initialize the off variable, triggering the bug [1].
> > 
> > Every node starts from BTree node descriptor: struct hfs_bnode_desc.
> > So, the size of node cannot be lesser than that. However, technical
> > specification declares that: "The node size (which is expressed in bytes)
> > must be power of two, from 512 through 32,768, inclusive." Add a check
> > for btree node size base on technical specification.
> > 
> > [1]
> > BUG: KMSAN: uninit-value in hfsplus_bnode_find+0x141c/0x1600 fs/hfsplus/bnode.c:584
> >  hfsplus_bnode_find+0x141c/0x1600 fs/hfsplus/bnode.c:584
> >  hfsplus_btree_open+0x169a/0x1e40 fs/hfsplus/btree.c:382
> >  hfsplus_fill_super+0x111f/0x2770 fs/hfsplus/super.c:553
> >  get_tree_bdev_flags+0x6e6/0x920 fs/super.c:1694
> >  get_tree_bdev+0x38/0x50 fs/super.c:1717
> >  hfsplus_get_tree+0x35/0x40 fs/hfsplus/super.c:709
> >  vfs_get_tree+0xb3/0x5d0 fs/super.c:1754
> >  fc_mount fs/namespace.c:1193 [inline]
> > 
> > Fixes: 8ad2c6a36ac4 ("hfsplus: validate b-tree node 0 bitmap at mount time")
> > Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=217eb327242d08197efb
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> > v1 -> v2: change check base on technical specification
> > 
> >  fs/hfsplus/btree.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> > index 761c74ccd653..857705c3fe0d 100644
> > --- a/fs/hfsplus/btree.c
> > +++ b/fs/hfsplus/btree.c
> > @@ -365,6 +365,8 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
> >  	}
> >  
> >  	size = tree->node_size;
> > +	if (size < sb->s_blocksize || size > HFSPLUS_NODE_MXSZ)
> 
> Technically speaking, you are right that b-tree node size should be aligned on
> logical block size. However, I am not sure that mkfs.hfsplus restricts the
> creation of volume with b-tree's node size smaller than logical block size but
> still in the required range of sizes.
> 
> Maybe, we need to declare the constant of HFSPLUS_NODE_MINSZ (512) and to check
> this constant instead of logical block size. What do you think?
Hmm, that's much safer.

Edward
BR

