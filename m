Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2773A3809
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311681; cv=pass; b=HvLJ5aXNVvDGAtNhsqDGjIb2zxeiOnlbPVoP8Ol4KTRjzoOvX5UDFNMUJGng6LSVnAb1JaEH0omZVdkZBxD2kRr1gtub+nLiXn7OjLj/TRa7C8fuF3Caz9jXuZUuRqM2YJTc+bOobMSsf2Xe8WD5wVE2S4/9UQowHKm0KuP+5CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311681; c=relaxed/simple;
	bh=bBfmQlF3h659lyc26EDzdulv2PbDcwwFJQGorhRcrO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0gPlQeEwxHzZBnMHNdiF/edh6+mOhZ05jqJben55rzJk0Su4J781vsYDz5IoKAOFu80LjihPAzbM2IY9fwkTEDLcAxUy1olfeaj1/maE/+VqLDoRuZ3VlgwUW1TfYhjCo49pD08aXLTgI434u1cdtg0R0PDe6IZ6O8WJFuU8Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHizJA86; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHizJA86"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69f7af97316so1018078a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 00:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785311678; cv=none;
        d=google.com; s=arc-20260327;
        b=eNer/FPEZk83S5iRKx3m/A8T/yjv0yw4QneUsg0aG1cZLFiX0R9zI7BTmRm/lLzshs
         oVA4PmBG4cZ/0CNGRmcNJVQu6wwc4oCTABq9sCx5uACJ0LSjKRZ7mAt4dXbBf+bxIaTg
         liyWLqqKcjf22rLCWjocPbvy38eTwm7CAH6T2AM2VvNIp66bTSIG1/w9vZgdDYGIK14b
         p+Di6NTkFq/BaMosv/vO7v2T1+NzzGndM7BqSFKhSd67DOKThnXcw3TeZAU9/JVH25zE
         DBAVg5crTDX3lAAJiBNrUm48U1cXZ/zAcy2UIfSdkUwyMLGadDLKHE5EFBnz/yDnRe6Q
         3KAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ta0Kyhc2ls9bkePZ+5DpUlAzYzR54xwWf81Viq6J+m4=;
        fh=9V8Sw9otFFWZaxzH7I9+yOi/K4QjOmIXXb6L6Rlp/ic=;
        b=jg6FI1LIFa+Fl9ao+Giqdp6Y9IdOFghomnis91SPloYEiZumQ9tzXzuFY5gA7nL3FS
         UNH5r9u1DX8JTdTnbFbUAWwY0QfXWlQjx/wS+89Gbo+PsJnPTLH+NMJ/3rUEyY10plQA
         vEnf4JmnErifbuw+e9ck4tuwwqNMMVuGViZatsAir36W+ojHyb5lcQjT9uUWI5BIoQLI
         x7qfPhfmFe7x7R6m/3rLCvr3MQofXLjGCrmVhIOFRuxkRzcdu86jHiN5bzv8mlyRc/en
         hETGx6xnRUbxlm0XJUB45+PVvq0sokrXBgo2jg8UrrFzYw3Zakhg0WCtERMLNMm3ZJVK
         6RyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785311678; x=1785916478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ta0Kyhc2ls9bkePZ+5DpUlAzYzR54xwWf81Viq6J+m4=;
        b=EHizJA86Ta+QG5YZKDibT+XHUM7fHCs8p1s6spGg5BY8H/HAaV/6+6URvfeog0nc8u
         a8xmGrbA8caK5xnw57qiN/Yyjh1h+sEVvGPdZVF7aCXNDZuDQrQ9UWAuqxxXjbrf7Yri
         u1VkE80ZIWN8SbQJcrFYG9sCVesD/4mC1FARGC7R/qC2KGrM8uosDIax9l+HDTsdt75H
         J1t/upYlXEDT1ZV8DBuSeG4VyL1OdX2EbxoYq+givjRhYNqqJ0kq8V3jdVMuHPPFAtkW
         iehQB0oG1FeWVhNXjqYf/E1Lz09/CzvmYqEtQyUa9Xxm1bodlzbFcr2HOXfrg0DPt9W8
         tgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311678; x=1785916478;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ta0Kyhc2ls9bkePZ+5DpUlAzYzR54xwWf81Viq6J+m4=;
        b=qArYx44BoZsdZJ8azkTfBhymxtTMi68fw6MQWgMCu2lM/pPbrYsnnmPJPalty6yTN8
         7mPfFglkG9SM2+eCrwZPG5NaUCtPkCd2NaozJwfja5xoWpMRmozddAt8zUm4R8B4GDlf
         nBts3+vo8Aj84PKpUNg/Vn6jweqli3js7KVyV6GDlt4M0GcUVZ6UmwpTJyQ571qy03DR
         aApTpQPsfKk2Wa0M3Kiv7yPLfmLKvR9DOM1KDeCPG8KBMKDwMqDaKbZkHM0CXpKpZ4j6
         knaZ5rUSF+GlxbkCi51X3t8bxlxK1eTaAFXN9ohAg+Gl6ct+ZyVuR5zbUpz+wjTbcvEy
         5X+w==
