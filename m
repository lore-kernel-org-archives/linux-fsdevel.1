Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04E2F9D98
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775931085; cv=pass; b=VkwymfVLJFi93pyjhRLIQK/MPQE1wWHUFXJLdg3a08WdeE6MayihEunyKfiH+GdVdHK/EEeQ5xC6sMG8AN4jkF6iWu5QhwXvI3fFH8aWT/EQepHlTfoxfGBfxZS/KXdLa6Kt9rSWZl4BZyzIidzROJ75T7gRunUwjgaFxkJS8qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775931085; c=relaxed/simple;
	bh=HAGNwk6eHFPNXLeAMHem19pzCjDCbOAo2Tsz0Hx0Xv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5ZXKDAYvrx8YPVv5q9zvD4Dn6jX/uaCn0gM8TAnU4fV1w1WTPkesxdr9cmlsufzh7s8Uws2VpgxZpRkV4m3xdiv47H3AFhNctZphp8zvnCALh2ESkPwnGG3d7OD5mEpi1i08vbO1Qc1tZ6dDJiMTuQDFqULdsZfZaySR/srgQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRjUG/hU; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRjUG/hU"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso3176568f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 11:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775931082; cv=none;
        d=google.com; s=arc-20240605;
        b=YEppgs5fpPBjNOfXCoi6jLHCusPhasGA/3qWjR+nP5mv6ZvhNQvZ4++BqWoIxk35Qb
         duFHDLNOhjIweWdBee6I+Spi6CwsJcZfLDsKC5dMvLA87XIFgUpotyrrsKgv9xkqIBMz
         zvb2QhO1ZVGIZ5Cyhh5hSvOra1Ih9aU1/jQEuzgRd1Txhyse61SwsX5YcrsSl47QnBZg
         GRhpQS6Tihd8uBPRYvK2mXu+evVuIoa59VOBY6guUNmaOu8PzE1FFHyPii7u18eNFYPd
         cNMKtR/VcujEzw0IKCF+2erZ2o918G6LA1oU9yf4Wzz3tKiDZAD77JAqUe0DRsn7mc96
         yTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NcztKu6tkjFwFoPUMiwrM+axM+c0vDxR0aI4xG5+Yxs=;
        fh=ChLHOGxBBzf+il+LKsZNwo4EjWgCRQPPswti1qCVon8=;
        b=JrUOdzsSX08Gk0FWzXBdNmqYQG7OAwb0A5CWMEU9din3LBg7XoSNQquiNbPEBBsI7y
         TbHmSaxxAsv9YlNSaY3/S2046DJ9wgoPBD7LfThA1FxzMSDG1a/d0P5OM2PpKu0oW3Sm
         574BDlCqbk2wzOYbYvVC/38rzfM8ifiLu2WuYWy/4wz+csTg2NmpRjIUALxHdUdF/21j
         UAU6yzgcavs1EvlMNkds4tHld6H0010bq5FtaEIT1rdKgV3SV4rZPFSuWq1xgI68ISTM
         XDPReTLeO2MtjlVaI/geuml+8SQXV62SioagOQd87+29vcY5jgqJ1l/iiFiSo92frBwV
         2dpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775931082; x=1776535882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcztKu6tkjFwFoPUMiwrM+axM+c0vDxR0aI4xG5+Yxs=;
        b=GRjUG/hUSMnnVHaghJg5hkWZuVEobZWejAjLOnsDgaONak1rpOuXpGbBGnICqz7O27
         qAMGEAlh91xNRd1w2CQOrzE+oR66BY8npuv2jkWWKsM3CJ4yvlX99CTrHjxmD3sbLguW
         MKvMO8YBUQBNbdzMNvkhMvePLZeP5qWo4fjjrvyB8VKkJf41n4iu2dJpnIQcGt1VIzP+
         1SvGoEWbANurfcSzASoci+5x4AA+NfUXTyrOL/8o9FwHG3ptCEkMJCT+Y+YHrjmFZ4Ma
         s6nlisYtzURH2WRHqfhiId7U8CeZiT+NAdaPoQLkk4r9/N0eQWDTGZDLpu6TssFhaObt
         TXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775931082; x=1776535882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NcztKu6tkjFwFoPUMiwrM+axM+c0vDxR0aI4xG5+Yxs=;
        b=lbiJ9sR7RSs5KOyAhIsK00enGXEIY+zP43SojADL3AEs11eM2efmNbZakDvo2K+ds1
         iozgIVeCYLFCA6tZk4lfzh1jp2k/M2v5rHnWt5cNBuXfPksd/JzorQ9KKqKcmr8tbKAj
         sZRPN56eqJT03AsUNVepkJe8n6afoHheWWpsCrWYIV0olvAxq++kw3FX2+RI4JdyYZAQ
         YZAzbSQC+Ymc8kOXOVTzDbli6e1ZWvBlpzzMLQVouf0Fe2OTO0SR8gCy7LA/WCsCTqc5
         IRxDGXZG9SIZEHOzW0fmuGBoORwshb9wpYqjAJjrLa0VEZ/qG+bOnSdGW5gGuDCZgCW9
         XIQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8U6azTQAeUXQ983WHk2fgC33RuDjxRZaB4DgBZ1i0X9vQPSh4gdvZtOv8KQMh9xEcTLDOjMr9Vm61oo1kI@vger.kernel.org
