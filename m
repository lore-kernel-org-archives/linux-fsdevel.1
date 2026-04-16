Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9252288D5;
	Thu, 16 Apr 2026 04:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776312672; cv=none; b=eGloy3e1gyILqQpG41QpYdjn8TjHDoCgB+hzxsVzGxan/aoBAITZ9uL46QRAt1ov3+UCGuLAbu19fkOKBugXxNjebX2Ntf2Du3ODXIPxxOHNHbL2cJ7BwCdLBzNbsu1D8FaggUkk2hLrHwYQNuc1FOhCU1uQBSiAOAvT+qPJGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776312672; c=relaxed/simple;
	bh=0GJsHIrKZtG3DpUG75PUeii1r0E6AtAFoSrFK0PrmJQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uPyFR+BElSzCKzv2z9kHtwe2I4tcMkWwEZVeal4Uj5qRVR1okwFxEQHeVm+F8t2ZEXOofM21yXKJk6vZSaTflFJd8/9GJmjgkG1VIwGkABGQCwzLsFzovrqxxjnQwN757JD8d/QcKJDDo0uUSPiCyHDG+7T0jixA+325t8epPO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LEMD7gYo; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LEMD7gYo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776312661; bh=nspGxetRB3zCpjzioWQZy4eR1aq8PwBNzWzXPEplagI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LEMD7gYoZ0PCVTclSgXjt4kIM3DRrWzHbXQZ++Pg9aewjNAbwXAjjuvVO4IBA4cWl
	 yDXZDU0Hqf5uh8cLrVX2gyhLQ5MU3pnKPsELbG3dgClDKxn7WVeCEuvUgp1M14Nqvx
	 UJkHbCckGXKrosObJBIz2WrZN+5A0/FVpi2V+56k=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 2709EA4A; Thu, 16 Apr 2026 12:09:48 +0800
X-QQ-mid: xmsmtpt1776312588tegqyuwmr
Message-ID: <tencent_8ECE3364C36FE975C3A64444176177734605@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLftmDZm3FaHY93dWics0oECS4+6WUqQXln5nLuB5lorOH6wEhj0
	 sRoUD1FskGTvOvYXYvrum+Akmvri3UKiUrS+B5UVju2Z8sB/rOAfhOOFu6ExYVHB4U2PYxiKMH2r
	 TCmHWa5AVTL0HVp3APO4EHEj8gML/215IH9jVNJtsFV4++ItGgz4So8MOcVsMsDSfw5WljOJZLky
	 qXnZTk5C5o0b6DPxxdn2lm+cHZeIT1pOm9bq1YsUDzHXdcpAOkBz2JENP2+zNCScrZWeDo9uEdYP
	 faLyGWaeJlBYl2sXKqri4tl/PP0mJ4SOLEyZ2M/5BjvP9tcDl4nK9DJBDwmzeSXUF9/sa3K7mJMA
	 hhOgAsN5NdqjeHGpKM0sduOm1vEvFdQq5xX7IfObWQpQLubmJidHDilpubamMlbGm3UEntxRmKNL
	 h8wN8X7LIhN9m4QHTvy997CT/03dIEtaeXZs4bx3ONY4CWmX+twKJepoeFeSf96l4FoDoc6Qtxmb
	 jolWkYBRzIeYnYGLT6L10BR6ASX9tas15VlJv3YKqvhmxmUmovLnxxo2QRNYeVDGjxgPpbcXsXOa
	 KvOed5jr9kPDiZ2nQuuZxSBrZK6QHGkiGcmDP2GEoV3Qs4QMoIiOkUSwT62I1uMCnr1rFTjl4wWq
	 WwGqPaUEVCuOQkqHGUtb47zkOE7xxR9z6X1esYmO5pwttiQvdNZE69hU1HMAK42HZvofgteOvxFW
	 y1hKzEuDn29oOwQE26X/qYU6ZRS3z6dSL0TwiOUph+8PrCFzkne4PpGv3Ai28njxWy0zurjCRJKJ
	 liLs37TgaQJAvp/P8boGUQOkBuW6ew2xzT6af1Vrigf5nL/rxC5Gw5F2xY7UMRCMcYsxHp28ZBKb
	 AYwnfSMEfe6cFTBktbOE4JE4v4BpG63zVWEcT3SNVdKHHXLVV9YuHdEvoRxPKWDYsAlarIZE5p2r
	 K3kkyBgAtYGncAIgoTUSE5abpbz+LPN0Wdcbukq4yQyV6ky7+fXJJ00y3G4hLS8jIhKdkw1jNZU3
	 8DxT5kLmiYphw0sOSxeTgE1Alu0jLvqmROOeFXJA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
Subject: Re: [PATCH] hfsplus: Add a sanity check for catalog btree node size
Date: Thu, 16 Apr 2026 12:09:49 +0800
X-OQ-MSGID: <20260416040948.363967-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <646f4e41c5b0ae14fa755f75fbe83837308ee35f.camel@redhat.com>
References: <646f4e41c5b0ae14fa755f75fbe83837308ee35f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Apr 2026 15:32:59 -0700, Viacheslav Dubeyko wrote:
> > Syzbot reported a uninit-value bug in [1], during the file system mounting
> > process, specifically while loading the catalog, a corrupted node_size
> > value of 1 caused the rec_off argument passed to hfs_bnode_read_u16()
> > (within hfs_bnode_find()) to be excessively large. Consequently, the
> > function failed to return a valid value to initialize the off variable,
> > triggering the bug [1].
> >
> > To prevent similar issues, a check for the catalog btree node size has
> > been added within the hfsplus_btree_open() function.
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
> >  fs/hfsplus/btree.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> > index 761c74ccd653..61050ffe425e 100644
> > --- a/fs/hfsplus/btree.c
> > +++ b/fs/hfsplus/btree.c
> > @@ -337,6 +337,11 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
> >  			pr_err("invalid catalog btree flag\n");
> >  			goto fail_page;
> >  		}
> > +		if (tree->node_size < 2) {
> 
> Every node starts from BTree node descriptor: struct hfs_bnode_desc. So, the
> size of node cannot be lesser than that. However, technical specification
> declares that: "The node size (which is expressed in bytes) must be power of
> two, from 512 through 32,768, inclusive.". So, we can add more smart check here.
Perhaps it could be adjusted as follows:
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 61050ffe425e..287cef5b5c56 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -370,6 +370,8 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
        }
 
        size = tree->node_size;
+       if (size < sb->s_blocksize || size > HFSPLUS_NODE_MXSZ)
+               goto fail_page;
        if (!is_power_of_2(size))
                goto fail_page;
        if (!tree->node_count)

> 
> And, maybe, it makes sense to check the node size value at the places of using
> it. What do you think?
> 
> But we have this check of node_size in hfs_btree_open() [1]:
> 
> 	size = tree->node_size;
> 	if (!is_power_of_2(size))
> 		goto fail_page;
> 
> If node size is 1, for example, then this check should fail to execute the
> hfs_btree_open(). How, finally, do we have node_size == 1 during the
> hfs_bnode_find()? I don't quite follow.
You overlooked that 2 to the power of 0 is 1.

Edward
BR

