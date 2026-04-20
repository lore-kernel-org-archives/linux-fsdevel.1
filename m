Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD23845B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669843; cv=none; b=BSR7oVk8VyANrp5HK/OfSsx5F2mbuAGaRitRxZP83TnbZYxRFL1Gd3wnLyA1pizGhV54QyBCfo8xDXg6IMRzFhfHuF+9NloRByM49ykPD7iKT1wMlFPyQMIJkoMd5hTSoqC0dwCQpOab8ZrwKKQe0xQZVlUspn9sAK/0P4I5L9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669843; c=relaxed/simple;
	bh=8SJmpwOcEbiMqJe54xl0w7n7rbv2p7hXICfOALVy6Zk=;
	h=Cc:Subject:Mime-Version:In-Reply-To:Content-Type:To:Message-Id:
	 From:References:Date; b=ogi6kxKmlqFgWq1JhlLgiD+t5ug55lsl3VEVz90D6I7LU91ZtNlA//2Zr3AbDB22h8qWZyVeZ1mGecVlyHYGb/UQWGM7R8UKEqP1TpM2ZW22SWnniToH6jQNU49JpG5sx1iLR76R9q9CcAu9UiGv+3kj0y+dG7XGrQxyZ7VvKng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fgsNB4wA; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fgsNB4wA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1776669829; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=8SJmpwOcEbiMqJe54xl0w7n7rbv2p7hXICfOALVy6Zk=;
 b=fgsNB4wAn9MEUXaGiRGlQDJ5jI0KkNXjapzJKBqeOBGxzQ3EMkp0q0y/L8VIQNngdXB7U9
 jucZ4hbkavTqPn3foc9/E17/voj//1TyMHOEJLD8ZDRgeEIgKTfdANzcOA3tiBh+VawC0S
 Dmxjf9VtAWMpNd+tR+jS1bADxv2DPpiZxZkNHrBY9COgikPYjlIbsmk9T6yu50nrP1KlPY
 tnX/GLX5GoEtAg6S99UBHGFXD0ZQys+lT+IXgKmJ03upDS9BudF3ay9I+JTNen5kqvirnD
 whFx7L/cyKRnePfd03FChWCNSHQAFX/zKzOPxWFONSGtLbdNXARI+MvQIq3SNA==
Cc: "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fsnotify: fix inode reference leak in fsnotify_recalc_mask()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260420064727.1760604-1-yinxin.x@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: "jack@suse.cz" <jack@suse.cz>
Message-Id: <b0a5d388d0b2cb320744535d7f9d8f59e469aa88.d60e52e9.50d8.4afd.95d2.6acf46297b6a@bytedance.com>
From: =?utf-8?q?=E5=B0=B9=E6=AC=A3?= <yinxin.x@bytedance.com>
X-Lms-Return-Path: <lba+169e5d483+8714e5+vger.kernel.org+yinxin.x@bytedance.com>
References: <20260420064727.1760604-1-yinxin.x@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 15:23:44 +0800

Cc=C2=A0 Jan
Sorry, I used the wrong email address.

Thanks,
Xin Yin

> From: "Xin Yin"<yinxin.x@bytedance.com>
> Date:=C2=A0 Mon, Apr 20, 2026, 14:51
> Subject:=C2=A0 [PATCH] fsnotify: fix inode reference leak in fsnotify_rec=
alc_mask()
> To: <jan@kara.cz>, <amir73il@gmail.com>
> Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Xin=
 Yin"<yinxin.x@bytedance.com>
