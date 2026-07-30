Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7E48987E
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440861; cv=pass; b=doAy+HXA+M1VuqVjBOlYLrVHgunznwQ3dSaJG9/XTk9rVs7hCn2ZBpln4gzDHGcMlEv6ycFkofRmK1lVcS6Kkc+lKsausQzZ/dJ/tD1VvS7S5X91dxP91vraAJG4XhcNHp3vP5Z+rGOWpKQj6HFTgvqxOSNTnb+fkSIETIGpEcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440861; c=relaxed/simple;
	bh=oi/xHlBdklqo4YV7qZlDYRdvWU9jT9geoNuMOps/N80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJNlVOMkvX2So/RfP4nsK1br+olhZPWQmy6SUY8oex3VBza/XeH3ISFaSs1ROlzqJpr59bAOGek2Z/idX9lahGAxlUAzpL07TQFmSadbcN5hKfB+Ydy29nZa1ZkpbbY8+QEmYmaHX16Lon8CUNPNlvQUHGpTVrkhx2lEDsF/Qdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbCIurmh; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbCIurmh"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so289129a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 12:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785440856; cv=none;
        d=google.com; s=arc-20260327;
        b=JlfIDgqtPTuBH3USyapTY130fHPHMNV89+tCRk8hLiNP4DyDIce+A734yVTtp0ahRS
         4m6yI0oDxY3hQSBrhiLHhvWB/0nn4S2KF6l4/zmCgmUfFYC/iHyfn3uODzZLJqNT4Sgr
         hvyfQ5MqrF1DNFvdEmn/MmNZJ39VXb2v093YXY6CIevOP1yMWtnWDRG9jKG/CrujE9ud
         wK92l6mEkcHeANV2L/rbP5YaxApsYILGi0p9FDQ7rgJG3c0KanWg5rTewe603Dmaz52m
         wUpAQlb1wTECeeiyk8TXxx38UlhngdfjDwk8EIqQXJQPuQiBwsydXI6hwcJByWIJswua
         lR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+b/MB2IBfN1O0DaR5wDrrHUKZ/8ztBtltdXanRbil6g=;
        fh=9V8Sw9otFFWZaxzH7I9+yOi/K4QjOmIXXb6L6Rlp/ic=;
        b=VpDNqbNB3hZky/dsCMOniukxaTeQVzR8R/ThCjJ3jMT29JbYiOx9LPEMaa3DWNwHRU
         0OVxn2PHuxJlkJmejEdFuu15h3T33THWn70CPsDf4pviLCeP6bn6E7+gFpydGSc9PKKf
         Tv8Nt0O9AIaDc6VMZD3WMBo7sGaFr0Uewu99LD8EfaxKrFA8euGVN4OXEzh8a2eQgyea
         Ugy4PFmj9KpHQk9QRliTJcUl6W72ghUiVN5UH2I0UlcNAr9CEl/77VFu361Jwhfavr8Z
         jgoAWrgKNr1hszPZUISWdLlNfpY7nARBuZWUROB5btDtMPBMkZ5UIsuRvvHJ7tV/vU0g
         frVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785440856; x=1786045656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+b/MB2IBfN1O0DaR5wDrrHUKZ/8ztBtltdXanRbil6g=;
        b=jbCIurmh6ziJG6JxZQomlV3pBtzflnMf/E0PrpiFoprBDAIySHYPZCLQazLbhRypuO
         lh6h8JuJoI/csIQuWK0WNkJ//8+JZ/e2lZh26Ilzh3Z9QBlnChcIC+A03+GxUhOGtPyI
         ID9HRefTEZ0qXE/+RxNb9NJPT8i2sE3WZ99RWK9ZUnglgDyi9yH2DSka9hHcZ8FIeIRS
         0sIW2Q7IxmyvtsFTKL38ip2PXM/npe7yoSYfieEwWx5s22e0XQLmAgrdfgO7UIDmYO6J
         OX137DI/UyWRrVzSGy9eqkgbeONlsR+QukaiEhYfYBm9XTwKpN3yvJTqrBWGgRNuDUa+
         ykKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785440856; x=1786045656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+b/MB2IBfN1O0DaR5wDrrHUKZ/8ztBtltdXanRbil6g=;
        b=HaR6q5b3MyWlFFmUp77/fXZahxkhXC3w4KzWJHw7fztKAUm2/vLRyHOMXAYZt3tOut
         SVkbbVEierFcZcU0WELUoUqwheX1bhBueV5owzLsOif1vzEViAMAhVA4O2dmJlV7MPjk
         nHSmVE9UuhI/Jl/ItVGPaJx++fI1kAkoxuhZIK35pXb04BoHYWbyM2+NpihZAjGiLr2V
         oRZZpQEbtpiOvD9AgqEgon972I0iiMsNOZHi2vUx9kNDUDLBq+DIuFVeL0VgLiX4SNWF
         AQQtbb54EXe26S0J3Pm+s+9NZDuI7PCQKvHycXGB2DkQqP0UQkwdkkIPEJ03LaBauMkD
         Qluw==
