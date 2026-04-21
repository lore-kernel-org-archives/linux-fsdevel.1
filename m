Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075E18E025
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776737075; cv=none; b=WmY5koqyzKFTp5GlvK3SFGVHn3Pqb1Gi0+XVna1WQ0nvYCMWYgPIdkDjxkwOPPo6tolG03iT0v2fA8SvnTcTJ+RaJnil1f4E5/2PHUIfvnOtHEZvWI94cK7H4eJMmsJ1bQGTKmXEjzTl1TnuBsCV/BP9Zj5tJNJNj/plZIIM2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776737075; c=relaxed/simple;
	bh=qJLxjW0Pid246NzXkdkmMuKd60nZcni0RBP2KI0bEOY=;
	h=In-Reply-To:Message-Id:Cc:From:Mime-Version:References:
	 Content-Type:Date:To:Subject; b=HRbZiwfDfWrry5CcjvRDzBfX3BDK6NNCDnvItkxeU95N8e3lV05XT9opBX8TESlZz2h3hp/uX/0fcE/rllNxTZX8AQ3xmX+qHRTMIRQimwa/bQqoIfOygUngG2UounM5WaKcJ/QIFXcQsmwW3mabaLIcG610gkgTsWESTk0tS40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Lms2/tJu; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Lms2/tJu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1776737067; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qJLxjW0Pid246NzXkdkmMuKd60nZcni0RBP2KI0bEOY=;
 b=Lms2/tJufiphPb++CLKcEalDjoh8FjYTFdA2obfytvKekb0fSnF1nnTAbP7uVmunmBplfj
 dDm6FLM9pxbT1I+tXL3j6vIhnuCVLhqRbvz3YGSe59tieBo1z6eafVHUS+5poM+cyCuiDx
 DFIoZagzqF0k2i0msRJDTmoXXuN4Ys9lf0+Mom2JzdkoVyylqr++dIEollaDUzENvCiHu5
 CVnmpZxW9rpTaULdyiO5lj77J7LI/lKxmjni5pdqHPlKf6JTE2WCkWs2fTO5hChCX174QE
 8piuA/WBXTVJIJHcuuSxkoPpGOap7R/Awmh4RPZGepwyp3N4BYazUclfrYRH7Q==
X-Lms-Return-Path: <lba+169e6db28+055fac+vger.kernel.org+yinxin.x@bytedance.com>
In-Reply-To: <CAOQ4uxiPsbHb0o5voUKyPFMvBsDkG914FYDcs4C5UpBMNm0Vcg@mail.gmail.com>
Message-Id: <b0a5d388d0b2cb320744535d7f9d8f59e469aa88.5f8a69cf.f26a.45a2.8d5f.c830525ff22e@bytedance.com>
Cc: <jan@kara.cz>, <linux-fsdevel@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
From: =?utf-8?q?=E5=B0=B9=E6=AC=A3?= <yinxin.x@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420064727.1760604-1-yinxin.x@bytedance.com>
	<CAOQ4uxiPsbHb0o5voUKyPFMvBsDkG914FYDcs4C5UpBMNm0Vcg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary=2268eec1fc9a8a5bb88ce6349a74a7d56d0db2341ad6901f4f89593e76fb
Date: Tue, 21 Apr 2026 10:04:21 +0800
To: "Amir Goldstein" <amir73il@gmail.com>
Subject: Re: [PATCH] fsnotify: fix inode reference leak in fsnotify_recalc_mask()

--2268eec1fc9a8a5bb88ce6349a74a7d56d0db2341ad6901f4f89593e76fb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8


