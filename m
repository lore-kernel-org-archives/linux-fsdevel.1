Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A49304BDC
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779855186; cv=pass; b=CRn26A0/rjUm0zTxYemZWsc6+nNwFH6XzA3ivKERL91Y9amaqg9Goe4epc9QLmcXU5uoLeauMgzp/Rl0b/G6Y9yBmcS7y9DS0r9rxZYJkj3KcRJepEIQecFmkjFbP+sFqIs901t6U83xjRDezSEOcjO83Fz5RuCC4CGcdeveayQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779855186; c=relaxed/simple;
	bh=rK5qEgI+ayIosJ4JrzScRyJ0Tg6kjMJCfjufW1kWoMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2MXrtlegmXeCUi9gylKmXtvyMYlSjSKjCqfv0sjXBb/rZXTtsrh8IOoKtNFovuheTUAI6FPbX6ySIvd8R1WQRRwwGEKmN/954FXt90xC4bsYJdzGvT2LP8Bzf7F5BU15Ituk6p71a1XHIkdiFxKUNzp+NJQKEegmkiLAcu1io0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYnRkW/2; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYnRkW/2"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43fe62837baso6600459f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 21:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779855183; cv=none;
        d=google.com; s=arc-20240605;
        b=RX+APiCayKw3r2ORj07v/grokbc+WinixinWzjJpgPImPb+YyAVdNfD0dbsA5Cnmhb
         q4MJB5uxyAyMzJJZ9HKDcnKRfyhvcv59KJ25ADyD5NYQnotYoeHb0tOP6hVTeI5rs7MM
         3J48T8RwDL/dg8yc4AyA2BvyAJRnBmY74F5oi60k8gFmtEEORIPhXGZrhvoIc52q5j3A
         VM1Fiq/Ak0rz5ZoqBKKyyl4JeKFOKWZhENm4OtBO5vj9Z6GY7NHXAvaj9j7Rv3d4vSWm
         qbK7ffghb5aOlrwVNCKfzsCc1w6Pgh0TrcWOANp6I3Gjv0R/yzbUT6NSKpOwqc9gLJpx
         OUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PQh95HH5EUt2hdoybPfMx/605ecf+e0yU2uPrQaxulU=;
        fh=ZkT6qPhuDds8eazx3BV4SLsjnJ2aiaHJ/fEHxCetT80=;
        b=SREIfFiVrhyAz5uZR14x3MnoNaDUc3+/xhmIOEWSlc5dfV7lPlOv/K+iD9aVUa5B6b
         j/62PJ897tyRrzo2v4LVspfLvH3n6Pm5dFsy8KXGHVaEeHwITi86RMK4q628fvuDJkRR
         1WvsgZhwk/aqFbbigR4JkWWe7ibY+6nEAb0s2FJFNa5YGxKE8H4iuXeet+awVzhApsg4
         ZGzjbSV5wJAIfpKEalocoE1zHqodwTQJB+TAyRQKBi44ijlzIBqjRfWA3DAhUlY0dJvV
         6v2RQDdPvnhMSOMJPnMXI0bpB2BFrlsPQX/lFg8j0c+ceuDNkBZnJjKVd8KK5ey1zJWX
         UKBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779855183; x=1780459983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQh95HH5EUt2hdoybPfMx/605ecf+e0yU2uPrQaxulU=;
        b=OYnRkW/2yYLjfdjk3eBV3GRRVV8IlKINksjc8wIE+6qz5cwgLoyq/Xpyti+Toj18y2
         0pZfJwqsdCD//IxaHQCBwtOuINX9lDR+ge09f6nPtmsFDhYPb+i+ETe6gVkQnMuGtiL/
         xICJNnLHnMjeTB6GGyw67i89EP9aQNDZQGcJ+JaTzKksFexT8hFFmzwagf1fNZjl24q3
         aFdhwLWFa3bXP8ihLW3lc0sL0ADLENgxuEPCeyh7MHb1ic33vyaINcrmXCNzJw/M+nDv
         nh7YmlSnoJC5GkGaocCPziu2n/vUnvmwFASNPdv24ojqIm3tgTfth+jOWdpq85LLVOla
         U11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779855183; x=1780459983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQh95HH5EUt2hdoybPfMx/605ecf+e0yU2uPrQaxulU=;
        b=s/aovk9+9xOe8BBQZ0GB5GS3tvkktIzGvq8IWmIOSESa5SIjJzBxVBDNHD5Osf/4vU
         ePI1R+B3R/wpyTUZu6CjcyNt5BIM+3HWxOy0R3SmX90puY6tvnMuTKz21gGSPrjG42W+
         dk4C9DFoF5tOHNOzA4LQE9NKE+D5UXMfIC4iYm201bMYpo+LgQWWTTqrXM52otI+/NmS
         BXQROklkSZpx5RTve31OY1Ze3pKDf0krZEMjMrOXEz81AABgkoGlJBYTQkVWJhHC4+DZ
         MVJnXB3v48wDn7L1iizKIPM7XvzojifWI5Ykg81QoAu5nXraV7H2pfeO7bEzBMYAdqNn
         uFiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/u2w6gIC2RfdZKHs5adjOXXNCxFs8N9iFTKeUuuMGP3NuVVvrvJlY3BF2WWQY8nsdutgIMkGgRLlo35mxc@vger.kernel.org
