Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C0347BDC
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jul 2026 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784442549; cv=pass; b=f/ry5pfnFfaPdc01naHw6iqbOE+oNkWKgU3pwVBkMqRjgbQYZzXAheSr5zYfRlWYvSPQwoEUd8rsvkxGAIdtuXi+ro/vsF2rmu1gGlEsjoBS8yG/1R0axRFdPGP8aVx0edPaLhdE+atjGlLeZBpJiOKTeXvaUWCv4rae13TCxLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784442549; c=relaxed/simple;
	bh=YsosXKlOCVvvHuJcqOmN357KwnuNHyp6aTLyEt8An6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBjtEBfVU+y4QGWBC8qQanjcDTDQZjmcYs2cE1LGUnZNf8JBK+VXsRduLDrBlADtGCGbGpMFyQ4ZgtiXKfUvfwsM/aH+v8+Dje+HUtbq3g31H3Y3aYUISJnu/aaIYq6xRVOX8v813Qxqkxo1c9dkFPVwvV1cFjFhqfBcgS/VFnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXGSqk8a; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXGSqk8a"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698ab9aae16so7583391a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 23:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784442546; cv=none;
        d=google.com; s=arc-20260327;
        b=k1n9ouCiJ03KLkJYHf/3a7S/JuO1ptr/tV9F06ctZ49Uoymtp9vEY+cJ39MKXxB8f8
         2AdBX0RA3+552t1qNmZsxKVbbjEdvabpql/r1NZIuKYORX+GcXQj1dEFVAGMSSyq/eg/
         VpJmQNEIVMaN3uNJxTw0HUR0JokfFSPuUmG5mtNWo5vZ7Q5H86N1nd04ArRtCuYRCMCg
         +0vxMDW5yQwb+gy42rYyFusouIVDtz6Vm87gdcDEbs9YR4zUiqXRYKCFnvxUnhFpXrIX
         4nQLlzDfuqDtg8S8T4xggiTk31rRqv2T5q2mcfmzPLEgA4Sqdno0uoKmGNdTjnj0s0GH
         7RBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C0Tv0u+NQSaPJ/rFy3GZOFRpoYsKR9R3UBHaDcmh25k=;
        fh=9V8Sw9otFFWZaxzH7I9+yOi/K4QjOmIXXb6L6Rlp/ic=;
        b=DFvQCePM3NnhiNG6zyTRBiFWTUgSxEWw5OCMm2HhT6NezDP4oYalPShua0ssnNXfBJ
         yLo50ALtyziPvzTBlm7zT1pfnCsed7pIzMdsd5GJBteRg4DU1zELz3FwzV3jpV3/ynQu
         TJNKxwYaHd51ySeTCup3mLbt0nQpxCGyV4L0IRRZ9toiRjF+g4PavSm9vEgwQp0wTMLn
         as+hLPyXKhpdvU2kLC3K50eMn/FSpeg9tWtQvYcxao7S8zDT+gRS1ggUbdo42Nsf1L2O
         /BNiwaLAUx/ZKiXjsNV1dgl6CQhYUGjVu3BlxJd5T9oVfb2ZBD94CQ4dvD0SRf1bvWDW
         FFZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784442546; x=1785047346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C0Tv0u+NQSaPJ/rFy3GZOFRpoYsKR9R3UBHaDcmh25k=;
        b=YXGSqk8aOjp08Th2yJdUvs8SSG0I4/RIR1sNUZNJIDL6R7V2bjAuh4IJEAxqin0sv2
         ZgYr8lw4DjeciZ8/2wlhEI8JOimhkmXHAdpYMEO+PU+mx7bwA08BD8RfOQ1DG9CINo80
         xJWk64tOEf49hqxF+5pzn/v0baEpUSIYgAMt8beV+pdLua6RpddL4TB+VwSx7Fv70til
         ouKXFEU4ljT08M8CqJkZsKP64LuBKP7lqMWKWdU4U5icwuHTr0sjCi6oSrI+amjQrHW1
         Bzk9yMsRsdDM6ng1bBRJqQZxCn7IrTefkDShDF29+xrrCYPKdOnYeEJXpO4yDf6hsafh
         N9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784442546; x=1785047346;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C0Tv0u+NQSaPJ/rFy3GZOFRpoYsKR9R3UBHaDcmh25k=;
        b=tODlD5rxRTRuoeZnskHI37P4sUGx3K9jKMrqAIdZon0eBY5l3S96y4Qfk8mY/ecnMq
         kU4YaD6gXHGPSXSSMwxQtrPl6ZEg3u0c8qdIc+oAiatqPI3nqsWdtWoZoSsHpmirc/fR
         yCnzF82Hr8lggEpABlcLfjZPg0A+2z0LIP38ptrUbimyNmENWSTrtpmbi97ZBVJzb6FE
         X7JElCTYkWt5KtvdM1PFlSRNsM1x+6k9SlPKz8W4lwn/hCmXrpxAZX0yjOxgY7o9RcBK
         d/6OQxSP/2qQ8wbHPSRb7WU08KthzHAis9Di2E08NPvaX0+lfANcU69wv6GOS/PdcKrp
         gx0g==