X-Gm-Message-State: AOJu0YyctNYp7ew5jXb7tVwNczBPJ1obfZRVux8tuVCs/5KiPg5GpN/X
	qzSXx3GLA9AsWjH9A/Z4081yl2MTK4B5XPjVs4bP1Ver4ruCfP1mOfFif5YbfZQ3D0PTcojbHG4
	NWMZ1AeqpFjn/v/Cu5dEBAVFUz7exd7iPUs211gM=
X-Gm-Gg: AeBDieuifOfcCBNfAmVJDoHYkMkUQn4od2TNPELzIqanhq47CgfxTEQJWiyRHP0oMe4
	zcCtz8+DRKBN/0DdwGFTorRDCWe9T12/Cx4UHH1aqwST1f+xQT6ZZDNOE62tKv42p6cSQR6jldy
	0JmbhjIHRclj5pfyOG/Ka/R3FOvygp1nseUEzgXlvauSgE9gjSwge9p8A3cipjMQvpvIZ3fwJNn
	i9o2lYc6nFTBAkvDzPP1FPKZHqpgd8VuNxgUybowI8JM8DqqvyYLXZq77DlpFHmL0VqPwTF9Wuu
	8vUhXA==
X-Received: by 2002:a05:6000:2886:b0:43b:7ff5:fdf7 with SMTP id
 ffacd0b85a97d-43d642c8664mr10955212f8f.29.1775931081774; Sat, 11 Apr 2026
 11:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com> <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <3eabbc7b-010f-4d4c-9145-30d69fe1aa79@bsbernd.com> <CAJnrk1aoxGMGNZi+OwdoET6ahhGHp_7dw__=dmOWW+PMxnsj2w@mail.gmail.com>
 <adlyjDaxLZyHcSun@fedora>
In-Reply-To: <adlyjDaxLZyHcSun@fedora>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Sat, 11 Apr 2026 11:11:10 -0700
X-Gm-Features: AQROBzBqtLUAi3m0PoX19LqBOySrg-A5_gLcNCQCf44cmRnrw7zewYYalY8UYOc
Message-ID: <CAJnrk1Yb2ABBKFK=KMaU+W10FNazt+h93P445i1USXcN2W45Xw@mail.gmail.com>
Subject: Re: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with
 immediate teardown
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 3:08=E2=80=AFPM Horst Birthelmer <horst@birthelmer.=
de> wrote:
>
> On Fri, Apr 10, 2026 at 02:24:08PM -0700, Joanne Koong wrote:
> > On Fri, Apr 10, 2026 at 4:26=E2=80=AFAM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> > >
> > Hi Bernd,
> >
> > > Hi Joanne,
> > >
> > > On 4/10/26 01:09, Joanne Koong wrote:
> > > > On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bsbern=
d.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 10/21/25 23:33, Bernd Schubert wrote:
> > > >>> Do not merge yet, the current series has not been tested yet.
> > > >>
> > > >> I'm glad that that I was hesitating to apply it, the DDN branch ha=
d it
> > > >> for ages and this patch actually introduced a possible fc->num_wai=
ting
> > > >> issue, because fc->uring->queue_refs might go down to 0 though
> > > >> fuse_uring_cancel() and then fuse_uring_abort() would never stop a=
nd
> > > >> flush the queues without another addition.
> > > >>
> > > >
> > > > Hi Bernd and Jian,
> > > >
> > > > For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
> > > > from fuse_uring_cancel" email was never delivered to my inbox, so I=
 am