X-Gm-Message-State: AOJu0YzIP+fdkDFWr8slM3ol/fBJBvTzP+ebCgstfoqWroLN1AagXGXs
	z3HuttDBGpsSRyj9fPzMgH2Oow/+MzICSDMFvm3/lC9QpamtD1BZEHnSgWFUdOYfwws4PaE2j4Q
	OcPthLJcY3XHMMWdtkJgJnW5nQmzQeVQ=
X-Gm-Gg: AR+sD10I83Sdy8ZSQcvt9htcos0f17pfxAUGD997i8pPmzD1rJN1EIebG5/1S7+5vRs
	C4iFdH1pwBQQoMMTGKqYghg5zRU4mPNVhq+3cIWXvJQpTA7Bn1IvvtMMvuHnuK4IxyZr1HXnZ79
	deWJU1NvdDd7l0ljJXykz8+Lu/XPYwlNjCcuUM3/u2z14XOmrrQRtVQLb0eEM44PaLytFQbsyJH
	AKpHAHTYesD9qYQHQorxbpaUc6GREVM2EDnQsqHCff4xzHZapAe+MV5LQiQlFKo6ywzmDK5E2o0
	D1/daGeLTcSWcyt7cBXYT2kEcnwTup9ft/qYNe8YdGowSEvjNqLVsa/DlqA0GPqDGESXV3T410l
	y
X-Received: by 2002:a05:6402:2b8c:b0:698:3b7c:7e46 with SMTP id
 4fb4d7f45d1cf-6a034a822a4mr2744053a12.38.1785311678327; Wed, 29 Jul 2026
 00:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430053645.1466196-1-coshi036@gmail.com> <xaqwfkwjnp7h2lg7ir6wy2tnyay26t3im3ftkdl64rhys3rhmu@lc5vfh5tc2f5>
 <CACd_6n17-pJuNoCLsstP7goocedrr5F8T8BwTjRUNx8frKEPgA@mail.gmail.com> <bnchcfog427eo3bxt5h6qautlq7sb2o4ww7cjgad73biycdn5f@np7qkbyqizup>
In-Reply-To: <bnchcfog427eo3bxt5h6qautlq7sb2o4ww7cjgad73biycdn5f@np7qkbyqizup>
From: Chris S <coshi036@gmail.com>
Date: Wed, 29 Jul 2026 03:54:27 -0400
X-Gm-Features: AUfX_mwdyTen07YTxg-Fba1BRPEEVqJia0NWbarPwx6IayFr-Xkhx6BSsAM5vYg
Message-ID: <CACd_6n2e4aqcSs0urwQOddjaokXg9Z8EzRvkjEQTqB=m7P05GQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	willy@infradead.org, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you! I'll update asap.

Best,
Chao

