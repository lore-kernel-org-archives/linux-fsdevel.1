Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543536C9CC
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777937379; cv=none; b=GEVZWuR0o5L2swSSTxL2+Vs2t/trsjzYvGxdH7gVg4ZLs8s9tLfsjgI77wgshT+Nvs0gen5qWpdq+pdteW2eWbxetBDJedQijQpvZZ20g/aynJ/CiF3CCRSrew4PKOFG+t6DVEt7mE49o1NUSDrMAsrbrNcSzPIIrh+5u+ly7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777937379; c=relaxed/simple;
	bh=VB/VZVOuWxM7Vs4MaYara4db9BUPG7xgRiAmNS6PBh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0MmQkk3bx2HfZ6xColHHSxrsjTDusrkjSgFe0RPMky1USR4BPUN8DV9dZtrb6Ja+1Tgm6HNmtyP7Xgmmf8DUFXNB7ldqnaF+SBo5KN5zT32bDaPA06BRJRAqrv+JF7AYmhBjdutDfCbzjU7LqaDbzX+SYFL2CDrsZf0wgpzQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h92yLmBp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxkhQDiK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h92yLmBp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxkhQDiK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777937376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMJ6qLGsbY/8TJJVB5qBWJI8imsazXiBmcRxjMiEVbc=;
	b=h92yLmBpTgXrgIJdmNPHbBbbuAyWFi89CxGtMVXZip3X3RWPINCGiALZVlobLNSOVIxEte
	Sl7GlskcLRRG65WTYMalAbmpO6JOwX3S2FixLK9O75TnyAMMPjtdUBfHM2yXQulvpvq5S5
	ImkR6tz5kxgpQj0Dk3wEOjzBVx14oBM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581--eYvNBSKMbuiEhcGTM1sJg-1; Mon, 04 May 2026 19:29:35 -0400
X-MC-Unique: -eYvNBSKMbuiEhcGTM1sJg-1
X-Mimecast-MFC-AGG-ID: -eYvNBSKMbuiEhcGTM1sJg_1777937374
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-799001d7289so7589647b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 16:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777937374; x=1778542174; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oMJ6qLGsbY/8TJJVB5qBWJI8imsazXiBmcRxjMiEVbc=;
        b=MxkhQDiKXqkTHkU03JhOUN8PGEBQCmoU77fFPhrTSthYkN5h7F+2JAXuZYxTnP5jy6
         nIAvDIsqe7fPiBW8Tv64y9b6a2X/10ru9ZwdT5VRSoKMAwFWDcHBTnBaMGsnVwP1kUWS
         Pt54rqy4Ciu26+7yFVOft5HVIKgbxoTER4Vh4/xdQaBQlpkQ8BvjcpUlEZrWH3NQ1CqR
         BhSOX++0fh/qbELUExn+jcDoy7gSddCNwb5BJLoVCfBw1ClCn0aiy+G7lI4MF010DEhr
         AMFaO4GIG2cqNKVxjC/+WFLy01lmi2KMuxh6yWFCcxAJPP1c5DZlI7HZf7BvLAL0EFSY
         KXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777937374; x=1778542174;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMJ6qLGsbY/8TJJVB5qBWJI8imsazXiBmcRxjMiEVbc=;
        b=REn08Q8cEo02upE7donVNrzM86LGQbsrfJi4htTc/emMvV8QvkK/fE4H146lct4Fi3
         XofWEOfg0332SgGSBrOYk4sup5uGZUHG6ccSsxmk956qx/maZ25pF0ZeTQuqPEgMwUCL
         o1zNjA0S1+KmbV8okWsBQUPANLqoKIrLVMTg6lALL9HfKskl5GetcKLGXxZzFdsfsxm/
         xL4ngyjfUofCH6Tv73CgJmIbS4RNHhYso7Y4yV5X5JqWfcWmmq5JQ5BgmIJBnXu+fKlx
         FkCHz1HJVQXqkvGLpUEUkgftTOE+etM0hLJCIEU0uyvK+tGkAiiXwCLjCdeLeE68QaTH
         1R8A==
X-Gm-Message-State: AOJu0YxSVGtUb/icIuVzalg0cXyUX1Mq++ErkhEFZ9FB1TGbQtOkgXwc
	3AjKHOwjue21Hh3f3OzTudX16ieGg/afmpn1tg0RaVDjG6BEP79YeH2kS0xm5DIuiwb3gysnf0O
	CogweCj+8m6LbTAZjjqaqSImAR/MtFgyZ6c/DIGKcyey+x2zZf+zb9wR6oOyCX/9mF5c=