> > > > just going to write my reply to that patch here instead, hope that'=
s
> > > > ok.
> > > >
> > > > Just to summarize, the race is that during unmount, fuse_abort() ->
> > > > fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... -=
>
> > > > fuse_uring_entry_teardown() gets run but there may still be sqes th=
at
> > > > are being registered, which results in new ents that are created (a=
nd
> > > > leaked) after the teardown logic has finished and the queues are
> > > > stopped/dead. The async teardown work (fuse_uring_async_stop_queues=
())
> > > > never gets scheduled because at the time of teardown, queue->refs i=
s 0
> > > > as those sqes have not fully created the ents and grabbed refs yet.
> > > > fuse_uring_destruct() runs during unmount, but this doesn't clean u=
p
> > > > the created ents because those registered ents got put on the
> > > > ent_in_userspace list which fuse_uring_destruct() doesn't go throug=
h
> > > > to free, resulting in those ents being leaked.
> > > >
> > > > The root cause of the race is that ents are being registered even w=
hen
> > > > the queue is already stopped/dead. I think if we at registration ti=
me
> > > > check the queue state before calling fuse_uring_prepare_cancel(), w=
e
> > > > eliminate the race altogether. If we see that the abort path has
> > > > already triggered (eg queue->stopped =3D=3D true), we manually free=
 the
