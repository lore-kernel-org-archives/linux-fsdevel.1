Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B80A2C21C3
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773479593; cv=pass; b=YHLsqH1TuH9yHfq0KEpxLKK1ia4P83mbPhxK+d+x41yM8UtHXVOixrgBwFXkyXBPpyoQnkgGgc6oIEZXT6CTuH4f/0HPNQ0A3Y6toHIecmZZ+7DcTYIflGsGd2yPv6bdQD/NEJ+gzKtPBWlYDG2WBTug7FUXi8vQVCW5nvOIWKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773479593; c=relaxed/simple;
	bh=BJnpQsygkyQab1gejp0T4O21O9TK6Uob6aaorA4gBoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLmSmIdeCjXsqXqYQKA7kaf04MxxFtnAcYeDUwt8kHPt0sx494fJk0d7YfB+A2KNjeu/vVY5o0h7CA2M+ucmN/bwjKKvQGOEafBNb32C2G1lMDO2kPauwdxzPfjws4YoAcQGwB9pXFFYlOg0333gHxr0DBlefzQzf2+tQTYfkEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPGuNz4A; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPGuNz4A"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6616cb8c80cso4573837a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 02:13:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773479589; cv=none;
        d=google.com; s=arc-20240605;
        b=H8L57aRA13hNnwJKj9hrAcluo4rqNhoo3isDq2aJ1xEaLVWIDEHr4yHIzGqLIPMKxd
         yZHzBfTPcufmLx18CStCk3En124pT7Q5GCLho3mI4vAaxVomyVTy0Xxf611M66IfkzNY
         l+98wL6isoI95FMMbClB26akjvH0Tu1y9cKW2XU0xl+jxHn6jzgpJxrK/4DJ8b9JR8Dd
         kleytCMABqwiM7GzHbxvtb7WjOet40KIp9lpvgRJpKHX974qfIMkfoWdjMLnV9aVuXhK
         YGBFo9VsD7NBlwYO0z4EAXAqikdbSE7aDlYV+tYuG6fi8xRNKw4DQQoaOKs6QiSarpZq
         vrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YP3ovO2iDNgmJ5VRNF5sgvLCgl94Y3HjyMEy+Kip1kE=;
        fh=0tYvsSn3S/ruZJN+dsyxdxalcFTMLzSmRZk+A6eyXKw=;
        b=FXAZ5I33r3UAkxKkesvoQRucekwMYlUo+6Avd1Y5f08cVkPNStMA1yxD9QSZfUUff1
         uIyV1qStjCxuKSKJ9+4XC4gxmTZs4rt+KSL/ihg7loV3+XxRZE0jF8Xt36NRk7z9Cl+w
         OFXgBeufXTzD5ueQvQNN4a1ZKUffL1vNhWGRAxEn9Bqza4WrwDzXU2IX7Uu2jbLLhCKY
         Tx4lEKzexiYI9TPO4VPc3TInrij+ai01l8XGa2ADS9rjuu/AgD1RBkaSSSns9yOUf92x
         ecvJdRfGN+AYTDS6Qr9F4cvJWtZDd0H3OEZA0X7dWjoqz8s5QBEI9H8WXDbgWYsGeCVd
         AzGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773479589; x=1774084389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP3ovO2iDNgmJ5VRNF5sgvLCgl94Y3HjyMEy+Kip1kE=;
        b=bPGuNz4ABfKW8cfy+SaWZxpE44qanZJbg+LqRYtjVDwGetUVL+dqhmYhIFs94R9jkD
         ImZ2Unv9HRh2N73HmUUmrY5xz5drLHbKUo+cTWJ3oUO6CSznP9dJl5SLdNRXQ9Z8Ox/4
         X1zK96HOcLQDNdK0EvgtXHVFz4zYYITwjihQFO6cRWp6PHu4RI8341Y8ncqfwR0UP/No
         t8BoiTXx7NFSiGmyEU/QQuYYbORdvwH6zfk/xElOwQ8XW+tFMwVlViMLpzwF6S7OS9RW
         z9bCSMJsOqEyxt5oxJg1VaST18YhfTwoNA1pVdejdTIVJpJe9OfqEwFHl8sQ++Fy05Ym
         cc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773479589; x=1774084389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YP3ovO2iDNgmJ5VRNF5sgvLCgl94Y3HjyMEy+Kip1kE=;
        b=Es8wN+H7+QSUZo95YpS5/pCwnk8FCQWSPF9OrKDGrqII22gijARMWyCqZHPa9JQYe9
         VRTmMRfID5llvZ0/LDUkTDAKODYFXKp+9EBDKwl2qkcg11+7McyPVCqGisqLo2fPFT2Q
         glzakQDDRs8Oc7966/5cGXQyxInJcOiYTaRpHT3KMn1gVCI5B6g0T/kr0LJcMUFGAZL7
         lWMYpAaepav56mu1/bjUIkFdDy/EcfLJbcC/KsF85hORjb/f9B3wM5ZDky8UuqK7GkKb
         A1adtlUxiosvIn/VEsYbvbIWFbvwAqINHEXA43MRuZwQLkIS9VXUM0HnXYJy06GNAsrg
         zI6g==
