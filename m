Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A1314D35
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778095410; cv=none; b=LfNDsGl+Odv/WZQxMseRwlFUQCODw+SzcE8+w+ia+CvWtc8A0fsxnwuC98bRUVW+Es7TjXXE3BKyMJIibiNshiUfvJycm71pVKA7XTPhvwbnWTsEmQui20vgK8Rjcs5u597aXn0ujn9EQmJ2adJrTg6Evcriiahi3pH42JGPE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778095410; c=relaxed/simple;
	bh=uJepBFL6cOUbc1xZRU6JLYUwiSE/867oDsw0QGbgJ5k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JN/VVrMn2rUWH6gyFXUQFKVva3/W/ezwr2/3I7qVu5RG0qPVPRv+oOMX9U1kmmqMg001K1I/l9sL4A+mn4dM/q5vYk/3f6yAcANQ/BBZNuxhJ1rqodjnFmM6v5+iyDSCgCGe6066rScicZsbv6uh8qXCnL8erPsCpDJ5s3sgUts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkDyOHbQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUJV/sI5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkDyOHbQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUJV/sI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778095408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVLzXZcsa2Chju/J2XsneBua4YrrV59ws3nFOLc6bEQ=;
	b=NkDyOHbQnybcjWR2/GF0a5T47RZk0URVnrN1gXyit1wBR5BuA12HYEMXAF6aAuM6Sd3r+d
	buMKRVfNUw4UTdVNEZGuKYJk/zOByGbu2C6LFhl3ncETmZvI/7vNcgayNZ0/4PfjReJ7co
	CofIavNIpSUvXUsENxY0nVsPzr7ogjc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-a0T_waUJNG-XHw4WxPk8UA-1; Wed, 06 May 2026 15:23:26 -0400
X-MC-Unique: a0T_waUJNG-XHw4WxPk8UA-1
X-Mimecast-MFC-AGG-ID: a0T_waUJNG-XHw4WxPk8UA_1778095406
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7bd5c9e2e4aso138292247b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 May 2026 12:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778095406; x=1778700206; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EVLzXZcsa2Chju/J2XsneBua4YrrV59ws3nFOLc6bEQ=;
        b=hUJV/sI59ckuHz/neu4g0gr4tIObhnNCLTAZjXza1mIZsrrucL7mL05mzrT8ZLte+m
         8HpYa9Zgfc2iPlJ8BdC99OpJNbBh7dYYb+I6KFf2PLOq/qwPwVdC9tZBPWT/4l5Xj0yy
         LsHlapR8FjG0SEcHv4oSbIJKtBiiiYCqZugnSNuryP/E5QUTXTXvnPRZTtn0sKVxZnC/
         L+WEfTryM6FNXQEwEnt6KXL626PM0NZfvX//14Wxz6LOMzUBVG3x0N2hbV070kKGdQp3
         B3rWzt6kJNRAxY9a72H9jsW7IdXWlT8dXgS7PA05/2owfKUY0SX+x3mdeXqrVBqCBzzh
         R47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778095406; x=1778700206;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVLzXZcsa2Chju/J2XsneBua4YrrV59ws3nFOLc6bEQ=;
        b=h/37hGQYNoyI9Smgy8+Z59nQRMw0T/3IXc5LBTKqdVerZRGSaDSsOAwR4AHGcBKGrN
         usQWy6j4JRlvakMsXX92XpAcTMRJxsgPlroecFkR6qgxMN+IC0SEsUyDqYKEskWnPivD
         1CfOE3IdDvuBTgkRSEz8QgJTIl3KHwCvi4GOSJKUY4y+eOZE/d285LE6vkFZu0MgBE1l
         I8nsvc+6lNYox1hJTSTPCdPFtZNu4cY75wE4fLu6M7O8ADBcrRV73Fm5fR6FoklY4rv1
         F5cPKuKZW4KpaqJj5ajqRM0LZmC8ocgp7iSYVwzqczsgCL0qaQlO/2laFauwfPCS4Ez3
         rGRQ==
