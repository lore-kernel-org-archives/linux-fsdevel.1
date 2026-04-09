Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF03A9605
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775734466; cv=pass; b=ofVWOD4XuO2c4l3Qy5GDKku5/f5eRyKLUDBkAny07e8NyBftybdZjpYlObugAF7DLQq0nB9Dn5BBx9eJRJYTakDQssGQtekwnPCPAgqjLQX1AdBSxFF1WGSEpjrwUSl3rJvbweclv9gT1jMKXQh5ucY6O4SNM3ou09vNANR1e1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775734466; c=relaxed/simple;
	bh=L+Wczuh9KLGAXgg+iq0uFWPCITlLrRyjxt3LtFr4r7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQxidzZI4DGGecIq43T0Zwqnh+gd9apgrglaObf8Nnfrl+vrfzwSOCsWxxw1/w+cOG8y+bemPeqqIMW1ERXACKAONrEG2JQ7ptF8gVskXTay625cKjjNW+My+rq0/naVNjVX5+oKBwI01YcKtp8o9EvKiiLQdLwCTu+YrA6K2Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVwBGJxY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSW4B+rx; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVwBGJxY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSW4B+rx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775734463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgrCj/PkEUGlRNLIdX4qp/95pD0BbHO19KX/pjOhdks=;
	b=GVwBGJxYaEIC71i/OFgzSDtNets6sM9YUt+ilaqN0qixknrrIoMhhso1XOfWtuTO3C0ppr
	lYXVAf7usutWvPEjEptFW3P8rllALbEqldt7a2zVAivZuCG06yHWn/PrgXDjGoR5xJWwbl
	6+8oSqYxmTc6R0R3h/hMko39PDndL+E=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-HDpEoRGXNNiLU_X8IW-SgA-1; Thu, 09 Apr 2026 07:34:21 -0400
X-MC-Unique: HDpEoRGXNNiLU_X8IW-SgA-1
X-Mimecast-MFC-AGG-ID: HDpEoRGXNNiLU_X8IW-SgA_1775734461
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5fae584a130so975376137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 04:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775734461; cv=none;
        d=google.com; s=arc-20240605;
        b=UiEGqlonEKxm5GpH/5iNaxigvmBteLknNpHE21zaqw6I+FUFUjgtstLZAnZx0+U1g7
         eVBnIR9IZ+z85XlglS5X7FqoB4EjGAIsJ1hgW4nHgK4LVfz8y96ORyxG5fffXNnoDLm6
         baJQ3g8Y23s0hfS04ZlNAci7vkSs6mBzyImskDUbYioQqToV09X4FZeCRT4LTWQFD+Hl
         z5wCLiIXrsgAv/yNHO3G9aydzA/swciphZFlHF0jGQFwmxSWCLJUhv+NetmWZLjMOdnJ
         iYMvS3niZ/iPDdsSEV92YNF9LVeTOuD2DnK68vWt/9e0WcJ/vJ3g6FD9SnMxmgncOunr
         JIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WgrCj/PkEUGlRNLIdX4qp/95pD0BbHO19KX/pjOhdks=;
        fh=hhmO+sr5SIg2fJ0W7BTWn6dbZMLayahnPxDtvNdlgls=;
        b=PMCWE9jBRurnpLpOuh9qYkv64b3rMQdKr8W0Lbw6KRFQYnoI53UnPiQ3GqZU6vtsej
         HMYF6wo36rKjEkPo0wmf7IowM1DmOgVjFfckGq5IjEaO8qpluB1u6SAwcz/ol3HKIGpQ
         R/TtDqBm4hgwcZRRnNA1r1gZnARq8iQUIKcWZaM7X146Fuxa0XAr3IXb/HWMnIhcXH4E
         lILVAI4u1/2hgzmC40pd1sc5WqMXy0ajNpKBBkqWgfsjYFgB6MzVW82UMrpnU7AnxwyY
         L+QKxZX3k0e7utjX9hP2unVWQLa7pRo5eeBsqAdyiGpwLgNTBw+j0zMwf3J0GWMuocUN
         uz3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775734461; x=1776339261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgrCj/PkEUGlRNLIdX4qp/95pD0BbHO19KX/pjOhdks=;
        b=dSW4B+rxncCdBUH4hsExy/ydX+glNM7G5nrr9uYQ12KbKmm2UW0tBxUBkJRXKtOZYK
         xQngfa0STZSHZtuxItDyfOS6Sipyr8/uAXWhC3Ru4we96RBYBxNvuS7FXJu+Z2N8DodX
         uQ3PeW5dbRIsJ8xew27UJfVuLNRl0eALxEIjbdPorhZEfAqBS3lgazfRgduOe8D/nsl/
         AHlkaAwCp6cmDbSmyKWpDFQt+YCihFf15aFU79BT05Ugplff4Saa8wniVkTQSTFY1/wh
         nBHaPy34NVYVTHyvWLBaecwSSHDE86Z8bb0gvfFQG/eFCZLHafdUasUL7djwWhD0dWTJ
         nkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775734461; x=1776339261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WgrCj/PkEUGlRNLIdX4qp/95pD0BbHO19KX/pjOhdks=;
        b=X26boevlvW4y3UowwQm5buda2mvpuqsaYYX32Zdi6j0qytOQIkhfm76iF20wlr5uv1
         c7U+JD276Dz3h9nhmhG8O0302fOoeX4DhhyHuTor0xR0hoyOvPwslnP2J/kmY8HaHFEN
         IYtR/bHftw5p37joCXgrIurHomSXl9gjJ2A5xYjTUE5snEpYoFkbrDmDKEmm81I4K7cs
         oAyaL+VYZbqiD7/9aV+EfRFLEND/p2tS5pU7e2OAKLj2D968KRn5A3dRO8v3sNhUhxY2
         oPCa4dC8oKbWPiUNrFDWSTjBxfWNY85v4QuqJ9uwb6GT06BCycT0umJo/jp2lsOi3pX8
         0tDg==
