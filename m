Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2807F3E1D01
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061179; cv=none; b=WQAiC/jI5T61GUrtTXYgPw/YKYJv4Frt/va75WHl23TEOfgxNvIwSUF23hM9wspjAz8NO4KvtmJthyanOC4HRPzb4DI3+DoPhGBJxOiEx9yOvQbrw9k7X82Xb1qPoScFI+uHfKL4RnI7UWD+5RJ8JSDqak8R02GbxcBe2+H+zbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061179; c=relaxed/simple;
	bh=6ZJTWCVexWgcOox0P9HFzxmkJ+aF96Ps9swed70VxHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GjQ1Yg2KBwWgZPpZd0Wnq24m3+iQsFt4ccboFtbUsk7mkPujwXvIP2Q0f+TPS8VGEmNJMQ+ZLPR5cHzWAIOlrA2sjjt3qlFNGwPydLe1UDvWlaXvBNXKNqzk0AQFKES00IuJsrxPr7XimlR8jA1tUxZ1fRqUY9Yus1Z+54Mcr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkUMySmY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sl3+j2gp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkUMySmY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sl3+j2gp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777061171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QscVZOg4w8Rhqqko9LVNMW3RsXPDXzUVqjkIOP9vkUE=;
	b=KkUMySmYBjLqIXi8en2KS2lFy38dN+jr8ciaqVo1EYwJItllss8wz/6co/cGAEVLpt+hnU
	CWZCcGNWEP0cGRLL4kjNNDqIeM3BvXnuSErtCb6Q4AEeAHMFBGGTa5klfHJLZKwNIraB+V
	02Rl849lozA6s3whFuTlO8DYFqsUJIE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-7ooEnehgPZ-57aijcMwE_g-1; Fri, 24 Apr 2026 16:06:08 -0400
X-MC-Unique: 7ooEnehgPZ-57aijcMwE_g-1
X-Mimecast-MFC-AGG-ID: 7ooEnehgPZ-57aijcMwE_g_1777061168
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dbc56f5290so19698690a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777061168; x=1777665968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QscVZOg4w8Rhqqko9LVNMW3RsXPDXzUVqjkIOP9vkUE=;
        b=sl3+j2gpR43DfNDsxLD/SrgLJLqVl8YLyllFnhv7mKKkILjUf8MWvqIoW7GJQr4umR
         N4dnRnLOlSaDgamWJluhmUuqrCvbT0+O7xZa51aO9r2usWBxej1HZ2goSLRDSu4hGFRR
         yWnvKvVbl4kMHbeTMsp3sEAYSNH1SJ+F4JoDR7BWoPtU4CqKoM05m7JheUHJCQudMMFo
         JWHiLWd69nfIZfrpcfypJIB1f975R1yROpNN483EHGYRBtbF1y2PyWaUy6WTyKvmr4LG
         LMYtCtHxcQEqy9YpEtpgfdSuyt30tKhqp9NKi91U+TdeXOJ+xopoE7kkkU3zfp7W0R4x
         wHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777061168; x=1777665968;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QscVZOg4w8Rhqqko9LVNMW3RsXPDXzUVqjkIOP9vkUE=;
        b=OqRI4MuPIF8k3m32UhfGWPeJsyXejrZ7ArWJqCC9XsCS0VAe0FQ/UDYDYIhgVGIduH
         WXYRwGu55zlQWwKTfWMLVPusganEbyIQk63nsBdgxgROrhC86GlkKW+sKja/IVANrxkQ
         ZiLZ7UbUKSVOikn4P/DG6V6EDfPJxi2lGmAhG3AOBrnEWRVddftP3P82ZndV6tHILRqD
         LcFM5/yLaxpzZ0yi8DfSJNWq+m1TxsqEq6Yi45ScuOe3IZdN2Kr+uHqmZMehravr+Xbq
         HkbvSGgbtIZF/95+hj7LPSavegiAW95tQ1ILoH3ezxzCtKiU+ge3Th05vVYtEaGepqQV
         e05A==
X-Gm-Message-State: AOJu0Yw66z/BbDpZtfkRua4+BktZTdj/5ur+rubUO8r3t0A15cZZIuUW
	0+7BGxeHjseYgoQVNDfJPWnuBY9xF9XWrZFqFilM83567Q6gVN5tttWBfyH43539i6lvuN7Kwh8
	FOGId9RryDdwaQDfBCv4Jl3JZH1zscCDdmCiTByuxm0p3vvueKber6+qMtOMVyDlE2bg=
X-Gm-Gg: AeBDievy1vIy5QkktRh3zgOvf/nm2RqnbK7hLcNgzw9zrnOgh3H3vI8wSy0+CpXRWVY
	5rOwdHp5rI27Rsq6N3MFcAz8m7sfw43EuvsuqekV+x+b2iwrTnqpydGVtLOmbVGBHohKxVvJB7Q
	jZSgh6LzDPm8JWAxKJ6WteI42CmQADHEfORPWuoj2WY4PbqilbC8xU1zwYTDIo3Z/iaC9TKUmLj
	WmYlNAeD0UoaxFajSFoFquRTybsFcmeelvDGORMqv1EJZFPZp2HJGHvsSazP6l4ojs/VmObpkFT
	kFmhutsZp/rq2i9oXI8mdYAqX1WLw3fvgq2IdRRrgEnjr+Jd5KcArzEa6QSYFD3vxGgPRKZeR04
	Pkqd55cnVayVCrfA4ne3Nunx7uN5TgAzFxepZtljgvJ0kTSs394KsabdJlrQScHM=
