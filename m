Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13933DEE1
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776464931; cv=none; b=hHZGEJuEh1QEmjo5nAsr9xeOjMbOH/U2YWL6XTsZ8OupqO5SFkQLUCzMd6iQSMFip7BYHCoHuw6qFOfGBgRxIHIPsxfcP7pqovj3eD/4E4W5trx/9KW2VJhvCeSBQIen7E9AyjWCvBxnp8dJpeZeLagARvtCAlyki7sSBojS+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776464931; c=relaxed/simple;
	bh=CUSSV5p2YNglH8yPy1E8JDrOG79TDiAp+XCyWPGEBX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pzOxTzaNHgjkmF8VF8c2yqSMRitRcnJkMGAKYlZ82KQUH0xZm1Xr8pCcJZhXB4daDnjC7ArV6V7PEnlKJJlQE0mfxNwmKi1JAEtNlWadTI3hI3CTwAwjvsCsFz7YZ5E2qgWZkGdnERD7cmVk++6qkBxuB2LP2jur6YMCfzDRnN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WpDOKCKX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RldPmhHS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpDOKCKX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RldPmhHS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776464929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPGF7Ew89bjaKVcHHIJ03y3YXUs4N+R29ZKBHaopb5o=;
	b=WpDOKCKXSmAJhnZApx7rQb9Ehn/P6ZSFiMXsRCq1e5wwqxKHHBvlj5e1mF3d2oMNBTo7IM
	lWLRWSK/RYdtbeWZE9EH6WqZZIDPRSmrsAEZSH6DS8K8xHnelirLPAFAoXHSjN0AVb5kL2
	qJul7Gqph6tgcatjFfpnCHnEnmrzh6s=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-izzB_lB2MBqn_Y_AjjShuQ-1; Fri, 17 Apr 2026 18:28:44 -0400
X-MC-Unique: izzB_lB2MBqn_Y_AjjShuQ-1
X-Mimecast-MFC-AGG-ID: izzB_lB2MBqn_Y_AjjShuQ_1776464924
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79ca1772ce3so49413067b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 15:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776464924; x=1777069724; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zPGF7Ew89bjaKVcHHIJ03y3YXUs4N+R29ZKBHaopb5o=;
        b=RldPmhHSi9XdhZexy0uYqXcuBaMCt2+wy66czE9K5rya09/Gz9okmAZ6Nw40C7uHZ4
         fqNceZcjlG67SgpW93YJyGSWY/O0DXlPFpJyePEQhDoqkfRwPAJrulNOFvpgedJw0tHt
         pYZReKQqvgYEMpHmqIZOngul/P950cnOUM8a3rgLkyc36/PeDFIJ81nvBq16WvnB8qru
         PwRk8cA03AhFEYCESwaWreVSFlGkkBC+s5XQgmWpln+jj4uxmWQ23CTaHTem95809O0k
         t0Q9/MxZdXoSmcKEQNB32lqN1T3FOXJ53j5PbDSQOsDSvYBKdv25vhuGaXyesvJqYooS
         dkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776464924; x=1777069724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPGF7Ew89bjaKVcHHIJ03y3YXUs4N+R29ZKBHaopb5o=;
        b=WwWHaW8C5wo/KX1T1x4JVh9xQ294gECCHK5DdW6DrinrhEdI8dN8K7GXwGkZXC/shl
         9/pgF9am3JbDoXVFFFRt6HTi0Zu7hAdStHxcSdQWRJt2RMppKR43R5q8kEFRg1tmLfWy
         CWJHj9tpfvb4amfEq857RksLBdsYfRbFhAQj6iH2QEhYnxaSDbka6V2nVXyBdUJupjKA
         JR/DVWkN0HglR+cR/GxOO7bTUx9PB8eFo22LeNUHjSzw+b4wUbyeswWld0xsmrrFo3zO
         sKujfry3WCNC7ByJWGkoUkZ2bJXlOXWhkasx+4p3REShmDWH6SGO2fzxnqodCbtAsQF6
         oZew==
