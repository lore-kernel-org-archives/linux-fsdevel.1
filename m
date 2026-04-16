Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14F2283C82;
	Thu, 16 Apr 2026 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776310224; cv=none; b=Xa0LmNTr2ZXb9L88jzCOrPDZxy8DuDB26vf4fJSZKzNUAksER6TJwRRgIYuiQ/BBm/TNAF+BPugAvZ+g45AvBrSLoUykkiAVPtgv5ikrXlz2Zb80nafGeLvY1P9IN3Va9r3vWAzX45Fdadqbl0GlxWXgExoknDjv4cFliNdWnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776310224; c=relaxed/simple;
	bh=vBFDnJrEPFRPlgm70HfA4wxz4Enhlc3uGdNeLKWB9Ts=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kF6pLSm3xZaHwgdboa1KLh1D0YdLjphClelnGoN+tpViGnPU530Z/nTrPd1Rr0mFCnX67ak91dnpVxX46YUeiTRBG/bGCZnnDaDO1bO6z23GA42GkuLenpSX3lvP1ThjGNfJoq6lgEgQnSPh/9ijY048mBfViRZ/ty2ox+n6NGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TQvqorGs; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TQvqorGs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776310216; bh=hZZp7MNLK+V4LvCNIrF9Gj77qLBKD9abqTCxmzaiSEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TQvqorGsD8qIVCmV42p05InJjpm1WtpVeTTn4vHyg5S+vc3RevpZ5pVmBx1xnVswa
	 R8qLMwqcgkU2mjQgqqsrcjZNdt55nzFDnAHgehgB6G3DlAvVq+ucPcar2YfYhXK2f1
	 fARc2FFv9xGsa4s9cyWKf6hSTh+NTIlrb8fuw4X0=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 78D956A8; Thu, 16 Apr 2026 11:30:13 +0800
X-QQ-mid: xmsmtpt1776310213t5ewvn9es
Message-ID: <tencent_858DE792345DFC5DEF99764F838D9A25E407@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5/1+xTilerq8vTRYofcpogeejrdYOCR9EozSIFHtkHKt3SqTAUo
	 ViFtof+WvMUN/1w4iqTIpoqHTbrHJqLFC68lUJpI2/ywXf3LXqmELaFXl5wb9vTL3MDl68NdYpu/
	 tNorG0CbrDJ2JRF0tJ4CZ71W/SF5Y/lsS718a7wUs9QjX9HXZ1+mcsKobh6aPfPsQ/mPnKeeAgLE
	 E3W3lEprgAUkm2svJF0q9MJIGRuMdwN0MDyuWGdx7Ye76TuEFYNhJW/hNIf+8kle0w+Ia/vDPEBE
	 PGUaEno4iYo9OB2asHnZXAHCOcwC7H1iVabK0SImcII5KmFcu0whg5/56RSu/VRxu8Yu8Oz5rW5N
	 YllI76Mcmd4TBCPTonGtz3vnFg+0MiFRevaqAz+i5rgkOqoH+zI1Q1VH0N7ILFH/fBfCi/Ol19+u
	 1eg6fVx6rs5ek8N1pnIl8eHl2H3eyTp5sLhVPVsby4LL0I3wTHzIRHqi/GOPVYDXYpJTOtw/jCY9
	 yjKPocDt4cPIMJ3vCuwz3whSEAxgMYuE4UjNYmAXiINlzzzQ3JUe/t/Xbt1tg208Lv5pTbosEBBO
	 iigV7eytzE6lubbr2PNvgZ+I+Z+Q2mkVRYCJG/I4r3s8l0eq5pCQC/MIjlem408sYBKYj83EPIat
	 SK7167Osla/Ze8rF6im4l12d/+TqIc8rruF96KkDh54+WE2bsgrv/vaOlqk5TgJzpAjAMzFmHNY0
	 3mZKRc0GEClr7NTVMC20dP4H7C4jtnL362QizGE10iEoclTYP0R83RMkmf8lVdhxCwH5xjczE/qh
	 cRcY+ZQFyQgQl+XZA8/Mi7ka1w6fmMyvf4UL2RwCQ7SIhcH6WSd/lvtklrSQ8eFwTuXsoSxeWM1O
	 O+MjiRZQ/okmbZBFdVakZxJPXdDrsgUNycZBaGjQRenYc1Gew9L9RChTUF7zC02s6cU8pMBA7fGI
	 hMbVrDBzQb+FGzYKDO3N0IKUm3cvl3VP4+blqie3GA8u05AfQjF1sHioOJgW67KgfureUYo08kUi
	 yvms30AA3KSPXA6O7pvCbA+MLv0M5vzgW7y2OyVg==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Edward Adam Davis <eadavis@qq.com>
To: vdubeyko@redhat.com
Cc: eadavis@qq.com,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] hfsplus: set attributes inode dirty at correct position
Date: Thu, 16 Apr 2026 11:30:14 +0800
X-OQ-MSGID: <20260416033013.359995-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4ca511af88f86e0b8bfb45ccc8e460ac773804e1.camel@redhat.com>
References: <4ca511af88f86e0b8bfb45ccc8e460ac773804e1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Apr 2026 15:11:13 -0700, Viacheslav Dubeyko wrote:
> > Syzbot reported a null-ptr-deref in [1].
> > If the attributes file is not loaded during system mount, a trigger
> > occurs [1] when setxattr is executed in userspace.
> >
> > Move the mark inode dirty operation to a point after the attr_tree has
> > been successfully acquired.
> >
> > [1]
> > KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> > Call Trace:
> >  hfsplus_setxattr+0x124/0x340 fs/hfsplus/xattr.c:555
> >  hfsplus_trusted_setxattr+0x40/0x60 fs/hfsplus/xattr_trusted.c:30
> >  __vfs_setxattr+0x43c/0x480 fs/xattr.c:218
> >  __vfs_setxattr_noperm+0x12d/0x660 fs/xattr.c:252
> >  vfs_setxattr+0x163/0x360 fs/xattr.c:339
> >  do_setxattr fs/xattr.c:654 [inline]
> >
> > Reported-by: syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
> > Fixes: ee8422d00b7c ("hfsplus: fix potential Allocation File corruption after fsync")
> > Closes: https://syzkaller.appspot.com/bug?extid=bc70a12e438dadba4fb4
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  fs/hfsplus/xattr.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> > index 452a1f9becb2..3e6f45b3259d 100644
> > --- a/fs/hfsplus/xattr.c
> > +++ b/fs/hfsplus/xattr.c
> > @@ -317,12 +317,14 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
> >  		next_node++;
> >  	}
> >
> > -	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY);
> 
> It's really strange that xfstests didn't catch the issue. Probably, we need to
> have the specialized HFS+ tests.
> 
> >  	hfsplus_mark_inode_dirty(attr_file, HFSPLUS_I_ATTR_DIRTY);
> >
> >  	sbi->attr_tree = hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
> >  	if (!sbi->attr_tree)
> >  		pr_err("failed to load attributes file\n");
> > +	else
> > +		hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb),
> > +					 HFSPLUS_I_ATTR_DIRTY);
> 
> As far as I can see, HFSPLUS_ATTR_TREE_I(sb) and attr_file are the same
> entities. Am I right here? :) So, we can simply remove the first
Yes, they point to the same attr inode.
> hfsplus_mark_inode_dirty(). Does it make sense?
Hmm, yes.

Edward
BR

