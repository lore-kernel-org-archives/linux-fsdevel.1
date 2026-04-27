Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE230DED0
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289834; cv=pass; b=R3wQbUQGAqrjp8kLTZ5xjbe7Bm+1BuIO1U9MC2E0+bBiDYt8fdk0H2PlKzt0Y/CW422vKdVNnOhxEvsD28WTUQ2jDvcGOg6ED7c0GufsK3xfoKfaNztoZovnKeE8vlgP1ouqxCwbZwPYZhxWt11DE/20Tnzhsxc3POegaC5KMTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289834; c=relaxed/simple;
	bh=F354IfJDkCCLKOl/sPhPTshgNWF1UuOVHEJ1hU4hlwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtA7qu/8In1p3dHCuy9QOUTDazqxOT7n9S5aZcpPniub85lUYxAdUFmym/eCSOVlKZvz0fBXC24lGN/LKi5SlcFXp7V28DGeKSIdf2vgh29VidS1vc7EDkT6TQyRMF8ohq6tHjje5YV8qqXh4WDj8nTincDGI9cVv3u7yT3ZR+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1PaRFmA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3PnSW8R; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1PaRFmA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3PnSW8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777289832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1t0q+WL95cKXsfCC9nv37pKUgFW8rNlOq1DBxIRgsM=;
	b=I1PaRFmA1iZ6UQAo3fJwjZGh3wH7uL+IL+uhEa6xu/bLAZHCBKSi4g5pTA78/h25PDWMRl
	QqursjU+9YCIsZwHdiOEj77bu8uCwJtZ0IAxZXfGEK65mi2b1eeJGL4CbzUNxggvUJljIG
	O0p4nMaGYH3NS/eC9MoYwDDvfnwO47M=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-6Y791NxSP4apWbm9tmIaYw-1; Mon, 27 Apr 2026 07:37:10 -0400
X-MC-Unique: 6Y791NxSP4apWbm9tmIaYw-1
X-Mimecast-MFC-AGG-ID: 6Y791NxSP4apWbm9tmIaYw_1777289830
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-953f37beed9so11961522241.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 04:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777289830; cv=none;
        d=google.com; s=arc-20240605;
        b=Li8EVXNpOdg87ZfkxoecYGXDAiZAj38a7/gUoThnOtO2w/4ImyIVYGfvCES4bWsAS9
         vEgHOeJB/4ounMaYmDNr1RURuDnFBBd4MzBj33O9w676VaMDn/2VD+PCZposU9FyaHNk
         uWpLYlW1slJ636cG7OuTP+VGW1eSG/a8+ysx9KfcXLon2oeTriPsg0dtTRutIm321H0w
         XWCsG64oLt2nnUFJdJ1Fx5hRT+MwXVSiRYTiyft+1uulfHdYunFCNYJuU4pV6qZhuHE1
         fqXS7vBWm8BwVMQP8sL5LqkA5CWgnO6ST/neHPTtO4kT519qLYwevRttawjI437jVtjQ
         V50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z1t0q+WL95cKXsfCC9nv37pKUgFW8rNlOq1DBxIRgsM=;
        fh=IzJG1rg0vol/WUcPEQUOvCufhZJqabKjyDL7SpV8vgs=;
        b=MCm305enUGr4bdPxG7InJU/X5wvJwcrMixt3pjlBG1Uz18pkWcxzZYiHzJdhGJCWxO
         PoEnQsM+GMtUe+C6zAmI+mEhVHonII3W32IGzQCsc2+nUjpNqin1KxU5frxv74+sXcsZ
         zKsS2fbLIbqiFsrjAO6vIe2mAGh4nGqrjZnp/vZxkEiQ6LX3+iczQ0+aGtVhKg4bY51i
         /wFqjbuN3VnBMP1VvMZ4sy5ETyizHznPBvT4RSNFh4gsVyPC3d4JWns5/SBMFOKeNO4F
         jSYY9Cg1V5RmkjCypo73F3lw6FfPbM+vYtLev6veIe1Wh/PNQAIT90y7yATnoElGtEfb
         RvlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777289830; x=1777894630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1t0q+WL95cKXsfCC9nv37pKUgFW8rNlOq1DBxIRgsM=;
        b=c3PnSW8Ro4kn/OpVNYtpjvPLyxFcjsUsELT4DW5xoO12WZtzac5J40stJGwgjl53mI
         k+G+mhMkrI/7e6eChnKzkAIJjp+ZkHPTmvq6j8XvgGWtW5xney9RbWqfxEuLTaumN3Wb
         zkEGg/Z4y6TGnLbnLVTV9Qus6kWNdFsQDoB+VTxTgyK1OWRib31mruGjBq7AP1EnDHNn
         D7Kw+ko6c0UIHAhp9hzzpUZzH3wydtxB//nDSLx/09lN7/FMA0eaXf/BjUtl6TtfFf7v
         x/4QJbFle8XFvaxsrXRxoO9OE9tseQk1j3SV7eBxk7tcsrxu5F0jczJAFNEZgnUNEpV4
         ckWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777289830; x=1777894630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z1t0q+WL95cKXsfCC9nv37pKUgFW8rNlOq1DBxIRgsM=;
        b=KvvkQHD0vyP1lc5e2IgV7dD7dhWmmkbzrlW/Wi8hAPHPzbY4gHBL6qKaai5Sabs+tf
         ctIxVbVZpv1d0+uFRisGr9O6eAc5rEWk6wOjvhLckaMVqkp8ZndaT2hLn9mheDkB2yCJ
         rBuCnn8vI9JSnGr/Mq6R4Xc9/NiKZzFkeOGS8v7qIQmLDsp8K1TwSXNr7PTg7ErmS+qo
         h5LEmLyLrHXQ/elWwP6OC+C9GiZWZEo08pqh4HSIVOj3txT61eRVV4Aedgmm2bstamaC
         CxZYPQtqALvwMZMPVkvtY7elNRoNQFTl6YbhRqQbl8u3LZdD+RQdyRTIiqVsZHTBdjxG
         4VVw==
