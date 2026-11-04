Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793791763;
	b=DNDSp/qWCej8tvB3pYkcvShO5eN6zUb3Kg9UGnhbvm+4QTXR9o/N8mFbdawk4fO001hC
	 ALtXQKcSoYvyEivrYp1kjVq4FolRwnPxti1bxhio3RUiIfKQCO7Lu1zCeMTrZNN2xZykX
	 r1pG++XaiEskDPgSJ7IBhlWgox30Z+xSaHMO5ac46yZjyFBCV3bwfgK2/BRzyD+yFcig7
	 ZeM87hPfttdI4SkXStd79vkKx5zVmPYmg43OzjshrjfmdhNxhdugwUO7yrtBI/pQEGJOA
	 ApmhnUrU/5ZSviR5b5+15+M/nG/HBMtk9+/NIb0n2P9YvcnFf1yUev6Nvr8OJoC21Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rpE1rKAahFNtJMl6F6/W6vx4G1mPjCzL+qxRLArJSlc=;
	b=PV46fRA15pEWjKBbgJMaWigEtjhiVzJ6I/0lUZ/4e64velXR2MKnVf2+ilfa1hr5dww/
	 hGN0a+l4aU2y1YQzkZXwXJQ6An2338YYblpg2uhx0bPn/SSyJPtRjdAtuxAlLC6Be/NjV
	 AjfaNEYK1wJmVNWCgFKABj/w1Zh0dAmoUyUwKHDhY5n0/QXkeEqA6EAqPFc175gIBGpm1
	 HJELPK//sdi/XanXjS1FS7QYhTOHMTW6o/olt4oya2ftE56zlIS3DiulfSJsXIF64akW5
	 3I88w9a1FA9bGsnzfCs9YgfCCOM60b4fz16e1JEaumKqjgOYRvf/TrP+8cofFL0pHAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l/7/7qpJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB055606A32D
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 11:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB055606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/7/7qpJ
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4c9abc1824so85096766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 03:29:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793791761; cv=none;
        d=google.com; s=arc-20260327;
        b=D/UJTwPYeAWiiAmyMxsMDLgPdWiBHVk4q/vdwH48KkQStbzO6xPBsP4I00uWwK8zKM
         HmcZSAH++GXgqNruIzrrJcYwRV76ejTQfsZOIVkWQ5I5kfESd2kVh57yVoTI7O/olWLx
         N+oUq6CZ/jVXlBz7/afqY/Bl2V7o+C4g0lQqbKugSAEKSn5F36KYj9Ub5imZqbcoAPyK
         e/tOmOtNkhNzX6k7QGtbCVfuNIsvRcnMHHmUqsK1EcubQOe3hTu+313+RfiE/yzqp/jh
         73AFEZyEAYHLPAYBL5mnfl5EIB7SH5yJIOh7dfw8By9wdRZ2KJ2b41WFdr5soLXdsExW
         6b7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rpE1rKAahFNtJMl6F6/W6vx4G1mPjCzL+qxRLArJSlc=;
        fh=EhZQHPiv96WVkcKZxO6HqEyh0JkReF3WR6i6914z+Ko=;
        b=fI4eHTzZlxUdWDJsWaGqD1xxUuKNOj9VAyY0PIKshGANAF1PnQ1d2KmGVFEsIOP5M4
         E3dLWvZPX7aQStCNAveXfKDY9NcYNn3Hg7mvJVpbyKFFsyxiIXZXe6TDCSb5WPb35F4U
         U1tR1/S6PCNGOB0wFap/4VqLoXzpHyvXQVnnHnwwHe7MDIj8MoN67MVt8uflDDc9Uwvq
         JoPAXyxKvhFiDjfnYlEy9D4VFFPMUhErxthlqrvjbwzwKT65yGdvzKlTPaawlUDcNK7j
         7bdaBWgCkIpTyPIeWe3VOOOiem98mUSfqHusDKh9XkK95xeLkl6q9I5Z+RBMaQI2sT/k
         qIYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793791761; x=1794396561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rpE1rKAahFNtJMl6F6/W6vx4G1mPjCzL+qxRLArJSlc=;
        b=l/7/7qpJQGGWILO+cEorLqFkR+fwlAWkExR0InQOsPCHwWeEfi7uEKBM8qdoO6Cm0C
         m2H1GED+U5pn0MgcU5Ai6lekFpnnxTrMnzZ/T1NrK19za9s7iS8Z89Ss7/c1TE5GGzKa
         Q4XFMNsiaOLFnPrzh0HUoVKlfZp4p/oF2Gh/vrbCW978iU7lc4rIVSQKenvd4ua2brB9
         JEMitMe65P87zwr/tYLBAkTcqe5BTuqPpAmaYIWNbA82oC9SAZJpzv4lsC16+RzNDjGC
         rq/MCnIHOd5SWVbXOTB773EtKtY/ZvN0pad+htXsnx4BFn1O0NcNrKP7jMluV6zG3sKn
         VA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793791761; x=1794396561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rpE1rKAahFNtJMl6F6/W6vx4G1mPjCzL+qxRLArJSlc=;
        b=uLWSH7GlAoB2B0h1i3wURXpkUXw/Ez5EDtSHVtXA9980fzB7OCmKQNaPPp0AHTC9A1
         z7XRtfUlGq2FtBTFO9cnVsR7JDTaE5HBR97WnbtoC4Ik9rLFuGkHPIDc3EnGx25a1ws0
         M4hx+89pUeXTciuJnyCKO/tuJI/TMTeCMh1Bgyeo9KOtAF43tF8+4pLG0BCPFnuaxc+k
         hXT8Bf411jVL4EriKK0hBIVhQU35rzU46Om+smWfH1zG6fVAcoy+9ggutn43Vbk/22Eb
         eBn11KisPA+ynx5iSBjKsrZ+9w32ihm8zsG4/5A59BdETKp+0uuIoR0EDRPV3/Zetdik
         +yhw==