> From: "Amir Goldstein"<amir73il@gmail.com>
> Date:=C2=A0 Mon, Apr 20, 2026, 21:34
> Subject:=C2=A0 Re: [PATCH] fsnotify: fix inode reference leak in fsnotify=
_recalc_mask()
> To: "Xin Yin"<yinxin.x@bytedance.com>
> Cc: <jan@kara.cz>, <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.ke=
rnel.org>
> On Mon, Apr 20, 2026 at 8:52=E2=80=AFAM Xin Yin <yinxin.x@bytedance.com> =
wrote:
> >
> > fsnotify_recalc_mask() fails to handle the return value of
> > __fsnotify_recalc_mask(), which may return an inode pointer that needs
> > to be released via fsnotify_drop_object() when the connector's HAS_IREF
> > flag transitions from set to cleared.
> >
> > This manifests as a hung task with the following call trace:
> >
> > =C2=A0 INFO: task umount:1234 blocked for more than 120 seconds.
> > =C2=A0 Call Trace:
> > =C2=A0 =C2=A0__schedule
> > =C2=A0 =C2=A0schedule
> > =C2=A0 =C2=A0fsnotify_sb_delete
> > =C2=A0 =C2=A0generic_shutdown_super
> > =C2=A0 =C2=A0kill_anon_super
> > =C2=A0 =C2=A0cleanup_mnt
> > =C2=A0 =C2=A0task_work_run
> > =C2=A0 =C2=A0do_exit
> > =C2=A0 =C2=A0do_group_exit
> >
> > The race window that triggers the iref leak:
> >
> > =C2=A0 Thread A (adding mark) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0Thread B (removing mark)
> > =C2=A0 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80
> > =C2=A0 fsnotify_add_mark_locked():
> > =C2=A0 =C2=A0 fsnotify_add_mark_list():
> > =C2=A0 =C2=A0 =C2=A0 spin_lock(conn->lock)
> > =C2=A0 =C2=A0 =C2=A0 add mark_B(evictable) to list
> > =C2=A0 =C2=A0 =C2=A0 spin_unlock(conn->lock)
> > =C2=A0 =C2=A0 return
> >
> > =C2=A0 =C2=A0 /* ---- gap: no lock held ---- */
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fsnotify_det=
ach_mark(mark_A):
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_=
lock(mark_A->lock)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear=
 ATTACHED flag on mark_A
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_=
unlock(mark_A->lock)
> >
> > =C2=A0 =C2=A0 fsnotify_recalc_mask():
> > =C2=A0 =C2=A0 =C2=A0 spin_lock(conn->lock)
> > =C2=A0 =C2=A0 =C2=A0 __fsnotify_recalc_mask():
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* mark_A skipped: ATTACHED cleared */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* only mark_B(evictable) remains */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 want_iref =3D false
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 has_iref =3D true =C2=A0/* not yet cleared =
*/
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 -> HAS_IREF transitions true -> false
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 -> returns inode pointer
> > =C2=A0 =C2=A0 =C2=A0 spin_unlock(conn->lock)
> > =C2=A0 =C2=A0 =C2=A0 /* BUG: return value discarded!
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0* iput() and fsnotify_put_sb_watched_objects=
()
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0* are never called */
> >
>=C2=A0
> Hi Xin!
>=C2=A0
> Ouch! nasty one.
> Very good analysis.
> Do you also have a reproducer?

Yes, I have a reproducer attached.=C2=A0
In my testing it reproduces reliably - typically within the first round.
./repro_nomod 200 16 3