X-Forwarded-Encrypted: i=1; AFNElJ9/RHc+Pt7e5D5E3DfJwjtS11UEnh9dMae/94dFBoYg7dQ+exwdRv19bovRo6n875wu0S8acslxkoUUwHuk@vger.kernel.org
X-Gm-Message-State: AOJu0YzxQwJEfz/TctFiOJGNyONcVqJrtUHFi6LiccDLg3YBb5EXYhW5
	qwSTjAQQTVEw3DWZc7uWBjpnuUPxP/71IFMFkCtkq/HhZPx56fcwV4qIBhUn1cZAkVXzkgMAeq/
	mO18XJsduo7dpKWlIKPobu2JwvfmXKXX498X/vD8GhhQHTOR0DmikMYtJs3DE2hBcSexITcceBj
	lsE+zrk9Jq31Pcdt+6J8qrh2sFP463Kpl5oAUu3T9yLyimezeR58Aq49s=
X-Gm-Gg: AeBDiesCkvSRArBHz++OTMHcQLY6nrZ1AsiZpoBkuIFRpMT6BZtEik9+et/pZRwwBRj
	Q3U4SHDdgxNrQKiCjEHqFGv7ERDyyJqUXc57y+lPAEjQH40DIQqyHpIa8WLz7gmYKML7eSR1UZJ
	astGIFzV4OdwCtiTeQzzTkUBJI7OPtyAvBdm3DZ8Twc01kvZkrCAcouZLiS+5+bqoc/SC9TMEuK
	RBA1bgO0OsUMdA=
X-Received: by 2002:a05:6102:f9a:b0:607:4fe2:a64d with SMTP id ada2fe7eead31-616f473aae6mr22733247137.6.1777289830049;
        Mon, 27 Apr 2026 04:37:10 -0700 (PDT)