> fsnotify_recalc_mask() fails to handle the return value of
> __fsnotify_recalc_mask(), which may return an inode pointer that needs
> to be released via fsnotify_drop_object() when the connector's HAS_IREF
> flag transitions from set to cleared.
>=C2=A0
> This manifests as a hung task with the following call trace:
>=C2=A0
> =C2=A0 INFO: task umount:1234 blocked for more than 120 seconds.
> =C2=A0 Call Trace:
> =C2=A0 =C2=A0__schedule
> =C2=A0 =C2=A0schedule
> =C2=A0 =C2=A0fsnotify_sb_delete
> =C2=A0 =C2=A0generic_shutdown_super
> =C2=A0 =C2=A0kill_anon_super
> =C2=A0 =C2=A0cleanup_mnt
> =C2=A0 =C2=A0task_work_run
> =C2=A0 =C2=A0do_exit
> =C2=A0 =C2=A0do_group_exit
>=C2=A0
> The race window that triggers the iref leak:
>=C2=A0
> =C2=A0 Thread A (adding mark) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Thread B (removing mark)
> =C2=A0 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80
> =C2=A0 fsnotify_add_mark_locked():
> =C2=A0 =C2=A0 fsnotify_add_mark_list():
> =C2=A0 =C2=A0 =C2=A0 spin_lock(conn->lock)
> =C2=A0 =C2=A0 =C2=A0 add mark_B(evictable) to list
> =C2=A0 =C2=A0 =C2=A0 spin_unlock(conn->lock)
> =C2=A0 =C2=A0 return
>=C2=A0
> =C2=A0 =C2=A0 /* ---- gap: no lock held ---- */
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fsnotify_detach=
_mark(mark_A):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_loc=
k(mark_A->lock)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear AT=
TACHED flag on mark_A
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unl=
ock(mark_A->lock)
>=C2=A0
> =C2=A0 =C2=A0 fsnotify_recalc_mask():
> =C2=A0 =C2=A0 =C2=A0 spin_lock(conn->lock)
> =C2=A0 =C2=A0 =C2=A0 __fsnotify_recalc_mask():
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* mark_A skipped: ATTACHED cleared */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* only mark_B(evictable) remains */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 want_iref =3D false
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 has_iref =3D true =C2=A0/* not yet cleared */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 -> HAS_IREF transitions true -> false
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 -> returns inode pointer
> =C2=A0 =C2=A0 =C2=A0 spin_unlock(conn->lock)
> =C2=A0 =C2=A0 =C2=A0 /* BUG: return value discarded!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* iput() and fsnotify_put_sb_watched_objects()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* are never called */
>=C2=A0
> Fix this by capturing the return value of __fsnotify_recalc_mask() and
> passing it to fsnotify_drop_object() after releasing the spinlock, which
> is the same pattern used in fsnotify_put_mark().
>=C2=A0
> Fixes: c3638b5b1374 ("fsnotify: allow adding an inode mark without pinnin=
g inode")
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
> =C2=A0fs/notify/mark.c | 8 +++++++-
> =C2=A01 file changed, 7 insertions(+), 1 deletion(-)
>=C2=A0
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index c2ed5b11b0fe6..cc93fcc2c5a9c 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -283,6 +283,8 @@ static void fsnotify_conn_set_children_dentry_flags(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsnotify_set_children_dentry_flags(fsno=
tify_conn_inode(conn));
> =C2=A0}
> =C2=A0
> +static void fsnotify_drop_object(unsigned int type, void *objp);
> +
> =C2=A0/*
> =C2=A0 * Calculate mask of events for a list of marks. The caller must ma=
ke sure
> =C2=A0 * connector and connector->obj cannot disappear under us. =C2=A0Ca=
llers achieve
> @@ -292,15 +294,19 @@ static void fsnotify_conn_set_children_dentry_flags=
(
> =C2=A0void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool update_children;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int type;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0void *objp;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!conn)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&conn->lock);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0update_children =3D !fsnotify_conn_watc=
hes_children(conn);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0__fsnotify_recalc_mask(conn);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0objp =3D __fsnotify_recalc_mask(conn);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D conn->type;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0update_children &=3D fsnotify_conn_watc=
hes_children(conn);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&conn->lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0fsnotify_drop_object(type, objp);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set children's PARENT_WATCHED flags =
only if parent started watching.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * When parent stops watching, we clear=
 false positive PARENT_WATCHED
> --=C2=A0
> 2.20.1
>=C2=A0