X-Gm-Message-State: AOJu0YysWUN31CnJ+7aN2qqzUBzYOoxr21oN1ILqzDXwLs6LS6kBVdn1
	/jKsb0Vw94unvfGvjHlc6TTvl8Oh0oWqixmPChONeipKRaxtqSs4bysXwT+f7qFDmd77V/HryVE
	milDVsnOClAFtumNkV2myWVprNaTRnA4=
X-Gm-Gg: Acq92OFe9HOeHeWGYzx4OImIM98M0JjUZFbWgQIxg6xfGNy9gkWiyw+xVoy4l8wVDiB
	ZbD7V2ylZNeKjOZkEL5hPlYOIw7RxY0UMDCfCQeQ6yXV3QQJgzYGdjWnwjJAD4jFjy2JuM0eEb+
	W7KYFUplYFe0ycHqyZFzCOPoHthQ63j56FiFcYjbKgfmtd6H57BwlyH5bRH1jxUypHc7wOSRUQ/
	8qiVknYSmitW1qhIHB9JpM7jZK5Ls3ACA75xNkVLKUNaGAu5Br0sGiiWYC2yQF9IiwW2PzJQvww
	ZMUnKFVSmKGIxSxWXVg1arsOkcLeRc12wQ==
X-Received: by 2002:a5d:5d02:0:b0:43e:b0f8:66f1 with SMTP id
 ffacd0b85a97d-45eb3afd371mr35042981f8f.43.1779855183235; Tue, 26 May 2026
 21:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYPhWdd59RKmuNLJg-bkypHz7xiOwaWyNVu3A8CUqQCnvg@mail.gmail.com>
 <ahPhcZvPD4S20UJf@infradead.org> <CAEkJfYP5YhcwVik31Mv3iouLG2wDksb4fEbu4TSU0TAYN25w6A@mail.gmail.com>
In-Reply-To: <CAEkJfYP5YhcwVik31Mv3iouLG2wDksb4fEbu4TSU0TAYN25w6A@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 26 May 2026 21:12:50 -0700
X-Gm-Features: AVHnY4LEEg-Gx__4supnB3_zW54o5z27MTN9TUGXHb-6cuRhEgGpfQXWgr6q6bw
Message-ID: <CAJnrk1a=ivLcEHBOJ8Nzodb52zJ_B2X4yV16hwv_Sio84y8y1g@mail.gmail.com>
Subject: Re: [BUG] iomap: NULL dereference in iomap_finish_folio_read after
 deferred failed read
To: Sam Sun <samsun1006219@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 8:25=E2=80=AFPM Sam Sun <samsun1006219@gmail.com> w=
rote:
>
> On Mon, May 25, 2026 at 1:43=E2=80=AFPM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Sat, May 23, 2026 at 06:58:46PM +0800, Sam Sun wrote:
> > > Dear developers and maintainers,
> > >
> > > We encountered a NULL pointer dereference in the deferred buffered
> > > read failure path. Unfortunately, no reproducer is available yet.
> >
> > [snip]
> >
> > > We analyzed the cause of this report. It seems that failed buffered
> > > read bios are deferred to a global work item "failed_read_work". The
> > > deferred worker still owns the bio/folio, but by the time it calls
> > > `iomap_finish_folio_read()`, the folio may have been truncated,
> > > invalidated, or otherwise detached from its mapping. In that case,
> > > `folio->mapping` is NULL, but the error reporting path unconditionall=
y
> > > dereferences `folio->mapping->host`. This pattern still exists on the
> > > latest kernel commit.
> > >
> > > A possible fix could be avoiding the `folio->mapping->host`
> >
> > The folio is locked until the folio_end_read() call.  So I don't see
> > what could legitimately clear folio->mapping here.  Curiously waiting
> > for the reproducer to see waht is going wrong here.
> >
>
> I have more data now. I agree that the folio is supposed to stay locked
> until `folio_end_read()`, but that does not fully protect this path. The
> problematic window is a non-final read completion, after
> `ifs->read_bytes_pending` has been decremented and before the error repor=
ting
> path dereferences `folio->mapping->host`. The relevant code is still
> present in v7.1-rc5.
>
> The race I observed is:
>
> 1. A failed buffered read completion reaches `iomap_finish_folio_read()`.
> 2. It decrements `ifs->read_bytes_pending`, but `finished` is false
> (`pending_after=3D2048` in the logs below), so this completion is not the=
 one
> that unlocks the folio.
> 3. If the worker is delayed/preempted before the `fserror_report_io()` ca=
ll,
> another completion can finish the remaining bytes and unlock the folio.
> 4. Userspace then truncates the XFS file. The truncate path removes the f=
olio
> from the page cache and clears `folio->mapping` in
> `delete_from_page_cache_batch()`.
> 5. The delayed worker resumes and dereferences `folio->mapping->host`.