X-Forwarded-Encrypted: i=1; AJvYcCXFXqs6dvk7fzaLAKN3+MgezUyBVRw+0TIvNXSH3yZe3iPnfz0JyPjVNEv3oXCY6AsB4/aYzjAI2bYMqiyq@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKnIptHPxjt4axXGlbkrJB9BhC/iKlc5+kAKqS9EsqIQXoD6g
	ZyR4OnXMEtensKMWmrmsj6A8HyNMsSPjiVl6beMW1j2uWfCkyDJHl6akA0mQ5V+C5rUgrKAVZt1
	Yju0hQivulcy5nr/y3I4piAttTHLXSOA=
X-Gm-Gg: ATEYQzx/J8s/H04axhm6xwFzKfNJG/8+Z6wa6CSr+UoL0opHNADQHb5gbb+gE5Qxm2u
	qIt0omKGkrYxaIrIVSKajUxMevx5TAteYsVJ6FOQYYY/G9ewmp0f0WN/m9Bs+S15hOjj9SX8ZAK
	vYFchfq6uiiQaIvd+nTbXAmaWOTDBmmzG2kfJ1SwyfOJjDsldLPUeiTfnhHoLaX8cBTHc0kg4xI
	sLE5GGE8X7OQ/x+ejEvCjJccKMKH9NEAfZY5+BLesW35WGUNI2KpBTCWCnBw8BoHJB3ocqfqKIq
	yMWGy+BNvV+Hi8OW8BooSXTOBAKGIp6JOAUNmKrVqVCqKFqg
X-Received: by 2002:a05:6402:f05:b0:64b:83cb:d943 with SMTP id
 4fb4d7f45d1cf-663ba0e8ebemr2608502a12.6.1773479589049; Sat, 14 Mar 2026
 02:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114094717.236202-1-mjguzik@gmail.com> <abNvb2PcrKj1FBeC@ly-workstation>
