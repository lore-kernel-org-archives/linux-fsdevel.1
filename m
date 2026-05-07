Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C3D31AF24
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191254; cv=none; b=imV/zzwnwkE2VIec1HiOC01WWF9iMYJ1eSFz47qIY6uMd40fvq1Dwgt+XCjM9bBedhIEtjAJXh9KAtEFqjY6D3+FTBIYr47z8L/SKN5d6Wyk/imj26pxVQwrrYwYpiBTWmJZczsCncWBR/+iyHl+q86FBk4c12VHUvQmMke1HdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191254; c=relaxed/simple;
	bh=kXvEVbWYiMNEcD5Eeg7Jx0kf81E2efj8MSkM/iq8Wog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jx9etdr6aEvz8xo6rvv9qXzq701M1h8mr2dsnaRZil14r13GqOlQnayueBD4nY90IXmNqDaPkSGO7BVdQt8U/ELTflktEj6R7ivR1ygM+KY6YatQkTmDhDDly2yVcSjtuxscL2DW73aV8+Hy2tuoS+mv6DZlgO+qu7n1yMGqtco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuFVRCpn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BD9cM8gc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuFVRCpn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BD9cM8gc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778191252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCt4CbnC2t1Wn2tH9HotoRjOmh7EYjaXkF1bamqzEMo=;
	b=KuFVRCpnDxjUhzur8K0RV10Hqsak3ACi+L05DChzrRlqHkdp1X57OsZY3SFQ1mAvZPzIWl
	pmEfbuNQA2Puz9YBJA7RJzP7AwR2zOKby8Kh79drDKayiLQvRW+udBQk0teKy32BRLibse
	bTYHc0+9uu7FpWC8ijwYhZU1RZvBTyo=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-MGS-Ni84MMWleU3kxi0zEg-1; Thu, 07 May 2026 18:00:51 -0400
X-MC-Unique: MGS-Ni84MMWleU3kxi0zEg-1
X-Mimecast-MFC-AGG-ID: MGS-Ni84MMWleU3kxi0zEg_1778191249
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-65c694b54d7so2781436d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778191249; x=1778796049; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FCt4CbnC2t1Wn2tH9HotoRjOmh7EYjaXkF1bamqzEMo=;
        b=BD9cM8gcGHtxVE5kS3XYi1uyVtnZbwsBPOYckeESZwWwywBkxtwuwt+zVMRp3l6Is+
         /rQHmLqtR5ciYeo1IFGxvup96TEXoFgqoX9Ay9s8k5NKIvt75A/XILIRXKyKBCFBdv3O
         5Sx9zxFADgBtv7wXyJGDeO5/1aSk6PcyzVRUhJwryDeS0i0UStFC8sAmVMUK6CB+gRrn
         zCAuZYSYWmOQt0AuLKsQPPT7dgM0siTb1q46JI6hNmhdaT1vm8vo+Y713f25ueJYfHQ0
         CDRaV5fEaDZUi0h1BSTdiUmyZN7v0gUwLEBuBL/SKeYQbSC1gg1ix9sPzudUwGpVNesD
         29Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778191249; x=1778796049;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCt4CbnC2t1Wn2tH9HotoRjOmh7EYjaXkF1bamqzEMo=;
        b=TqzuZdvXz5RGRHB+eA4ZvtvIep3dRwY2F/dDvf08jnGcNMJ6YwQ4C/s3RYQei12M/M
         Hj5w4YJP7/9LrwjaU/VEtZJYfuzCHc40GAGlTOu9FO3cZcslfVDSPlm8D5G/djVLATwb
         eooMTEVY7ZC5IbAu1sv3w34zM+b6MRr5Dcl7b6n2nDGMkxIgD8GvrDuYLgfKRJW5dSLt
         OKttUPkOunTimy2woJrOqwPsxEUhaNjAbleDcE4ysreWCZgXBnVpkP0oDT9W1NEkPWJP
         37qH7Ss0W4GEG0mUWyf5FGKy1FJZIoBBJfrNLe19oO55JqGgsvnNB+4cYMtwehLEa8FE
         yqaw==
X-Gm-Message-State: AOJu0YwhlMqnOXtZ5cvdaYIoTfVzi+JHXgVnnf9LMjktyimTGeO88JWZ
	k6EfdueAaCetKZNYncERKA4MRC9YAbunqCG0E+EQ53kJYJJ6W5lnynTYFhorhEvwj000N23frZS
	OgzQiE6+BKnE2MqwLOOiM0mOlfrhpcyUC0smlCK8e50ODc9r7vYpBDo7YgBj4zRMCAc0=
X-Gm-Gg: AeBDies2owJ3/MoDNpSbCAng+sPed37xhFEEftIlxaihtUIMwbc6i/016nJ1bJYNgqZ
	Dl4Or1AusFBn3bj0qSyEVpuwXF2aDw5uoddr9ABbNSJvpfuDjr4dbvoDDkLt4hwQJhyQNDjwlW0
	J9U43xpVnm73uffQ6VOdx98ggKYG30Yw9AUx8WMY8Ftnozdt6LEevQqpifAQ6Jo1HFatqazlFGV
	cFFotBXbQWJa+zsLrSx2jq3jYq9+bLCQdI+2A1IUAeGNDN7eFG/3VnbUdJ/Q39uk7iC84o/0X16
	XRMiSpqr2Tr577bRmYDNtlIXzN6Fmhw4mVVIRXm0r3l5yCWvh3RlENA90HI1Pkxe9SvZLnamUdE
	Cv+biu73fylIOx8zwvOZ/ZCtLjF9EW7XAs0X93S5vL0vS9QLxKh4l
X-Received: by 2002:a05:690e:4850:b0:657:656d:5680 with SMTP id 956f58d0204a3-65c799d553fmr8389816d50.53.1778191248996;
        Thu, 07 May 2026 15:00:48 -0700 (PDT)
X-Received: by 2002:a05:690e:4850:b0:657:656d:5680 with SMTP id 956f58d0204a3-65c799d553fmr8389772d50.53.1778191248284;
        Thu, 07 May 2026 15:00:48 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d9573cf3csm16834d50.1.2026.05.07.15.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:00:47 -0700 (PDT)
Message-ID: <20de8ed057c5b554b0d8edbdb921842a499f9848.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] hfs/hfsplus: zero-initialize buffer in
 hfs_bnode_read
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:00:46 -0700
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
>=20
> =20

Looks good. Thanks a lot for the fix.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