X-Gm-Message-State: AOJu0Yxfqm7Axp0KIKcTOpL26HxejqSRW59yvRD5tGyJ6w0J+b5yZBQP
	QzwRZSEm1m3+/K8KqMYLAD8Y+5efu2vPUNJmTIBMCYpHvpNeYgy+HLn5P6jN6Fz2dDtW5Mbv9IQ
	WAg/aRFyl0qyY8M6fLE8IiJYt/XS69ZvLGZhi0KC3nZOhntaEcYjWTxBIMJ0vwcBPf10=
X-Gm-Gg: AeBDievZvbsJKpzPQov9DEirUKUZXYlwR6gkwFyXr+PCkMFhL/QFCBqH4nWYimi/CdV
	vF8ZCtpCxrxOkDqyDBtrlaiiF1cP84ljHEBrCo5GDYQ8am//RYUiEtXynav9ANUpkvI9uDsKV0b
	+9GTfmUgo6S0hU2AKL7e+qkDPwbswg2gQJGEcWUZpi2tBn3AYt3w8gOTsvZvwNJaB/uWS5PW8gC
	T6UAWN0DmsLNeAV62gzk5g1ZuOeLcwN+1Z7UFx0/pnv9wE/ppiTQpgkODeoQxPZfdAzemeA5P5a
	V1vZzBUkKiXTbEmBLYVVxo+XYskeNrVFTZQzgiAhuFLjqOgJdZPPFoTzpqhfV8zLn4gutep1Nw0
	Hohbv8YLFafxFcQEJyQ1vNHPGPA6KYL7tUS74GubvFWA1XLQr7qb8BFSFaVJ03F4=
X-Received: by 2002:a05:690e:43c7:b0:653:1b50:4ffd with SMTP id 956f58d0204a3-6531b505654mr1366079d50.26.1776464924233;
        Fri, 17 Apr 2026 15:28:44 -0700 (PDT)
X-Received: by 2002:a05:690e:43c7:b0:653:1b50:4ffd with SMTP id 956f58d0204a3-6531b505654mr1366067d50.26.1776464923830;
        Fri, 17 Apr 2026 15:28:43 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314ea3ee2sm1338811d50.16.2026.04.17.15.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 15:28:43 -0700 (PDT)
Message-ID: <c60b92d963294d97e5e02b52d05d5854edc4bf8b.camel@redhat.com>
Subject: Re: [PATCH] hfsplus: zero-initialize data buffer in
 hfs_bnode_read_u16 and hfs_bnode_read_u8
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com,
 stable@vger.kernel.org,  Tristan Madani <tristan@talencesecurity.com>,
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Date: Fri, 17 Apr 2026 15:28:41 -0700
In-Reply-To: <20260417193913.338982-1-tristan@talencesecurity.com>
References: <20260417193913.338982-1-tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-17 at 19:39 +0000, Tristan Madani wrote:
> hfs_bnode_read_u16() and hfs_bnode_read_u8() declare local data
> variables without initialization, then pass them to hfs_bnode_read().
>=20
> When hfs_bnode_read() returns early due to an invalid offset on a
> corrupted HFS+ image (the is_bnode_offset_valid() check), the data
> buffer is never written and the functions return uninitialized stack
> data.  KMSAN flags this as a use of uninitialized memory.
>=20
> Zero-initialize both data variables so that an early return from
> hfs_bnode_read() produces a deterministic zero value instead of
> stack garbage.
>=20
> Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D217eb327242d08197efb
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfsplus/bnode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 14f4995588ff..4404cd35c192 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -96,7 +96,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, =
int off, int len)
> =20
>  u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
>  {
> -	__be16 data;
> +	__be16 data =3D 0;
>  	/* TODO: optimize later... */
>  	hfs_bnode_read(node, &data, off, 2);
>  	return be16_to_cpu(data);
> @@ -104,7 +104,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, int of=
f)
> =20
>  u8 hfs_bnode_read_u8(struct hfs_bnode *node, int off)
>  {
> -	u8 data;
> +	u8 data =3D 0;
>  	/* TODO: optimize later... */
>  	hfs_bnode_read(node, &data, off, 1);
>  	return data;

Both methods hfs_bnode_read_u16() and hfs_bnode_read_u8() call the
hfs_bnode_read(). And it is widely used method. We need to make initializat=
ion
at all places where hfs_bnode_read() is called. Oppositely, we can initiali=
ze
buffer in hfs_bnode_read() itself.

Thanks,
Slava.