In-Reply-To: <abNvb2PcrKj1FBeC@ly-workstation>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 14 Mar 2026 10:12:57 +0100
X-Gm-Features: AaiRm51JQybQM4__WHYWOmEzD3anImf8NqEXtchKEVKoEl8DmS9Nx76UfOBtKno
Message-ID: <CAGudoHHVwE5XFwEaRYfKX7HuAR5eopHtg8X=yyBqW3_SQiH+6Q@mail.gmail.com>
Subject: Re: [PATCH v2] fs: make insert_inode_locked() wait for inode destruction
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 2:59=E2=80=AFAM Lai, Yi <yi1.lai@linux.intel.com> w=
rote:
>
> On Wed, Jan 14, 2026 at 10:47:16AM +0100, Mateusz Guzik wrote:
> > This is the only routine which instead skipped instead of waiting.
> >
> > The current behavior is arguably a bug as it results in a corner case
> > where the inode hash can have *two* matching inodes, one of which is on
> > its way out.
> >
> > Ironing out this difference is an incremental step towards sanitizing
> > the API.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > v2:
> > - add a way to avoid the rcu dance in __wait_on_freeing_inode
> >
> >
> >  fs/inode.c | 41 ++++++++++++++++++++++++-----------------
> >  1 file changed, 24 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 8a47c4da603f..a4cfe9182a7c 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1028,19 +1028,20 @@ long prune_icache_sb(struct super_block *sb, st=
ruct shrink_control *sc)
> >       return freed;
> >  }
> >
> > -static void __wait_on_freeing_inode(struct inode *inode, bool is_inode=
_hash_locked);
> > +static void __wait_on_freeing_inode(struct inode *inode, bool hash_loc=
ked, bool rcu_locked);
> > +
> >  /*
> >   * Called with the inode lock held.
> >   */
> >  static struct inode *find_inode(struct super_block *sb,
> >                               struct hlist_head *head,
> >                               int (*test)(struct inode *, void *),
> > -                             void *data, bool is_inode_hash_locked,
> > +                             void *data, bool hash_locked,
> >                               bool *isnew)
> >  {
> >       struct inode *inode =3D NULL;
> >
> > -     if (is_inode_hash_locked)
> > +     if (hash_locked)
> >               lockdep_assert_held(&inode_hash_lock);
> >       else
> >               lockdep_assert_not_held(&inode_hash_lock);
> > @@ -1054,7 +1055,7 @@ static struct inode *find_inode(struct super_bloc=
k *sb,
> >                       continue;
> >               spin_lock(&inode->i_lock);
> >               if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) =
{
> > -                     __wait_on_freeing_inode(inode, is_inode_hash_lock=
ed);
> > +                     __wait_on_freeing_inode(inode, hash_locked, true)=
;
> >                       goto repeat;
> >               }
> >               if (unlikely(inode_state_read(inode) & I_CREATING)) {
> > @@ -1078,11 +1079,11 @@ static struct inode *find_inode(struct super_bl=
ock *sb,
> >   */
> >  static struct inode *find_inode_fast(struct super_block *sb,
> >                               struct hlist_head *head, unsigned long in=
o,
> > -                             bool is_inode_hash_locked, bool *isnew)
> > +                             bool hash_locked, bool *isnew)
> >  {
> >       struct inode *inode =3D NULL;
> >
> > -     if (is_inode_hash_locked)
> > +     if (hash_locked)
> >               lockdep_assert_held(&inode_hash_lock);
> >       else
> >               lockdep_assert_not_held(&inode_hash_lock);
> > @@ -1096,7 +1097,7 @@ static struct inode *find_inode_fast(struct super=
_block *sb,
> >                       continue;
> >               spin_lock(&inode->i_lock);
> >               if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) =
{
> > -                     __wait_on_freeing_inode(inode, is_inode_hash_lock=
ed);
> > +                     __wait_on_freeing_inode(inode, hash_locked, true)=
;
> >                       goto repeat;
> >               }
> >               if (unlikely(inode_state_read(inode) & I_CREATING)) {
> > @@ -1832,16 +1833,13 @@ int insert_inode_locked(struct inode *inode)
> >       while (1) {
> >               struct inode *old =3D NULL;
> >               spin_lock(&inode_hash_lock);
> > +repeat:
> >               hlist_for_each_entry(old, head, i_hash) {
> >                       if (old->i_ino !=3D ino)
> >                               continue;
> >                       if (old->i_sb !=3D sb)
> >                               continue;
> >                       spin_lock(&old->i_lock);
> > -                     if (inode_state_read(old) & (I_FREEING | I_WILL_F=
REE)) {
> > -                             spin_unlock(&old->i_lock);
> > -                             continue;
> > -                     }
> >                       break;
> >               }
> >               if (likely(!old)) {
> > @@ -1852,6 +1850,11 @@ int insert_inode_locked(struct inode *inode)
> >                       spin_unlock(&inode_hash_lock);
> >                       return 0;
> >               }
> > +             if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
> > +                     __wait_on_freeing_inode(old, true, false);
> > +                     old =3D NULL;
> > +                     goto repeat;
> > +             }
> >               if (unlikely(inode_state_read(old) & I_CREATING)) {
> >                       spin_unlock(&old->i_lock);
> >                       spin_unlock(&inode_hash_lock);
> > @@ -2522,16 +2525,18 @@ EXPORT_SYMBOL(inode_needs_sync);
> >   * wake_up_bit(&inode->i_state, __I_NEW) after removing from the hash =
list
> >   * will DTRT.
> >   */
> > -static void __wait_on_freeing_inode(struct inode *inode, bool is_inode=
_hash_locked)
> > +static void __wait_on_freeing_inode(struct inode *inode, bool hash_loc=
ked, bool rcu_locked)
> >  {
> >       struct wait_bit_queue_entry wqe;
> >       struct wait_queue_head *wq_head;
> >
> > +     VFS_BUG_ON(!hash_locked && !rcu_locked);
> > +
> >       /*
> >        * Handle racing against evict(), see that routine for more detai=
ls.
> >        */
> >       if (unlikely(inode_unhashed(inode))) {
> > -             WARN_ON(is_inode_hash_locked);
> > +             WARN_ON(hash_locked);
> >               spin_unlock(&inode->i_lock);
> >               return;
> >       }
> > @@ -2539,14 +2544,16 @@ static void __wait_on_freeing_inode(struct inod=
e *inode, bool is_inode_hash_lock
> >       wq_head =3D inode_bit_waitqueue(&wqe, inode, __I_NEW);
> >       prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBL=
E);
> >       spin_unlock(&inode->i_lock);
> > -     rcu_read_unlock();
> > -     if (is_inode_hash_locked)
> > +     if (rcu_locked)
> > +             rcu_read_unlock();
> > +     if (hash_locked)
> >               spin_unlock(&inode_hash_lock);
> >       schedule();
> >       finish_wait(wq_head, &wqe.wq_entry);
> > -     if (is_inode_hash_locked)
> > +     if (hash_locked)
> >               spin_lock(&inode_hash_lock);
> > -     rcu_read_lock();
> > +     if (rcu_locked)
> > +             rcu_read_lock();
> >  }
> >
> >  static __initdata unsigned long ihash_entries;
> > --
> > 2.48.1
> >
>
> Hi Mateusz Guzik,
>
> Greetings!
>
> I used Syzkaller and found that there is INFO: task hung in in add_transa=
ction_credits and jbd2_journal_commit_transaction in linux-next next-202603=
11.

Thanks for the report. The provided reproducer indeed triggers the
issue for me, so I have good basis to dig into it.

>
> After bisection and two issues lead to the same first bad commit:
> "
> 88ec797c4680 fs: make insert_inode_locked() wait for inode destruction
> "
>
> Detailed information for "there is INFO: task hung in in add_transaction_=
credits":
> https://github.com/laifryiee/syzkaller_logs/tree/main/260312_161703_add_t=
ransaction_credits
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260312_161703_add_t=
ransaction_credits/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260312_161703_add_t=
ransaction_credits/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260312_161703_add_t=
ransaction_credits/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/260312_161703_add_t=
ransaction_credits/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260312_161703_add_t=
ransaction_credits/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/260312_16=
1703_add_transaction_credits/bzImage_next-20260311
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/260312_161703_add_t=
ransaction_credits/next-20260311_dmesg.log
>
> "
> [  300.335888] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  300.336427] task:systemd         state:D stack:0     pid:744   tgid:1 =
    ppid:0      task_flags:0x400040 flags:0x00
> [  300.337200] Call Trace:
> [  300.337398]  <TASK>
> [  300.337563]  __schedule+0xf7f/0x4910
> [  300.337849]  ? __pfx___schedule+0x10/0x10
> [  300.338141]  ? lock_release+0x14f/0x2d0
> [  300.338473]  ? wait_transaction_locked+0x196/0x240
> [  300.338829]  schedule+0xf6/0x3d0
> [  300.339063]  wait_transaction_locked+0x1bb/0x240
> [  300.339382]  ? wait_transaction_locked+0x196/0x240
> [  300.339717]  ? __pfx_wait_transaction_locked+0x10/0x10
> [  300.340074]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  300.340437]  add_transaction_credits+0x121/0x1000
> [  300.340771]  ? check_preemption_disabled+0x1/0x180
> [  300.341133]  ? __pfx_add_transaction_credits+0x10/0x10
> [  300.341519]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.341881]  ? lock_acquire+0x1c1/0x330
> [  300.342181]  ? __kasan_check_write+0x18/0x20
> [  300.342541]  start_this_handle+0x457/0x1550
> [  300.342887]  ? __pfx_start_this_handle+0x10/0x10
> [  300.343249]  ? kasan_save_track+0x18/0x40
> [  300.343560]  ? jbd2__journal_start+0x198/0x6c0
> [  300.343899]  ? debug_smp_processor_id+0x20/0x30
> [  300.344242]  ? rcu_is_watching+0x19/0xc0
> [  300.344540]  ? kmem_cache_alloc_noprof+0x4d4/0x6c0
> [  300.344916]  jbd2__journal_start+0x397/0x6c0
> [  300.345256]  __ext4_journal_start_sb+0x451/0x650
> [  300.345620]  ? ext4_rmdir+0x637/0xf10
> [  300.345917]  ext4_rmdir+0x637/0xf10
> [  300.346196]  ? __pfx_ext4_rmdir+0x10/0x10
> [  300.346893]  ? sysvec_call_function_single+0x9a/0x110
> [  300.347299]  ? vfs_rmdir+0x1a3/0x880
> [  300.347581]  vfs_rmdir+0x351/0x880
> [  300.347857]  filename_rmdir+0x3e5/0x560
> [  300.348138]  ? __virt_addr_valid+0x10a/0x5f0
> [  300.348443]  ? __pfx_filename_rmdir+0x10/0x10
> [  300.348761]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> [  300.349135]  ? strncpy_from_user+0x198/0x290
> [  300.349443]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.349824]  ? do_getname+0x19e/0x3e0
> [  300.350091]  __x64_sys_unlinkat+0x107/0x140
> [  300.350390]  x64_sys_call+0x1b55/0x21c0
> [  300.350690]  do_syscall_64+0xc1/0x1130
> [  300.350964]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  300.351316] RIP: 0033:0x7f69c443ebab
> [  300.351570] RSP: 002b:00007f69c3b33838 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000107
> [  300.352091] RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f69c=
443ebab
> [  300.352576] RDX: 0000000000000200 RSI: 00007f69bc008bf0 RDI: 000000000=
000000c
> [  300.353064] RBP: 000000000000000c R08: 0000000000000003 R09: 000000000=
0000078
> [  300.353547] R10: 000000000000009b R11: 0000000000000246 R12: 000000000=
0000000
> [  300.354034] R13: 00007f69bc008bf0 R14: 0000000000000200 R15: 000000000=
0000006
> [  300.354550]  </TASK>
> "
>
> Detailed information for "there is INFO: task hung in in jbd2_journal_com=
mit_transaction":
> https://github.com/laifryiee/syzkaller_logs/tree/main/260312_123000_jbd2_=
journal_commit_transaction
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260312_123000_jbd2_=
journal_commit_transaction/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260312_123000_jbd2_=
journal_commit_transaction/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260312_123000_jbd2_=
journal_commit_transaction/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/260312_123000_jbd2_=
journal_commit_transaction/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260312_123000_jbd2_=
journal_commit_transaction/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/260312_12=
3000_jbd2_journal_commit_transaction/bzImage_v7.0-rc3
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/260312_123000_jbd2_=
journal_commit_transaction/v7.0-rc3_dmesg.log
>
> "
> [  300.500157] INFO: task jbd2/sda-8:100 blocked for more than 147 second=
s.
> [  300.500574]       Not tainted 7.0.0-rc3-v7.0-rc3 #1
> [  300.500876] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  300.501335] task:jbd2/sda-8      state:D stack:0     pid:100   tgid:10=
0   ppid:2      task_flags:0x240040 flags:0x00
> [  300.501988] Call Trace:
> [  300.502146]  <TASK>
> [  300.502289]  __schedule+0xf9f/0x4200
> [  300.502526]  ? __pfx___schedule+0x10/0x10
> [  300.502787]  ? lock_release+0x14f/0x2d0
> [  300.503036]  schedule+0xf6/0x3d0
> [  300.503248]  jbd2_journal_wait_updates+0x146/0x270
> [  300.503551]  ? __pfx_jbd2_journal_wait_updates+0x10/0x10
> [  300.503892]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  300.504212]  ? lock_release+0x14f/0x2d0
> [  300.504464]  jbd2_journal_commit_transaction+0x7aa/0x6350
> [  300.504827]  ? lock_is_held_type+0xef/0x150
> [  300.505097]  ? __lock_acquire+0x412/0x2210
> [  300.505355]  ? __lock_acquire+0x412/0x2210
> [  300.505616]  ? __pfx_jbd2_journal_commit_transaction+0x10/0x10
> [  300.505980]  ? do_raw_spin_lock+0x140/0x280
> [  300.506244]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [  300.506526]  ? lock_acquire+0x1c1/0x330
> [  300.506782]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.507069]  ? _raw_spin_unlock_irqrestore+0x35/0x70
> [  300.507376]  ? lockdep_hardirqs_on+0x85/0x110
> [  300.507653]  ? _raw_spin_unlock_irqrestore+0x45/0x70
> [  300.507956]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.508280]  ? __timer_delete_sync+0x21e/0x300
> [  300.508578]  ? __this_cpu_preempt_check+0x21/0x30
> [  300.508879]  ? lock_release+0x14f/0x2d0
> [  300.509129]  kjournald2+0x203/0x790
> [  300.509361]  ? __pfx_kjournald2+0x10/0x10
> [  300.509617]  ? lockdep_hardirqs_on+0x85/0x110
> [  300.509897]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  300.510221]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [  300.510559]  ? __kthread_parkme+0x1bc/0x260
> [  300.510831]  ? __pfx_kjournald2+0x10/0x10
> [  300.511089]  kthread+0x41a/0x570
> [  300.511303]  ? calculate_sigpending+0x8d/0xb0
> [  300.511578]  ? __pfx_kthread+0x10/0x10
> [  300.511821]  ret_from_fork+0x781/0xbe0
> [  300.512065]  ? __pfx_ret_from_fork+0x10/0x10
> [  300.512340]  ? native_load_tls+0x16/0x50
> [  300.512598]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> [  300.512934]  ? __switch_to+0x81e/0x1110
> [  300.513178]  ? __pfx_kthread+0x10/0x10
> [  300.513418]  ret_from_fork_asm+0x1a/0x30
> [  300.513690]  </TASK>
> "
>
> Hope this cound be insightful to you.
>
> Regards,
> Yi Lai
>
> ---
>
> If you don't need the following environment to reproduce the problem or i=
f you
> already have one reproduced environment, please ignore the following info=
rmation.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v=
7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65=
 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=3Dpflash,format=3Draw,reado=
nly=3Don,file=3D./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduc=
ed
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc =
has
>
> Fill the bzImage file into above start3.sh to load the target kernel in v=
m.
>
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc --e=
nable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
>