X-Gm-Message-State: AOJu0YxOKK8CPekyixG7lDvwnqCCUvPo9c1wrzm9IbYRn1cdt23XaKxp
	FNIf2Fb+iC91daTeu2qEqrzFlcI9JP/HyFkmhGGTlIH0BzcOpM+OOKEHEapF/vQeWzkG/Z6NVhU
	wC7on9RFGj5irruqzRHJ/pzTdnVPpXzY=
X-Gm-Gg: AfdE7clBqZdXhhKPPDvUHbuL7hp7X3VqphkD2kuCInFAh1lN7U8H/dH5+9iB8iQA30J
	L4P8+B78Y+KFroR0EGTZ2YJhRLKUOg8Y0GihLKSeP09wbMfIGaSvGx8noVmM3V7Vp1JddrQfYD9
	WonSDBFtCq35/2UW25FMozxQiP3051e7EFgKFfhH3uOmE0gsMTSSW5mAslJcPN+0D/tWANYNq/k
	ohdMQmwliT0kjuWKVk73oMuMXjjqYLVsD4lGUmKuto1/scoSfcI+fiA6Sec6OA=
X-Received: by 2002:a05:6402:518b:b0:69c:2fc9:7ff2 with SMTP id
 4fb4d7f45d1cf-69e652e1d45mr3522793a12.19.1784442545386; Sat, 18 Jul 2026
 23:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430053645.1466196-1-coshi036@gmail.com> <xaqwfkwjnp7h2lg7ir6wy2tnyay26t3im3ftkdl64rhys3rhmu@lc5vfh5tc2f5>
In-Reply-To: <xaqwfkwjnp7h2lg7ir6wy2tnyay26t3im3ftkdl64rhys3rhmu@lc5vfh5tc2f5>
From: Chao S <coshi036@gmail.com>
Date: Sun, 19 Jul 2026 02:28:54 -0400
X-Gm-Features: AUfX_mxe7udDJapOGQ40fjXvt05h9YppgG9kxvJ_4xkKgMScMk7Us-_HpAMj1IA
Message-ID: <CACd_6n17-pJuNoCLsstP7goocedrr5F8T8BwTjRUNx8frKEPgA@mail.gmail.com>
Subject: Re: [PATCH v2] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	willy@infradead.org, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu 30-04-26 09:28:13, Jan Kara wrote:
> But it would be actually very welcome if you took the work, went through
> all the places using end_buffer_write_sync() and converted them in
> filesystem-by-filesystem to check for IO error by checking
> buffer_write_io_error() instead of buffer_uptodate() and then we can drop
> clear_buffer_uptodate() call from end_buffer_write_sync().

Sorry for the long delay, I've been working on some patches and a paper
deadline.  Also, you were right about v2, and I have dropped it.  I
would like to
take the conversion work.

Before writing it, I found your "fs: Fix missed inode write during fsync"
series, v4 of 16 July.  It removes four of the sites I had on my list, so
I will base this on top of it once it lands.  Say if you would rather
sequence it differently.

(end_buffer_write_sync() is now bh_end_write(), per b20f15420f78.  Current
names below; line numbers against v7.2-rc1.)

The sites, one patch each:

  core     fs/buffer.c:621 (mmb_sync), :2803 (__sync_dirty_buffer)
  adfs     fs/adfs/dir.c:194
  ext2     fs/ext2/xattr.c:772
  ext4     fs/ext4/ext4_jbd2.c:399, fs/ext4/mmp.c:52
  omfs     fs/omfs/inode.c:148, :162
  exfat    fs/exfat/misc.c:190
  fat      fs/fat/misc.c:358
  ocfs2    fs/ocfs2/buffer_head_io.c:69, :449, fs/ocfs2/journal.c:675, :691
  gfs2     fs/gfs2/log.c:110, :324
  jbd2     fs/jbd2/commit.c:880
  removal  fs/buffer.c:210 and :444

Conversions first, removal last.  The list is short because
__sync_dirty_buffer() and mmb_sync() test internally and return -EIO, so
the ~40 callers that use the return value need no edit of their own.

I would like your suggestions on the following.

