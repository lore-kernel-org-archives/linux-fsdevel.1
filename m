Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0E01A316E
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191332; cv=none; b=e6zhW5s4HigOGEjumFVcuurdKeeuoMbJYLkKoL73XjGTbnekhqX2WFFBvhUICwkfPS0MJQmvIJxw+zMtU07GJsN2V0Pj4CR394cXngFgnp0ZqjLbVYQDXwckUqdEZ5YOmxLCcbpB8i9/zBd9A/7X5GrFu7ndFTUg7cloGfeC/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191332; c=relaxed/simple;
	bh=aevgSz8+YiQkYmwbwa2Znv00DPcN+ByyI9F0Fhh1YWc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zsx+P/bhMn/L6G9oNieesee+JYPOJdDh1tbmWX0l+BhRmdik5k0/k6/hqRDRjqo8c1mf4Objc4NocqAOjAE/gzH+aEVxvGUjRyc4aUzpm/DQ1x7FS//Jg0OT6uUqUbPC/XeqovGlVq4MRgNeN3hwTyK69ffByAum8NzIfXyzA7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMHnjOT9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SuLL8QPQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMHnjOT9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuLL8QPQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778191330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/FARJZgNi0r+qVrAoVHMHW1WahLtk0szPiWx0DrMUtU=;
	b=IMHnjOT9txlJIC38FmL9fR/MgT7k85Wxo7EonT4PPRP2l4JctxsICIuTs7kI8+o7ZgR/+8
	q0RqdFICTE/SsA+44wW9U4gZRGw5knDgrZhN2r54nnEq9OLmPq9BQ4lkHLFOFWR2J4jiGW
	adBCe7OSBaNQkfgoU+iQnctLS18Iekk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-QwDgch4BO06rRfpdptM0nQ-1; Thu, 07 May 2026 18:02:09 -0400
X-MC-Unique: QwDgch4BO06rRfpdptM0nQ-1
X-Mimecast-MFC-AGG-ID: QwDgch4BO06rRfpdptM0nQ_1778191328
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7bf14e36717so21229717b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778191328; x=1778796128; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/FARJZgNi0r+qVrAoVHMHW1WahLtk0szPiWx0DrMUtU=;
        b=SuLL8QPQhFqs6xc29yOTIKgj/6YPfZMs7j0Ocz5AXIfAmgYHUp5mXP2sdX6MMyDh2b
         CndQZpYMp/Sfy4P3GnGgP4YqUxEJbHESxbfEf8ozD4SLC2Con1q+GcZmNt5AUHzmJ+Co
         5ukz7sjCY7lZ5z6ZsuuwEKLFRkOlvVSXYsO6GRZ/NkJuNFMGqygCrFPZGH26EqrF3rMT
         37Wv9UA9B9Y0ZtB+OLwXVVdxxUC9nETPsn8+tqRMwXi+bROgvLuopdes1FN+fNzRRpKf
         kFHEdHjvBT00Osxh5LmPJtRn6gyre/0zEW/MEc3xoeQ6wNQRlBQ4tInMvjjTdwtkd5dA
         c9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778191328; x=1778796128;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FARJZgNi0r+qVrAoVHMHW1WahLtk0szPiWx0DrMUtU=;
        b=o+uXiaAqVg06v616lQ0iQQwF8yX9knmPbXhM9bNpHF9mZ+9OFzzcQk9rAtzd8FrQQl
         YKRaufsV7dleuzKoS+uGdOGPiC1y2F9eXl/vXMItxGm0yJFP4+mebE9jNz4uD/pRRSRe
         r+fQqvLf8ngUljfzln7U6mwNzuWu2aLmnbEAfK3ri69Vg6BNwXPl0no8IE9IHk2uHhPA
         WLWH2Dtork7aHofBt96tJJR0DSBk4q3tQ3aF7NW5P6lDbSYEF8bRDKZ8DH8wqWNBaHZJ
         yDWQHpu0MU2BZJB/GPDGlEbQ+HWJoGveGgD9Akwu9ldGLzls8fch6YXrx/wnq3n/Gntc
         MbLg==
