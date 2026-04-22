Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799233DED5
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884733; cv=none; b=Xi2hbQIZ3fD41pwqolZ2jAMlwDVYwBmQ6tDuiWl3TeSWPB8eDz1Rz3dmGInE8dM9AlLqF62n39/UAaLxmyHwLBTdibP+XMSm1cAohIQAN75Yq+7BwPh5lH7hsLUDESteP+buNbHP9aM5TKHu12M70JWsoUZG/EeFJcWkxtkojJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884733; c=relaxed/simple;
	bh=Tz3hhX5x+6vq9gkHGTZMedq2MVdkGKiJWeelP5fat0c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a6pFf9LJKENXN2196AKFpcCVL2VAv5q7VPknMy2MgIRadpC6QTZ6mXdMrOUOYL7ekd4O0g9ma5tOsRkbIAYrGM44Ium7T0+BrKZK81s4Y//pccQVHJH6dvxwGs364eawS+WT/c2U9r7IcmRr+uF01m+Qcyaz2fKx++fOtPW21UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4P8N4vs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOSd9Eig; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4P8N4vs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOSd9Eig"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776884715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdmwawli/VQb0uXVhY3lVbW18VGZ4FsWwRRf0cqAFUQ=;
	b=H4P8N4vsSxEL1yGbdwe/UTWyyrfI7OYqI+sLIcUqm2hZ32+mn1AJbxJVXJC440r2SgiHJX
	PsymYtBkaru8I5RSLG5Xp/3XhKYx2t52IyIaswGZ07LkUebCqa2zyml9B0yJV7Dt2tR82c
	ERxGKPuilhd/ln1cicq2+m7gTD9VreY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-3FhVIARQOYmsbybeCsoRMw-1; Wed, 22 Apr 2026 15:05:12 -0400
X-MC-Unique: 3FhVIARQOYmsbybeCsoRMw-1
X-Mimecast-MFC-AGG-ID: 3FhVIARQOYmsbybeCsoRMw_1776884712
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-46335278e7bso11648368b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776884712; x=1777489512; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qdmwawli/VQb0uXVhY3lVbW18VGZ4FsWwRRf0cqAFUQ=;
        b=IOSd9EigKPcZ1clLdaXJHrlMLwWAOVmHCz55mDHh8kioJAYYB5OumqGF4K8hkttG+D
         DDu+H7gO0krhwYhWPVdrlAngyqrNAx9A77O4pCv1WIAACD1cjYFwKsqBwUMBoGGUKEkd
         DVGtTgUdy1jTb8pFxwO7Ou3mvn4InAIorDTMBKYmk7RSXqhoX/y1he8Kl6AItIF6COlM
         DswE1iQ7TS70cOsHmMF1SIySR/9v333W/dY62eGmFZQmFe1p2bxDF+G2Zrjr05n5Ervl
         n8bQNZvIMXK8dXgiybtNQWQBRlT5aBiZftjgl915NeeQxlRf/+WkZ2miNDjvC6uKBP+m
         XfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776884712; x=1777489512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdmwawli/VQb0uXVhY3lVbW18VGZ4FsWwRRf0cqAFUQ=;
        b=oywHuNnn3bFl81Q3MKyfamCHS13OgrGSUaTJoci9j/VoQqwe/MBCFyW4/2lU55UwGR
         +OQRxZ7+DYbKHLnJYte3RpaYKaT6CBAyVpu46E0XtnqF8aaeGGiQcSwRfVj8taq5acj/
         BRxrGWMaL51A/VcX3Qo4sgo3g7uiPnFSe2uQ/Z+2lSCLQcnoDgX/1qMf+VDwfI/1Sn9Q
         IGtLCSl24YWLYYAa5qqh78sJW9CxSk7HqdeOenB0DrzhD2+ODpXNueg9mn8DnA62DWCp
         CYdAf7I35puOilWaDlB1QzKx8v4+J2WdS9Erg6kh94EtXPxn31na/WNAQAkhAWYRr8c5
         bAgA==