X-Received: by 2002:a05:6830:2b0a:b0:7d7:fd71:f2e4 with SMTP id 46e09a7af769-7dc9518becbmr20412778a34.14.1777061167772;
        Fri, 24 Apr 2026 13:06:07 -0700 (PDT)
X-Received: by 2002:a05:6830:2b0a:b0:7d7:fd71:f2e4 with SMTP id 46e09a7af769-7dc9518becbmr20412758a34.14.1777061167328;
        Fri, 24 Apr 2026 13:06:07 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9759bfa3sm20318100a34.13.2026.04.24.13.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 13:06:06 -0700 (PDT)
Message-ID: <d6c14c73839aa899b4fa40a04e8d650c3c2c49f8.camel@redhat.com>
Subject: Re: [PATCH] hfsplus: fix hfs_bnode_split() failure on
 sparsely-filled nodes
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	janak@mpiric.us, kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com
Date: Fri, 24 Apr 2026 13:06:05 -0700
In-Reply-To: <20260423214936.444718-1-shardul.b@mpiricsoftware.com>
References: <20260423214936.444718-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 03:19 +0530, Shardul Bankar wrote:
> hfs_bnode_split() determines the split point by scanning the node's
> offset table for the first record whose data offset exceeds a threshold
> derived from node_size / 2. When all record data fits within the first
> half of the node, no record offset exceeds the threshold, the loop
> exhausts all records, and the function returns -ENOSPC even though the
> node can be validly split. This causes xattr insertions to fail
> silently.
>=20
> The failing code path is exercised by xfstests generic/070 and
> generic/642 during xattr stress operations.
>=20
> Fix this by re-scanning with a threshold based on the actual data
> midpoint when the position-based scan exhausts. If the re-scan also
> exhausts, fall back to splitting off the last record.
>=20
> Reported-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>  fs/hfsplus/brec.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index e3df89284079..cfc909c808a4 100644
> --- a/fs/hfsplus/brec.c
> +++ b/fs/hfsplus/brec.c
> @@ -282,12 +282,32 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs=
_find_data *fd)
>  		old_rec_off -=3D rec_size;
>  		if (++num_recs < node->num_recs)
>  			continue;
> -		hfs_bnode_put(node);
> -		hfs_bnode_unlink(new_node);
> -		hfs_bnode_put(new_node);
> -		if (next_node)
> -			hfs_bnode_put(next_node);
> -		return ERR_PTR(-ENOSPC);

I don't quite follow why do we completely remove this logic? Potentially, i=
t
could be valid situation. No?

Also, I think we need to add hfs_bnode_unlink(new_node) here [1]. Otherwise=
,
hfs_bnode_put() will be unable to destroy the node.

> +		/*
> +		 * All data fits within the node_size/2 threshold,
> +		 * so re-scan using the actual data midpoint.
> +		 */

First of all, I don't see the answer on question. Why we call this method f=
or
node that is not completely full (or near to be full). If we have half empt=
y
node, then, what's the point to execute node splitting? We have enough spac=
e to
add more items. Do we have the same issue for Catalog File and Extents file=
?

> +		size =3D hfs_bnode_read_u16(node, tree->node_size -
> +			(node->num_recs + 1) * rec_size);

I prefer to executes likewise calculation more carefully. We could have
incorrect tree->node_size, weird node->num_recs value.

Why do we need node->num_recs + 1?

Potentially, we could have overflow here.

> +		size =3D ((int)node_desc_size + size) / 2;

How can we blindly rely on size that we received from hfs_bnode_read_u16()?=
 What
if it was really huge or really small value?

> +		old_rec_off =3D tree->node_size - (2 * rec_size);

Why 2 was hardcoded here? What this value mean? Why do we need to multiple
rec_size on 2?

> +		num_recs =3D 1;
> +		for (;;) {

I slightly dislike infinite loop here. Why do we need to use infinite loop?=
 We
have size or number of items estimation. What the point to use infinite loo=
p? It
is always bad coding style.

> +			data_start =3D hfs_bnode_read_u16(node,
> +							old_rec_off);
> +			if (data_start > size)
> +				break;
> +			old_rec_off -=3D rec_size;
> +			if (++num_recs < node->num_recs)

This is can be used as for loop boundary. Why infinite loop has been used?

> +				continue;
> +			/* last record holds most of the data */
> +			num_recs =3D node->num_recs - 1;
> +			old_rec_off =3D tree->node_size -
> +				(num_recs + 1) * rec_size;

The same concerns related to calculation here.

Thanks,
Slava.

> +			data_start =3D hfs_bnode_read_u16(node,
> +							old_rec_off);
> +			break;
> +		}
> +		break;
>  	}
> =20
>  	if (fd->record + 1 < num_recs) {

[1] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/brec.c#L262

