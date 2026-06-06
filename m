Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA13AE1A5
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750108; cv=pass; b=r1Zm2PCEDADOP+o38nec98PGCtRsb9So5tnpwUYwyaZ4Fs1mm6otk4bbYdV20Qd1tT0aW6z0/YwQuZP++0hAtySe7q1YSJkvq9KJ5bmgPFgmA9IDATcflRiPu4uEhfeUpbd/CpVT0kFfx4/U+wAWS/y6H+krbKKuSsaZmB5oUto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750108; c=relaxed/simple;
	bh=xo3ITuhUiM5ECRhBGKvQyU6PibkHxZ6yBSY3p/lvpXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvO9dH9zIAK6jD/9Uu3Ee+6MSWfOfteP8Rd7vC87xn1ztv9mjZHP1dKSer043juIwXIJixCnRW+6SW6CytKZR6b5m6g48i42jTdmOxQlHjFLEghSmAiJvIQ9BD/WIT2H23ckzgrAey1lb0fvq5hFYvELVbyuLQb0YEDbHx/8MmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1NQg/px; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=crBo4l7a; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1NQg/px";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="crBo4l7a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780750105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JS0tkKH/d6iCKTNlfzaObVrKdH7r2McEd05TEs111g0=;
	b=d1NQg/pxRv8BgwmyGn055gG3IttcoRYoV9R95oTmGpSQCGVKuCzzPRH7ZYaxhz5jv3w1af
	fBwlN2ZVwuOLej4UZ44xEaAU4EOmxYJN3AWYBqE+Kq/oHUSecr4+KEE1rKtgiyBz2tHWtq
	sFbz9ZtSmErYWvE5X4DEfaAlnxKENkw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-4rrp-Cy-Pg-Uhb42Db2D0w-1; Sat, 06 Jun 2026 08:48:23 -0400
X-MC-Unique: 4rrp-Cy-Pg-Uhb42Db2D0w-1
X-Mimecast-MFC-AGG-ID: 4rrp-Cy-Pg-Uhb42Db2D0w_1780750103
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7e9369f8d35so52463707b3.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 05:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780750103; cv=none;
        d=google.com; s=arc-20240605;
        b=AOFvD5BOdKYbhj8wUdu+JN8ZNv0REmkzPzpejU6qTgEfF8gtsOrKih9gAQlSBFjKEa
         UG0QLH80UDSqYdVSDUnNMO7scG1xzI1auij/pTpatdxOhG1juaNlwTnndSknE5UIIL8H
         biE8OMnEx/xk66XnSjgO4RA4Rbzv7hC002rAr+WrcJTQ6IyX3f6PvmlgsDv+QaaJgKZi
         H7f2KhLa5Fpkhg2oIORK+4+zv0cgwHfJk+ZWCSsP0srz5i7No2+sPHaNiyMEULwtMGwU
         AaYdEyIkvicqN+VDZW0KYwIfCjUO/d6sNREK84YuQaD1GR8mKsQZQkWxco74avg9q9/c
         fkEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JS0tkKH/d6iCKTNlfzaObVrKdH7r2McEd05TEs111g0=;
        fh=ISycuRQVonFFaQilA/Q815tbtaqRQxMJ50XrdTzCUkc=;
        b=Iov4ghaiOp/A6D8ShRmxQo3MRf03gSi9Jzh2yHI8sKYA8dsh6mGmF6Z1ng/khi+fwA
         b8HONu5kWiArIqsNZKCYertDp+pbl90Ph9xtKbaCTjCJmCjRa5InkaHBcFX2kHLUjK4h
         xd30oCNOJutHpG46/Zu7Tx3az8hApfe2urE8DmllAkBldMZ/y5LfSTSW6tOGHR63ZoEt
         tBAJwQ3P6vmJ69Jrcyw1YvKG2fmV6yqDxwnCYEdtI6cWQxyEZdYbF5yrXJp0v6PhlYQ6
         rcUGZ6JPBGXFVRoJnB4KgbLmWuLNzFAR0O8ex9HTOeppsS+DBUbmWADDU9CbQYSl4aoW
         sKHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780750103; x=1781354903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JS0tkKH/d6iCKTNlfzaObVrKdH7r2McEd05TEs111g0=;
        b=crBo4l7acuC/f8Nq8NbMAgsOSt+85JUcO4TK53VInAgSw9LMFxGtk5Y463/QYMa0Is
         O1LL/+9hOY7OI4XDRQTkDoDzyNgogDBH+K1OECxCiuB0yNsukgqDNmOSXGjBmp50EEqw
         golOOz6JwhfW1qRR1g77Eyz8R0xw+WbpyxhzV6nmAyi3BiOuB4a8bC3DK597xYHdnc8r
         sW3TdRUyL3uBdp5N92QefOVEPjxJftAOdQDz1LzA292Ggixais3o7bE6CoiRc47gVtQL
         CrSt0wnkdWDBzITAUgB+CeZSBL8DlgehRCYUJImyVBF6B25CD4TAM/Ad9Xk6BSfAIIde
         obQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780750103; x=1781354903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JS0tkKH/d6iCKTNlfzaObVrKdH7r2McEd05TEs111g0=;
        b=nJoZZAEup4QBJGdHQClz7ejhEQjZbEXi0VO7uMpxxTy64ZE7tSSFm4XG8ZONLNjReE
         GRN4ZsDZnV0MvZ8woe3RGGwTuaC0VliNjc6rD5K39f/lXU0e/zpS0H6h6JcpJ5YW4LgD
         brasZrK42ISIz52DsZpDJDk/hFq30HXNAf6yaamsMfyPjkvmEkva2/WPO30HarhJHnnG
         VGwThlNiq6sZjUCvjFP6VKuj1NRRH3Q2RofUoQbsjcK5npi+iqWOBgwwUMOzjtq5TXmI
         uJRJXki4hHUCaCujnURm0ZIRPLyHlNG5P0MCL1m/fFPGgutukKVH5ietwecOfWMPOSdm
         L7hg==