1. BH_Write_EIO is sticky.  It is cleared only on rewrite
(fs/buffer.c:1196), and only if BH_Req was already set, which
BUFFER_FLAGS_DISCARD clears on its own.  So a converted test can see a
stale error.  I would fix this first, either by making the clear at :1196
unconditional for REQ_OP_WRITE, or by adding BH_Write_EIO to
BUFFER_FLAGS_DISCARD.  Which do you prefer?

2. jbd2: log_bufs is a mixed list.  Commit descriptors come from
journal_end_buffer_io_sync(), which never sets BH_Write_EIO; revoke
descriptors from write_dirty_buffer(), so bh_end_write().  I would convert
fs/jbd2/commit.c:880 to the disjunct !buffer_uptodate(bh) ||
buffer_write_io_error(bh).  The alternative is to add
mark_buffer_write_io_error() to journal_end_buffer_io_sync() and convert
all three jbd2 sites.  Which do you prefer?

3. bh_end_async_write() has the same clear at fs/buffer.c:444.  I would
remove both, which needs the gfs2 patch first since gfs2 reads that bit at
fs/gfs2/log.c:110 and :324.  I can also leave the async half out.

4. ocfs2: fs/ocfs2/journal.c:691 sits inside an outer
if (!buffer_uptodate(bh)) at :675, so dropping the clear stops ocfs2 going
read-only after a failed metadata checkpoint.  I would convert both sites
and Cc ocfs2-devel.

Build-tested only so far.

Chao

