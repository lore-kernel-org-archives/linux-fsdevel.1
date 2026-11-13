Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794537814;
	b=FDNlTWnjnYvI6+ouaMKEViYpDJEabNla4GTdLEYg62TfIweTRUkl1NDzV/8PPLoSXL+T
	 jpxLqfVm+XcVMtR/6YkuN9jOZuXWhCVP9vFpc5i0IYNKdQCGSrNY2+2GqhrUZ2fWjhD3j
	 YI0zno0WMMVG5rL8hWLphw5RqEiNlnZCbcK3dWzlulR7Zo03ZbZi34LovZ79e2Rlds7UU
	 b5H5FIGal7eHrYwA7mbFhGczGy0HLZi5oUD54p/+A9vKINqMZ2N/bX/eaT2XJCKZ3xMAo
	 ZwRCDRcBO+RuSceMaXqqQ3iv0bLMES9NdUhvBvO3qKaLCgBVgk3UY3k7SWxx/Sa1RXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iRwkd5j0tilTD7xDUiozRivLLF250AVqWFPnza6O7Ts=;
	b=b12KbyRKKxvhdrqQDiGUSGgqAqfeleN/sQ/2ReJ0sLM5cqMalrIfgDkB8hdbvyNc1s9a
	 wRirsC97ngELnj3OHtKjTlPtFUNweuaIrV4cF31KCBlmasMG/5N+JTfUEtvulC6nqlDVt
	 +l0spy9HLVzGSAPDgW2SIukoQpFnJIfy8k5cloD+oLitlcoFV+fEmR+AL43z/8Xs9T98q
	 lGXTZ3Z1zHJgyL04JPoE3QuSW2XgitDNTCIvS5r2gFD0s9JqsaHxADib5gh25Y6WSAccP
	 qo68hnjICVg0CncwWsyMuqdx0Ao3apUNo/G+/+MbIvNM4AwzEuBUF8cCVW5cAfuJrcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hsUfBl+v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8923E606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8923E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hsUfBl+v
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ebf4cd218so8930506d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 18:43:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794537812; cv=none;
        d=google.com; s=arc-20260327;
        b=k7b1EhCNFVG0ICK2IOG8m5l9e2n68wFCAQSi3frPu/Qm2tLw1gqZMVow868D09KkMw
         quF6hWRtqpVpnFBvASGHHSZMSQJGTPB5DmlS9H1jCImiruE+ryUG5Opj+nKRYVGIh+Hu
         MxRPj+c5p2RKebgOn9R7bdIuRMtF1DiM27g9AtOQXxmpPUFmD44/Pe52uqGPgHAPap+u
         vOIC7FjojD61iyLMyOqPjEaZEgga6jgn3H9iQLnC92ay4KZkOZpe2iGsuwwsgKBIBzSW
         FkT+01fc9QVfhfIM0PTIdWNTLgpBB+9gm3CYkYAkIIQqCzuxHSPD0xb7FN0SrrlVcKRQ
         /XKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iRwkd5j0tilTD7xDUiozRivLLF250AVqWFPnza6O7Ts=;
        fh=rwT2tGf9SXoziaSrdgTUECPg6uO5lpIr3NdFvhCW2yA=;
        b=sAVsHDY+sg+gl/fegjALGxAYFD4jiiEtzPYBn4U7AVOXudj0u8c8yh+vlL7fRfmJ9b
         9PZnrNSRsNDEqoMBE9af0nKHM0u+8a2SKVdUVuJxajQ0603f7SURLrcdx5A8Z2OJ79jD
         D7KyQinFTiIaWO6eXREhFWPeDI8UHu8pFBzvJLPp4zLZAaNuhWSzC+NOFADEkvvwnMBq
         4LZvCxZSGcJkwIm7hepcQnxkh/OFXbVekxRYCudl2ssM1F8IeRyJwh65V5N79R8Y9xPy
         biKf/08rjCrSeg33Es0+mez3+by6d0uTqSYrlmK0O3WSj4WFXJiuXjxW5BiloiRLy6kY
         Xrcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794537812; x=1795142612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iRwkd5j0tilTD7xDUiozRivLLF250AVqWFPnza6O7Ts=;
        b=hsUfBl+vMGnBB+Kzl+uj0IOtWEqxSAE2E2ec8bZmwJrfrOVtHOViEVmjB7GubsMC8H
         jYMxut4i/w5jZ4DdGsJqAsHdlUBn2U54/WHmCOiw1hItASqMhN+Rijyt+HQ2kmPrOAbR
         5Bt/OxY5TVSLuV0I5HnJgd5k+i+M5euT150ToyGEHIaeLuZSaoP4dleG5viYGcSgUTAq
         +SPqFGB6B9Ho46qjlMsBQv/Hyt6zwm58J1qLtd4N1otnecfwt8enbY4ddOcpqYbXE9zT
         StTduT5K76v8ffM5ZYP1CdPJiLcESXQf0uJ39jVLuL5ar4ZFDMrdL1GI2a9KqxUaaOaO
         JxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794537812; x=1795142612;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iRwkd5j0tilTD7xDUiozRivLLF250AVqWFPnza6O7Ts=;
        b=nmLq0Q8GsFQK1Pj4HBODPVQ1bsd07uq9RYlnBrZ3FH/O0Jo6vgrb9tceLSv9pHhMSW
         4QMoPIdMKMAJeRkKOxnT5SQis8DlGPn942etHhxC9xrs45TZU6Ky7hsgjsSlS8RCRbtI
         xr2gSR24Q22FKMyTXCbHTl8XchScf7wCZ8xBOUzKim1arYXyori/RoCWJ4ekkpop3f3u
         YBx5ms4tluPUtJIvZoRcunMRkXwyxv0oiQlJP9tF7TcFgA5iWOTfibhd1XqMgQD/bVLS
         10weToDWJFtHI9Ics/rnkPfdbrPdN0k8mQpvLr3SjoocV0N+NdFwdIyLfAmdG97k+p1K
         hr8w==