X-Gm-Message-State: AOJu0YxHjTDNS/Fw1ikXEU1uGRxeeGiIXC9WsNSHx15n8QcOMTi8y262
	tmMEX4M+m77docmlTu4ChEskZdPJRVIU0RHfEFAWyroj9O9T0m5QHhgww6uECoZmDkNOxaZq79Y
	1GOdL8Jb4ms4DT7svykzECoU5Zs3r8ldHjK+BLZiqwkdVaqPvcTUeu/jRs+NC8FqfI+hjHRBEF+
	E=
X-Gm-Gg: AeBDievJJu6lhg9sqlO6qNNEwbfuu0zy7x+UntZH8s0B9/YR5+Bs4SyXfcBy3e3dN5V
	1gO6mq/q/MtQsKdAe8kK4nKIhnwnCS8+aTJTrTZPZgzQ5qGR+Ftv3NBcipGmoVBqsHUQNVobr3Z
	6whU95tXuKhl5c3h85wsDxJAPc4kiHkHr9cCOmQr9Ku9k3YXHj8A/GiOwX7Z0HopqRgrHYtq3iB
	vPrms84wOCYLyf0gUwxdjYk8oqJaMRX45Qt1iT8ZnN8Lbiq1F8Vjx9iBlynLs4RWULBlmO7CtUK
	MWgG77meTPRLk7S+TkazNRQ+6gdjrYE0vawbn2AbqTvxqGnxLL54WE7+zkoM1wmz9a10bHl6jHs
	pgVxz1gMh7RmZi+6ktIQWTj2vxK5VQmUYAXyZwBW/UQAA8txqirdnszvULqeYTbs=
X-Received: by 2002:a05:690c:3489:b0:7be:5f3e:5309 with SMTP id 00721157ae682-7be5f3e5883mr21987317b3.38.1778095405975;
        Wed, 06 May 2026 12:23:25 -0700 (PDT)
X-Received: by 2002:a05:690c:3489:b0:7be:5f3e:5309 with SMTP id 00721157ae682-7be5f3e5883mr21986647b3.38.1778095405522;
        Wed, 06 May 2026 12:23:25 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665464ccsm83249867b3.11.2026.05.06.12.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:23:24 -0700 (PDT)
Message-ID: <00306449e9bb0703aedc71b01fea2b04e33b2725.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] hfs/hfsplus: zero-initialize buffer in
 hfs_bnode_read
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 May 2026 12:23:23 -0700
In-Reply-To: <20260505111300.3592757-3-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
	 <20260505111300.3592757-1-tristmd@gmail.com>
	 <20260505111300.3592757-3-tristmd@gmail.com>
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
> hfs_bnode_read() can return early without writing to the output buffer
> when is_bnode_offset_valid() fails or when check_and_correct_requested_
> length() corrects the length to zero.  Callers such as hfs_bnode_read_
> u16() and hfs_bnode_read_u8() pass stack-allocated buffers and use the
> result unconditionally, leading to KMSAN uninit-value reports.
>=20
> Rather than initializing at each individual call site, zero the buffer
> at the start of hfs_bnode_read() before any validation checks.  This
> ensures all callers in both hfs and hfsplus get a deterministic zero
> value regardless of which early-return path is taken.
>=20
> Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D217eb327242d08197efb
> Tested-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfs/bnode.c     | 2 ++
>  fs/hfsplus/bnode.c | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index 9571f33b91085..25cef62fbba6d 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -64,6 +64,8 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, =
u32 off, u32 len)
>  	u32 bytes_read;
>  	u32 bytes_to_read;
> =20
> +	memset(buf, 0, len);
> +
>  	if (!is_bnode_offset_valid(node, off))
>  		return;
> =20
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index f8b5a8ae58ff5..14d1af2c7ba93 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -25,6 +25,8 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, =
u32 off, u32 len)
>  	struct page **pagep;
>  	u32 l;
> =20
> +	memset(buf, 0, len);
> +
>  	if (!is_bnode_offset_valid(node, off))
>  		return;
> =20

We are returning back to the same my question. What if the caller of
hfs_bnode_read() provides the len =3D=3D 0 somehow but the buffer has not z=
ero size
on the caller side? I assume that memset() will do nothing and the buffer s=
till
be not initialized. Am I correct here?

Thanks,
Slava.