On Thu, Apr 30, 2026 at 3:28=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 30-04-26 01:36:45, Chao Shi wrote:
> > A WARN_ON_ONCE(!buffer_uptodate(bh)) in mark_buffer_dirty() is
> > reachable from the buffered write path on a block device when the
> > underlying device returns I/O errors at high density.  Reproduced
> > by fuzzing an NVMe controller (FEMU) that returns crafted error
> > completions for a sustained workload from /dev/nvme0n1.
> >
> > The contract documented at set_buffer_uptodate() in
> > include/linux/buffer_head.h reads:
> >
> >   Any other serialization (with IO errors or whatever that might
> >   clear the bit) has to come from other state (eg BH_Lock).
> >
> > In fs/buffer.c, BH_Uptodate can be cleared from four I/O completion
> > callbacks: __end_buffer_read_notouch, end_buffer_write_sync,
> > end_buffer_async_read, end_buffer_async_write.
> >
> > end_buffer_async_read() runs with BH_Lock held throughout, so its
> > clear is already serialized against any caller that also holds
> > BH_Lock around set_buffer_uptodate(); the call may in fact be
> > redundant, but addressing that is independent of this fix.
> >
> > end_buffer_write_sync() likewise holds BH_Lock while it clears
> > BH_Uptodate on the write-error path.  Removing that clear would
> > change long-standing buffer-cache I/O-error semantics and is out
> > of scope here.
> >
> > The race is therefore between block_commit_write() and
> > end_buffer_write_sync():
> >
> >   CPU A: block_commit_write              CPU B: end_buffer_write_sync
> >          (folio lock held, BH_Lock NOT)         (BH_Lock held)
> >     set_buffer_uptodate(bh);
> >                                            clear_buffer_uptodate(bh);
> >                                            unlock_buffer(bh);
> >     mark_buffer_dirty(bh);  /* WARN */
> >
> > CPU B observes the contract; CPU A does not.  With one side unlocked
> > the serialization is one-sided and ineffective: CPU A's set can be
> > immediately followed by CPU B's clear, tripping the WARN_ON_ONCE.
> > In the fuzzing reproducer, write-error completions are frequent
> > (visible as repeated "lost async page write" and per-LBA write
> > failures); buffer I/O completion callbacks on the write-error path
> > (e.g. end_buffer_write_sync, end_buffer_async_write) clear
> > BH_Uptodate while holding BH_Lock.
> >
> > The bug is not benign: a not-uptodate buffer can be marked dirty
> > and subsequently written back; depending on whether the buffer was
> > fully or partially covered by the user write, this can leave on-disk
> > content that does not match the intended buffered write state.
> >
> > Fix this by taking BH_Lock around set_buffer_uptodate() +
> > mark_buffer_dirty() in block_commit_write(), so both sides of the
> > contract use the documented serialization.
> >
> > Found by FuzzNvme (Syzkaller with FEMU fuzzing framework).
> >
> > Acked-by: Sungwoo Kim <iam@sung-woo.kim>
> > Acked-by: Dave Tian <daveti@purdue.edu>
> > Acked-by: Weidong Zhu <weizhu@fiu.edu>
> > Signed-off-by: Chao Shi <coshi036@gmail.com>
>
> Thanks for trying but this basically just silences the warning without
> addressing the real problem. Sure enough it silences the warning in
> mark_buffer_dirty() but effectively it just papers over the real problem =
-
> the IO completion with error can come the moment you unlock the bh and it
> will happily clear the uptodate bit, resulting in the same "dirty but not
> uptodate" invalid buffer state. So I actually prefer keeping things as th=
ey
> currently are so that we are reminded there is this unresolved issue.
>
> But it would be actually very welcome if you took the work, went through
> all the places using end_buffer_write_sync() and converted them in
> filesystem-by-filesystem to check for IO error by checking
> buffer_write_io_error() instead of buffer_uptodate() and then we can drop
> clear_buffer_uptodate() call from end_buffer_write_sync(). Yes, it is muc=
h
> more work but also much more useful.
>
>                                                                 Honza
>
> > ---
> > Hi Matthew, Hi Jan,
> >
> > Thanks for the review on v1.  v2 takes the feedback, quick notes below.
> >
> > To Matthew:
> >
> > You were right that the v1's timing diagram named the wrong racer.
> >
> > The actual race is with end_buffer_write_sync() on the write-error
> > path, as Jan pointed out -- it also clears BH_Uptodate under BH_Lock,
> > but block_commit_write()'s else branch was reaching set_buffer_uptodate
> > without BH_Lock, leaving the serialization one-sided.  v2's commit
> > message and in-code comment now name end_buffer_write_sync() as the
> > racer.
> >
> > To Jan:
> >
> > Thanks for confirming the racer and for the historical context on the
> > dirty + !uptodate state question.  v2 keeps the fix scoped to taking
> > BH_Lock in block_commit_write(); the broader semantic question and any
> > change to end_buffer_write_sync()'s clear is left out of scope here.
> >
> > The redundant lock_buffer/unlock_buffer that v1 added to the
> > buffer_new branch of __block_write_begin_int() is also dropped in v2 --
> > that bh has no in-flight async I/O so no race exists there.
> >
> > v1 thread for context:
> > https://lore.kernel.org/all/20260426020137.1221985-1-coshi036@gmail.com=
/
> >
> > Thanks,
> > Chao
> >
> > Changes in v2:
> >   - Drop the lock_buffer/unlock_buffer added in v1 to the buffer_new
> >     branch of __block_write_begin_int(): that bh is freshly BH_New
> >     and has no in-flight async I/O on it, so no race exists at that
> >     site.
> >   - Rewrite the commit message and the in-code comment to identify
> >     end_buffer_write_sync() as the actual racer, not
> >     end_buffer_async_read() as v1 claimed; end_buffer_async_read()
> >     holds BH_Lock across its clear so a caller that also holds
> >     BH_Lock would already be serialized.
> >   - Reference the BH_Lock contract at set_buffer_uptodate() in
> >     include/linux/buffer_head.h explicitly.
> >   - Drop verbose line-number citations and the WARN stack dump from
> >     the commit message; tighten wording around reproducer evidence
> >     and on-disk impact.
> >
> > v1: https://lore.kernel.org/all/20260426020137.1221985-1-coshi036@gmail=
.com/
> >
> >  fs/buffer.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 4d7f84e77d2..6fddb2f1e7c 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -2104,8 +2104,22 @@ void block_commit_write(struct folio *folio, siz=
e_t from, size_t to)
> >                       if (!buffer_uptodate(bh))
> >                               partial =3D true;
> >               } else {
> > +                     /*
> > +                      * Per the contract documented at set_buffer_upto=
date()
> > +                      * in include/linux/buffer_head.h, callers must h=
old
> > +                      * BH_Lock to serialize against concurrent clears=
 of
> > +                      * BH_Uptodate.  Holding only the folio lock is n=
ot
> > +                      * sufficient: a concurrent end_buffer_write_sync=
() on
> > +                      * the write-error path clears BH_Uptodate while
> > +                      * holding BH_Lock; without BH_Lock here the clea=
r can
> > +                      * land between set_buffer_uptodate() and
> > +                      * mark_buffer_dirty(), tripping the WARN_ON_ONCE=
 in
> > +                      * mark_buffer_dirty().
> > +                      */
> > +                     lock_buffer(bh);
> >                       set_buffer_uptodate(bh);
> >                       mark_buffer_dirty(bh);
> > +                     unlock_buffer(bh);
> >               }
> >               if (buffer_new(bh))
> >                       clear_buffer_new(bh);
> >
> > base-commit: ffe69af1f87fa77da975ad4b0b093d48c3cbe6c3
> > --
> > 2.43.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
