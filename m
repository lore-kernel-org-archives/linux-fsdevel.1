Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306674502F
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774712004; cv=pass; b=VVS5fURRvQ+Hv1hcpXLk4N8saognGjNSvXpQf8JK8XuFBv6918YnuwZGRfTn4FHb7TQBzTXCOYeVSf7AFirFXLFVuswgEz4Jh9HOcsaRXVeVw8xUE9n8CuKF16CRSoLcfqbxcu9nUyWKM5+uNIr8gKeUFFoMD45sbskHoZ+Y97I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774712004; c=relaxed/simple;
	bh=A/0wriKYdahugBNlSipO5KOpIDYUKOn7KPPhcCy2pBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6hGKAqc0CIhwaSUWo34fxXTzBtKxQG6IfC6VLqzw7u97IU+mHtD5cBuXvsAW2s/m5YH84Yjtw+mejUZUMIdwvzFAkggo7Ja/6NLwF80oIxe+psCvf4sWNdBttjnu0V7i9K3oEnP7N1vBBmlRlcikArnKh9XGRqN9Ixx1cZX71A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZy5c3Fl; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZy5c3Fl"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66a9a2187a5so4826762a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 08:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774712002; cv=none;
        d=google.com; s=arc-20240605;
        b=S9fdnPuZDHThu9PFbW6ZGiopOd6+hLyJY6bmZhaknW9Ifx11Amud1p5fnx0gxftZQs
         8lfj/h2A+jIViXE7kFYs/wmDgjeJBfnrNcfAQuLmi63iGWVxXNemKxPMb5v9Ztrm8CtO
         5BTttkPqaIDFFVaSvOzsNS3goUZEaX2uSJtVInIodr7VGs66Lmsnzx9V4vU/KbVOSgB8
         nKYXwWtOUTD0EP42DBKMauGoYVnLCjRMpQIKrn02AW87xg7cv7SWtivYykvcl3uu0+vj
         cyA6elyiI1BU9v4LfUOdfC3Y8BYdiKFCKrtgo2OwZs3gA8PbcrGljoG4W2viF74SgFD/
         qBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eAKwany47bnANFWMHIaOVQLoWC7FGvUqO49LHFaTKQQ=;
        fh=hT4HMO8A1aIQhEg92ztagnhd3VGbMispoLRvlyRD5oE=;
        b=aOExYUg8jEgtSC3PIWnnEffGky871XyemK+k1Nsc8f894iwMa+itpiL/4NP3KbB1bk
         CoIT9XI0UWXkXftnbDfsq8izB4AVc/BKGl9lEcFUHlzWgSZ6i936F9ICzptVyBX7pMLT
         8GaUVeCTjpPkr2203NvnMADf543Rn24IPbm7P3z6/w/L1lQnzYaQXOGrTeCGKzrYDh5s
         M81h0es3FvdoKsQY374rJ2bikcN3BosaHsWNV3yJr9CyV1+iCZQpJLJOmJs6mjPjD3Ml
         td7VwZZsl8x7/BiSaWDjCUef9RIOdIIlGTl+Gnfwbhf61X1fPfUvmIWakn0SzG2i5J7Z
         O/cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774712002; x=1775316802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAKwany47bnANFWMHIaOVQLoWC7FGvUqO49LHFaTKQQ=;
        b=LZy5c3FlWzCRqNlPFgqGMloxWiEQSjOWcKdzBfmowwbOAYjVYOlo17K/ts+34l7WKS
         0FBP2NK1TXuRZzFV232O0nQGGC1AFMB0P1/J7M1FvnjenqwjSFUCuGXMxTbp/qwMRJgf
         AEzYZ/hZoUO4zIcFFtDXC9QksMYBz1MWbSUtlytNwvCG0ZZsO8B2Wtwcm9xdDBAlIx5B
         cKbWBz2HOEIQVw3EQq5AOG/sFbdkLi2lMik7W/6cQkuT2cFY97ZK7Y3M18nvO2algfWA
         zfHyKKIsuD0KJOGQdXwUOSIzsQH1iToQm9sSQx9DgvsPJ23C0Z+oSroL8f3EpoYLni4l
         cz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774712002; x=1775316802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAKwany47bnANFWMHIaOVQLoWC7FGvUqO49LHFaTKQQ=;
        b=jI+v4fa8j/ls4J7SmNwMi9EApTqX4IQH4k/2bFTV22XibKBufH6n4ZU7Cz5PZO0Ukb
         NrDdXzMWvMjaDs5HUNGc2eONDFPjbrMdFUNrOjDVSHe/2M3Z9lnuf1KqHzZ1Etd72+3J
         qHW82RacXC9AnvUpiWPz3GbWJlQeuocmukm11japVgv0PquRH1TRgtXVGkO61SHI8gXL
         wxcKPl5/kAZqIjs5DkdolpUQWX95XGRu7dXikZ7DBGmeXpoKn+QTVYpFyR+Dk9wQfQjo
         tqlKZNstjDYrI9kgJ8Qn8DTPSaa5kCDXS9qFyfc8pK3XWg0V/KqK4CfSglJ76wHXOtVd
         W1UA==