X-Gm-Message-State: AOJu0YzuVOu8I20cGb9HrCD1iv1HRXudXE2Sy9bw4GFQhRKoLRSmuUPl
	HBJ7l8U0XijltYWKRry4m6S3eBhO2BFM1NAk0xqsrqj45Ch4+B/13rCBmES81VSPaIvoU1HUv7w
	4SJAZqlspLDqQ3qr2w7SN9ha8nndMJhJZHzm2hA00QU7k8ZYK3mp2nn3fFzbKJZkLEapghFkScT
	TsQm3I8/nHf/1kc7FO69L0Iz5f9LvOL0vLQov38IHLCbErXVVgYQ==
X-Gm-Gg: Acq92OGFaMfTDrZ/CQCAg6bTZc5i+/0+0SRl4NiugIKivCT1WaULUX+uyLhRk0vQyDJ
	yJbJbvx9BsxrSYtiPiGvK3ncBfnSnFUVl29hJmC3eNOECqAkJDP0bPyXU+HQxPizXmSZMQBI8q2
	JuW8PaYPYhrkuFFT2xE0+EDbxukbN5rS3qrmjuqWRRtOjhrSSvYKrVNuJhbAaQnYd/61A1kkI35
	alvqzk87zMM4A7H+tH4o84D8hd2v6Be5ao+JZiwhefxDmkGjeMCz1AbEk4JFSd72Ypo+LkQOrcb
X-Received: by 2002:a05:690c:6c83:b0:7dd:7dc9:c2c5 with SMTP id 00721157ae682-7ed0a5ef492mr77182727b3.4.1780750102938;
        Sat, 06 Jun 2026 05:48:22 -0700 (PDT)
X-Received: by 2002:a05:690c:6c83:b0:7dd:7dc9:c2c5 with SMTP id
 00721157ae682-7ed0a5ef492mr77182497b3.4.1780750102535; Sat, 06 Jun 2026
 05:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606064956.2722874-1-viro@zeniv.linux.org.uk> <20260606064956.2722874-7-viro@zeniv.linux.org.uk>
In-Reply-To: <20260606064956.2722874-7-viro@zeniv.linux.org.uk>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 6 Jun 2026 14:48:11 +0200
X-Gm-Features: AVVi8CeZ5hoLt8u24VFcwgTCAMdWsKM-3xLveOGDCv5lqG_UvbPJxfJN9YfbOQI
Message-ID: <CAHc6FU57ttxrK=u7y3X2-Wt728ecV_1uh_Vp1LhV+uDobJzCbg@mail.gmail.com>
Subject: Re: [PATCH 6/6] gfs2: use d_splice_alias() for ->lookup() return value
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Tyler Hicks <code@tyhicks.com>, 
	Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 9:11=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

> ---
>  fs/gfs2/inode.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index e9bf4879c07f..6a3581e3ba93 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -987,12 +987,8 @@ static struct dentry *__gfs2_lookup(struct inode *di=
r, struct dentry *dentry,
>         int error;
>
>         inode =3D gfs2_lookupi(dir, &dentry->d_name, 0);
> -       if (inode =3D=3D NULL) {
> -               d_add(dentry, NULL);
> -               return NULL;
> -       }
> -       if (IS_ERR(inode))
> -               return ERR_CAST(inode);
> +       if (inode =3D=3D NULL || IS_ERR(inode))
> +               return d_splice_alias(inode, dentry);
>
>         gl =3D GFS2_I(inode)->i_gl;
>         error =3D gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
> --
> 2.47.3
>