X-Forwarded-Encrypted: i=1; AJvYcCVu6/EIaHobz+ZjfD5Bq4+X1+BPQ1UWvXUtcoJiEc1s1PqSQ76VDNGrFpxZlrdVMq17YSktoPnKjRjC/2d/@vger.kernel.org
X-Gm-Message-State: AOJu0YzLI+IYL08murxEVutUSpiuy8y8ExcDFe4cIjrvrkm4dk8Iw73p
	iZUvbAmC5wilzJV1CqPOopxchzbKMcegm/s8RnzA+xH3i7Ksq9/ukIvDRHsVbL+xZ9BvBu38KpN
	gfM8wqI23v/h4/PREHlmOsGU4h4EHSZoDbNpggcj2NI1yo2HFk9KLuMMXxNPi16mnXn1hLkipX0
	c1xBLp2QHexAqPcQpXDgoUTK+L9zqPZ5jxsv1yn977tQ==
X-Gm-Gg: AeBDies4Yb6I1zJmR5cn9tKg23rupTCHzMhd+j3AtiK+UbL5UyyggrhgVu41tc8RAwr
	nuwxZrO/W8rXQx1zLJJZaZ16yyRTgiOLoSNPT4sMLgvpr9hMiz40X3ug1m2jPdj0+K6C1cVsf2e
	VM/BgaMtLx5FroWN0KZL/zkvCJ/QNR5L2tmnu64kojyHL2MUV9p1QQlSBBlcdRT87AFJYt4eDFH
	ujmTQ==
X-Received: by 2002:a05:6102:644c:b0:603:273f:3576 with SMTP id ada2fe7eead31-605a4e0c576mr11168310137.10.1775734460989;
        Thu, 09 Apr 2026 04:34:20 -0700 (PDT)
X-Received: by 2002:a05:6102:644c:b0:603:273f:3576 with SMTP id
 ada2fe7eead31-605a4e0c576mr11168299137.10.1775734460536; Thu, 09 Apr 2026
 04:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408181123.310291-2-slava@dubeyko.com>
In-Reply-To: <20260408181123.310291-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 9 Apr 2026 14:34:08 +0300
X-Gm-Features: AQROBzD2oAW4zebr47SzIxZN4ebOV7_ib45EoYE6M5Hr_27mto2gFY8z02oGRbQ
Message-ID: <CAO8a2SgeDwVzdKphHYQZJMV_z5Sg7Mc=jfPY3q1RZTvCWaUDkA@mail.gmail.com>
Subject: Re: [PATCH] ceph: add ceph_has_realms_with_quotas() check into ceph_quota_update_statfs()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good catch. Please add braces for multiline if-else statements; braces
are needed even if it is only a comment braces are now needed.
Small nit, please change the comment to  * Treat it as "no quota realm
found" and fall through gracefully. you are not returning.

On Wed, Apr 8, 2026 at 9:12=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
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
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/quota.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 4dc9426643e8..0fa0e7c4b52f 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -231,9 +231,14 @@ static int get_quota_realm(struct ceph_mds_client *m=
dsc, struct inode *inode,
>         if (realm)
>                 ceph_get_snap_realm(mdsc, realm);
>         else
> -               pr_err_ratelimited_client(cl,
> -                               "%p %llx.%llx null i_snap_realm\n",
> -                               inode, ceph_vinop(inode));
> +               /*
> +                * i_snap_realm is NULL when all caps have been released,=
 e.g.
> +                * after an MDS session rejection.  This is a transient s=
tate;
> +                * the realm will be restored once caps are re-granted.  =
Treat
> +                * it as "no quota realm found" and return gracefully.
> +                */
> +               doutc(cl, "%p %llx.%llx null i_snap_realm\n",
> +                     inode, ceph_vinop(inode));
>         while (realm) {
>                 bool has_inode;
>
> @@ -343,9 +348,14 @@ static bool check_quota_exceeded(struct inode *inode=
, enum quota_check_op op,
>         if (realm)
>                 ceph_get_snap_realm(mdsc, realm);
>         else
> -               pr_err_ratelimited_client(cl,
> -                               "%p %llx.%llx null i_snap_realm\n",
> -                               inode, ceph_vinop(inode));
> +               /*
> +                * i_snap_realm is NULL when all caps have been released,=
 e.g.
> +                * after an MDS session rejection.  This is a transient s=
tate;
> +                * the realm will be restored once caps are re-granted.  =
Treat
> +                * it as "quota not exceeded" and return gracefully.
> +                */
> +               doutc(cl, "%p %llx.%llx null i_snap_realm\n",
> +                     inode, ceph_vinop(inode));
>         while (realm) {
>                 bool has_inode;
>
> @@ -496,6 +506,9 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *=
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

