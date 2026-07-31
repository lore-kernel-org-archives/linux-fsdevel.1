Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15E3B95FF
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520769; cv=pass; b=fPQkaX8AQA5zwOImC7G1UJC5ntk3f7ShQn7aYJfksOlxUy/exIQ0dekTA7AgUr57oBhKVzeNBEWKZb5GyNBJkyhhcN1DAB2v4umMk19Kas/3YM07bjrQnZ/5cAb6g4McoIi9nneSxYG4Kg/nS3oXoJK5XDAJq1KhBtQlF0MVUs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520769; c=relaxed/simple;
	bh=lMJ4RQUzhyTTRs69OWZFWOaAOEs2O7OPY2SZWqv+8fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJss00YJw+1LyzZ1SWhwG8ZT5eR3DmItlWF/iBy9gTVqC1kkrXMQWQssjB7s3Lc/WcASO2fiW4DUdxIGZEwlzhQ5xgE5kOCi794+27NTQkcymx0r0hx9djzmZ4JU4eqDX6ZgLAalhQunmT7KUshqMVV00pn/xq2aY06Xng26UB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oey2/jdr; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oey2/jdr"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso2099819a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 10:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785520766; cv=none;
        d=google.com; s=arc-20260327;
        b=ja8lT+sX1lgUZo4LABXi5jPeq0BxT76VpjXoztDfi0hjqv3naqQl4d/iKQfdMCVRd+
         FuRP/bcL17m4J9fj76Xw2yJfaQg/qwbqXD0Gf2HzitdkVJOW/d+IhMaScBFSMDvOn6jL
         lWl2/wNVktlHqiWfAkrNJo0eTA/v3O8AL96pHP8SzmColJRJ2izSzjz6WcD33PadWoaw
         vVgCoO3y8pSXvvViAZF3w2lMUsC3Xum20tJ7TdDBWEGolXy534cibyRGcxORa9hp99Do
         KZvMCxQZoanz8Knkn6pbvr7yjv1Y7Q75Z5s3WO9tPCHSM4C3axd3H/Qgkd/irWXFm/z8
         Jp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8bTHJ+bbvGGGzCsgxXPnKov5qoBwolOgR7WMewveCZE=;
        fh=9V8Sw9otFFWZaxzH7I9+yOi/K4QjOmIXXb6L6Rlp/ic=;
        b=Gfp+m1RKTX5CXekpU1Pu8tHq0EYvBgwrEaSRHcYXS9E3gkkE+eSPKyJMGe0Iy0XKat
         IjUdbwZubIKneXO2BAmMM7GS4unzxRnoseQN2yD+Kr1SydSiFC/BYGu9eYiwidaIxBmB
         lS6giykU711kGd0mHJAQ2WFubS0H1BYYI22TeLZsLnTyk3BdDmMYoMDkPsmErSvj4Dm2
         Y+weJFuxNjqGcaqHTOTUtQ1/mfeVp3AQwn8Nle5RI6alGOum5JvVYZc7cTpk44Tz1M1f
         k+AAjdzY+vtsvc0yL1pjIF0OBF4KqV/N3OSJhIKGL9cZHimHZbVaMS3CfwSQ65Yo2C4W
         QsLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785520766; x=1786125566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8bTHJ+bbvGGGzCsgxXPnKov5qoBwolOgR7WMewveCZE=;
        b=oey2/jdrvT84pwyGKQgPU6S6jmpesGGDA8w8Ggy4/8iK8Ip5O/S0wImkoj1mCMB9Bt
         yOFxhEFedLrtZ5Ck2Qs1ldQhcoNWrNQ6cJqI3DKxpM1cbqqEVQp67RaHDxj44hiRqszl
         g19BYNQPnZcEIZG82OCUBFSqQ7Y+p2U/ZaYk8iCeslq/UNXRNy06Rt98VQm/o+2il35/
         UXeXL+kT0RbtfbVFt6XdYkxg+26TSx5mNb4aVTuQGzBO0DxLjWjlwdX5V6hD7AjeVWJz
         WnY7qloVuvmJOqCLfR/CGUz++QF+gV22cf2M0zygGta9vnzOExiJQpECVOiKfkR/99SZ
         PA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785520766; x=1786125566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8bTHJ+bbvGGGzCsgxXPnKov5qoBwolOgR7WMewveCZE=;
        b=N3PqN55hZGLztwW4IdNmpdeDphG3RHK7czHS97WptlUeZkkDJ0HGbo9ejE/1Vvzu/6
         mGJpTEtxQMifFmaz0T+0SaO2vZuliuas1IqsYdDaMYzJyBzujLLvuDFpJv85PPbiZwl9
         7AqZ2A5h+XaIb92KnXHHH5e2VymdfSdY0Tg9hs4rQ/JkbIJWBYeQkidycYpl65RwHAlf
         7dHnnqMoDgEzcCpfcHB6RL0UUy/0Cxc1qm+MieIMC3Zo6EcXnko7qfttJ9OWvcZlpjL+
         ma2reWAZvB7qIKp7pf03ZTr89LaZQlcXo6b3EzmEkMHUBNVIBgkR//Csi/6RuYpW5pwr
         N8uw==
