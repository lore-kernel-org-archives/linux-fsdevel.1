Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D33603CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201370; cv=none; b=EYRy20oURAyyvECFZywr3cGRjY7cACpsOnL4UgqcbS/Ur6CMt1Ru6lKIINLw3Sse19OSceNdmoB1V3WxUSCGi/DXpB1qUJjtT6qpgU6EQmCks2gOQbb62Jk65SP+zFWi/Jgk7B3hXu5l+dldL0QaEi1cUHi+pqZnwRZeGa5cDAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201370; c=relaxed/simple;
	bh=Q4INpfKWk7mxaKmB7Uf/Gsp8EUYR21VjlgB0GxYGYxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qpsRHmdCuFPFzZzr4I3ILJQeoKIYfzE6HrdXfyXn/ZYFF8Zm0+9TDcm2T/3bbuITioCY/dto1EuuhRGm9iZNOa0ttCgkFapf0uHy13ev45fEAHpAxRNVbMXqHMs9cCwHwbByBiY8uS47fb7g0kn4d8p0qeKCqjEMiyOe+7Dy6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPYdadDv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRyqJv9r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPYdadDv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRyqJv9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776201368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/TyCH9SMWGwZ0uzhcSuuZUtHYH+vVfCSIhLbgFrzZ0M=;
	b=DPYdadDvQDuRpYejYsBmMk9dxAbMDwnGZlkFDDyni7OaWReJomjDqkHnJ6Ma8iaoi6OqW7
	iN69YMVjheB0wkOOPrS0glWd8tV4C0UdnwNbdC8qq4Dn1qTseVRrl4NwWQgRsXBfJb6oSQ
	YJjL1oQ1tqxPy73j/+Vdn9q1tF+lGtI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-xXOZnVfNPFWI5NS47YZ10Q-1; Tue, 14 Apr 2026 17:16:07 -0400
X-MC-Unique: xXOZnVfNPFWI5NS47YZ10Q-1
X-Mimecast-MFC-AGG-ID: xXOZnVfNPFWI5NS47YZ10Q_1776201366
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7982c3b7da7so145251197b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 14:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776201366; x=1776806166; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/TyCH9SMWGwZ0uzhcSuuZUtHYH+vVfCSIhLbgFrzZ0M=;
        b=MRyqJv9r0e3ouh+RXrs//POsjQjs4Go1fUYCNIopgEJ6i3wvJl0q49Qh4VZ/ElX2bm
         Djmf30gsrihnSWevTIQwdo1xGNt2tqYildA3THy2nBSh/pab4N90w2ZRxIjVPVip0rDo
         rOvZW+ZVR4jRV2OHO5kkY9/TgjOrXUaQsuJ8BQ1SQ7JRIZtxbTryW+hYGwyRW8AvDvit
         HQGKaScx/axmE9W5VpHem/wG1/HEt7ODqB06cqkR2TCiwqiekWxUDf3tHAak8Lk5fabS
         z+PQB5yD6664u8DRfH+6XISCppnvpgC2Rne3xej74dRyQ2wClImZnybrswNAiyE658n+
         nq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776201366; x=1776806166;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TyCH9SMWGwZ0uzhcSuuZUtHYH+vVfCSIhLbgFrzZ0M=;
        b=DqUjufeYvcCr+t5Pt7mFf+csiIugKAj2x6dJJpCcuCRnKyCQS6X0mQ6mMhUAKXYHwj
         Epdt0uMZmv2nGspFZnvUOOlB9FLW/U0ZOm+tT4Tb45tO/H+DQtQxQkDeeDC+J8JDAX+q
         JKsLhY7kmOkFKYN/uO46jX6MiUaPOunow8xPAvHGZhRiAc7Uh8HcrBNtE5hIGvlCJUdl
         rmEVFWdFBCmPvKPwGMUFZHk7DF6wnX7Hqq+78yx6hlX1FEHWjymZTkK6Di95+FrN1KoS
         vZ867w7x3JMNq4D0w0OpE+X7E7bfm420+weCwvBx2ekoSKV69rwvJvQu+aSivcXXAeL4
         fSgw==
X-Forwarded-Encrypted: i=1; AFNElJ/VtIhi3YsFPzaGNDSkIvdS8KmMQTsC6ueNopSoSIdjBOXfKlzS1JmR1jGotalcW7Jjq1OqHVBLtxGGEW3M@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ZXQSHcIQLzo5pD9ydUvFlVbKSDYsKg/+7SBVemQgHrtijGCr
	e38oscCw7RSIu5eRoGw1WzgnXE6w7LLf1BAXDovallLS/fzry0nqTs/9u4W3hHv3Pdb9mzJqR+F
	xQnDiW9cuhuXeKw9Es059ZAHj2ca+AqDH3iv6vSKDKEmkzU4wkmYhinntvhHpkj3EuwQ=