X-Forwarded-Encrypted: i=1; AKwUvBx/w7Zsk6y3qFON/XytktEgPHH8NMrvMNKIE6qnXfbYi9aDfA4HSBD3089HwXgtVsBq1UlZfA/dtn5ci08d@vger.kernel.org
X-Gm-Message-State: APuU4Z+dgbuM5cxbyvG5UnRFlrpIu2VzLJMPXddS/d6lGPqgkpoo4OEG
	J35D4CC6p5WzDG9jUdtcd3+A9a0n/W7lW92uglFF8shnJzmdgNALwzkcqnguQz61Ai+9sg3JAMX
	1utIxaP/fEwBZwmg0pqwYCHYtnm06SlSChdUX
X-Gm-Gg: AYBFou15Fx4DzkPztxYyMQmYKj9tg77pLpDpPo0K4TqncBsSYxL8CvR0RmIkE1ZSZMN
	NlrXpvxP5IjGJ8SqXwO54f4m+Qj44kkrE/o4VTdL5m1m/IG/7iWkP/9JGXkIzAAzkLMVvj1i0XM
	SNyu8g1pOPisZifOc6hL4jF8+CCStfYvjFbODhQcpeptbl9W82A/qM3dZXJqTyc2uiL74wEXWjq
	rJ1225gd4WzGh5z3sx0+Ij+epLDxljA6oGCWkQ1HFDrx4Vpt329Y+nTucSXdCQSuBFslY1DzC73
	xPGIgAxD6tEPi6x4Rmn/cKxIj+DZcab77lUwMfSuxO3pnaqOGYMd2l4x7L+e6vWUDwGGGgeMfuH
	SN/1hMOCqea3RdlYNcqfA/DNQMku8IUJR6eZ2VfWbfCUWwrXDJ8pFNCZ+332NO4Adlq9K6oAxcq
	o1ZPJTE/Kt0K96htBJjks=
X-Received: by 2002:a17:907:9603:b0:c31:8cfe:9a25 with SMTP id
 a640c23a62f3a-c4ca7a4d9bfmr1379031266b.9.1793791760796; Wed, 04 Nov 2026
 03:29:20 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023162906.2938-1-drifabdelmalekmohamedsaid@gmail.com>