> > > > ent and return an error instead of adding it to a list, eg
> > > >
> > > > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > > > index d88a0c05434a..351c19150aae 100644
> > > > --- a/fs/fuse/dev_uring.c
> > > > +++ b/fs/fuse/dev_uring.c
> > > > @@ -969,7 +969,7 @@ static bool is_ring_ready(struct fuse_ring *rin=
g,
> > > > int current_qid)
> > > >  /*
> > > >   * fuse_uring_req_fetch command handling
> > > >   */
> > > > -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
> > > > +static int fuse_uring_do_register(struct fuse_ring_ent *ent,
> > > >                                    struct io_uring_cmd *cmd,
> > > >                                    unsigned int issue_flags)
> > > >  {
> > > > @@ -978,6 +978,16 @@ static void fuse_uring_do_register(struct
> > > > fuse_ring_ent *ent,
> > > >         struct fuse_conn *fc =3D ring->fc;
> > > >         struct fuse_iqueue *fiq =3D &fc->iq;
> > > >
> > > > +       spin_lock(&queue->lock);
> > > > +       /* abort teardown path is running or has run */
> > > > +       if (queue->stopped) {
> > > > +               spin_unlock(&queue->lock);
> > > > +               atomic_dec(&ring->queue_refs);
> > > > +               kfree(ent);
> > > > +               return -ECONNABORTED;
> > > > +       }
> > > > +       spin_unlock(&queue->lock);
> > > > +
> > > >         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> > > >
> > > >         spin_lock(&queue->lock);
> > > > @@ -994,6 +1004,7 @@ static void fuse_uring_do_register(struct
> > > > fuse_ring_ent *ent,
> > > >                         wake_up_all(&fc->blocked_waitq);
> > > >                 }
> > > >         }
> > > > +       return 0;
> > > >  }
> > > >
> > > >  /*
> > > > @@ -1109,9 +1120,7 @@ static int fuse_uring_register(struct io_urin=
g_cmd *cmd,
> > > >         if (IS_ERR(ent))
> > > >                 return PTR_ERR(ent);
> > > >
> > > > -       fuse_uring_do_register(ent, cmd, issue_flags);
> > > > -
> > > > -       return 0;
> > > > +       return fuse_uring_do_register(ent, cmd, issue_flags);
> > > >  }
> > > >
> > > > There's the scenario where the abort path's "queue->stopped =3D tru=
e"
> > > > gets set right between when we drop the queue lock and before we ca=
ll
> > > > fuse_uring_prepare_cancel(), but the fuse_uring_create_ring_ent()
> > > > logic that was called before fuse_uring_do_register() has already
> > > > grabbed the ref on ring->queue_refs, which means in the abort path,
> > > > the async teardown (fuse_uring_async_stop_queues()) work is guarant=
eed
> > > > to run and clean up / free the entry.
> > >
> > >
> > > I don't think your changes are needed, it should be handled by
> > > IO_URING_F_CANCEL -> fuse_uring_cancel(). That is exactly where the
> > > initial leak was - these commands came after abort and
> > > fuse_uring_cancel() in linux upstream then puts the entries onto the
> > > &queue->ent_in_userspace list.
> >
> > I think there are still races if we handle it in fuse_uring_cancel()
> > that still leak the ent, eg even with the fuse_uring_abort()
> > queue_refs gating taken out in the original (jian's) patch:
> > * thread A: fuse_uring_register() ->fuse_uring_create_ring_ent() ->
> > kzalloc, sets up the entry but hasn't called
> > atomic_inc(&ring->queue_refs) yet
> >   concurrently on another thread, thread B: fuse_uring_cancel()
> > ->fuse_uring_entry_teardown() ->
> > atomic_dec_return(&queue->ring->queue_refs) -> brings queue_refs down
> > to 0
> >   At this instant, queue_Refs =3D=3D 0. fuse_uring_stop_queues() ->
> > teardown entries (nothing left) -> checks "if
> > atomic_read(&ring->queue_refs) > 0", sees this is false, and skips
> > scheduling any async teardown work
> >   thread A calls atomic_inc(&ring->queue_refs) for the new ent,
> > queue_refs is now 1, the ent is now placed on the ent_avail_queue, but
> > it's never torn down.
> >   the ent is leaked and there's also a hang now when we hit
> > fuse_uring_wait_stopped_queues() -> fuse_uring_wait_stopped_queues()
> > where it sleeps and is never woken since it's waiting for queue refs
> > to drop to 0
> >
> > imo, the change proposed in my last message is more robust and handles
> > this case since it guarantees the async teardown worker will be
> > running (since it does the queue state check after the ent has grabbed
> > the queue ref).
>
> Ok so you rely on the fact that fuse_abort_conn() will call
> fuse_uring_abort() and that sets queue->stopped.
> This could work, but I would still remove the check for
> queue_refs > 0 in fuse_uring_abort(), since it just complicates things
> for no real reason.
>
> >
> > btw, there's also another (separate) race, which neither of our
> > approaches solve lol. This is the situation where fuse_uring_cancel()
> > runs right after we call fuse_uring_prepare_cancel() in
> > fuse_uring_do_register() but before we have set the ent state to
> > FRRS_AVAILABLE. The ent gets leaked and continues to be used even
> > though it's canceled, which may lead to use-after-frees. This probably
> > requires a separate fix, I haven't had time to look much at it yet.
> > Maybe Horst or Jian has looked at this?
> >
> Interesting scenario ... haven't seen that one so far.

Looking at the io-uring code for how cancels are handled
(io_uring_try_cancel_uring_cmd()), I was wrong in my prevoius message
about these two races. io-uring already serializes this for us, the
io-uring code unconditionally grabs the uring lock before invoking
file->f_op->uring_cmd() in the cancel path, which means there's no
interweaving between the fuse registration logic and the cancel logic.

But I still think the more robust/resilient fix for the memleak is to
do the preemptive checking at registration time. I think this fixes
races in the force unmount case between registration and abort that is
unresolved with the original patch. With the original patch w/
fuse_uring_abort()'s queue_refs check removed, I think we can still
hit this:

registration vs abort:
  - thread a: io_uring_enter -> register sqe ->
fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
yet
  - thread b: fuse_conn_destroy() -> fuse_abort_conn() ->
fuse_uring_abort() -> fuse_uring_stop_queues() ->
fuse_uring_teardown_entries(), skips scheduling async teardown work
since queue_refs =3D=3D 0, returns
  - thread a: grabs the queue_ref, queue_ref is now 1, rest of
fuse_uring_do_register() logic executes, ent is now marked cancelable,
ent state is now available, ent is placed on available queue
  - thread b: fuse_abort_conn() returns, fuse_wait_aborted() now runs
and does a "wait_event(ring->stop_waitq,
atomic_read(&ring->queue_refs) =3D=3D 0);" which hangs since the waiter
never gets woken

whereas if we check preemptively at registration time, we explicjtly
free the ent and release the queue_ref. I think the preemptive check
needs to check ring->fc->connected though instead of queue->stopped,
because there's the race where abort and stop_queues() may have been
triggered before the register sqe path does queue creation. I'm hoping
there's a better solution than having to grab the fc lock and checking
fc->connected though, will try to look more at this next week.

I think we can hit this hang on a ring creation vs abort race as well:
* thread a: fuse_uring_cmd() gets called, passes fc->aborted check (not set=
 yet)
* thread b: abort is called, calls fuse_uring_abort(),
fuse_uring_abort() is a no-op since ring =3D=3D NULL right now
* thread a: creates ring, creates queue, creates entry
- if thread a takes the queue_ref count before the rest of the abort
logic, we end up with the same hang as the situation above.

I think for this we'll need to check fc->connected state under the fc
lock before doing the "smp_store_release(&fc->ring, ring);" call, eg
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -243,6 +243,11 @@ static struct fuse_ring *fuse_uring_create(struct
fuse_conn *fc)
        max_payload_size =3D max(max_payload_size, fc->max_pages * PAGE_SIZ=
E);

        spin_lock(&fc->lock);
+       if (!fc->connected) {
+               spin_unlock(&fc->lock);
+               goto out_err;
+       }
        if (fc->ring) {
                /* race, another thread created the ring in the meantime */