X-Gm-Gg: AeBDievGL41WD5EAAkZoPOyheEcPtvt9mYGw50YGU+9tkHulwidOjDmu5vvVMkDPgvf
	UP057SohG7Pt6dvMZT0kBC55KDMxxBTZoir4/jT4wpwtqIL4C3hfCsiPAR8m2A1qt/iN7v8Qthm
	IyjeKqbZCUYxlpY4+wM93OXFD7sqBb8l3JXlKHKtW2dhctuZSDBIlmq+vbCrYuirXc8pRvEpbfm
	d+21RvyMQDt/i9BkA0NEUus3sr4CapuiCVVrCVWAAQ3CnJ79ivOgYffHDSHWbvENVFIp4fW679f
	83touQEibjkK9/pUg27IrY6+w0eO81Tjpc0bBh9VIkXeJ95v1mDAda1P5seJBRO7PA8sh59GumH
	J1KC2YHyYU28hDUAzG8ME21gIaGRiidb0nqNc2/kp0XHPj60hElqvMJexi95BDF8=
X-Received: by 2002:a05:690c:c1cc:b0:7a1:a31a:bfce with SMTP id 00721157ae682-7af715776famr166038057b3.32.1776201365730;
        Tue, 14 Apr 2026 14:16:05 -0700 (PDT)
X-Received: by 2002:a05:690c:c1cc:b0:7a1:a31a:bfce with SMTP id 00721157ae682-7af715776famr166037817b3.32.1776201365354;
        Tue, 14 Apr 2026 14:16:05 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3d1c07absm73967887b3.19.2026.04.14.14.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 14:16:04 -0700 (PDT)
Message-ID: <f57f2eb9cb81dfd11f1b4dbc9f345b7713dbb5f4.camel@redhat.com>
Subject: Re: [PATCH] hfsplus: remove xattr error message
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: "Colin King (gmail)" <colin.i.king@gmail.com>, Viacheslav Dubeyko	
 <slava@dubeyko.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Yangtao Li <frank.li@vivo.com>,
 linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Apr 2026 14:16:03 -0700
In-Reply-To: <4a6a9ef3-cfa1-46df-bf82-d083ef30041a@gmail.com>
References: <20260411125338.165758-1-colin.i.king@gmail.com>
	 <b0e9b8218a2daeb65c8481d1f4646f3ca89d713a.camel@redhat.com>
	 <4a6a9ef3-cfa1-46df-bf82-d083ef30041a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-14 at 21:19 +0100, Colin King (gmail) wrote:
> On 13/04/2026 18:12, Viacheslav Dubeyko wrote:
> > On Sat, 2026-04-11 at 13:53 +0100, Colin Ian King wrote:
> > > When exercising hfsplus with the stress-ng xattr stressor a large
> > > quantity of somewhat unhelpful error messages "hfsplus: xattr exists
> > > yet" spam the kernel log. Remove these.
> >=20
> > We can convert it into hfs_dbg() and to add showing inode ID + name. Wh=
at do you
> > think?
>=20
> Yes, that's a good idea. Perhaps the phrase "xattr exists yet" can be=20
> rephrased as the message is not really that clear. Any ideas for an=20
> improved message?

Maybe, "unable to recreate the existing xattr"?

Thanks,
Slava.

>=20
> Colin
>=20
> >=20
> > Also, there are other pr_err() in xattr code that can be converted into
> > hfs_dbg(). Could you please take a look into other ones too?
> >=20
> > Thanks,
> > Slava.
> >=20
> > >=20
> > > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > > ---
> > >   fs/hfsplus/xattr.c | 2 --
> > >   1 file changed, 2 deletions(-)
> > >=20
> > > diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> > > index c70bb6f494b2..e10e1d8a5862 100644
> > > --- a/fs/hfsplus/xattr.c
> > > +++ b/fs/hfsplus/xattr.c
> > > @@ -301,7 +301,6 @@ int __hfsplus_setxattr(struct inode *inode, const=
 char *name,
> > >  =20
> > >   	if (!strcmp_xattr_finder_info(name)) {
> > >   		if (flags & XATTR_CREATE) {
> > > -			pr_err("xattr exists yet\n");
> > >   			err =3D -EOPNOTSUPP;
> > >   			goto end_setxattr;
> > >   		}
> > > @@ -348,7 +347,6 @@ int __hfsplus_setxattr(struct inode *inode, const=
 char *name,
> > >  =20
> > >   	if (hfsplus_attr_exists(inode, name)) {
> > >   		if (flags & XATTR_CREATE) {
> > > -			pr_err("xattr exists yet\n");
> > >   			err =3D -EOPNOTSUPP;
> > >   			goto end_setxattr;
> > >   		}
> >=20

