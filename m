Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B34DB54D
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692026; cv=pass; b=a4Qq7sG3h/l26nJCqBJ0wOIFevABgKIlCiVC75VJjHczbKbRqKmrVN5n1e6Q/vPZ06WshMdR6Qo6bPOm50RgQ8JIC1Om4vRgxeFJwegnzusXboATqZWck/KHjtNVFuRuJ0FySceDErnXZXMZBDcwLQbmgqii7DyE+yvX+jvk0Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692026; c=relaxed/simple;
	bh=vzXvqs00qeR5FQnhgl7o4h9HkFil1ktVmjkSoY9sIt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtcGdM8rSn2ZaSKfi39Q+VlWLAKXpr9CcL36DgkNXBvHTAatQbWstpODLJippwgcwfG6+rUGwAIBDyLQ4KmAjKY2lQCGGTG66v2Pzqa/xn9dN8LEa+L9DwDNxsIlh2DnShVZYD/m5/V8KqfzYkhh7LvSzwQQIBtJMmIW04Gh4M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+6tN0m9; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+6tN0m9"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-675ab6221c4so1899214a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 06:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776692022; cv=none;
        d=google.com; s=arc-20240605;
        b=SZ6xBauDP3ORDxxKyOLbmYyYJGo8B1wPN9Qr/w0u+iEz2PENd//hTk+EKtll2yDmYC
         HhUF1POgxYMdE6oQS9NJrKzzP0IlgwWwJw5zvYu3ESqGcUYcObZh842H0qOj4jiJiaf+
         pHz7MSxR58gsALnaz7JS5X6YZptdzb2UD5NuOGNOq7SaqYh/df28AVYmd7/LQLgtqHkK
         Yu4emrmBKlGLqY1A36lq7K2txGMOsJNWmCv0HiNP0jvP6BfjWVbadEbMVMACkR3d+9v9
         mhbojUxWaVQ8iqoBniRaP39kQNXzoSUI87HvZzcZe7e7fhMHx1eoWpdfJRcxTi/Prh43
         CReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LIQRT4mwUvztUs6xloPa+5GlT4+1fhJHuAJ1sXslZU4=;
        fh=frRtPloZ34CtrYa4THo4RjhJQN25ujNdVI59QSfektE=;
        b=ClUZvvEXLfkVBUZ0SATSZedIKbf/uefO2XBUZ+SFS+tujNV0pjZJPurswqAJ1xJi0N
         pZ8G7T2z3dW6n/3KQQRCqd+iLT62I7QIhzouHy7RvS5+VCmiJtaNio12l+wLfgdw5erf
         x6g0FYiKS/ETMA+gDXSThV0HaFRvUnBnnbegJAPlaT5ePk3CWob4glg7EIm1AJW/MiLa
         euBuYb75hDGqdK0eCyWfoK4g2Oxl0N4qzmdqyIgXZvlu08fD0SvKz0qF1296IqK8GJAF
         tC8elyOe7GMqzEdxA+8aGb9lfabPsCF6PuIAYNPLMZkmlMCTnCztR9uDO5aC5nnVMPB9
         Y0Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776692022; x=1777296822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LIQRT4mwUvztUs6xloPa+5GlT4+1fhJHuAJ1sXslZU4=;
        b=W+6tN0m9hsAjlBZUXkcDOKPSyDFW/eYf3pego7gG+IIR4DaceOb3AsviHb+xJpjNYJ
         e+jveLmPuT3RlCeNW7UwJn9jJLziRVYw5YjxTf6rAFoA1YCfzfE9dGMsQkuPsUyq7V6m
         sSfz7AFjNZTFtmDZqBFIQvnbMgvpFXHhNhfrj2sPFG7m1AgTPuVa/W+5p/wFtMg+btHp
         i173KLfYPN5yBMj3aANgJQB5syTccEXQ0qZjth+zcBgmWyQ3Ir31vYz5Zi1VpSMQn9or
         /SOGDMi99gD3kD8XWTIzTwx3p0h1Q2hmfzxqTFkVCJvuvQgdeEL2pg7dSV1eAr//Wfdj
         Phjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692022; x=1777296822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIQRT4mwUvztUs6xloPa+5GlT4+1fhJHuAJ1sXslZU4=;
        b=R7jf3fTT9qAsLhu/rljgRNgIOBpfvNUleGGou9Ce1dyv1XUSw9KWsvXJnAZVdUVKqM
         SkH95NDmb9GcUDNkh3rkjr45BPqzoicHx+6SgbWP0OMBKc3Jy3dVvWeW9lnucumaJOcF
         /U1UqO8x6H3/dMLrcFEeNZ0SJe+K6yptP2E42Jqc5QqJ9aT+8S1+DkpMy+iW8SOWewvZ
         F8OjalomFkHs3NQu9bodyW2PWGaeCPj3v/t+mS3QulOA7ldHJArxkj7YqFTzqFAmymED
         feTIyRQK4buW833XRHCdodozjRnUx8s1wH8Sl4HEZDyms7Ylya1l/inFu9X/aq/AI1Ie
         hvdw==