X-Forwarded-Encrypted: i=1; AJvYcCVcgGOIWVsc0n7WvBU6GJzA1RtOBCsf8SXzny2pJHNqpvORCFQJ+5BNG+iT3cDtyk6iTdi7X+Wt+mSRWbbi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZsGy5MtYY6TU9/ktJYtW2DMST1xOVxVM8wmg/qyfa6v1Sx8J
	3tjdaR30qvikrQWIUC9tU1kbJ2wyUudKraeMJQH8fGAQUruCpZ8AT6cRhcWCsTKlvmZHR1Z1xae
	p1w3FtMDChqpwY1VtNMzzqdoFVO9ad24=
X-Gm-Gg: ATEYQzz7buptowEzOSWdxWHV4SBRPl3YBaBkIlOwykRGxslfzAl4crw0Ar3FL4kDKcX
	p/VF+v/YLU/0xFyclOY2nbWnMR5boI3dDx5CXDGKAf3dC+ktbnmncjtJJMeS+I2OlicG1/oeRNP
	F7WPyEnB+ZeLmZn05vI5/z3nVVArKhsXOlgWDSpXdIbPsYh2Ok/+vEUpFJVjGIz+uiz6r9tLJ3R
	GqHZzpOInPjS6gE3kJjyjM1rzDbAZQ5xfGVzse8M20wBvej8DH2bO9zvATgltP41kldDzQZaE5T
	cHK1zycszv15sNLXdCXRC6qo6UZaNqOl08PmHMQ=
X-Received: by 2002:a05:6402:6c3:b0:66b:3cb7:f638 with SMTP id
 4fb4d7f45d1cf-66b3cb7fbf3mr2456159a12.10.1774712001527; Sat, 28 Mar 2026
 08:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328153146.3368470-1-mjguzik@gmail.com> <20260328153146.3368470-3-mjguzik@gmail.com>
In-Reply-To: <20260328153146.3368470-3-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 28 Mar 2026 16:33:09 +0100
X-Gm-Features: AQROBzAvKP2azTntT5DNQ4R-5lU9ukFi4xz306ejCXFxNu6oKw2jzP_hjXltkbo
Message-ID: <CAGudoHE6089nSpA6mvj0sSoBB5c1kde8yNsPzXukaie8fpw=wg@mail.gmail.com>
Subject: Re: [PATCH] fs: revert insert_inode_locked() eviction wait change and
 explain why
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Lai, Yi" <yi1.lai@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

oops, sorry guys. this one snuck in with bad globbing in the shell

