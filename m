Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA0DDCD
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776464336; cv=none; b=K8EGXfKQ2BeTsclxmwCXGuF0DHMsR3mZd/O/aSHS/k44N7mh8w2StbwIbdgUPJVQ4teBCGcp0TYA3SYbhALRD8ZfRpUHmjhT8pCtQzsAC6vDtemSzMPSdmc1FDjqznmn9bzWTUXD72a8Y19cpiKHIWgWNccAddG2Mi460aMmtW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776464336; c=relaxed/simple;
	bh=x2ltSZwWwG16qGDDXnqqZkOPdWpby5TntvRFz/1Hh3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WErBkKCYSlZayN5yjAJjqbsbmbzoIMfNzenPrb8Udwhe7/ulxT8at503UEb0NUgBICWP2vXFQXjs8gwvGikPtdwMQOh+UdLIqAcBYnCOByLs0XtCj3hqT6pSb08pcoSbWx5psz9KS8qGMmR5AMHxA21nHJee4Oz20ZkNveZHj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKyV4Naz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fx2p+Vhc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKyV4Naz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fx2p+Vhc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776464333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2TkwTWh53bAvy7ale2RIwDuDgsVj+kc+55FasuLmjA4=;
	b=LKyV4NazNbTIhp/MDocMYsXH93xxOVag5TPd/tjUqXKdh/7hc7BUahrRG0bHhAQcbbNGmI
	v+w59LBVQL+d4DydASTzEB4Z0RDjm5558SeAh59aNizkfefYuUXJvO8NeJWTqoyMixxuNf
	PDS9XMN3Sqtoef98DK2F9X23yUbzgt0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-SrQuXdgaMgyM5g0J58YJQg-1; Fri, 17 Apr 2026 18:18:52 -0400
X-MC-Unique: SrQuXdgaMgyM5g0J58YJQg-1
X-Mimecast-MFC-AGG-ID: SrQuXdgaMgyM5g0J58YJQg_1776464332
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79e095d7628so29221527b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 15:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776464331; x=1777069131; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2TkwTWh53bAvy7ale2RIwDuDgsVj+kc+55FasuLmjA4=;
        b=fx2p+VhcTXOxX9Qzvvhwzqyg/YI8VHDcuWYQT/FJ0Hk/JNq7QPoW91I2VXYsYJSgQ2
         HS0DbDW0MQd2t1WGmz44WljWS+D1LC1CepWV+VVqiS7K9pAw1lkTE2MGvEvS2+pEYbfW
         x/6fiGx862ePYcaIk8nCAI5Im3r/ng/Oe4n11EWny+j+BNfpJpUCTwy9wnBZ3neEC8Gm
         FixWxaUqaqdYQwHfEddWmSJi6j10ZTfpu6QVm3jdmb4zzXX7X42vVRU4yWgW1QGlXkUX
         gc4fnlYLVhHaorNMnPjGSxRmTJXNxG3TVYm4UY4ougXU2SVp5gc7rMj2XhSLONsNQBPi
         FD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776464331; x=1777069131;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TkwTWh53bAvy7ale2RIwDuDgsVj+kc+55FasuLmjA4=;
        b=KMc2OreiBo4MkH5TW11d6upH3YNHYxW+mI9SjdbkZVWwTObUdrq16YbZIbU9b0Bx+c
         +U1wT3fosfToJ+O9B37mK2Rzv+eXYSEwrnx7NbcOabEv/QXUs9Tf2zB0dJZGuZrfnDEa
         6Ofb1c44u/Ywr04Ziyd6Jt/h4UT0nuV+ZeG+eazMlASmtXWjSDb1bnIVRNWV52vicTRZ
         yUxYw7upP9SrEgziORVIZSPCngaMsLBOA2ecjzLuUxTVzepZ/emoxuC8OvTAE51zieHE
         fQIF3KuKYs/xkQ7K1TzUotmfyoeTST9n2rjC0yff+6IyQF8dHy47yXeWpWUq4FOVeRqB
         6QXg==
X-Gm-Message-State: AOJu0Yy/4ook2r5mhmyjGVY3oR6+uR+J5VPmazyUYII2f5cQbH3x0dYV
	+SRN/rTOUJt+nMiUSEMY7U1Mqrt0nSbWNp8gHMJFiE3Gdwo4FcdXmY6N5sGuQIPFqnh2tve+kMV
	XAotLYP8EWIIeFgDPe18khInejXl7yzxFO8SSFL98zSMDpdeyotY77omDSwL7z5ZbApKtfYpVEk
	A=