X-Gm-Message-State: AOJu0YzWMAFXYv4e73kEiwx+m+g7m8Iw1D7/JGoxQgimY4reM48nEMKE
	aD/UXzumaZNr6J/pzLoP04hSWv2+9Ka+npfWqDPo+vrYOFG+G6WUwJI4+4yhGd9/ZLAIPWlMiSd
	naCXw04DUInhP0DWi26/HmqAPlCkWKdphkDVmd7vO0A9nvRXZhIyhHb+Hz/fo90FYLNU=
X-Gm-Gg: Acq92OEcqaY30HJR3F6o+bRa/pzk5pE31/ZZP+t2ZW0tcVq4lfwRHpTA8x6QzQi2e3S
	MLzk+1XN4zrNE0CewHKcZW7e1wMjDu3j8BXdmF1oTWA9nRl9HuUhn9ZUCGw0VVmmpQ6PaCyt1+a
	sDSWKZYoV0kioB07zulYG4Iack2WeKIzBIBjRG4/+3yIp7loFJOCPXkIoW/xFd8HaUACjUef98P
	Q4qvQMJdHAibyrRhTy7QGgiNA0H3yOKoGSXqEhX0/wsxTU/mAn5IN+DxIWyPWjINb+ySoUEQJGf
	Qh/2gw6pfflP8KqyQKL0i5EEie5ERADmuDfyMipwF+b2K66lwPATC5Wy5xzPXvdBAt/hD84/1RD
	OW1ZQsteTfRhsTVo+Ccj+R0l/5Uqemx6UsnKfUnXt3XmXYiO6gqIc
X-Received: by 2002:a05:690c:399:b0:798:7879:1ab4 with SMTP id 00721157ae682-7bdf5ece4f6mr106303037b3.37.1778191328129;
        Thu, 07 May 2026 15:02:08 -0700 (PDT)
X-Received: by 2002:a05:690c:399:b0:798:7879:1ab4 with SMTP id 00721157ae682-7bdf5ece4f6mr106302387b3.37.1778191327403;
        Thu, 07 May 2026 15:02:07 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6656d218sm97273237b3.22.2026.05.07.15.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:02:06 -0700 (PDT)
Message-ID: <8cfc69ac21525b037c7e238ac6690f440dbff9c0.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] hfs/hfsplus: fix u32 overflow in
 check_and_correct_requested_length
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:02:05 -0700
In-Reply-To: <20260505111300.3592757-2-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
	 <20260505111300.3592757-1-tristmd@gmail.com>
	 <20260505111300.3592757-2-tristmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-05 at 11:12 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> check_and_correct_requested_length() compares (off + len) against
> node_size using u32 arithmetic.  When the caller passes a large len
> value (e.g. from an underflowed subtraction in hfs_brec_remove()),
> off + len can wrap past 2^32 and produce a small result, causing the
> bounds check to pass when it should fail.
>=20
> For example, with off=3D14 and len=3D0xFFFFFFF2 (underflowed from
> data_off - keyoffset - size in hfs_brec_remove), off + len wraps to 6,
> which is less than a typical node_size of 512, so the check passes and
> the subsequent memmove reads ~4GB past the node buffer.
>=20
> Fix this by widening the addition to u64 before comparing against
> node_size.  This prevents the u32 wrap while keeping the logic
> straightforward.
>=20
> Reported-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D6df204b70bf3261691c5
> Tested-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
> Reported-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De76bf3d19b85350571ac
> Tested-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
> Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfs/bnode.c          | 2 +-
>  fs/hfsplus/hfsplus_fs.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index 13d58c51fc46b..9571f33b91085 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -41,7 +41,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode=
 *node, u32 off, u32 len)
> =20
>  	node_size =3D node->tree->node_size;
> =20
> -	if ((off + len) > node_size) {
> +	if ((u64)off + len > node_size) {
>  		u32 new_len =3D node_size - off;
> =20
>  		pr_err("requested length has been corrected: "
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 3545b8dbf11c5..0e4268de9e60e 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -600,7 +600,7 @@ u32 check_and_correct_requested_length(struct hfs_bno=
de *node, u32 off, u32 len)
> =20
>  	node_size =3D node->tree->node_size;
> =20
> -	if ((off + len) > node_size) {
> +	if ((u64)off + len > node_size) {
>  		u32 new_len =3D node_size - off;
> =20
>  		pr_err("requested length has been corrected: "


Looks good. Thanks for the fix.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

