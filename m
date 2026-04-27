Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A42364EA5
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315226; cv=none; b=A3TpkC+6hShqgqw/rh38THPbv0EozuZKA9rmtRsbESz6FX5SRMEh/Nm7fPe+A36FaDb8oFh8V2w75p7r5P33SATAvWzatYPMi2rIn4KyezSlNR0YS3Y7KrwXmsTsui+8IzWCf09nIQ/YDgfFML6OzHZgENtJDc9/trc52+HnXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315226; c=relaxed/simple;
	bh=1Knkergunfn/Q2UF4oD0saaYtIb9ujPoX9yCvJEDe+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wo3CAg8SQo0K5oiaUf//NHvGsFI1k7V8MX4TJb6Ptg5H8StVQAW8ovCSYUtLFDmxuG8g6auK4Lt8C3sufz59v6UkQmH0Y8a9LhGs8tNvCgi+RLQTtqvQUhmOW2UyRJbLQ6vL2vcbBoi0AUJ/vD41DATz3EoQadZmmclAqkrQEQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+RZX2IK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l7fZNvQz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+RZX2IK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l7fZNvQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777315223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PlvWh0ZxnEKw7Nj4k3LyalqqSH/DjFTuRi+c7QidSo=;
	b=b+RZX2IKAPwXNPXdo6f4mHiIhPhoyJcKTjTLflquz/60EiOU0Gvhg5cKG1BROSpLchzez4
	DixKJe56bCit55gT6XaQCLdNbx+cnDb3qkO3hA4NMiiKwrd38hF5l+ZlbBj+NXl/U5g81/
	tH/kXvJARG7x15s5aWr6jFwRlOOodO8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-jpkIJzSJMYKpp_eM5Xb4Ww-1; Mon, 27 Apr 2026 14:40:22 -0400
X-MC-Unique: jpkIJzSJMYKpp_eM5Xb4Ww-1
X-Mimecast-MFC-AGG-ID: jpkIJzSJMYKpp_eM5Xb4Ww_1777315222
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7a3715e9e69so311457617b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777315222; x=1777920022; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2PlvWh0ZxnEKw7Nj4k3LyalqqSH/DjFTuRi+c7QidSo=;
        b=l7fZNvQzs109rb63+37u/4LV25A4DnJ4k7eSehyv42GRzeXzlvWOzPGJfKn6K/UpYU
         4E59zgS+DwC3nDMcmvCYulECoq+E+iv1hkBlj7XiiSYc1m3aZ5HBUTr8qLig+82CitDx
         NjC0eQIZyDF8OwJWm+Yp6dzIoPJ8VLeCMsuZPBb927IDHsGQiIiZRDDDL9hxANlGn44E
         BcW7uMslMLpI0a3UgIiKfNQALPedVzYu2iYvkDbM2GEThy2gdNu+0y+j50AnBgHIxfAm
         aCy8S+XivkagM0eHxybIhNipw8YYc/vA9/jEvxB3WmU4E3foXfWACOOm9XYm+DIglIzR
         V7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777315222; x=1777920022;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PlvWh0ZxnEKw7Nj4k3LyalqqSH/DjFTuRi+c7QidSo=;
        b=PWv+Rn4yPp8jnSTrlUEM6GB4RIQaKYRJTsL2NEm5rEcl4FEtPBU9tuFg8pq/wL7X6H
         alelccDcmopl6tNBVCbcPMLxtQvZGrLmQhG+faeLsaOxaUkXXk/9Kwix7lJfJnfRW3x6
         C7RJ/XMf8FrKlFwi44rXb78c9maPXAI9DoHVFHva5qmY3y7CdhscMHQWrZ9m03telei6
         D0CgiCpb5ww7M5XDfrQg9fidbmAwRFecs0omVT6P1JhLADmVpCwOakTQvj5qJe7BkZbU
         6XVJOuFCHQw2wRLhRinSO9ihbKG5UKoiPBQFb+1FwvYOGE4MWOXpPFSP2/wrXjlf7k2e
         F09A==
X-Forwarded-Encrypted: i=1; AFNElJ9RWQCTu3FLoNXR+p3vGSgcMKuYkoNpAmmB/xDUY/tKidbeHY4ZDj7ofwq6On8Bl9y3vPkDzHZlnojMLiYA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+rYk2V3JJ2SfPGCzmFOuaNitOA0eLv/cCEOGCMNcvYSD/OJX/
	IzrDG5E5vP6zHRO8CrlSA3ffhZr8ppwy1iqW0tAuuKhFXUUstmVqSdvLpLmx9aQVMI0t5KYB0NU
	4PvqK27Cw+rKQxU4ahETcLsqARh/NlZ++5UPFtuYh/9Wm+GWvNqL/+00KRv0hitD8hbc=