X-Gm-Gg: AeBDietG1pC1XSToptH9P3FB7gR9C3OM5vLvpoaXyCKCyq7RTRTjYcqpOUNXwBaP2PK
	0/6yd5IS5ZGxERGNsLdMvbZYnel4GVN6ZUDAOu8zb5qDPkY8Llvaor+r4MGw0WeIDbw+4BdAgwO
	14fDY1v3utV42FgXUAS+5Q8H6BmymZw6kdg/OfA2kkAyl8KxNkNdE5WqJnFHI4wp2xvEQl3TFSL
	A7K2V+WwdtYWnlPqwM0gQmI/LbzwLLhAeb2F++sTxm1md/qeQXiuNbN5Gwx84CbRahe+3MrvLs9
	7xxa5vLTS7Q785y8AXq7Qq2P3mfhUCpnC95oQaXwBR+R6fJjFRWRN4xV5LNCiq0YQBHoaHf5/Pz
	Ct3wgpv79qqh7DpbQNg85jfjMwMtQtSl7T+HTBgp0PZ5kwX923P3NFf9DhKCkYqw=
X-Received: by 2002:a05:690c:60c3:b0:7a2:1f26:3d6a with SMTP id 00721157ae682-7b9ed00a78dmr50596117b3.45.1776464331532;
        Fri, 17 Apr 2026 15:18:51 -0700 (PDT)
X-Received: by 2002:a05:690c:60c3:b0:7a2:1f26:3d6a with SMTP id 00721157ae682-7b9ed00a78dmr50595847b3.45.1776464331001;
        Fri, 17 Apr 2026 15:18:51 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b0463sm13106777b3.35.2026.04.17.15.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 15:18:50 -0700 (PDT)
Message-ID: <c3bf88025e3213b22d2bcc32213e52e2157e1616.camel@redhat.com>
Subject: Re: [PATCH] hfs: return error when bnode already hashed in
 hfs_bnode_create
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com,
 stable@vger.kernel.org,  Tristan Madani <tristan@talencesecurity.com>,
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Date: Fri, 17 Apr 2026 15:18:49 -0700
In-Reply-To: <20260417185920.182595-1-tristan@talencesecurity.com>
References: <20260417185920.182595-1-tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-17 at 18:59 +0000, Tristan Madani wrote:
> hfs_bnode_create() checks if the requested node number is already
> present in the B-tree hash table.  If it is, the function emits a
> WARN_ON(1) and returns the existing node:
>=20
>     if (node) {
>         pr_crit("new node %u already hashed?\n", num);
>         WARN_ON(1);
>         return node;
>     }
>=20
> On crafted HFS images with inconsistent B-tree bitmap data, the
> allocator can repeatedly request creation of node 0 which is
> already hashed, triggering this WARNING reliably on every mkdir.
>=20
> Replace the WARN_ON with an error return.  The node being already
> hashed when creation is requested indicates filesystem corruption
> -- returning ERR_PTR(-EIO) allows the caller to handle this
> gracefully rather than generating a kernel stack trace.
>=20
> Reported-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
> Tested-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da19ca73b21fe8bc69101
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfs/bnode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index e8cd1a31f247..69895ccf81ef 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -517,8 +517,7 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *=
tree, u32 num)
>  	spin_unlock(&tree->hash_lock);
>  	if (node) {
>  		pr_crit("new node %u already hashed?\n", num);
> -		WARN_ON(1);
> -		return node;
> +		return ERR_PTR(-EIO);

We return -EEXISTS in HFS+ because it is the case of node existence [1].

This issue takes place because of node 0 has been set in bitmap as not
available. However, every HFS/HFS+ b-tree must have this node. We already
implemented this check for HFS+. I would like to ask you to port this check=
 for
the case of HFS [2].

Thanks,
Slava.

>  	}
>  	node =3D __hfs_bnode_create(tree, num);
>  	if (!node)

[1]
https://lore.kernel.org/linux-fsdevel/08e7f7ef7da57448945a8d62160d2d7a67df2=
883.camel@ibm.com/
[2]
https://lore.kernel.org/linux-fsdevel/43be87e694ed6fe291990226624559e7f0182=
0d9.camel@dubeyko.com/