X-Forwarded-Encrypted: i=1; AL+hErFgM1VD7r/7rI0ioW+kJxfeIkdRL++lTLZmOilIRG5dLQzVdrYdJNpS5h3JAukkWx8xSmLldFhvdPTmFKaQ@vger.kernel.org
X-Gm-Message-State: APuU4Z/gnj0Adf+425NOdukyV5pOQ44Z3vhpr1W9GRI0J8TolB02wPmH
	mnySD7U1v2R0IrCin95/3SuGvl9Ij8fXHBrxf0I9rvRKJOZh3R79XZ6+70o+BwC7VbaNEYVsHjm
	4pOiypIwnTrsqIZGMuy7BE3QEdhb5s+Z6PDoeQGo=
X-Gm-Gg: AYBFou1xQ8tKBO9hOKbE1kHnYWVK8h/jmp5BMlqQKGCqqbG7v/JdER79WwtFnyjm/rh
	+xCPVBPxNcVkjcwZ0UfMAmUCo8XqcUBip9Ap30D8LK8OtAUW/n64FinIxe7a2QDQ4MQgqHuX6wG
	YuawLYYc+8OwozTs9dYBm+/wi+gl8+Pgd20QgmsGoS6N7q+zwz0prutdOfBU2jMTHAPmEhPhVro
	wolCJOr1zQIGutFSQew+cMRqEH6qbhve46qMKH0ZNuXZbbniDnJRah8qerrXTP9y7qBe3kdkPMI
	tMEaxDL9+vkvICUN5vslTIteCSgacvgjMyjpZKhE5bQeTc14T9JVof6B1okfQf03RdwUY2wXznQ
	fpH2E5/bAK3CDdrVVMnKESDIVuy/ZZNXFVwMcB+QkQWzLYj4b+GMRxi4QtYw=
X-Received: by 2002:a05:6214:3b85:b0:91c:15ce:66ce with SMTP id
 6a1803df08f44-91f24194ac5mr22430326d6.11.1794537812283; Thu, 12 Nov 2026
 18:43:32 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <azdwnedsaesxdsp6vxjxgzg6ynrszveibmqkpznn3yuqyttlcj@5lz4p2aw5hxk>
 <20261029015217.840177-1-hongyu.jin@unisoc.com> <j77bd4foxrzipxiyute77hoc6vgszevpre2vifpfnaqwetpavf@36z37lyzaz34>