X-Gm-Gg: AeBDieveGr/1UBOxdgQSz58C7DVX5q6uSwhtnIkGqJ9K+GZepP+2iHHwsuIr7kRQG9X
	TipSAntPfDqoYizAeuTNbvHnd/tdX2KTPiO9AJemCPBLJbPPlUvbqkgcAotJHGZWodRoK+UHygS
	ZAeVE1PBvneBQBXl7Qilh87e/FrKoKnP04yVN0Rw/GLChnaNlrCAHBDJnAzobAWaplMgUsT23Bx
	c6LWVtwETLVNsqlHaiuPjoPFlhn5qI/m7ODjc57GuIw00dp7JADZQ5E9aKMY1LV+HQs5247qQlT
	RX5FhL/V7iU1pUOXzjkhSkzJ/whHwwm36qRizf2zCdjGyz4G3gdmRVS5xkPgpIJrpLJZSRTwmO3
	MvfhgtNC209HuSpPlXjZ1GYXkUC1hJcrv7tC5ytjUbWj22ApjAVvZe+96R7roavk=
X-Received: by 2002:a05:690c:e345:b0:796:335a:895 with SMTP id 00721157ae682-7bcee78a7cdmr3360657b3.6.1777315221890;
        Mon, 27 Apr 2026 11:40:21 -0700 (PDT)
X-Received: by 2002:a05:690c:e345:b0:796:335a:895 with SMTP id 00721157ae682-7bcee78a7cdmr3360457b3.6.1777315221450;
        Mon, 27 Apr 2026 11:40:21 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf05e622esm813537b3.17.2026.04.27.11.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 11:40:21 -0700 (PDT)
Message-ID: <f901feb6317d93a7cd55f6ec155340161b36f41e.camel@redhat.com>
Subject: Re: [PATCH] hfs/hfxplus: use kzalloc_flex()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Rosen Penev <rosenp@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, open list
	 <linux-kernel@vger.kernel.org>
Date: Mon, 27 Apr 2026 11:40:19 -0700
In-Reply-To: <20260425014441.441252-1-rosenp@gmail.com>
References: <20260425014441.441252-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 18:44 -0700, Rosen Penev wrote:
> Instead of doing the math manually, use kzalloc_flex() which does it in
> a cleaner way.
>=20
> Also clarifies which is the flexible array member.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  fs/hfs/bnode.c     | 6 ++----
>  fs/hfsplus/bnode.c | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index 13d58c51fc46..b0165de7640d 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -344,7 +344,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hf=
s_btree *tree, u32 cnid)
>  	struct hfs_bnode *node, *node2;
>  	struct address_space *mapping;
>  	struct page *page;
> -	int size, block, i, hash;
> +	int block, i, hash;
>  	loff_t off;
> =20
>  	if (cnid >=3D tree->node_count) {
> @@ -352,9 +352,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hf=
s_btree *tree, u32 cnid)
>  		return NULL;
>  	}
> =20
> -	size =3D sizeof(struct hfs_bnode) + tree->pages_per_bnode *
> -		sizeof(struct page *);
> -	node =3D kzalloc(size, GFP_KERNEL);
> +	node =3D kzalloc_flex(*node, page, tree->pages_per_bnode, GFP_KERNEL);
>  	if (!node)
>  		return NULL;
>  	node->tree =3D tree;
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index f8b5a8ae58ff..a717fa008ddd 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -455,7 +455,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hf=
s_btree *tree, u32 cnid)
>  	struct hfs_bnode *node, *node2;
>  	struct address_space *mapping;
>  	struct page *page;
> -	int size, block, i, hash;
> +	int block, i, hash;
>  	loff_t off;
> =20
>  	if (cnid >=3D tree->node_count) {
> @@ -464,9 +464,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hf=
s_btree *tree, u32 cnid)
>  		return NULL;
>  	}
> =20
> -	size =3D sizeof(struct hfs_bnode) + tree->pages_per_bnode *
> -		sizeof(struct page *);
> -	node =3D kzalloc(size, GFP_KERNEL);
> +	node =3D kzalloc_flex(*node, page, tree->pages_per_bnode);
>  	if (!node)
>  		return NULL;
>  	node->tree =3D tree;

Makes sense.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