X-Forwarded-Encrypted: i=1; AFNElJ/QezXjPYFHB+6GYKb6S+yB9LSaRh46XKUMnb2Wvv/I/x/+NGP1eFdloKvALagR/N+EZxsrackHlZXsxZrK@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRSI4We1woXjJRQIc06kOEUBePdkIT/uk4D8xCh7qA2vU1OiD
	OPw9JFTPIArmfowqgInEvHdFTD4XFkXSi3kxb7LsIAJu0hXobcX9FIuXhko/o4U9kHlK0XEVbhb
	13BPyTaBkNrNSJ3fMpC2FEOzzw9YiG3A=
X-Gm-Gg: AeBDievlgUe+ADqi25D/z+TuAp0uacs9rkWVoWXtUSxpQ0uGqsCjBsqYKmLREe2DUMS
	/YwjDtRKYB5G7GO2JId+4QzejwHHwC5+tbkLg0QBpIHhmYu+T0RKlR3g6wrnLPipPDkrU+yvXeo
	XUX0FRVr+VLgVjtXbWYITU3zpGZ8EKCi1lODsS1ljFNH/bwxt9kW/Nmf7ImpDO+gVD89nPOeSuw
	8kKowkUTBHEyZjN117hBOM5tWP2BSbLJeC5jgCxaQsFk2sUu3fW0XY3oobTxzxfbnpRtwGpDWBa
	WpYMwIpWIlzQ9tELDg==
X-Received: by 2002:a17:907:7b93:b0:b98:7e30:8129 with SMTP id
 a640c23a62f3a-ba41a825cd1mr601883166b.32.1776692022187; Mon, 20 Apr 2026
 06:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420064727.1760604-1-yinxin.x@bytedance.com>
In-Reply-To: <20260420064727.1760604-1-yinxin.x@bytedance.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Apr 2026 15:33:30 +0200
X-Gm-Features: AQROBzD5aET_i-UKze6l-ixfbYqxD7Tlnkscdo07kgsEh-WpLoPy-XoInocvbDQ
Message-ID: <CAOQ4uxiPsbHb0o5voUKyPFMvBsDkG914FYDcs4C5UpBMNm0Vcg@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: fix inode reference leak in fsnotify_recalc_mask()
To: Xin Yin <yinxin.x@bytedance.com>
Cc: jan@kara.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000dc3c7e064fe458fc"

--000000000000dc3c7e064fe458fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 8:52=E2=80=AFAM Xin Yin <yinxin.x@bytedance.com> wr=
ote:
>
> fsnotify_recalc_mask() fails to handle the return value of
> __fsnotify_recalc_mask(), which may return an inode pointer that needs
> to be released via fsnotify_drop_object() when the connector's HAS_IREF
> flag transitions from set to cleared.
>
> This manifests as a hung task with the following call trace:
>
>   INFO: task umount:1234 blocked for more than 120 seconds.
>   Call Trace:
>    __schedule
>    schedule
>    fsnotify_sb_delete
>    generic_shutdown_super
>    kill_anon_super
>    cleanup_mnt
>    task_work_run
>    do_exit
>    do_group_exit
>
> The race window that triggers the iref leak:
>
>   Thread A (adding mark)              Thread B (removing mark)
>   =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80              =E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>   fsnotify_add_mark_locked():
>     fsnotify_add_mark_list():
>       spin_lock(conn->lock)
>       add mark_B(evictable) to list
>       spin_unlock(conn->lock)
>     return
>
>     /* ---- gap: no lock held ---- */
>
>                                       fsnotify_detach_mark(mark_A):
>                                         spin_lock(mark_A->lock)
>                                         clear ATTACHED flag on mark_A
>                                         spin_unlock(mark_A->lock)
>
>     fsnotify_recalc_mask():
>       spin_lock(conn->lock)
>       __fsnotify_recalc_mask():
>         /* mark_A skipped: ATTACHED cleared */
>         /* only mark_B(evictable) remains */
>         want_iref =3D false
>         has_iref =3D true  /* not yet cleared */
>         -> HAS_IREF transitions true -> false
>         -> returns inode pointer
>       spin_unlock(conn->lock)
>       /* BUG: return value discarded!
>        * iput() and fsnotify_put_sb_watched_objects()
>        * are never called */
>