On Sat, Mar 28, 2026 at 4:32=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> It causes a deadlock, reproducer can be found here:
> https://lore.kernel.org/linux-fsdevel/abNvb2PcrKj1FBeC@ly-workstation/
>
> The real bug is in ext4, but I'm not digging into it and a working order
> needs to be restored.
>
> Commentary is added as a warning sign for another sucker^Wdeveloper.
>
> Fixes: 88ec797c468097a8 ("fs: make insert_inode_locked() wait for inode d=
estruction")
> Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/inode.c | 53 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index cc12b68e021b..5f7e76c9fb53 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1037,20 +1037,19 @@ long prune_icache_sb(struct super_block *sb, stru=
ct shrink_control *sc)
>         return freed;
>  }
>
> -static void __wait_on_freeing_inode(struct inode *inode, bool hash_locke=
d, bool rcu_locked);
> -
> +static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_h=
ash_locked);
>  /*
>   * Called with the inode lock held.
>   */
>  static struct inode *find_inode(struct super_block *sb,
>                                 struct hlist_head *head,
>                                 int (*test)(struct inode *, void *),
> -                               void *data, bool hash_locked,
> +                               void *data, bool is_inode_hash_locked,
>                                 bool *isnew)
>  {
>         struct inode *inode =3D NULL;
>
> -       if (hash_locked)
> +       if (is_inode_hash_locked)
>                 lockdep_assert_held(&inode_hash_lock);
>         else
>                 lockdep_assert_not_held(&inode_hash_lock);
> @@ -1064,7 +1063,7 @@ static struct inode *find_inode(struct super_block =
*sb,
>                         continue;
>                 spin_lock(&inode->i_lock);
>                 if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) =
{
> -                       __wait_on_freeing_inode(inode, hash_locked, true)=
;
> +                       __wait_on_freeing_inode(inode, is_inode_hash_lock=
ed);
>                         goto repeat;
>                 }
>                 if (unlikely(inode_state_read(inode) & I_CREATING)) {
> @@ -1088,11 +1087,11 @@ static struct inode *find_inode(struct super_bloc=
k *sb,
>   */
>  static struct inode *find_inode_fast(struct super_block *sb,
>                                 struct hlist_head *head, unsigned long in=
o,
> -                               bool hash_locked, bool *isnew)
> +                               bool is_inode_hash_locked, bool *isnew)
>  {
>         struct inode *inode =3D NULL;
>
> -       if (hash_locked)
> +       if (is_inode_hash_locked)
>                 lockdep_assert_held(&inode_hash_lock);
>         else
>                 lockdep_assert_not_held(&inode_hash_lock);
> @@ -1106,7 +1105,7 @@ static struct inode *find_inode_fast(struct super_b=
lock *sb,
>                         continue;
>                 spin_lock(&inode->i_lock);
>                 if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) =
{
> -                       __wait_on_freeing_inode(inode, hash_locked, true)=
;
> +                       __wait_on_freeing_inode(inode, is_inode_hash_lock=
ed);
>                         goto repeat;
>                 }
>                 if (unlikely(inode_state_read(inode) & I_CREATING)) {
> @@ -1842,13 +1841,28 @@ int insert_inode_locked(struct inode *inode)
>         while (1) {
>                 struct inode *old =3D NULL;
>                 spin_lock(&inode_hash_lock);
> -repeat:
>                 hlist_for_each_entry(old, head, i_hash) {
>                         if (old->i_ino !=3D ino)
>                                 continue;
>                         if (old->i_sb !=3D sb)
>                                 continue;
>                         spin_lock(&old->i_lock);
> +                       /*
> +                        * FIXME: inodes awaiting eviction don't get wait=
ed for
> +                        *
> +                        * This is a bug because the hash can temporarily=
 end up with duplicate inodes.
> +                        * It happens to work becuase new inodes are inse=
rted at the beginning of the
> +                        * chain, meaning they will be found first should=
 anyone do a lookup.
> +                        *
> +                        * Fixing the above results in deadlocks in ext4 =
due to journal handling during
> +                        * inode creation and eviction -- the eviction si=
de waits for creation side to
> +                        * finish. Adding __wait_on_freeing_inode results=
 in both sides waiting on each
> +                        * other.
> +                        */
> +                       if (inode_state_read(old) & (I_FREEING | I_WILL_F=
REE)) {
> +                               spin_unlock(&old->i_lock);
> +                               continue;
> +                       }
>                         break;
>                 }
>                 if (likely(!old)) {
> @@ -1859,11 +1873,6 @@ int insert_inode_locked(struct inode *inode)
>                         spin_unlock(&inode_hash_lock);
>                         return 0;
>                 }
> -               if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
> -                       __wait_on_freeing_inode(old, true, false);
> -                       old =3D NULL;
> -                       goto repeat;
> -               }
>                 if (unlikely(inode_state_read(old) & I_CREATING)) {
>                         spin_unlock(&old->i_lock);
>                         spin_unlock(&inode_hash_lock);
> @@ -2534,18 +2543,16 @@ EXPORT_SYMBOL(inode_needs_sync);
>   * wake_up_bit(&inode->i_state, __I_NEW) after removing from the hash li=
st
>   * will DTRT.
>   */
> -static void __wait_on_freeing_inode(struct inode *inode, bool hash_locke=
d, bool rcu_locked)
> +static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_h=
ash_locked)
>  {
>         struct wait_bit_queue_entry wqe;
>         struct wait_queue_head *wq_head;
>
> -       VFS_BUG_ON(!hash_locked && !rcu_locked);
> -
>         /*
>          * Handle racing against evict(), see that routine for more detai=
ls.
>          */
>         if (unlikely(inode_unhashed(inode))) {
> -               WARN_ON(hash_locked);
> +               WARN_ON(is_inode_hash_locked);
>                 spin_unlock(&inode->i_lock);
>                 return;
>         }
> @@ -2553,16 +2560,14 @@ static void __wait_on_freeing_inode(struct inode =
*inode, bool hash_locked, bool
>         wq_head =3D inode_bit_waitqueue(&wqe, inode, __I_NEW);
>         prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBL=
E);
>         spin_unlock(&inode->i_lock);
> -       if (rcu_locked)
> -               rcu_read_unlock();
> -       if (hash_locked)
> +       rcu_read_unlock();
> +       if (is_inode_hash_locked)
>                 spin_unlock(&inode_hash_lock);
>         schedule();
>         finish_wait(wq_head, &wqe.wq_entry);
> -       if (hash_locked)
> +       if (is_inode_hash_locked)
>                 spin_lock(&inode_hash_lock);
> -       if (rcu_locked)
> -               rcu_read_lock();
> +       rcu_read_lock();
>  }
>
>  static __initdata unsigned long ihash_entries;
> --
> 2.48.1
>