In-Reply-To: <j77bd4foxrzipxiyute77hoc6vgszevpre2vifpfnaqwetpavf@36z37lyzaz34>
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
Date: Fri, 13 Nov 2026 10:43:21 +0800
X-Gm-Features: AclHuK85LuEtQasXtPEifI9OxvXGrGy15ONN5ztZCEyt4LasgqOqXg5xN_TBFeI
Message-ID: <CAMQnb4PNr724WVV4-N-2XoKgbgXCMD0O9qNfDR6ejknqRX8TQQ@mail.gmail.com>
Subject: Re: [PATCH v2] writeback: Avoid postponing periodic data writeback indefinitely
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2026=E5=B9=B411=E6=9C=8813=E6=97=A5=E5=91=
=A8=E4=BA=94 02:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu 29-10-26 09:52:17, Hongyu Jin wrote:
> > From: Jan Kara <jack@suse.cz>
> >
> > f2fs periodically calls sync_inode_metadata() for some inodes. The logi=
c
> > in writeback_single_inode() thus periodically calls to redirty_tail() a=
nd
> > the inode's dirtied_when timestamp never gets old enough for the inode
> > to be eligible for periodic data writeback. Thus dirty data from it is
> > only ever written on explicit request (fsync(2), sync(2), unmount) or
> > on dirty limit pressure.
> >
> > The redirty_tail() logic in writeback_single_inode() actually should no=
t
> > be necessary. Since this function is used only for once-off writeback,
> > there's no need for any livelock protection among inodes and
> > writeback_single_inode() is only responsible for demoting inode to "les=
s
> > dirty" list based on dirty bits cleared as a result of writeback. So
> > remove the redirty_tail() logic and add a comment explaining the rules.
> >
> > The redirty_tail() did hide a race though, the one fixed by
> > commit 846a3351ddfe ("writeback: Avoid skipping inode writeback").
> > __writeback_single_inode() sets I_DIRTY_PAGES again when the mapping
> > is still tagged dirty. If the inode had no I_DIRTY bits (e.g.
> > write_inode_now(inode, 0) or sync_inode_metadata(inode, 0) of an inode
> > with only I_DIRTY_TIME), the dirty pages come from a racing writer,
> > whose __mark_inode_dirty() then finds I_DIRTY_PAGES set and does not
> > queue the inode, leaving it on b_dirty_time or b_attached. Call
> > __mark_inode_dirty() in that case instead, so that the inode gets queue=
d
> > on b_dirty.
> >
> > Fixes: 846a3351ddfe ("writeback: Avoid skipping inode writeback")
> > Reported-by: Hongyu Jin <hongyu.jin.cn@gmail.com>
> > Link: https://lore.kernel.org/all/20261023023707.263101-1-hongyu.jin@un=
isoc.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > [hongyu.jin: let __mark_inode_dirty() queue an inode whose pages were
> >  dirtied while it had no I_DIRTY bits, update comments]
> > Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
>
> I wasn't still happy with this solution so I was pondering for quite a
> while about a cleaner solution. Finally, I've come up with a patch I like
> and which should fix the race you have found. Some testing is still runni=
ng
> on my side but I'm attaching it already now in case you want to run testi=
ng
> on your side as well. Thanks for your patience!
>
>                                                                 Honza
>
https://lore.kernel.org/all/j77bd4foxrzipxiyute77hoc6vgszevpre2vifpfnaqwetp=
avf@36z37lyzaz34/2-0001-writeback-Avoid-postponing-periodic-data-writeback-=
i.patch
Thank you for your efforts. I tested your newest patch and it worked fine

> > ---
> >  fs/fs-writeback.c | 60 +++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 43 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 58a6403780aa..c7979b0cd375 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1780,7 +1780,9 @@ bool sync_lazytime(struct inode *inode)
> >   *
> >   * This doesn't remove the inode from the writeback list it is on, exc=
ept
> >   * potentially to move it from b_dirty_time to b_dirty due to timestam=
p
> > - * expiration.  The caller is otherwise responsible for writeback list=
 handling.
> > + * expiration, or to queue it on b_dirty via __mark_inode_dirty() when=
 its