Hi Xin!

Ouch! nasty one.
Very good analysis.
Do you also have a reproducer?


> Fix this by capturing the return value of __fsnotify_recalc_mask() and
> passing it to fsnotify_drop_object() after releasing the spinlock, which
> is the same pattern used in fsnotify_put_mark().

The fix looks correct, but I prefer for my mental model to keep
fsnotify_drop_object() in one place at the end of fsnotify_put_mark().

Please see the suggested (only sanity tested) patch.

Thanks,
Amir.


>
> Fixes: c3638b5b1374 ("fsnotify: allow adding an inode mark without pinnin=
g inode")
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/notify/mark.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index c2ed5b11b0fe6..cc93fcc2c5a9c 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -283,6 +283,8 @@ static void fsnotify_conn_set_children_dentry_flags(
>         fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
>  }
>
> +static void fsnotify_drop_object(unsigned int type, void *objp);
> +
>  /*
>   * Calculate mask of events for a list of marks. The caller must make su=
re
>   * connector and connector->obj cannot disappear under us.  Callers achi=
eve
> @@ -292,15 +294,19 @@ static void fsnotify_conn_set_children_dentry_flags=
(
>  void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  {
>         bool update_children;
> +       unsigned int type;
> +       void *objp;
>
>         if (!conn)
>                 return;
>
>         spin_lock(&conn->lock);
>         update_children =3D !fsnotify_conn_watches_children(conn);
> -       __fsnotify_recalc_mask(conn);
> +       objp =3D __fsnotify_recalc_mask(conn);
> +       type =3D conn->type;
>         update_children &=3D fsnotify_conn_watches_children(conn);
>         spin_unlock(&conn->lock);
> +       fsnotify_drop_object(type, objp);
>         /*
>          * Set children's PARENT_WATCHED flags only if parent started wat=
ching.
>          * When parent stops watching, we clear false positive PARENT_WAT=
CHED
> --
> 2.20.1

--000000000000dc3c7e064fe458fc
Content-Type: text/x-patch; charset="UTF-8"; 
	name="v2-0001-fsnotify-fix-inode-reference-leak-in-fsnotify_rec.patch"
Content-Disposition: attachment; 
	filename="v2-0001-fsnotify-fix-inode-reference-leak-in-fsnotify_rec.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mo7851ac0>
X-Attachment-Id: f_mo7851ac0

RnJvbSA4Y2MzZTdlMmU3NWY1YzkzODc1YmZmY2U2YmY4Mzk4ZDk0Mzk4YzMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBNb24sIDIwIEFwciAyMDI2IDE0OjU4OjAwICswMjAwClN1YmplY3Q6IFtQQVRDSCB2Ml0g
ZnNub3RpZnk6IGZpeCBpbm9kZSByZWZlcmVuY2UgbGVhayBpbgogZnNub3RpZnlfcmVjYWxjX21h
c2soKQpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9
VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKZnNub3RpZnlfcmVjYWxjX21h
c2soKSBmYWlscyB0byBoYW5kbGUgdGhlIHJldHVybiB2YWx1ZSBvZgpfX2Zzbm90aWZ5X3JlY2Fs
Y19tYXNrKCksIHdoaWNoIG1heSByZXR1cm4gYW4gaW5vZGUgcG9pbnRlciB0aGF0IG5lZWRzCnRv
IGJlIHJlbGVhc2VkIHZpYSBmc25vdGlmeV9kcm9wX29iamVjdCgpIHdoZW4gdGhlIGNvbm5lY3Rv
cidzIEhBU19JUkVGCmZsYWcgdHJhbnNpdGlvbnMgZnJvbSBzZXQgdG8gY2xlYXJlZC4KClRoaXMg
bWFuaWZlc3RzIGFzIGEgaHVuZyB0YXNrIHdpdGggdGhlIGZvbGxvd2luZyBjYWxsIHRyYWNlOgoK
ICBJTkZPOiB0YXNrIHVtb3VudDoxMjM0IGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAxMjAgc2Vjb25k
cy4KICBDYWxsIFRyYWNlOgogICBfX3NjaGVkdWxlCiAgIHNjaGVkdWxlCiAgIGZzbm90aWZ5X3Ni
X2RlbGV0ZQogICBnZW5lcmljX3NodXRkb3duX3N1cGVyCiAgIGtpbGxfYW5vbl9zdXBlcgogICBj
bGVhbnVwX21udAogICB0YXNrX3dvcmtfcnVuCiAgIGRvX2V4aXQKICAgZG9fZ3JvdXBfZXhpdAoK
VGhlIHJhY2Ugd2luZG93IHRoYXQgdHJpZ2dlcnMgdGhlIGlyZWYgbGVhazoKCiAgVGhyZWFkIEEg
KGFkZGluZyBtYXJrKSAgICAgICAgICAgICAgVGhyZWFkIEIgKHJlbW92aW5nIG1hcmspCiAg4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSAICAgICAgICAgICAgICDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIAKICBmc25vdGlmeV9hZGRfbWFya19s
b2NrZWQoKToKICAgIGZzbm90aWZ5X2FkZF9tYXJrX2xpc3QoKToKICAgICAgc3Bpbl9sb2NrKGNv
bm4tPmxvY2spCiAgICAgIGFkZCBtYXJrX0IoZXZpY3RhYmxlKSB0byBsaXN0CiAgICAgIHNwaW5f
dW5sb2NrKGNvbm4tPmxvY2spCiAgICByZXR1cm4KCiAgICAvKiAtLS0tIGdhcDogbm8gbG9jayBo
ZWxkIC0tLS0gKi8KCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnNub3Rp
ZnlfZGV0YWNoX21hcmsobWFya19BKToKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNwaW5fbG9jayhtYXJrX0EtPmxvY2spCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjbGVhciBBVFRBQ0hFRCBmbGFnIG9uIG1hcmtfQQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2sobWFya19BLT5sb2NrKQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnNub3RpZnlfcHV0X21hcmsobWFy
a19BKQoKICAgIGZzbm90aWZ5X3JlY2FsY19tYXNrKCk6CiAgICAgIHNwaW5fbG9jayhjb25uLT5s
b2NrKQogICAgICBfX2Zzbm90aWZ5X3JlY2FsY19tYXNrKCk6CiAgICAgICAgLyogbWFya19BIHNr
aXBwZWQ6IEFUVEFDSEVEIGNsZWFyZWQgKi8KICAgICAgICAvKiBvbmx5IG1hcmtfQihldmljdGFi
bGUpIHJlbWFpbnMgKi8KICAgICAgICB3YW50X2lyZWYgPSBmYWxzZQogICAgICAgIGhhc19pcmVm
ID0gdHJ1ZSAgLyogbm90IHlldCBjbGVhcmVkICovCiAgICAgICAgLT4gSEFTX0lSRUYgdHJhbnNp
dGlvbnMgdHJ1ZSAtPiBmYWxzZQogICAgICAgIC0+IHJldHVybnMgaW5vZGUgcG9pbnRlcgogICAg
ICBzcGluX3VubG9jayhjb25uLT5sb2NrKQogICAgICAvKiBCVUc6IHJldHVybiB2YWx1ZSBkaXNj
YXJkZWQhCiAgICAgICAqIGlwdXQoKSBhbmQgZnNub3RpZnlfcHV0X3NiX3dhdGNoZWRfb2JqZWN0
cygpCiAgICAgICAqIGFyZSBuZXZlciBjYWxsZWQgKi8KCkZpeCB0aGlzIGJ5IGRlZmVycmluZyB0
aGUgdHJhbnNpdGlvbiB0cnVlIC0+IGZhbHNlIG9mIEhBU19JUkVGIGZsYWcgZnJvbQpmc25vdGlm
eV9yZWNhbGNfbWFzaygpIChUaHJlYWQgQSkgdG8gZnNub3RpZnlfcHV0X21hcmsoKSAodGhyZWFk
IEIpLgoKRml4ZXM6IGMzNjM4YjViMTM3NCAoImZzbm90aWZ5OiBhbGxvdyBhZGRpbmcgYW4gaW5v
ZGUgbWFyayB3aXRob3V0IHBpbm5pbmcgaW5vZGUiKQpTaWduZWQtb2ZmLWJ5OiBYaW4gWWluIDx5
aW54aW4ueEBieXRlZGFuY2UuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1p
cjczaWxAZ21haWwuY29tPgotLS0KIGZzL25vdGlmeS9tYXJrLmMgfCAzOSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL25vdGlmeS9tYXJrLmMgYi9mcy9u
b3RpZnkvbWFyay5jCmluZGV4IDYyMmYwNTk3N2Y4NmEuLmUyNTZiNDIwMTAwZGMgMTAwNjQ0Ci0t
LSBhL2ZzL25vdGlmeS9tYXJrLmMKKysrIGIvZnMvbm90aWZ5L21hcmsuYwpAQCAtMjM4LDcgKzIz
OCwxMiBAQCBzdGF0aWMgc3RydWN0IGlub2RlICpmc25vdGlmeV91cGRhdGVfaXJlZihzdHJ1Y3Qg
ZnNub3RpZnlfbWFya19jb25uZWN0b3IgKmNvbm4sCiAJcmV0dXJuIGlub2RlOwogfQogCi1zdGF0
aWMgdm9pZCAqX19mc25vdGlmeV9yZWNhbGNfbWFzayhzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25u
ZWN0b3IgKmNvbm4pCisvKgorICogQ2FsY3VsYXRlIG1hc2sgb2YgZXZlbnRzIGZvciBhIGxpc3Qg
b2YgbWFya3MuCisgKgorICogUmV0dXJuIHRydWUgaWYgYW55IG9mIHRoZSBhdHRhY2hlZCBtYXJr
cyB3YW50IHRvIGhvbGQgYW4gaW5vZGUgcmVmZXJlbmNlLgorICovCitzdGF0aWMgYm9vbCBfX2Zz
bm90aWZ5X3JlY2FsY19tYXNrKHN0cnVjdCBmc25vdGlmeV9tYXJrX2Nvbm5lY3RvciAqY29ubikK
IHsKIAl1MzIgbmV3X21hc2sgPSAwOwogCWJvb2wgd2FudF9pcmVmID0gZmFsc2U7CkBAIC0yNjIs
NiArMjY3LDM0IEBAIHN0YXRpYyB2b2lkICpfX2Zzbm90aWZ5X3JlY2FsY19tYXNrKHN0cnVjdCBm
c25vdGlmeV9tYXJrX2Nvbm5lY3RvciAqY29ubikKIAkgKi8KIAlXUklURV9PTkNFKCpmc25vdGlm
eV9jb25uX21hc2tfcChjb25uKSwgbmV3X21hc2spOwogCisJcmV0dXJuIHdhbnRfaXJlZjsKK30K
KworLyoKKyAqIENhbGN1bGF0ZSBtYXNrIG9mIGV2ZW50cyBmb3IgYSBsaXN0IG9mIG1hcmtzIGFm
dGVyIGF0dGFjaC9tb2RpZnkgbWFyaworICogYW5kIGdldCBhbiBpbm9kZSByZWZlcmVuY2UgZm9y
IHRoZSBjb25uZWN0b3IgaWYgbmVlZGVkLgorICoKKyAqIEEgY29uY3VycmVudCBhZGQgb2YgZXZp
Y3RhYmxlIG1hcmsgYW5kIGRldGFjaCBvZiBub24tZXZpY3RhYmxlIG1hcmsgY2FuCisgKiBsZWFk
IHRvIF9fZnNub3RpZnlfcmVjYWxjX21hc2soKSByZXR1cm5pbmcgZmFsc2Ugd2FudF9pcmVmLCBi
dXQgaW4gdGhpcworICogY2FzZSB3ZSBkZWZlciBjbGVhcmluZyBpcmVmIHRvIGZzbm90aWZ5X3Jl
Y2FsY19tYXNrX2NsZWFyX2lyZWYoKSBjYWxsZWQKKyAqIGZyb20gZnNub3RpZnlfcHV0X21hcmso
KS4KKyAqLworc3RhdGljIHZvaWQgZnNub3RpZnlfcmVjYWxjX21hc2tfc2V0X2lyZWYoc3RydWN0
IGZzbm90aWZ5X21hcmtfY29ubmVjdG9yICpjb25uKQoreworCWJvb2wgaGFzX2lyZWYgPSBjb25u
LT5mbGFncyAmIEZTTk9USUZZX0NPTk5fRkxBR19IQVNfSVJFRjsKKwlib29sIHdhbnRfaXJlZiA9
IF9fZnNub3RpZnlfcmVjYWxjX21hc2soY29ubikgfHwgaGFzX2lyZWY7CisKKwkodm9pZCkgZnNu
b3RpZnlfdXBkYXRlX2lyZWYoY29ubiwgd2FudF9pcmVmKTsKK30KKworLyoKKyAqIENhbGN1bGF0
ZSBtYXNrIG9mIGV2ZW50cyBmb3IgYSBsaXN0IG9mIG1hcmtzIGFmdGVyIGRldGFjaCBtYXJrCisg
KiBhbmQgcmV0dXJuIHRoZSBpbm9kZSBvYmplY3QgaWYgaXRzIHJlZmVyZW5jZSBpcyBubyBsb25n
ZXIgbmVlZGVkLgorICovCitzdGF0aWMgdm9pZCAqZnNub3RpZnlfcmVjYWxjX21hc2tfY2xlYXJf
aXJlZihzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25uZWN0b3IgKmNvbm4pCit7CisJYm9vbCB3YW50
X2lyZWYgPSBfX2Zzbm90aWZ5X3JlY2FsY19tYXNrKGNvbm4pOworCiAJcmV0dXJuIGZzbm90aWZ5
X3VwZGF0ZV9pcmVmKGNvbm4sIHdhbnRfaXJlZik7CiB9CiAKQEAgLTI5OCw3ICszMzEsNyBAQCB2
b2lkIGZzbm90aWZ5X3JlY2FsY19tYXNrKHN0cnVjdCBmc25vdGlmeV9tYXJrX2Nvbm5lY3RvciAq
Y29ubikKIAogCXNwaW5fbG9jaygmY29ubi0+bG9jayk7CiAJdXBkYXRlX2NoaWxkcmVuID0gIWZz
bm90aWZ5X2Nvbm5fd2F0Y2hlc19jaGlsZHJlbihjb25uKTsKLQlfX2Zzbm90aWZ5X3JlY2FsY19t
YXNrKGNvbm4pOworCWZzbm90aWZ5X3JlY2FsY19tYXNrX3NldF9pcmVmKGNvbm4pOwogCXVwZGF0
ZV9jaGlsZHJlbiAmPSBmc25vdGlmeV9jb25uX3dhdGNoZXNfY2hpbGRyZW4oY29ubik7CiAJc3Bp
bl91bmxvY2soJmNvbm4tPmxvY2spOwogCS8qCkBAIC00MTksNyArNDUyLDcgQEAgdm9pZCBmc25v
dGlmeV9wdXRfbWFyayhzdHJ1Y3QgZnNub3RpZnlfbWFyayAqbWFyaykKIAkJLyogVXBkYXRlIHdh
dGNoZWQgb2JqZWN0cyBhZnRlciBkZXRhY2hpbmcgbWFyayAqLwogCQlpZiAoc2IpCiAJCQlmc25v
dGlmeV91cGRhdGVfc2Jfd2F0Y2hlcnMoc2IsIGNvbm4pOwotCQlvYmpwID0gX19mc25vdGlmeV9y
ZWNhbGNfbWFzayhjb25uKTsKKwkJb2JqcCA9IGZzbm90aWZ5X3JlY2FsY19tYXNrX2NsZWFyX2ly
ZWYoY29ubik7CiAJCXR5cGUgPSBjb25uLT50eXBlOwogCX0KIAlXUklURV9PTkNFKG1hcmstPmNv
bm5lY3RvciwgTlVMTCk7Ci0tIAoyLjUzLjAKCg==
--000000000000dc3c7e064fe458fc--