but this is a separate race from the main one we're talking about on
this thread.

Does all of this align with your analysis and Bernd's analysis of the
situation or am I misanalyzing something here? I'll try to spend more
time next week looking at this.

Thanks,
Joanne

>
> > > Issue in master is, fuse_uring_stop_queues() might have been run alre=
ady
> > > - entries then get leaked and fuse_uring_destruct() later might give =
a
> > > warning. That part can be reproduced with xfstests, before it starts =
any
> > > of the tests it does some funny start stop actions.
> > >
> > > Initial *simple* patch was to either add a new list or to just remove
> > > the warning and to also handle either that new list or
> > > queue->ent_in_userspace list  in fuse_uring_destruct(). The comment
> > > explaining why it is needed was much longer than the rest of the patc=
h.
> > > The hard part in the long term would be tranfer the knowledge for tha=
t
> > > requirement.
> >
> > I think the initial simple patch doesn't address the hang. When the
> > ent is canceled, it still has the ref on queue_refs, which means
> > fuse_uring_wait_stopped_queues() will wait for queue_refs =3D=3D 0
> > forever. I don't think we ever even get to fuse_uring_destruct().
> >
> > Thanks,
> > Joanne
> >
> > >
> > > You then asked to handle the release directly in fuse_uring_cancel()
> > > without another list
> > > https://lore.kernel.org/r/CAJnrk1YaRRKHA-jVPAKZYpydaKcdswLG0XO7pUQZZ4=
-pTewkHQ@mail.gmail.com
> > >
> > > Yes possible and this is what the next patch version does. However,
> > > given fuse_uring_cancel() runs outside of all the fuse locks, it is r=
acy
> > > and I therefore asked in the introduction patch not to merge it yet.
> > >
> > > https://lore.kernel.org/all/20251021-io-uring-fixes-cancel-mem-leak-v=
1-0-26b78b2c973c@ddn.com/
> > >
> > >
> > > Turns out my suspicion was right ;)
> > >
> > > Queue references might go to 0 when nothing is in flight and then
> > > fuse_uring_abort(), which _might_ race and come a little later, then
> > > might not doing anything.
> > >
> > >         if (atomic_read(&ring->queue_refs) > 0) {
> > >                 fuse_uring_abort_end_requests(ring);
> > >                 fuse_uring_stop_queues(ring);
> > >         }
> > >
> > > As Horst figure out, removing this check for queue_refs avoids the
> > > issue. I'm rather sure that the check was needed during development a=
nd
> > > avoided some null pointer derefs, as that is what I remember. But I
> > > don't think it is needed anymore.
> > >
> > >
> > > Thanks,
> > > Bernd
> >
