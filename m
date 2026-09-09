Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC17179A3
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919701; cv=none; b=k39ozqTUvPcrnpluXMfupb/6IEzAdosphp8BWggaDAbNM1pFwaBum2qRNZ2h7PJ3C1bTSz4TTkweO/MQ6bFi+++Hw3SNF7LxHPX6yvGAkYIciH97Q0ZCvtvcq8+tyyG/wIjcQKbMb+APwz9oEgCCY228uZthul4V58s6nUHnBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919701; c=relaxed/simple;
	bh=ubDYaYOICJ4YWD/Jj98sNQ6dSD4fMGJQJzt5G0uu5ZY=;
	h=Content-Type:To:From:References:In-Reply-To:Mime-Version:Date:
	 Message-Id:Cc:Subject; b=TBND2i8YKbMCH7e8cBZq0wcc/n5lUNwRQJL3GugHvRdacCzSGCwczNEZbH1Hz9ma/57UGXP0hVHJJ12El8JKkYa4RwMzYM/zz5mXTETGTHOhSMgNDFkLXSkgJGOQQhkngVDTR55/E34T8jaXXN/86qlzdKKkbE64m1OU7cA3UJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TnGYa4rn; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TnGYa4rn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788919693; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ubDYaYOICJ4YWD/Jj98sNQ6dSD4fMGJQJzt5G0uu5ZY=;
 b=TnGYa4rnvVdcHrL02CF6jhH0MNjvbm2Cr7nkcDf7Q0NnRtJQKrmnVkjXv15As9iHzkuTjY
 gUQ3iTMXVcHN2YOu/KBjKLWlm2k+oKypLXRMM/IglDZkyUpskTVZ1dH7AT56yPN0/WhHD1
 yf0wpkH2KNHiWjmCSZ60NdTzC4BcWN4NoofFn0ycPnsjAOq6h4drEv54MqCf26s3x33Nvx
 zmEnJKZFcz1AO4gcwoIhHeVjIQYvJr3UNjD+EOXmVzEd4PzYGkBZflB3HeEVf09MT6+Gd1
 ujmQF9Mww1DgEsJcXApGqc6l/AHo/2RNeJ7UQ50VxsJ3dliGX/LdbfoUr+8MdQ==
Content-Type: text/plain; charset=UTF-8
To: "Jan Kara" <jack@suse.cz>
From: =?utf-8?q?=E5=B0=B9=E6=AC=A3?= <yinxin.x@bytedance.com>
References: <cover.1788836830.git.yinxin.x@bytedance.com> <dce170b76e9501d555b0af70cc8c45c248577400.1788836830.git.yinxin.x@bytedance.com>
	<matvd3klv4w7buhnjkdpllkautw3zu2e5hpjfdedvvoozpbfxj@z7joalz5an74>
In-Reply-To: <matvd3klv4w7buhnjkdpllkautw3zu2e5hpjfdedvvoozpbfxj@z7joalz5an74>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16aa0bf8c+d1252a+vger.kernel.org+yinxin.x@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 10:08:08 +0800
Message-Id: <b0a5d388d0b2cb320744535d7f9d8f59e469aa88.aa79b65b.6b2f.41be.bcbf.08bf9deeb395@bytedance.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, 
	"Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, 
	"Tejun Heo" <tj@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] writeback: snapshot foreign flush pages


> From: "Jan Kara"<jack@suse.cz>
> Date:=C2=A0 Tue, Sep 8, 2026, 19:01
> Subject:=C2=A0 Re: [PATCH v1 2/2] writeback: snapshot foreign flush pages
> To: "Xin Yin"<yinxin.x@bytedance.com>
> Cc: "Alexander Viro"<viro@zeniv.linux.org.uk>, "Christian Brauner"<braune=
r@kernel.org>, "Jan Kara"<jack@suse.cz>, "Tejun Heo"<tj@kernel.org>, "Jens =
Axboe"<axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>, <linux-kernel@vge=
r.kernel.org>
> On Tue 08-09-26 11:23:52, Xin Yin wrote:
> > WB_REASON_FOREIGN_FLUSH is best-effort writeback for foreign dirtying. =
It
> > should write pages that are already visible to the target wb, but shoul=
d
> > not keep extending the same work with pages dirtied while the work is
> > running.
> >=C2=A0
> > Make foreign flushes use tagged writeback while preserving WB_SYNC_NONE
> > semantics. Use the remaining work budget as the per-inode chunk, so a
> > tagged pass is not truncated to the normal periodic chunk and a large
> > inode still cannot exceed the finite work budget.
> >=C2=A0
> > Queue b_dirty only once for each foreign-flush work. Later passes only
> > retry b_more_io inodes skipped due to I_SYNC, and the work exits once
> > b_io and b_more_io are drained. If the budget is consumed, redirty the
> > inode instead of requeueing it to b_more_io so the same work cannot loo=
p
> > on a continuously dirtied inode.
> >=C2=A0
> > Do not refresh dirtied_when for foreign flushes; later dirtying should =
be
> > handled by later foreign, kupdate, or background writeback.
> >=C2=A0
> > Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushin=
g")
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
>=C2=A0
> I really dislike how your implementation ties the two writeback deadlock
> avoidance schemes (nr_to_write for WB_SYNC_NONE writeback vs folio taggin=
g
> + inode dirty timestamp for WB_SYNC_ALL writeback) together. But before w=
e
> get to the implementation details let's discuss the purpose a bit:
>=C2=A0
> In principle I agree with you that the primary purpose of
> cgroup_writeback_by_id() is that it wants to flush inodes that have folio=
s
> that are accounted to our memcg. It does this by a rather rough approach =
of
> flushing the whole wb. If this races with other dirtying, it might happen
> that we won't actually flush the foreign folios we want. Am I getting you=
r
> concern right? Are you able to actually observe such situation in practic=
e?
Hi Jan,