X-Gm-Message-State: AOJu0YzHlZ3J7aQZb9cykIaoTp/QxlYig88sAULpK6N3iKJVoKnOx3nE
	BIU31ylB4udL1ljnaTY5JJqMC9MpUuwJzUea8APfh3IeOdljI2E+ug0cNvTuy4HCsqGpH05ywkV
	bHa6+52/AD7hQQrIkZQTHuc3z8kT8k2g=
X-Gm-Gg: AR+sD11rkwYV0fiy8riO23wEv1HZcaRBMyX6WY3ysjeJMCX0cO8RKoxiFfWFCf0Qpb6
	tzbIuGZc6V6Oqj2mbA+SzedljvfLEI7mWvtofToCHFVWtgg7Ndq5HIFsTxxIjzxovrYmEnoe5dD
	CugWvu1hT546Z3bfNwEPRbsUFnSu4cDBuWeUrSVnNjzPaCdCT//9oVUegblCJKmnyn37tTZcRvf
	UMx+OxEXsdy4dR+uCXLd7dgu6dv3L6JPvDUt2cMUxVDGvXzvHRn318V24HpmSWR+Pq4uiLcthQJ
	GPQCJ9ocZ/xn9xp+ALZ3ukov0qnZc+68P1NY2o86us+3jA==
X-Received: by 2002:a05:6402:5386:b0:6a0:a4be:6ed0 with SMTP id
 4fb4d7f45d1cf-6a0a7cbab4bmr340980a12.17.1785520766024; Fri, 31 Jul 2026
 10:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430053645.1466196-1-coshi036@gmail.com> <xaqwfkwjnp7h2lg7ir6wy2tnyay26t3im3ftkdl64rhys3rhmu@lc5vfh5tc2f5>
 <CACd_6n17-pJuNoCLsstP7goocedrr5F8T8BwTjRUNx8frKEPgA@mail.gmail.com>
 <bnchcfog427eo3bxt5h6qautlq7sb2o4ww7cjgad73biycdn5f@np7qkbyqizup>
 <CACd_6n1Sht4xs6P_GT0-+wj1uu9Ww_4X=TysQRvq6ZSFJ71CBQ@mail.gmail.com> <zuntjkh7ir3wwql3pckp2rq446cxtyzehjsgjldpckvankw5xv@i6wag4niumr4>