On Tue, Jul 28, 2026 at 3:45=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 19-07-26 02:28:54, Chao S wrote:
> > On Thu 30-04-26 09:28:13, Jan Kara wrote:
> > > But it would be actually very welcome if you took the work, went thro=
ugh
> > > all the places using end_buffer_write_sync() and converted them in
> > > filesystem-by-filesystem to check for IO error by checking
> > > buffer_write_io_error() instead of buffer_uptodate() and then we can =
drop
> > > clear_buffer_uptodate() call from end_buffer_write_sync().
> >
> > Sorry for the long delay, I've been working on some patches and a paper
> > deadline.  Also, you were right about v2, and I have dropped it.  I
> > would like to
> > take the conversion work.
> >
> > Before writing it, I found your "fs: Fix missed inode write during fsyn=
c"
> > series, v4 of 16 July.  It removes four of the sites I had on my list, =
so
> > I will base this on top of it once it lands.  Say if you would rather
> > sequence it differently.
>
> Yes, please base your changes on top of vfs tree
> (https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all). My
> patches are already in there now.
>
> > (end_buffer_write_sync() is now bh_end_write(), per b20f15420f78.  Curr=
ent
> > names below; line numbers against v7.2-rc1.)
> >
> > The sites, one patch each:
> >
> >   core     fs/buffer.c:621 (mmb_sync), :2803 (__sync_dirty_buffer)
> >   adfs     fs/adfs/dir.c:194
> >   ext2     fs/ext2/xattr.c:772
> >   ext4     fs/ext4/ext4_jbd2.c:399, fs/ext4/mmp.c:52
> >   omfs     fs/omfs/inode.c:148, :162
> >   exfat    fs/exfat/misc.c:190
> >   fat      fs/fat/misc.c:358
> >   ocfs2    fs/ocfs2/buffer_head_io.c:69, :449, fs/ocfs2/journal.c:675, =
:691
> >   gfs2     fs/gfs2/log.c:110, :324
> >   jbd2     fs/jbd2/commit.c:880
> >   removal  fs/buffer.c:210 and :444
> >
> > Conversions first, removal last.  The list is short because
> > __sync_dirty_buffer() and mmb_sync() test internally and return -EIO, s=
o
> > the ~40 callers that use the return value need no edit of their own.
>
> Sounds good.
>
> > I would like your suggestions on the following.
> >
> > 1. BH_Write_EIO is sticky.  It is cleared only on rewrite
> > (fs/buffer.c:1196), and only if BH_Req was already set, which
> > BUFFER_FLAGS_DISCARD clears on its own.  So a converted test can see a
> > stale error.  I would fix this first, either by making the clear at :11=
96
> > unconditional for REQ_OP_WRITE, or by adding BH_Write_EIO to
> > BUFFER_FLAGS_DISCARD.  Which do you prefer?
>
> I think we should add it to BUFFER_FLAGS_DISCARD. It doesn't make sense t=
o
> keep it on a discarded buffer.
>
> > 2. jbd2: log_bufs is a mixed list.  Commit descriptors come from
> > journal_end_buffer_io_sync(), which never sets BH_Write_EIO; revoke
> > descriptors from write_dirty_buffer(), so bh_end_write().  I would conv=
ert
> > fs/jbd2/commit.c:880 to the disjunct !buffer_uptodate(bh) ||
> > buffer_write_io_error(bh).  The alternative is to add
> > mark_buffer_write_io_error() to journal_end_buffer_io_sync() and conver=
t
> > all three jbd2 sites.  Which do you prefer?
>
> Please convert journal_end_buffer_io_sync() to use
> mark_buffer_write_io_error() so that we completely get rid of this
> antipattern.
>
> > 3. bh_end_async_write() has the same clear at fs/buffer.c:444.  I would
> > remove both, which needs the gfs2 patch first since gfs2 reads that bit=
 at
> > fs/gfs2/log.c:110 and :324.  I can also leave the async half out.
>
> Please change gfs2 the same way as you are fixing jbd2. Keeping the mix o=
f
> uptodate & write_io_error checks only makes things more fragile...
>
> > 4. ocfs2: fs/ocfs2/journal.c:691 sits inside an outer
> > if (!buffer_uptodate(bh)) at :675, so dropping the clear stops ocfs2 go=
ing
> > read-only after a failed metadata checkpoint.  I would convert both sit=
es
> > and Cc ocfs2-devel.
>
> Yes, please.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