Yes, that's the concern. Concurrent dirtying could consume the work's budge=
t without sufficiently flushing the foreign folios charged to the memcg we'=
re trying to help.

We haven't confirmed that specific situation in production. What we've obse=
rved is long-running foreign work with many subsequent works queued behind =
it. We haven't traced the original source memcg's folios closely enough to =
show that they were left dirty because newly dirtied pages consumed the bud=
get. So that part is still a concern, not an observed failure.

The idea behind combining the two approaches was to get the budget right fo=
r the target wb, while keeping the flush from chasing concurrent dirtying. =
The first is about not holding up later work on the same wb, including sync=
fs. There's also a fairness concern: an old inode can keep getting newly di=
rtied pages written while later-dirtied inodes have to wait for another wor=
k. The second is about making the flush more useful to the source memcg, al=
though tagging alone doesn't guarantee that its folios get flushed.

I see your concern about mixing the two mechanisms, though. Would you sugge=
st keeping the budget-only approach for now, or is there a simpler way to a=
ddress the concurrent-dirtying concern?

Thanks
Xin Yin
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Honza
>=C2=A0
> > ---
> > =C2=A0fs/fs-writeback.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 57 ++++++++++++++=
++++++++++++++++---------
> > =C2=A0include/linux/writeback.h | =C2=A01 +
> > =C2=A02 files changed, 45 insertions(+), 13 deletions(-)
> >=C2=A0
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 7c2340a5dead..6c5d1c85b6f8 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -40,6 +40,7 @@ struct wb_writeback_work {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct super_block *sb;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum writeback_sync_modes sync_mode;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int tagged_writepages:1;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int for_foreign_flush:1;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int for_kupdate:1;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int range_cyclic:1;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int for_background:1;
> > @@ -1174,6 +1175,12 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg=
_id,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (work) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0work->nr_=
pages =3D dirty;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0work->syn=
c_mode =3D WB_SYNC_NONE;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Foreign flu=
shes should write a snapshot of dirty pages without
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * chasing con=
current dirtiers, but still honor the finite target
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * wb budget c=
alculated above.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0work->for_fore=
ign_flush =3D 1;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0work->ran=
ge_cyclic =3D 1;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0work->rea=
son =3D reason;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0work->don=
e =3D done;
> > @@ -1553,18 +1560,21 @@ static int move_expired_inodes(struct list_head=
 *delaying_queue,
> > =C2=A0 * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 +--> dequeue for IO
> > =C2=A0 */
> > =C2=A0static void queue_io(struct bdi_writeback *wb, struct wb_writebac=
k_work *work,
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 unsigned long dirtied_before)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 unsigned long dirtied_before, bool queue_dirty)
> > =C2=A0{
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0int moved;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0int moved =3D 0;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long time_expire_jif =3D dir=
tied_before;
> > =C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert_spin_locked(&wb->list_lock);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_splice_init(&wb->b_more_io, &wb-=
>b_io);
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0moved =3D move_expired_inodes(&wb->b_dirty=
, &wb->b_io, dirtied_before);
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!work->for_sync)
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time_expire_ji=
f =3D jiffies - dirtytime_expire_interval * HZ;
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0moved +=3D move_expired_inodes(&wb->b_dirt=
y_time, &wb->b_io,
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time_expire_jif);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (queue_dirty) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0moved =3D move=
_expired_inodes(&wb->b_dirty, &wb->b_io,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dirtied_before);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!work->for=
_sync)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0time_expire_jif =3D jiffies - dirtytime_expire_interval * HZ;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0moved +=3D mov=
e_expired_inodes(&wb->b_dirty_time, &wb->b_io,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 time_expire_jif);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (moved)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wb_io_lis=
ts_populated(wb);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_writeback_queue_io(wb, work, di=
rtied_before, moved);
> > @@ -1651,11 +1661,13 @@ static void requeue_inode(struct inode *inode, =
struct bdi_writeback *wb,
> > =C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Sync livelock prevention. Each ino=
de is tagged and synced in one
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 * shot. If still dirty, it will be redirt=
y_tail()'ed below. =C2=A0Update
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the dirty time to prevent enqueue and s=
ync it again.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * shot for WB_SYNC_ALL or unbudgeted tagg=
ed writeback. If still dirty,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * it will be redirty_tail()'ed below. Upd=
ate the dirty time to prevent
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * enqueue and sync it again.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((inode_state_read(inode) & I_DIRT=
Y) &&
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(wbc->sync_mode =3D=3D WB_SY=
NC_ALL || wbc->tagged_writepages))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(wbc->sync_mode =3D=3D WB_SY=
NC_ALL ||
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (wbc->tagged_writepages && =
!wbc->for_foreign_flush)))
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode->di=
rtied_when =3D jiffies;
> > =C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (wbc->pages_skipped) {
> > @@ -1678,6 +1690,7 @@ static void requeue_inode(struct inode *inode, st=
ruct bdi_writeback *wb,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * someti=
mes bales out without doing anything.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (wbc->=
nr_to_write <=3D 0 &&
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
!wbc->for_foreign_flush &&
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0!inode_dirtied_after(inode, dirtied_before)) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* Slice used up. Queue for next turn. */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0requeue_io(inode, wb);
> > @@ -1918,6 +1931,8 @@ static long writeback_chunk_size(struct super_blo=
ck *sb,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (quickly) tag currently dirty pages
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (maybe slowly) sync all tagged pages
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (work->for_foreign_flush)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return work->n=
r_pages;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (work->sync_mode =3D=3D WB_SYNC_AL=
L || work->tagged_writepages)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return LO=
NG_MAX;
> > =C2=A0
> > @@ -1943,7 +1958,9 @@ static long writeback_sb_inodes(struct super_bloc=
k *sb,
> > =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct writeback_control wbc =3D {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.sync_mod=
e =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D work->sync_mod=
e,
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.tagged_writep=
ages =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D work->tagged_writepages,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.tagged_writep=
ages =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D work->tagged_writepages ||
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0work->for_foreign_flush,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.for_foreign_f=
lush =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D work->for_foreign_flush,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.for_kupd=
ate =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D work->for_ku=
pdate,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.for_back=
ground =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D work->for=
_background,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.for_sync=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D work->for_sync,
> > @@ -2141,7 +2158,7 @@ static long writeback_inodes_wb(struct bdi_writeb=
ack *wb, long nr_pages,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blk_start_plug(&plug);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&wb->list_lock);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (list_empty(&wb->b_io))
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queue_io(wb, &=
work, jiffies);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queue_io(wb, &=
work, jiffies, true);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__writeback_inodes_wb(wb, &work);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&wb->list_lock);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blk_finish_plug(&plug);
> > @@ -2202,6 +2219,13 @@ static long wb_writeback(struct bdi_writeback *w=
b,
> > =C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock=
(&wb->list_lock);
> > =C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (queued && =
work->for_foreign_flush &&
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
list_empty(&wb->b_io) &&
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
list_empty(&wb->b_more_io)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0spin_unlock(&wb->list_lock);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > +
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_wri=
teback_start(wb, work);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (list_=
empty(&wb->b_io)) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/*
> > @@ -2217,7 +2241,14 @@ static long wb_writeback(struct bdi_writeback *w=
b,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0} else if (work->for_background)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirtied_before =3D jiffies;
> > =C2=A0
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0queue_io(wb, work, dirtied_before);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/*
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 * After the initial queue_io() pass, a foreign flush may
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 * still have I_SYNC-skipped inodes on b_more_io. =C2=A0Move
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 * those back to b_io without selecting another batch from
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 * b_dirty.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0queue_io(wb, work, dirtied_before,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !work->for_foreign_flush || !que=
ued);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0queued =3D true;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (work-=
>sb)
> > diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> > index e530112c4b3a..096f0963d104 100644
> > --- a/include/linux/writeback.h
> > +++ b/include/linux/writeback.h
> > @@ -59,6 +59,7 @@ struct writeback_control {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned for_kupdate:1; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* A kupdate writeback */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned for_background:1; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* A background writeback */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned tagged_writepages:1; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* tag-and-write to avoid livelock */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned for_foreign_flush:1; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* foreign dirty flushing */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned range_cyclic:1; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* range_start is cyclic */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned for_sync:1; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* sync(2) WB_SYNC_ALL writeback *=
/
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned unpinned_netfs_wb:1; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* Cleared I_PINNING_NETFS_WB */
> > --=C2=A0
> > 2.20.1
> --=C2=A0
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>=C2=A0