X-Received: by 2002:a05:6102:f9a:b0:607:4fe2:a64d with SMTP id
 ada2fe7eead31-616f473aae6mr22733236137.6.1777289829609; Mon, 27 Apr 2026
 04:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409190046.317760-2-slava@dubeyko.com>
In-Reply-To: <20260409190046.317760-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 27 Apr 2026 14:36:58 +0300
X-Gm-Features: AVHnY4JiTwgyHXokkmc5nSoTr8J-qjc92vaTullRpUsi0AKyA0uLuOI7ElxuhlY
Message-ID: <CAO8a2ShUgDbnRygsFDAmQXtTC9hh4eAWh0PW6jFGsZ0szd-4LA@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: add ceph_has_realms_with_quotas() check into ceph_quota_update_statfs()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Thu, Apr 9, 2026 at 10:01=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> When MDS rejects a session, remove_session_caps() ->
> __ceph_remove_cap() -> ceph_change_snap_realm() clears
> i_snap_realm for every inode that loses its last cap.
> The realm is restored once caps are re-granted after
> reconnect. It is not a real error and thsi patch changes
> pr_err_ratelimited_client() on doutc().
>
> Every quota methods ceph_quota_is_max_files_exceeded(),
> ceph_quota_is_max_bytes_exceeded(),
> ceph_quota_is_max_bytes_approaching() calls
> ceph_has_realms_with_quotas() check. This patch adds
> the missing ceph_has_realms_with_quotas() call into
> ceph_quota_update_statfs().
>
> v2
> Small cleanup by adding braces for multiline if-else
> statements and changing the comments.
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/quota.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 4dc9426643e8..67ce1ff1a421 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -230,10 +230,17 @@ static int get_quota_realm(struct ceph_mds_client *=
mdsc, struct inode *inode,
>         realm =3D ceph_inode(inode)->i_snap_realm;
>         if (realm)
>                 ceph_get_snap_realm(mdsc, realm);
> -       else
> -               pr_err_ratelimited_client(cl,
> -                               "%p %llx.%llx null i_snap_realm\n",
> -                               inode, ceph_vinop(inode));
> +       else {
> +               /*
> +                * i_snap_realm is NULL when all caps have been released,=
 e.g.
> +                * after an MDS session rejection. This is a transient st=
ate;
> +                * the realm will be restored once caps are re-granted.
> +                * Treat it as "no quota realm found".
> +                */
> +               doutc(cl, "%p %llx.%llx null i_snap_realm\n",
> +                     inode, ceph_vinop(inode));
> +       }
> +
>         while (realm) {
>                 bool has_inode;
>
> @@ -342,10 +349,17 @@ static bool check_quota_exceeded(struct inode *inod=
e, enum quota_check_op op,
>         realm =3D ceph_inode(inode)->i_snap_realm;
>         if (realm)
>                 ceph_get_snap_realm(mdsc, realm);
> -       else
> -               pr_err_ratelimited_client(cl,
> -                               "%p %llx.%llx null i_snap_realm\n",
> -                               inode, ceph_vinop(inode));
> +       else {
> +               /*
> +                * i_snap_realm is NULL when all caps have been released,=
 e.g.
> +                * after an MDS session rejection. This is a transient st=
ate;
> +                * the realm will be restored once caps are re-granted.
> +                * Treat it as "quota not exceeded".
> +                */
> +               doutc(cl, "%p %llx.%llx null i_snap_realm\n",
> +                     inode, ceph_vinop(inode));
> +       }
> +
>         while (realm) {
>                 bool has_inode;
>
> @@ -496,6 +510,9 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *=
fsc, struct kstatfs *buf)
>         u64 total =3D 0, used, free;
>         bool is_updated =3D false;
>
> +       if (!ceph_has_realms_with_quotas(d_inode(fsc->sb->s_root)))
> +               return false;
> +
>         down_read(&mdsc->snap_rwsem);
>         get_quota_realm(mdsc, d_inode(fsc->sb->s_root), QUOTA_GET_MAX_BYT=
ES,
>                         &realm, true);
> --
> 2.53.0
>