X-Gm-Message-State: AOJu0Yyd/yCBQiq5Zw/VqPz7VOPJApiXkp1+EwZVwAa6Gv53dIy4sctV
	uVUHtzins+eWn0wEDv7V8im4z1AtJpMGfWhC0c3jPtOU12QfcHB8AwqlbHwOceRWfpcEFgi2NOr
	nN2eaP7/RSwksI7pwuBEaWKDRDdxqcT/4t3KC6wVqkwny1Awu6fx0P9b3juSjqLcQtr4=
X-Gm-Gg: AeBDieuGBi/WOySUng116HDKf4XlHpHDE3NDpgb4gPFLR0yxXoeUQx8SFZu495LR13F
	KsgdM4nQ/7M7NRv8eX3SaFwDSYtrlBnitJ7/B+zYiGsqMmZDiYDQlCvL5UATrfaZO7t7d+CjGrK
	ofGZ7Hr+E6s1pTA8EojmdL2ndKXTftrjJY5RmtCdQ97ZRH13G5XIbNA1FxLdv+xEZ8r56u2i/z+
	2KJv05zrU6FWL7kChFWECPmjgTijiICReP0fgFzQuk3QURolqpnSW0myEa9AiFz1pYYzDRzeBIj
	L9p66Yq8tjAsF4QdeMRVfklZx5xBtPs6AJ9ZqTjs/BqoVPFkyAEhU2lv0Jl6J5O4ibiE1DXrYCC
	yZ5wgdYz2rM4YLUliflPXroKU/wBF7dyMgsEYy05YnESzw9gobbXpjrJ/RE+Rroc=
X-Received: by 2002:a05:6808:158f:b0:479:ec96:f4de with SMTP id 5614622812f47-479ec97413amr4506892b6e.2.1776884712035;
        Wed, 22 Apr 2026 12:05:12 -0700 (PDT)
X-Received: by 2002:a05:6808:158f:b0:479:ec96:f4de with SMTP id 5614622812f47-479ec97413amr4506875b6e.2.1776884711604;
        Wed, 22 Apr 2026 12:05:11 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42c05ca16e2sm7973157fac.15.2026.04.22.12.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:05:11 -0700 (PDT)
Message-ID: <44cc78470b0b550d24bba9d159ebe1e07e2ef9c5.camel@redhat.com>
Subject: Re: [PATCH] hfsplus: zero-initialize buffer in hfs_bnode_read
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org,
 syzbot+217eb327242d08197efb@syzkaller.appspotmail.com,  Tristan Madani
 <tristan@talencesecurity.com>
Date: Wed, 22 Apr 2026 12:05:10 -0700
In-Reply-To: <20260418134003.1719393-1-tristan@talencesecurity.com>
References: <20260418134003.1719393-1-tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-04-18 at 13:40 +0000, Tristan Madani wrote:
> hfs_bnode_read() can return early without initializing the output
> buffer when the offset is invalid or the requested length is
> corrected to zero by check_and_correct_requested_length().  Callers
> such as hfs_bnode_read_u16() pass stack-allocated buffers and use the
> result unconditionally, leading to KMSAN uninit-value reports.
>=20
> Rather than initializing at each individual call site, zero the buffer
> at the start of hfs_bnode_read() before any validation checks.  This
> ensures the buffer is always in a known state regardless of which
> early-return path is taken.
>=20
> Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Tested-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D217eb327242d08197efb
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfsplus/bnode.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
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

The patch looks good. However, I have this point in my mind. Let's imagine =
that
we receive a valid buf pointer but len is 0. It sounds to me that memset()
simply will do nothing. But if buffer has not zero length, then it means th=
at we
have no initialization again. What do you think?

>  	if (!is_bnode_offset_valid(node, off))
>  		return;
> =20

I assume that this is a second version of the patch. You can use this comma=
nd to
add version to the patch: 'git format-patch -v2 -1 HEAD', for example. Fran=
kly
speaking, the patch without version looks slightly confusing for my taste. =
:)

Thanks,
Slava.