Does it not suffice to just call fserror_report_io() before
decrementing ifs->read_bytes_pending? eg

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d7b648421a70..d55b936e6986 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -400,6 +400,11 @@ void iomap_finish_folio_read(struct folio *folio,
size_t off, size_t len,
        bool uptodate =3D !error;
        bool finished =3D true;

+       if (error)
+               fserror_report_io(folio->mapping->host, FSERR_BUFFERED_READ=
,
+                                 folio_pos(folio) + off, len, error,
+                                 GFP_ATOMIC);
+
        if (ifs) {
                unsigned long flags;

@@ -411,11 +416,6 @@ void iomap_finish_folio_read(struct folio *folio,
size_t off, size_t len,
                spin_unlock_irqrestore(&ifs->state_lock, flags);
        }

-       if (error)
-               fserror_report_io(folio->mapping->host, FSERR_BUFFERED_READ=
,
-                                 folio_pos(folio) + off, len, error,
-                                 GFP_ATOMIC);
-
        if (finished)
                folio_end_read(folio, uptodate);


With read_bytes_pending still > 0, it's guaranteed that the folio is
locked and truncate can't invalidate folio->mapping yet as it requires
the folio lock.

Thanks,
Joanne

>
> In other words, the truncate path clears the mapping after the folio
> has legitimately
> been unlocked by another, final read completion. The unsafe part is that =
the
> non-final failed completion uses `folio->mapping->host` without holding a=
 lock
> or reference that keeps `folio->mapping` stable.
>
> One possible interleaving is:
>
> ```
> CPU0: failed_read_work CPU1: another read completion CPU2: userspace trun=
cate
> -------------------------------------
> ---------------------------------- --------------------------------
>
> iomap_finish_folio_read(folio, err)
>
> lock(ifs->state_lock)
> ifs->read_bytes_pending -=3D len
> finished =3D false
> unlock(ifs->state_lock)
>
> if (error)
>   /* about to execute:
>   * fserror_report_io(folio->mapping->host, ...)
>   */
> <preempted here>
>                                       iomap_finish_folio_read(folio, 0)
>
>                                       lock(ifs->state_lock)
>                                       ifs->read_bytes_pending -=3D len
>                                       finished =3D true
>                                       unlock(ifs->state_lock)
>
>                                       folio_end_read(folio, true)
>
>
>           open(..., O_TRUNC)
>
>             do_truncate()
>
>               truncate_setsize()
>
>                 truncate_inode_pages()
>
>
>           lock_folio(folio)
>
>           delete_from_page_cache_batch()
>
>             folio->mapping =3D NULL
>
>           unlock_folio(folio)
>
> <resumed>
>   fserror_report_io(folio->mapping->host, ...)
>                               ^^^^^^^^^^^^^^
>                               NULL now
> ```
>
> To validate the race on v7.1-rc5, I used a diagnostic build that is
> equivalent to
> placing a breakpoint immediately before the original dereference.
> The diagnostic patch:
>
> - logs non-final failed completions and records the folio/mapping being u=
sed by
> the error path;
> - logs immediately before the existing `folio->mapping =3D NULL` assignme=
nts in
> `page_cache_delete()` and `delete_from_page_cache_batch()`;
> - defers only the non-final `fserror_report_io(folio->mapping->host, ...)=
` by
> one second so the truncate race has time to run.
>
> With the syz corpus on v7.1-rc5 plus the diagnostic breakpoint:
>
> ```text
> [ 116.142333] d280-iomap-latest: deferred non-final fserror
> folio=3Dffd40000013ea940 mapping=3Dff1100004560b6b8 pending_after=3D2048
> comm=3Dkworker/0:7
> [ 116.177780] d280-filemap-latest: delete_from_page_cache_batch
> clearing watched folio=3Dffd40000013ea940 mapping=3Dff1100004560b6b8
> host=3Dff1100004560b4a0 ino=3D9286 index=3D0 locked=3D1 ref=3D4 comm=3Dsy=
z.5.30
> [ 117.330579] d280-iomap-latest: deferred fserror
> folio=3Dffd40000013ea940 mapping=3D0000000000000000 host=3D00000000000000=
00
> index=3D0 pos=3D0 off=3D0 len=3D2048 locked=3D0 ref=3D1 comm=3Dkworker/0:=
9
> [ 117.336816] Oops: general protection fault, probably for
> non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> [ 117.337746] KASAN: null-ptr-deref in range
> [0x0000000000000000-0x0000000000000007]
> [ 117.339635] Workqueue: events d280_deferred_report_work
> ```
>
> The detach is done by the normal truncate path:
>
> ```text
> delete_from_page_cache_batch()
> truncate_inode_pages_range()
> truncate_pagecache()
> xfs_vn_setattr_size()
> xfs_vn_setattr()
> notify_change()
> do_truncate()
> path_openat()
> do_file_open()
> __x64_sys_open()
> ```
>