Thanks,
Xin.
>=C2=A0
>=C2=A0
> > Fix this by capturing the return value of __fsnotify_recalc_mask() and
> > passing it to fsnotify_drop_object() after releasing the spinlock, whic=
h
> > is the same pattern used in fsnotify_put_mark().
>=C2=A0
> The fix looks correct, but I prefer for my mental model to keep
> fsnotify_drop_object() in one place at the end of fsnotify_put_mark().
>=C2=A0
> Please see the suggested (only sanity tested) patch.
>=C2=A0
> Thanks,
> Amir.
>=C2=A0
>=C2=A0
> >
> > Fixes: c3638b5b1374 ("fsnotify: allow adding an inode mark without pinn=
ing inode")
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > ---
> > =C2=A0fs/notify/mark.c | 8 +++++++-
> > =C2=A01 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> > index c2ed5b11b0fe6..cc93fcc2c5a9c 100644
> > --- a/fs/notify/mark.c
> > +++ b/fs/notify/mark.c
> > @@ -283,6 +283,8 @@ static void fsnotify_conn_set_children_dentry_flags=
(
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 fsnotify_set_children_dentry_flags(fsnotify=
_conn_inode(conn));
> > =C2=A0}
> >
> > +static void fsnotify_drop_object(unsigned int type, void *objp);
> > +
> > =C2=A0/*
> > =C2=A0 * Calculate mask of events for a list of marks. The caller must =
make sure
> > =C2=A0 * connector and connector->obj cannot disappear under us. =C2=A0=
Callers achieve
> > @@ -292,15 +294,19 @@ static void fsnotify_conn_set_children_dentry_fla=
gs(
> > =C2=A0void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> > =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool update_children;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned int type;
> > + =C2=A0 =C2=A0 =C2=A0 void *objp;
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!conn)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock(&conn->lock);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_children =3D !fsnotify_conn_watches_=
children(conn);
> > - =C2=A0 =C2=A0 =C2=A0 __fsnotify_recalc_mask(conn);
> > + =C2=A0 =C2=A0 =C2=A0 objp =3D __fsnotify_recalc_mask(conn);
> > + =C2=A0 =C2=A0 =C2=A0 type =3D conn->type;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_children &=3D fsnotify_conn_watches_=
children(conn);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&conn->lock);
> > + =C2=A0 =C2=A0 =C2=A0 fsnotify_drop_object(type, objp);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set children's PARENT_WATCHED flags=
 only if parent started watching.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* When parent stops watching, we clea=
r false positive PARENT_WATCHED
> > --
> > 2.20.1
>=C2=A0

--2268eec1fc9a8a5bb88ce6349a74a7d56d0db2341ad6901f4f89593e76fb
Content-Disposition: attachment; filename="repro_nomod.c"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; name="repro_nomod.c"

LyoKICogUmVwcm9kdWNlciBmb3IgZnNub3RpZnlfcmVjYWxjX21hc2soKSBpcmVmIGxlYWsgKE5P
IGtlcm5lbCBtb2RpZmljYXRpb24pLgogKgogKiBCdWc6IGZzbm90aWZ5X3JlY2FsY19tYXNrKCkg
ZGlzY2FyZHMgdGhlIHJldHVybiB2YWx1ZSBvZgogKiBfX2Zzbm90aWZ5X3JlY2FsY19tYXNrKCks
IGxlYWtpbmcgYW4gaWhvbGQoKSByZWZlcmVuY2Ugd2hlbiBIQVNfSVJFRgogKiB0cmFuc2l0aW9u
cyB0cnVlLT5mYWxzZS4gVGhpcyBwcmV2ZW50cyBzX2Zzbm90aWZ5X2Nvbm5lY3RvcnMgZnJvbQog
KiByZWFjaGluZyAwLCBibG9ja2luZyB1bW91bnQgKGZzbm90aWZ5X3NiX2RlbGV0ZSkgZm9yZXZl
ci4KICoKICogU3RyYXRlZ3k6IFB1cmUgYnJ1dGUtZm9yY2UgcmFjZSB3aXRob3V0IGtlcm5lbCBk
ZWxheSBpbmplY3Rpb24uCiAqCiAqIFRocmVhZCBncm91cCBBIChtYW55IHRocmVhZHMpOiBSYXBp
ZGx5IGFkZCB0aGVuIHJlbW92ZSBhIHJlZ3VsYXIKICogICAobm9uLWV2aWN0YWJsZSkgZmFub3Rp
ZnkgbWFyayBvbiBhIGZpbGUuIFRoZSByZW1vdmFsIGdvZXMgdGhyb3VnaAogKiAgIGZzbm90aWZ5
X3B1dF9tYXJrIC0+IGZzbm90aWZ5X2RldGFjaF9tYXJrIChjbGVhcnMgQVRUQUNIRUQgZmxhZyku
CiAqCiAqIFRocmVhZCBncm91cCBCIChtYW55IHRocmVhZHMpOiBSYXBpZGx5IGFkZCBldmljdGFi
bGUgbWFya3Mgb24gdGhlCiAqICAgc2FtZSBmaWxlLiBBZGRpdGlvbiBjYWxscyBmc25vdGlmeV9y
ZWNhbGNfbWFzayAodGhlIGJ1Z2d5IHBhdGgpLgogKiAgIElmIHRocmVhZCBBIGp1c3QgY2xlYXJl
ZCBBVFRBQ0hFRCBvbiB0aGUgcmVndWxhciBtYXJrLCByZWNhbGMgc2VlcwogKiAgIG9ubHkgZXZp
Y3RhYmxlIG1hcmtzIC0+IEhBU19JUkVGIHRyYW5zaXRpb25zIGZhbHNlIC0+IGlub2RlIGxlYWtl
ZC4KICoKICogRGV0ZWN0aW9uOiBBZnRlciByYWNpbmcsIGF0dGVtcHQgdW1vdW50IHdpdGggYSB0
aW1lb3V0LiBJZiB1bW91bnQKICogICBoYW5ncywgYW4gaXJlZiB3YXMgbGVha2VkIC0+IGJ1ZyBy
ZXByb2R1Y2VkLiBXZSBwcmVzZXJ2ZSB0aGUgc2NlbmUKICogICAobm8gTU5UX0RFVEFDSCkgc28g
dGhlIGh1bmcgdGFzayByZW1haW5zIGZvciBkdW1wIGFuYWx5c2lzLgogKgogKiBDb21waWxlOiBn
Y2MgLXN0YXRpYyAtTzIgLXB0aHJlYWQgLW8gcmVwcm9fbm9tb2QgcmVwcm9fbm9tb2QuYwogKiBS
dW46ICAgICAuL3JlcHJvX25vbW9kIFtyb3VuZHNdIFt0aHJlYWRzXSBbZHVyYXRpb25fc2VjXQog
KiAgICAgICAgICBEZWZhdWx0OiAxMDAgcm91bmRzLCAxNiB0aHJlYWRzIHBlciBncm91cCwgMyBz
ZWNvbmRzIGVhY2gKICoKICogTmVlZHM6IHJvb3QsIGtlcm5lbCB3aXRoIENPTkZJR19GQU5PVElG
WT15CiAqLwoKI2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUg
PHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1
ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5j
bHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlIDxzeXMvbW91bnQuaD4KI2luY2x1ZGUgPHN5cy9zdGF0
Lmg+CiNpbmNsdWRlIDxzeXMvd2FpdC5oPgojaW5jbHVkZSA8c3lzL2Zhbm90aWZ5Lmg+CiNpbmNs
dWRlIDxzeXMvc3lzY2FsbC5oPgojaW5jbHVkZSA8c2NoZWQuaD4KCiNpZm5kZWYgRkFOX01BUktf
RVZJQ1RBQkxFCiNkZWZpbmUgRkFOX01BUktfRVZJQ1RBQkxFIDB4MDAwMDAyMDAKI2VuZGlmCgpz
dGF0aWMgdm9sYXRpbGUgaW50IHN0b3BfZmxhZyA9IDA7CnN0YXRpYyBjb25zdCBjaGFyICp0ZXN0
ZmlsZTsKc3RhdGljIGludCBudW1fdGhyZWFkcyA9IDE2OwoKLyogQmluZCB0aHJlYWQgdG8gYSBz
cGVjaWZpYyBDUFUgZm9yIGNhY2hlIGxvY2FsaXR5ICovCnN0YXRpYyB2b2lkIHBpbl9jcHUoaW50
IGNwdSkKewogICAgY3B1X3NldF90IHNldDsKICAgIENQVV9aRVJPKCZzZXQpOwogICAgQ1BVX1NF
VChjcHUgJSBzeXNjb25mKF9TQ19OUFJPQ0VTU09SU19PTkxOKSwgJnNldCk7CiAgICBzY2hlZF9z
ZXRhZmZpbml0eSgwLCBzaXplb2Yoc2V0KSwgJnNldCk7Cn0KCi8qCiAqIFRocmVhZCBBOiBhZGQg
YW5kIHJlbW92ZSByZWd1bGFyIChub24tZXZpY3RhYmxlKSBtYXJrcyBhcyBmYXN0IGFzIHBvc3Np
YmxlLgogKiBUaGUga2V5IGlzIHRoZSBSRU1PVkFMOiBmc25vdGlmeV9kZXRhY2hfbWFyaygpIGNs
ZWFycyBBVFRBQ0hFRCBmbGFnLAogKiB3aGljaCBpcyB3aGF0IHRocmVhZCBCJ3MgcmVjYWxjIG5l
ZWRzIHRvIHNlZS4KICovCnN0YXRpYyB2b2lkICp0aHJlYWRfcmVndWxhcl9tYXJrKHZvaWQgKmFy
ZykKewogICAgaW50IGlkID0gKGludCkobG9uZylhcmc7CiAgICBpbnQgaXRlciA9IDA7CgogICAg
cGluX2NwdShpZCAqIDIpOyAgLyogZXZlbiBDUFVzICovCgogICAgd2hpbGUgKCFzdG9wX2ZsYWcp
IHsKICAgICAgICBpbnQgZmFuX2ZkID0gZmFub3RpZnlfaW5pdChGQU5fQ0xBU1NfTk9USUYsIE9f
UkRPTkxZKTsKICAgICAgICBpZiAoZmFuX2ZkIDwgMCkKICAgICAgICAgICAgY29udGludWU7Cgog
ICAgICAgIC8qIEFkZCByZWd1bGFyIG1hcmsgLT4gc2V0cyBIQVNfSVJFRiBvbiBjb25uZWN0b3Ig
Ki8KICAgICAgICBmYW5vdGlmeV9tYXJrKGZhbl9mZCwgRkFOX01BUktfQURELAogICAgICAgICAg
ICAgICAgICAgICAgRkFOX0FDQ0VTUyB8IEZBTl9NT0RJRlksCiAgICAgICAgICAgICAgICAgICAg
ICBBVF9GRENXRCwgdGVzdGZpbGUpOwoKICAgICAgICAvKgogICAgICAgICAqIE5PIGRlbGF5IGhl
cmUgLSBjbG9zZSBpbW1lZGlhdGVseSB0byB0cmlnZ2VyIHJlbW92YWwgQVNBUC4KICAgICAgICAg
KiBjbG9zZShmYW5fZmQpIC0+IGZzbm90aWZ5X3B1dF9tYXJrIC0+IGZzbm90aWZ5X2RldGFjaF9t
YXJrCiAgICAgICAgICogd2hpY2ggY2xlYXJzIEFUVEFDSEVEIGZsYWcgb24gdGhlIG1hcmsuCiAg
ICAgICAgICovCiAgICAgICAgY2xvc2UoZmFuX2ZkKTsKICAgICAgICBpdGVyKys7CiAgICB9CiAg
ICByZXR1cm4gTlVMTDsKfQoKLyoKICogVGhyZWFkIEI6IGFkZCBldmljdGFibGUgbWFya3MgYXMg
ZmFzdCBhcyBwb3NzaWJsZS4KICogZnNub3RpZnlfYWRkX21hcmsgLT4gZnNub3RpZnlfcmVjYWxj
X21hc2sgKGJ1Z2d5IHBhdGgpLgogKiBJZiBpdCByYWNlcyB3aXRoIHRocmVhZCBBJ3MgcmVtb3Zh
bCwgcmVjYWxjIHNlZXMgbm8gcmVndWxhciBtYXJrcwogKiAtPiBIQVNfSVJFRiB0cmFuc2l0aW9u
cyBmYWxzZSAtPiByZXR1cm5zIGlub2RlIC0+IExFQUtFRC4KICovCnN0YXRpYyB2b2lkICp0aHJl
YWRfZXZpY3RhYmxlX21hcmsodm9pZCAqYXJnKQp7CiAgICBpbnQgaWQgPSAoaW50KShsb25nKWFy
ZzsKICAgIGludCBpdGVyID0gMDsKCiAgICBwaW5fY3B1KGlkICogMiArIDEpOyAgLyogb2RkIENQ
VXMgKi8KCiAgICB3aGlsZSAoIXN0b3BfZmxhZykgewogICAgICAgIGludCBmYW5fZmQgPSBmYW5v
dGlmeV9pbml0KEZBTl9DTEFTU19OT1RJRiwgT19SRE9OTFkpOwogICAgICAgIGlmIChmYW5fZmQg
PCAwKQogICAgICAgICAgICBjb250aW51ZTsKCiAgICAgICAgLyogQWRkIGV2aWN0YWJsZSBtYXJr
IC0+IHRyaWdnZXJzIGZzbm90aWZ5X3JlY2FsY19tYXNrICovCiAgICAgICAgZmFub3RpZnlfbWFy
ayhmYW5fZmQsIEZBTl9NQVJLX0FERCB8IEZBTl9NQVJLX0VWSUNUQUJMRSwKICAgICAgICAgICAg
ICAgICAgICAgIEZBTl9BQ0NFU1MsCiAgICAgICAgICAgICAgICAgICAgICBBVF9GRENXRCwgdGVz
dGZpbGUpOwoKICAgICAgICBjbG9zZShmYW5fZmQpOwogICAgICAgIGl0ZXIrKzsKICAgIH0KICAg
IHJldHVybiBOVUxMOwp9CgovKiBBbGFybSBoYW5kbGVyIGZvciB1bW91bnQgdGltZW91dCBkZXRl
Y3Rpb24gKi8Kc3RhdGljIHZvbGF0aWxlIGludCB1bW91bnRfdGltZWRfb3V0ID0gMDsKc3RhdGlj
IHZvaWQgYWxhcm1faGFuZGxlcihpbnQgc2lnKSB7IHVtb3VudF90aW1lZF9vdXQgPSAxOyB9Cgpp
bnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQp7CiAgICBpbnQgcm91bmRzID0gMTAwOwog
ICAgaW50IGR1cmF0aW9uX3NlYyA9IDM7CiAgICBpbnQgdW1vdW50X3RpbWVvdXQgPSAxNTsgIC8q
IHNlY29uZHMgdG8gd2FpdCBmb3IgdW1vdW50ICovCiAgICBjaGFyIGZpbGVwYXRoWzI1Nl07CiAg
ICBjaGFyIG1udHBvaW50WzI1Nl07CgogICAgaWYgKGFyZ2MgPiAxKSByb3VuZHMgPSBhdG9pKGFy
Z3ZbMV0pOwogICAgaWYgKGFyZ2MgPiAyKSBudW1fdGhyZWFkcyA9IGF0b2koYXJndlsyXSk7CiAg
ICBpZiAoYXJnYyA+IDMpIGR1cmF0aW9uX3NlYyA9IGF0b2koYXJndlszXSk7CgogICAgcHJpbnRm
KCI9PT0gZnNub3RpZnkgaXJlZiBsZWFrIHJlcHJvZHVjZXIgKG5vIGtlcm5lbCBtb2QpID09PVxu
Iik7CiAgICBwcmludGYoIlJvdW5kczogJWQsIFRocmVhZHMvZ3JvdXA6ICVkLCBEdXJhdGlvbi9y
b3VuZDogJWRzXG4iLAogICAgICAgICAgIHJvdW5kcywgbnVtX3RocmVhZHMsIGR1cmF0aW9uX3Nl
Yyk7CiAgICBwcmludGYoIlVtb3VudCB0aW1lb3V0OiAlZHMgKGhhbmcgPSBidWcgcmVwcm9kdWNl
ZClcblxuIiwgdW1vdW50X3RpbWVvdXQpOwoKICAgIHNpZ25hbChTSUdBTFJNLCBhbGFybV9oYW5k
bGVyKTsKCiAgICBmb3IgKGludCByb3VuZCA9IDE7IHJvdW5kIDw9IHJvdW5kczsgcm91bmQrKykg
ewogICAgICAgIC8qIFVzZSB1bmlxdWUgbW91bnRwb2ludCBwZXIgcm91bmQgdG8gYXZvaWQgbGVm
dG92ZXIgaXNzdWVzICovCiAgICAgICAgc25wcmludGYobW50cG9pbnQsIHNpemVvZihtbnRwb2lu
dCksICIvdG1wL3JlcHJvX25vbW9kXyVkIiwgcm91bmQpOwogICAgICAgIG1rZGlyKG1udHBvaW50
LCAwNzU1KTsKCiAgICAgICAgaWYgKG1vdW50KCJ0bXBmcyIsIG1udHBvaW50LCAidG1wZnMiLCAw
LCAic2l6ZT00TSIpICE9IDApIHsKICAgICAgICAgICAgdW1vdW50MihtbnRwb2ludCwgTU5UX0RF
VEFDSCk7CiAgICAgICAgICAgIHVzbGVlcCgxMDAwMDApOwogICAgICAgICAgICBpZiAobW91bnQo
InRtcGZzIiwgbW50cG9pbnQsICJ0bXBmcyIsIDAsICJzaXplPTRNIikgIT0gMCkgewogICAgICAg
ICAgICAgICAgcGVycm9yKCJtb3VudCIpOwogICAgICAgICAgICAgICAgY29udGludWU7CiAgICAg
ICAgICAgIH0KICAgICAgICB9CgogICAgICAgIHNucHJpbnRmKGZpbGVwYXRoLCBzaXplb2YoZmls
ZXBhdGgpLCAiJXMvdGFyZ2V0IiwgbW50cG9pbnQpOwogICAgICAgIHRlc3RmaWxlID0gZmlsZXBh
dGg7CiAgICAgICAgaW50IGZkID0gb3Blbih0ZXN0ZmlsZSwgT19DUkVBVCB8IE9fV1JPTkxZLCAw
NjQ0KTsKICAgICAgICBpZiAoZmQgPCAwKSB7IHBlcnJvcigib3BlbiIpOyB1bW91bnQyKG1udHBv
aW50LCBNTlRfREVUQUNIKTsgY29udGludWU7IH0KICAgICAgICB3cml0ZShmZCwgIngiLCAxKTsK
ICAgICAgICBjbG9zZShmZCk7CgogICAgICAgIC8qIFN0YXJ0IHJhY2luZyB0aHJlYWRzICovCiAg
ICAgICAgc3RvcF9mbGFnID0gMDsKICAgICAgICBwdGhyZWFkX3QgKnRhID0gY2FsbG9jKG51bV90
aHJlYWRzLCBzaXplb2YocHRocmVhZF90KSk7CiAgICAgICAgcHRocmVhZF90ICp0YiA9IGNhbGxv
YyhudW1fdGhyZWFkcywgc2l6ZW9mKHB0aHJlYWRfdCkpOwoKICAgICAgICBmb3IgKGludCBpID0g
MDsgaSA8IG51bV90aHJlYWRzOyBpKyspIHsKICAgICAgICAgICAgcHRocmVhZF9jcmVhdGUoJnRh
W2ldLCBOVUxMLCB0aHJlYWRfcmVndWxhcl9tYXJrLCAodm9pZCAqKShsb25nKWkpOwogICAgICAg
ICAgICBwdGhyZWFkX2NyZWF0ZSgmdGJbaV0sIE5VTEwsIHRocmVhZF9ldmljdGFibGVfbWFyaywg
KHZvaWQgKikobG9uZylpKTsKICAgICAgICB9CgogICAgICAgIHNsZWVwKGR1cmF0aW9uX3NlYyk7
CiAgICAgICAgc3RvcF9mbGFnID0gMTsKCiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBudW1f
dGhyZWFkczsgaSsrKSB7CiAgICAgICAgICAgIHB0aHJlYWRfam9pbih0YVtpXSwgTlVMTCk7CiAg
ICAgICAgICAgIHB0aHJlYWRfam9pbih0YltpXSwgTlVMTCk7CiAgICAgICAgfQogICAgICAgIGZy
ZWUodGEpOwogICAgICAgIGZyZWUodGIpOwoKICAgICAgICAvKiBSZW1vdmUgdGhlIHRlc3QgZmls
ZSBzbyB1bW91bnQgaGFzIGZld2VyIG9ic3RhY2xlcyAqLwogICAgICAgIHVubGluayhmaWxlcGF0
aCk7CgogICAgICAgIC8qCiAgICAgICAgICogQXR0ZW1wdCB1bW91bnQgd2l0aCB0aW1lb3V0Lgog
ICAgICAgICAqIElmIGlyZWYgbGVha2VkLCBmc25vdGlmeV9zYl9kZWxldGUgd2lsbCBibG9jayBp
biB3YWl0X3Zhcl9ldmVudAogICAgICAgICAqIHdhaXRpbmcgZm9yIHNfZnNub3RpZnlfY29ubmVj
dG9ycyB0byByZWFjaCAwLgogICAgICAgICAqLwogICAgICAgIHByaW50ZigiW1JvdW5kICVkLyVk
XSB1bW91bnQgJXMgLi4uICIsIHJvdW5kLCByb3VuZHMsIG1udHBvaW50KTsKICAgICAgICBmZmx1
c2goc3Rkb3V0KTsKCiAgICAgICAgdW1vdW50X3RpbWVkX291dCA9IDA7CiAgICAgICAgYWxhcm0o
dW1vdW50X3RpbWVvdXQpOwoKICAgICAgICBwaWRfdCBwaWQgPSBmb3JrKCk7CiAgICAgICAgaWYg
KHBpZCA9PSAwKSB7CiAgICAgICAgICAgIC8qIENoaWxkOiB0cnkgdW1vdW50ICovCiAgICAgICAg
ICAgIGludCByZXQgPSB1bW91bnQyKG1udHBvaW50LCAwKTsKICAgICAgICAgICAgX2V4aXQocmV0
ID09IDAgPyAwIDogMSk7CiAgICAgICAgfQoKICAgICAgICBpbnQgc3RhdHVzOwogICAgICAgIHBp
ZF90IHcgPSB3YWl0cGlkKHBpZCwgJnN0YXR1cywgMCk7CiAgICAgICAgYWxhcm0oMCk7ICAvKiBj
YW5jZWwgYWxhcm0gKi8KCiAgICAgICAgaWYgKHVtb3VudF90aW1lZF9vdXQgfHwgdyA8PSAwKSB7
CiAgICAgICAgICAgIHByaW50ZigiSFVORyEgaXJlZiBsZWFrIGRldGVjdGVkISBQcmVzZXJ2aW5n
IHNjZW5lLlxuIik7CiAgICAgICAgICAgIHByaW50ZigiXG4iKTsKICAgICAgICAgICAgcHJpbnRm
KCI9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09XG4iKTsKICAgICAgICAg
ICAgcHJpbnRmKCJCVUcgUkVQUk9EVUNFRCBhdCByb3VuZCAlZCFcbiIsIHJvdW5kKTsKICAgICAg
ICAgICAgcHJpbnRmKCJ1bW91bnQgaXMgc3R1Y2sgaW4gZnNub3RpZnlfc2JfZGVsZXRlLlxuIik7
CiAgICAgICAgICAgIHByaW50ZigiPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PVxuIik7CiAgICAgICAgICAgIHByaW50ZigiXG4iKTsKICAgICAgICAgICAgcHJpbnRmKCJT
Y2VuZSBwcmVzZXJ2ZWQuIERvIE5PVCBmb3JjZSB1bW91bnQuXG4iKTsKICAgICAgICAgICAgcHJp
bnRmKCJSdW46IGRtZXNnIHwgZ3JlcCAtaSBodW5nXG4iKTsKICAgICAgICAgICAgcHJpbnRmKCJU
byBkdW1wOiBrd29ya3NwYWNlIGR1bXAgbWFzdGVyX3Vwc3RyZWFtXG4iKTsKICAgICAgICAgICAg
cHJpbnRmKCJNb3VudCBwb2ludDogJXNcbiIsIG1udHBvaW50KTsKICAgICAgICAgICAgZmZsdXNo
KHN0ZG91dCk7CiAgICAgICAgICAgIC8qIEV4aXQgYnV0IGxlYXZlIGV2ZXJ5dGhpbmcgaW50YWN0
IGZvciBhbmFseXNpcyAqLwogICAgICAgICAgICAvKiBUaGUgY2hpbGQgcHJvY2VzcyBpcyBzdHVj
ayBpbiB1bW91bnQgLSBsZWF2ZSBpdCAqLwogICAgICAgICAgICBleGl0KDApOwogICAgICAgIH0K
CiAgICAgICAgaWYgKFdJRkVYSVRFRChzdGF0dXMpICYmIFdFWElUU1RBVFVTKHN0YXR1cykgPT0g
MCkgewogICAgICAgICAgICBwcmludGYoIk9LXG4iKTsKICAgICAgICB9IGVsc2UgewogICAgICAg
ICAgICBwcmludGYoImZhaWxlZCAocmV0PSVkKSwgZm9yY2UgZGV0YWNoXG4iLAogICAgICAgICAg
ICAgICAgICAgV0lGRVhJVEVEKHN0YXR1cykgPyBXRVhJVFNUQVRVUyhzdGF0dXMpIDogLTEpOwog
ICAgICAgICAgICB1bW91bnQyKG1udHBvaW50LCBNTlRfREVUQUNIKTsKICAgICAgICB9CiAgICB9
CgogICAgcHJpbnRmKCJcbj09PSBBbGwgJWQgcm91bmRzIGNvbXBsZXRlIHdpdGhvdXQgaGFuZy4g
PT09XG4iLCByb3VuZHMpOwogICAgcHJpbnRmKCJCdWcgd2FzIE5PVCByZXByb2R1Y2VkLiBUaGUg
cmFjZSB3aW5kb3cgaXMgdmVyeSBuYXJyb3cgd2l0aG91dFxuIik7CiAgICBwcmludGYoImtlcm5l
bCBkZWxheSBpbmplY3Rpb24uIFRyeSBpbmNyZWFzaW5nIHJvdW5kcy90aHJlYWRzL2R1cmF0aW9u
LlxuIik7CiAgICByZXR1cm4gMTsKfQo=

--2268eec1fc9a8a5bb88ce6349a74a7d56d0db2341ad6901f4f89593e76fb--