X-Gm-Message-State: AOJu0YxGg0SvV9DAxdXdHzvPYy+/bUo8vODh3nAFsY3R2+vHo+g7qADz
	u7HrmTu1/SO6Hu5ovu8B9LCtLMLbliNEKaMsL47nVywHdwZ4ixIM3zx5/S7Jbw7gFA4uHHVYgwx
	QXc1duAXPkILx28FYZZcpKoX8/dmTeTQ=
X-Gm-Gg: AR+sD1334n1QyT3e6IUbC/JbwBYLTMmGne1rjhGWlkroxMCWd/itPc9PX2OAEIkraHC
	bdfJCd9B1BRCY/DeTmKb465ruzd9JH69EdpJtnojrjlfmDJokjk4B+dyx2y6mr70QovHNFeLSkr
	p5o/xFa/JA7xjPgS2bBwQh3cUcmkE9Tpw19eJheESxvkAbWxIfrq7Zf9kvblHghfYaAX66DfkXp
	P7nInbPrcKbH4ch1s/yaDa2XLxm3QZIpauQwcs4uIA2r7hl1HMJzYITumByYXnEVron46uLIzQM
	3NaVH1Rz2JwKS0XxvYdwL4sy74TvbtAvuUz9JjZW5Dk0
X-Received: by 2002:a05:6402:510f:b0:6a0:eb:ae50 with SMTP id
 4fb4d7f45d1cf-6a07b814c6cmr2031354a12.18.1785440855558; Thu, 30 Jul 2026
 12:47:35 -0700 (PDT)
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
Date: Thu, 30 Jul 2026 15:47:23 -0400
X-Gm-Features: AUfX_mxYltrxwzfdRYvZPDsxYAtUi_bXZSm3IN_MgUjT84MkZaGGwYlfAdEuLMk
Message-ID: <CACd_6n1Sht4xs6P_GT0-+wj1uu9Ww_4X=TysQRvq6ZSFJ71CBQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	willy@infradead.org, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan, I'm currently working on the changes we discussed.  Based on
vfs.all now.  Four things came out of writing it that I would rather
resolve before posting.

1. mark_buffer_write_io_error() is not safe for jbd2's buffers yet.  It
dereferences bh->b_folio->mapping directly (fs/buffer.c:1057), and
jbd2_journal_write_metadata_buffer() points the temporary bh at
virt_to_folio(jh->b_frozen_data), which is slab-backed.
buffer_set_crypto_ctx() right next to it already uses folio_mapping() for
exactly this reason.  So I would send a prerequisite converting
mark_buffer_write_io_error() to folio_mapping() before the jbd2 change.
Also worth noting the consequence of A2: in ordered mode the temp bh
inherits the source folio, so the error lands on the bdev mapping and
mapping_set_error() errseq_set()s s_wb_err - a later syncfs() on an
unrelated fd of the same fs can then return EIO.

2. gfs2 already has what we are building: gfs2_end_log_write_bh()
(fs/gfs2/lops.c:171) calls mark_buffer_write_io_error() and does not clear
uptodate.  Which means fs/gfs2/log.c:110 and :324 are blind to log write
errors today, and converting them is not behaviour-preserving - it makes
them start catching those.  I think that is right, but say if you would
rather it were separate.

3. On the sticky BH_Write_EIO: I am adding it to BUFFER_FLAGS_DISCARD as
you suggested.  That covers discard_buffer(), but there are four other
clear_buffer_req() sites (fs/buffer.c:1687, fs/gfs2/aops.c:600,
fs/jbd2/commit.c:1035, fs/jbd2/transaction.c:2462).  Three of them also
clear_buffer_mapped() and NULL b_bdev, so __bh_submit()'s
BUG_ON(!buffer_mapped(bh)) makes them unreachable.  Only
clean_bdev_aliases() leaves the buffer writable, and I could not construct
a workload that reaches it.  So I am not sending the ungating patch.  The
one place it would matter is ocfs2: fs/ocfs2/journal.c:691 is nested
inside an if (!buffer_uptodate(bh)) at :675 that goes dead once the clear
is gone, so :691 has to be hoisted out, and it then becomes a pre-use
check on a sticky flag rather than a post-write one. I will Cc ocfs2-devel
on that patch.

4. fs/jbd2/transaction.c:923, J_EXPECT_JH(jh, buffer_uptodate(bh)) in
jbd2_freeze_jh_data(): after the series a failed write leaves the buffer
uptodate, so this stops firing for write errors.  Arguably correct - the
in-memory copy being frozen is still valid - but it is your assert.  Leave
it, or convert it?  I instrumented it and ran ext4 with data=3Djournal unde=
r
injected write errors, forcing copy-out; it never saw a non-uptodate
buffer, so I have no evidence either way.

One thing I did settle by testing.  fs/ext4/ext4_jbd2.c:416 open-codes
buffer_req(bh) && !buffer_uptodate(bh) after sync_dirty_buffer(), which
already returns -EIO.  On an instrumented kernel (ext4 without a journal,
-o sync, injected write errors) the two agreed on all 40 occurrences and
never diverged, with BH_Write_EIO set every time.  So that site just
consumes the return value and the buffer_req() question goes away.

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