In-Reply-To: <20261023162906.2938-1-drifabdelmalekmohamedsaid@gmail.com>
From: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Date: Wed, 4 Nov 2026 12:29:09 +0100
X-Gm-Features: AclHuK9n0n1wFI-BQNi_I7J_lSePj75BbeFovuuaUe5meINQJKR3eCub08MReQg
Message-ID: <CA+xk8n_Dufvfa5_tsHxRAVaVnEjZkd9Zy5r3ORXpqjYtLsBXng@mail.gmail.com>
Subject: Re: [PATCH v2] configfs: fix slab-UAF Write in config_item_put
To: Breno Leitao <leitao@debian.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com, 
	Ran Hongyun <ranhongyun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
Just following up on this patch to see if anyone has had a chance to
review it or if any changes are needed since we're at 7.4-rc1.
Thanks,
Drif Abdelmalek Mohamed Said

On Fri, Oct 23, 2026 at 5:29=E2=80=AFPM Drif Abdelmalek Mohamed Said
<drifabdelmalekmohamedsaid@gmail.com> wrote:
>
> syzbot reported:
>
> BUG: KASAN: slab-use-after-free in instrument_atomic_read_write
>            include/linux/instrumented.h:112 [inline]
> BUG: KASAN: slab-use-after-free in atomic_fetch_sub_release
>            include/linux/atomic/atomic-instrumented.h:400 [inline]
> BUG: KASAN: slab-use-after-free in __refcount_sub_and_test
>            include/linux/refcount.h:389 [inline]
> BUG: KASAN: slab-use-after-free in __refcount_dec_and_test
>            include/linux/refcount.h:432 [inline]
> BUG: KASAN: slab-use-after-free in refcount_dec_and_test
>            include/linux/refcount.h:450 [inline]
> BUG: KASAN: slab-use-after-free in kref_put
>            include/linux/kref.h:64 [inline]
> BUG: KASAN: slab-use-after-free in config_item_put+0x26/0x90
>            fs/configfs/item.c:149
> Write of size 4 at addr ffff88803b6444b4 by task syz-executor324/5709
>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_address_description+0x55/0x1e0 mm/kasan/report.c:378
>  print_report+0x58/0x70 mm/kasan/report.c:482
>  kasan_report+0x117/0x150 mm/kasan/report.c:595
>  check_region_inline mm/kasan/generic.c:-1 [inline]
>  kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
>  instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
>  atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 =
[inline]
>  __refcount_sub_and_test include/linux/refcount.h:389 [inline]
>  __refcount_dec_and_test include/linux/refcount.h:432 [inline]
>  refcount_dec_and_test include/linux/refcount.h:450 [inline]
>  kref_put include/linux/kref.h:64 [inline]
>  config_item_put+0x26/0x90 fs/configfs/item.c:149
>  configfs_symlink+0x6be/0x11d0 fs/configfs/symlink.c:225
>  vfs_symlink+0x18b/0x330 fs/namei.c:5823
>  filename_symlinkat+0x1cd/0x420 fs/namei.c:5848
>  __do_sys_symlinkat fs/namei.c:5868 [inline]
>  __se_sys_symlinkat+0x4e/0x2b0 fs/namei.c:5863
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Allocated by task 5712:
>  kasan_save_stack mm/kasan/common.c:57 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>  poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
>  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:426
>  kasan_kmalloc include/linux/kasan.h:263 [inline]
>  __kmalloc_cache_noprof+0x3d5/0x680 mm/slub.c:5563
>  _kmalloc_noprof include/linux/slab.h:991 [inline]
>  _kzalloc_noprof include/linux/slab.h:1312 [inline]
>  nvmet_ports_make+0xe6/0xf00 drivers/nvme/target/configfs.c:2054
>  configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1369
>  vfs_mkdir+0x408/0x620 fs/namei.c:5439
>  filename_mkdirat+0x289/0x520 fs/namei.c:5472
>  __do_sys_mkdir fs/namei.c:5499 [inline]
>  __se_sys_mkdir+0x34/0x150 fs/namei.c:5496
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 5712:
>  kasan_save_stack mm/kasan/common.c:57 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
>  poison_slab_object mm/kasan/common.c:264 [inline]
>  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:296
>  kasan_slab_free include/linux/kasan.h:235 [inline]
>  slab_free_hook mm/slub.c:2748 [inline]
>  slab_free mm/slub.c:6509 [inline]
>  kfree+0x1c5/0x6d0 mm/slub.c:6802
>  config_item_cleanup fs/configfs/item.c:128 [inline]
>  config_item_release+0x13a/0x2d0 fs/configfs/item.c:137
>  configfs_rmdir+0x885/0x950 fs/configfs/dir.c:1580
>  vfs_rmdir+0x3e9/0x6b0 fs/namei.c:5544
>  filename_rmdir+0x292/0x520 fs/namei.c:5601
>  __do_sys_rmdir fs/namei.c:5624 [inline]
>  __se_sys_rmdir+0x2e/0x140 fs/namei.c:5621
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff88803b644000
>  which belongs to the cache kmalloc-4k of size 4096
> The buggy address is located 1204 bytes inside of
>  freed 4096-byte region [ffff88803b644000, ffff88803b645000)
>
> This is a race between a thread creating a symlink and another one
> doing rmdir on a parent (or ancestor) directory of symlink creation dir.
>
> configfs_symlink() takes a reference on parent_item, the directory the
> link is created in, and then drops the directory inode lock around
> get_target(). While the lock is dropped, a concurrent rmdir can remove
> the group that parent_item belongs to.
>
> If parent_item is a default group embedded in a larger object, such as
> nvmet_port.subsys_group, the reference on the embedded item does not
> keep the containing object alive. rmdir frees the object, and the final
> config_item_put(parent_item) in configfs_symlink() then decrements a
> kref inside freed memory.
>
> Fix this by not holding parent_item across the unlocked window. Drop
> the reference before inode_unlock() and look it up again from
> dentry->d_parent after inode_lock(). configfs_get_config_item() returns
> NULL if the parent dentry was unhashed in the meantime, in which case
> release the target references and return -ENOENT.
>
> Re-looking up parent_item is not sufficient on its own.
> configfs_get_config_item() only fails if the parent dentry has been
> unhashed, and the rmdir path in another thread may skip that: if
> simple_rmdir() failed, the earlier d_drop() was skipped, so the dentry
> can stay hashed even though the directory has already been detached.
>
> Such a directory was created as a default group (CONFIGFS_USET_DIR), so
> configfs_rmdir() takes the CONFIGFS_USET_DIR branch and calls
> configfs_detach_group(). detach_groups() then marks each child inode
> S_DEAD (d_inode(child)->i_flags |=3D S_DEAD). Check IS_DEADDIR(dir)
> after retaking the inode lock and before taking a reference on the
> parent, and return -ENOENT. This also rejects a detached directory
> whose dentry is still hashed.
>
> Reported-by: syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D63336d70e1af377d7388
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gm=
ail.com>
> ---
> v2: Added check for dead dir, this would be helpful when configfs_remove_=
dir skips
> unhashing the dentry.
> v1: https://lore.kernel.org/all/20261017123748.4430-1-drifabdelmalekmoham=
edsaid@gmail.com/T/
>  fs/configfs/symlink.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
> index 89178f5d371a..7d746a10c369 100644
> --- a/fs/configfs/symlink.c
> +++ b/fs/configfs/symlink.c
> @@ -196,11 +196,26 @@ int configfs_symlink(const struct mnt_idmap *idmap,=
 struct inode *dir,
>          *
>          *  AV, a thoroughly annoyed bastard.
>          */
> +
> +       /* Put the reference back, retake and check after relocking*/
> +       config_item_put(parent_item);
> +       parent_item =3D NULL;
>         inode_unlock(dir);
>         ret =3D get_target(symname, &target_item, &target_sd, dentry->d_s=
b);
>         inode_lock(dir);
>         if (ret)
> -               goto out_put;
> +               goto out_put; /* config_item_put on NULL, no problem */
> +
> +       if (IS_DEADDIR(dir)) {
> +               ret =3D -ENOENT;
> +               goto out_put_target;
> +       }
> +
> +       parent_item =3D configfs_get_config_item(dentry->d_parent);
> +       if (!parent_item) {
> +               ret =3D -ENOENT;
> +               goto out_put_target;
> +       }
>
>         if (dentry->d_inode || d_unhashed(dentry))
>                 ret =3D -EEXIST;
> @@ -218,6 +233,7 @@ int configfs_symlink(const struct mnt_idmap *idmap, s=
truct inode *dir,
>                                                      target_item);
>         }
>
> +out_put_target:
>         configfs_put(target_sd);
>         config_item_put(target_item);
>
> --
> 2.43.0
>