In-Reply-To: <zuntjkh7ir3wwql3pckp2rq446cxtyzehjsgjldpckvankw5xv@i6wag4niumr4>
From: Chris S <coshi036@gmail.com>
Date: Fri, 31 Jul 2026 13:59:14 -0400
X-Gm-Features: AUfX_mwVVHkIXcIlneFBVAiqKdbRIMLKMGXeuLk4Gv1wF3sV287wPjLv4H5MqT4
Message-ID: <CACd_6n2ze=81UrrGOJdGLTeL74spr4Fbi+0Uow3oDujxz125QQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	willy@infradead.org, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got you. Working on it. Will try my best to make it ASAP.
Thanks for your help and time!

Best,
Chao

On Fri, Jul 31, 2026 at 1:51=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 30-07-26 15:47:23, Chris S wrote:
> > Hi Jan, I'm currently working on the changes we discussed.  Based on
> > vfs.all now.  Four things came out of writing it that I would rather
> > resolve before posting.
> >
> > 1. mark_buffer_write_io_error() is not safe for jbd2's buffers yet.  It
> > dereferences bh->b_folio->mapping directly (fs/buffer.c:1057), and
> > jbd2_journal_write_metadata_buffer() points the temporary bh at
> > virt_to_folio(jh->b_frozen_data), which is slab-backed.
> > buffer_set_crypto_ctx() right next to it already uses folio_mapping() f=
or
> > exactly this reason.  So I would send a prerequisite converting
> > mark_buffer_write_io_error() to folio_mapping() before the jbd2 change.
> > Also worth noting the consequence of A2: in ordered mode the temp bh
> > inherits the source folio, so the error lands on the bdev mapping and
> > mapping_set_error() errseq_set()s s_wb_err - a later syncfs() on an
> > unrelated fd of the same fs can then return EIO.
>
> This you've already solved with Matthew.
>
> > 2. gfs2 already has what we are building: gfs2_end_log_write_bh()
> > (fs/gfs2/lops.c:171) calls mark_buffer_write_io_error() and does not cl=
ear
> > uptodate.  Which means fs/gfs2/log.c:110 and :324 are blind to log writ=
e
> > errors today, and converting them is not behaviour-preserving - it make=
s
> > them start catching those.  I think that is right, but say if you would
> > rather it were separate.
>
> Yes, that's a desirable change. I think it's minor enough that we can kee=
p
> it in the series.
>
> > 3. On the sticky BH_Write_EIO: I am adding it to BUFFER_FLAGS_DISCARD a=
s
> > you suggested.  That covers discard_buffer(), but there are four other
> > clear_buffer_req() sites (fs/buffer.c:1687, fs/gfs2/aops.c:600,
> > fs/jbd2/commit.c:1035, fs/jbd2/transaction.c:2462).  Three of them also
> > clear_buffer_mapped() and NULL b_bdev, so __bh_submit()'s
> > BUG_ON(!buffer_mapped(bh)) makes them unreachable.  Only
> > clean_bdev_aliases() leaves the buffer writable, and I could not constr=
uct
> > a workload that reaches it.
>
> That get's used e.g. when a block is first used for metadata, then it's
> freed before it is written, and then the block gets reallocated as data.
> Whatever is set on the bdev buffer head is irrelevant at that point. But
> clean_bdev_aliases() is practically dead (only called from legacy DIO cod=
e
> and ntfs). I'd just leave it alone. What would make sense though is to
> clear the BH_Write_EIO in bforget() which is generally used by filesystem=
s
> on metadata blocks to be freed.
>
> > So I am not sending the ungating patch.  The
> > one place it would matter is ocfs2: fs/ocfs2/journal.c:691 is nested
> > inside an if (!buffer_uptodate(bh)) at :675 that goes dead once the cle=
ar
> > is gone, so :691 has to be hoisted out, and it then becomes a pre-use
> > check on a sticky flag rather than a post-write one. I will Cc ocfs2-de=
vel
> > on that patch.
>
> Not sure what you exactly mean here but it needs to become something like=
:
>
>
>         if (!buffer_uptodate(bh)) {
>                 mlog(ML_ERROR, "giving me a buffer that's not uptodate!\n=
");
>                 mlog(ML_ERROR, "b_blocknr=3D%llu, b_state=3D0x%lx\n",
>                      (unsigned long long)bh->b_blocknr, bh->b_state);
>         }
>         /*
>          * A previous transaction with a couple of buffer heads fail
>          * to checkpoint, so all the bhs are marked as BH_Write_EIO.
>          * For current transaction, the bh is just among those error
>          * bhs which previous transaction handle. We can't just clear
>          * its BH_Write_EIO and reuse directly, since other bhs are
>          * not written to disk yet and that will cause metadata
>          * inconsistency. So we should set fs read-only to avoid
>          * further damage.
>          */
>         if (buffer_write_io_error(bh)) {
>                 lock_buffer(bh);
>                 if (buffer_write_io_error(bh)) {
>                         unlock_buffer(bh);
>                         return ocfs2_error(osb->sb, "A previous attempt t=
o "
>                                         "write this buffer head failed\n"=
);
>                 }
>                 unlock_buffer(bh);
>         }
>
>
> And yes, CCing lists & maintainers for the corresponding filesystems that
> are touched is needed in all the cases.
>
> > 4. fs/jbd2/transaction.c:923, J_EXPECT_JH(jh, buffer_uptodate(bh)) in
> > jbd2_freeze_jh_data(): after the series a failed write leaves the buffe=
r
> > uptodate, so this stops firing for write errors.  Arguably correct - th=
e
> > in-memory copy being frozen is still valid - but it is your assert.  Le=
ave
> > it, or convert it?  I instrumented it and ran ext4 with data=3Djournal =
under
> > injected write errors, forcing copy-out; it never saw a non-uptodate
> > buffer, so I have no evidence either way.
>
> I'd convert it to:
>
>         J_EXPECT_JH(jh, !buffer_write_io_error(bh), "IO failure.\n");
>
> > One thing I did settle by testing.  fs/ext4/ext4_jbd2.c:416 open-codes
> > buffer_req(bh) && !buffer_uptodate(bh) after sync_dirty_buffer(), which
> > already returns -EIO.  On an instrumented kernel (ext4 without a journa=
l,
> > -o sync, injected write errors) the two agreed on all 40 occurrences an=
d
> > never diverged, with BH_Write_EIO set every time.  So that site just
> > consumes the return value and the buffer_req() question goes away.
>
> The test
>
>         if (buffer_req(bh) && !buffer_uptodate(bh)) {
>
> is stronger than just checking the return value of sync_dirty_buffer()
> because it triggers also if the buffer was written by background writebac=
k
> and hit IO error. Arguably sync_dirty_buffer() should return EIO in that
> case as well but that's another cleanup I don't want to entangle with thi=
s.
> So I'd rather change that test to buffer_write_io_error().
>
>                                                                 Honza
>
> > On Tue, Jul 28, 2026 at 3:45=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Sun 19-07-26 02:28:54, Chao S wrote:
> > > > On Thu 30-04-26 09:28:13, Jan Kara wrote:
> > > > > But it would be actually very welcome if you took the work, went =
through
> > > > > all the places using end_buffer_write_sync() and converted them i=
n
> > > > > filesystem-by-filesystem to check for IO error by checking
> > > > > buffer_write_io_error() instead of buffer_uptodate() and then we =
can drop
> > > > > clear_buffer_uptodate() call from end_buffer_write_sync().
> > > >
> > > > Sorry for the long delay, I've been working on some patches and a p=
aper
> > > > deadline.  Also, you were right about v2, and I have dropped it.  I
> > > > would like to
> > > > take the conversion work.
> > > >
> > > > Before writing it, I found your "fs: Fix missed inode write during =
fsync"
> > > > series, v4 of 16 July.  It removes four of the sites I had on my li=
st, so
> > > > I will base this on top of it once it lands.  Say if you would rath=
er
> > > > sequence it differently.
> > >
> > > Yes, please base your changes on top of vfs tree
> > > (https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all)=
. My
> > > patches are already in there now.
> > >
> > > > (end_buffer_write_sync() is now bh_end_write(), per b20f15420f78.  =
Current
> > > > names below; line numbers against v7.2-rc1.)
> > > >
> > > > The sites, one patch each:
> > > >
> > > >   core     fs/buffer.c:621 (mmb_sync), :2803 (__sync_dirty_buffer)
> > > >   adfs     fs/adfs/dir.c:194
> > > >   ext2     fs/ext2/xattr.c:772
> > > >   ext4     fs/ext4/ext4_jbd2.c:399, fs/ext4/mmp.c:52
> > > >   omfs     fs/omfs/inode.c:148, :162
> > > >   exfat    fs/exfat/misc.c:190
> > > >   fat      fs/fat/misc.c:358
> > > >   ocfs2    fs/ocfs2/buffer_head_io.c:69, :449, fs/ocfs2/journal.c:6=
75, :691
> > > >   gfs2     fs/gfs2/log.c:110, :324
> > > >   jbd2     fs/jbd2/commit.c:880
> > > >   removal  fs/buffer.c:210 and :444
> > > >
> > > > Conversions first, removal last.  The list is short because
> > > > __sync_dirty_buffer() and mmb_sync() test internally and return -EI=
O, so
> > > > the ~40 callers that use the return value need no edit of their own=
.
> > >
> > > Sounds good.
> > >
> > > > I would like your suggestions on the following.
> > > >
> > > > 1. BH_Write_EIO is sticky.  It is cleared only on rewrite
> > > > (fs/buffer.c:1196), and only if BH_Req was already set, which
> > > > BUFFER_FLAGS_DISCARD clears on its own.  So a converted test can se=
e a
> > > > stale error.  I would fix this first, either by making the clear at=
 :1196
> > > > unconditional for REQ_OP_WRITE, or by adding BH_Write_EIO to
> > > > BUFFER_FLAGS_DISCARD.  Which do you prefer?
> > >
> > > I think we should add it to BUFFER_FLAGS_DISCARD. It doesn't make sen=
se to
> > > keep it on a discarded buffer.
> > >
> > > > 2. jbd2: log_bufs is a mixed list.  Commit descriptors come from
> > > > journal_end_buffer_io_sync(), which never sets BH_Write_EIO; revoke
> > > > descriptors from write_dirty_buffer(), so bh_end_write().  I would =
convert
> > > > fs/jbd2/commit.c:880 to the disjunct !buffer_uptodate(bh) ||
> > > > buffer_write_io_error(bh).  The alternative is to add
> > > > mark_buffer_write_io_error() to journal_end_buffer_io_sync() and co=
nvert
> > > > all three jbd2 sites.  Which do you prefer?
> > >
> > > Please convert journal_end_buffer_io_sync() to use
> > > mark_buffer_write_io_error() so that we completely get rid of this
> > > antipattern.
> > >
> > > > 3. bh_end_async_write() has the same clear at fs/buffer.c:444.  I w=
ould
> > > > remove both, which needs the gfs2 patch first since gfs2 reads that=
 bit at
> > > > fs/gfs2/log.c:110 and :324.  I can also leave the async half out.
> > >
> > > Please change gfs2 the same way as you are fixing jbd2. Keeping the m=
ix of
> > > uptodate & write_io_error checks only makes things more fragile...
> > >
> > > > 4. ocfs2: fs/ocfs2/journal.c:691 sits inside an outer
> > > > if (!buffer_uptodate(bh)) at :675, so dropping the clear stops ocfs=
2 going
> > > > read-only after a failed metadata checkpoint.  I would convert both=
 sites
> > > > and Cc ocfs2-devel.
> > >
> > > Yes, please.
> > >
> > >                                                                 Honza
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