> > + * pages were dirtied while it had no I_DIRTY bits.  The caller is oth=
erwise
> > + * responsible for writeback list handling.
> >   *
> >   * The caller is also responsible for setting the I_SYNC flag beforeha=
nd and
> >   * calling inode_sync_complete() to clear it afterwards.
> > @@ -1790,6 +1792,7 @@ __writeback_single_inode(struct inode *inode, str=
uct writeback_control *wbc)
> >  {
> >       struct address_space *mapping =3D inode->i_mapping;
> >       long nr_to_write =3D wbc->nr_to_write;
> > +     bool mark_pages =3D false;
> >       unsigned dirty;
> >       int ret;
> >
> > @@ -1843,12 +1846,23 @@ __writeback_single_inode(struct inode *inode, s=
truct writeback_control *wbc)
> >        * still has dirty pages.  The flag is reinstated after smp_mb() =
if
> >        * necessary.  This guarantees that either __mark_inode_dirty()
> >        * sees clear I_DIRTY_PAGES or we see PAGECACHE_TAG_DIRTY.
> > +      *
> > +      * If the inode had any I_DIRTY bits, __mark_inode_dirty() has al=
ready
> > +      * queued it (if it is to be queued at all) and we can just reins=
tate
> > +      * I_DIRTY_PAGES.  Otherwise the pages were dirtied by a racing w=
riter
> > +      * and the inode may sit on b_dirty_time or b_attached.  Setting =
the
> > +      * flag here would make the writer's __mark_inode_dirty() bail ou=
t
> > +      * without queueing the inode, so let __mark_inode_dirty() set it=
 and
> > +      * queue the inode instead.
> >        */
> >       smp_mb();
> >
> > -     if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> > -             inode_state_set(inode, I_DIRTY_PAGES);
> > -     else if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB)) =
{
> > +     if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
> > +             if (dirty)
> > +                     inode_state_set(inode, I_DIRTY_PAGES);
> > +             else
> > +                     mark_pages =3D true;
> > +     } else if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB)=
) {
> >               if (!(inode_state_read(inode) & I_DIRTY_PAGES)) {
> >                       inode_state_clear(inode, I_PINNING_NETFS_WB);
> >                       wbc->unpinned_netfs_wb =3D true;
> > @@ -1858,6 +1872,9 @@ __writeback_single_inode(struct inode *inode, str=
uct writeback_control *wbc)
> >
> >       spin_unlock(&inode->i_lock);
> >
> > +     if (mark_pages)
> > +             __mark_inode_dirty(inode, I_DIRTY_PAGES);
> > +
> >       /* Don't write the inode if only I_DIRTY_PAGES was set */
> >       if (dirty & ~I_DIRTY_PAGES) {
> >               int err =3D write_inode(inode, wbc);
> > @@ -1946,22 +1963,31 @@ static int writeback_single_inode(struct inode =
*inode,
> >        * as it can be finally deleted at this moment.
> >        */
> >       if (!(inode_state_read(inode) & I_FREEING)) {
> > +             enum inode_state_flags_enum istate =3D inode_state_read(i=
node);
> > +
> >               /*
> > -              * If the inode is now fully clean, then it can be safely
> > -              * removed from its writeback list (if any). Otherwise th=
e
> > -              * flusher threads are responsible for the writeback list=
s.
> > +              * __mark_inode_dirty() is responsible for promoting inod=
e to
> > +              * the proper list (b_attached -> b_dirty_time -> b_dirty=
).
> > +              * Here we are responsible for demoting inode after some =
dirty
> > +              * bits were cleared.
> > +              *
> > +              * If the inode is now fully clean, then it can be safely=
 moved
> > +              * to b_attached list. If the inode is dirty, we don't wa=
nt to
> > +              * touch it - it should be already put to the dirty list =
by
> > +              * __mark_inode_dirty() and we'd just unnecessarily clobb=
er the
> > +              * dirtied_when stamp (which is particularly problematic =
when
> > +              * we were called from sync_inode_metadata()). We also ca=
nnot
> > +              * touch the dirty list association when I_SYNC_QUEUED is=
 set
> > +              * and flush worker is responsible for it. Otherwise move=
 the
> > +              * inode to b_dirty_time list as that's the only remainin=
g
> > +              * possibility.
> >                */
> > -             if (!(inode_state_read(inode) & I_DIRTY_ALL))
> > +             if (!(istate & I_DIRTY_ALL))
> >                       inode_cgwb_move_to_attached(inode, wb);
> > -             else if (!(inode_state_read(inode) & I_SYNC_QUEUED)) {
> > -                     if ((inode_state_read(inode) & I_DIRTY))
> > -                             redirty_tail_locked(inode, wb);
> > -                     else if (inode_state_read(inode) & I_DIRTY_TIME) =
{
> > -                             inode->dirtied_when =3D jiffies;
> > -                             inode_io_list_move_locked(inode,
> > -                                                       wb,
> > -                                                       &wb->b_dirty_ti=
me);
> > -                     }
> > +             else if (!(istate & I_SYNC_QUEUED) && !(istate & I_DIRTY)=
) {
> > +                     WARN_ON_ONCE(!(istate & I_DIRTY_TIME));
> > +                     inode->dirtied_when =3D jiffies;
> > +                     inode_io_list_move_locked(inode, wb, &wb->b_dirty=
_time);
> >               }
> >       }
> >
> > --
> > 2.53.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