X-Gm-Gg: AeBDiesggr1uAvJd9qaQBHcYT5QPrtPjjk1pLx8fgsaegGixjk55FfpluV/xItHoT7s
	es67EtDomCnyTKLa2uoHaj1tbwR0z3C4Tx85BTNDkEmqbe6nomKRf93UA8uyfWB8CL1E1Bc3fSg
	kA5CSZFD0IpB6Hv5eNgH7MS4V22WSTrE+u9205+I0aeCPdyjPYiSHr9J8Wu71FfmAiTdIAyLPsk
	0Ng+zZEV4lpGta2+5mlXzJ7YPN2EX1s6xj6bnj6zLoLJJFWZbE1QpVZOVeDhvui/h+LbRGelK1r
	kO2c4JyYuU75HZEbKGIxqHl27KC6OWxgJUDv9X58nLy95IMb7TBhSwo8wD7hN+5WEq0ccP9id5y
	1gcOMjCRAzoh2Bpsan+QkmrUgE2xVzIdfGrwLIgvY1+wXQWLGZw5PwIbV3uSPhvk=
X-Received: by 2002:a05:690c:c501:b0:7ba:fd82:9131 with SMTP id 00721157ae682-7bdac640431mr9348007b3.47.1777937374242;
        Mon, 04 May 2026 16:29:34 -0700 (PDT)
X-Received: by 2002:a05:690c:c501:b0:7ba:fd82:9131 with SMTP id 00721157ae682-7bdac640431mr9347667b3.47.1777937373502;
        Mon, 04 May 2026 16:29:33 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd7d849afesm37183217b3.49.2026.05.04.16.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:29:33 -0700 (PDT)
Message-ID: <af5d510b2204484b414474c5b92c8654908c4db3.camel@redhat.com>
Subject: Re: [PATCH 2/3] hfs/hfsplus: initialize data buffer in
 hfs_bnode_read_u16 and hfs_bnode_read_u8
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>,  John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>, 
	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Date: Mon, 04 May 2026 16:29:31 -0700
In-Reply-To: <20260501110218.29906-2-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
	 <20260501110218.29906-2-tristmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-01 at 11:02 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> hfs_bnode_read_u16() and hfs_bnode_read_u8() declare local data buffers
> without initialization, then pass them to hfs_bnode_read().  If
> is_bnode_offset_valid() fails inside hfs_bnode_read(), the function
> returns early without writing to the buffer, leaving it uninitialized.
> The caller then returns the garbage value to its caller.
>=20
> This triggers KMSAN uninit-value reports when a corrupted HFS+ image
> has a node_size of 1, causing rec_off to underflow in hfs_bnode_find()
> and the subsequent hfs_bnode_read_u16() to operate on an invalid offset.
>=20
> Zero-initialize both buffers so that callers get a deterministic zero
> value when the underlying read fails.
>=20
> Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D217eb327242d08197efb
> Tested-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfs/bnode.c     | 4 ++--
>  fs/hfsplus/bnode.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index c00645a4a5733..08307faea7a68 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -97,7 +97,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, =
u32 off, u32 len)
> =20
>  u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
>  {
> -	__be16 data;
> +	__be16 data =3D 0;
>  	// optimize later...
>  	hfs_bnode_read(node, &data, off, 2);
>  	return be16_to_cpu(data);
> @@ -105,7 +105,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 of=
f)
> =20
>  u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
>  {
> -	u8 data;
> +	u8 data =3D 0;
>  	// optimize later...
>  	hfs_bnode_read(node, &data, off, 1);
>  	return data;
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index f8b5a8ae58ff5..35790085b5b2e 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -55,7 +55,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, =
u32 off, u32 len)
> =20
>  u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
>  {
> -	__be16 data;
> +	__be16 data =3D 0;
>  	/* TODO: optimize later... */
>  	hfs_bnode_read(node, &data, off, 2);
>  	return be16_to_cpu(data);
> @@ -63,7 +63,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
> =20
>  u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
>  {
> -	u8 data;
> +	u8 data =3D 0;
>  	/* TODO: optimize later... */
>  	hfs_bnode_read(node, &data, off, 1);
>  	return data;

If I remember correctly, I already shared that hfs_bnode_read() is called i=
n
multiple places. So, this patch is not enough for complete fix of the issue=
.

Thanks,
Slava.

