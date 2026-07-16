Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB67348C4B
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784231983; cv=none; b=gunn4xgwrYYjPlWyKx9+rsYE+8oEOkm9Se1HztfdAFvkY4ukmz38rBq4ztOrzFs/F/z4WyTb/ISFiJEr4lHHt0mNHLLPNkoRhpE6Z7eGw9AVtvz6HOh+sukhNK+AGCy/kWJ1MQkrmZiKe9NRRxZdnhf4kSfxRSDKSxemtgcXNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784231983; c=relaxed/simple;
	bh=e+m1SwYMH/CdvTCpbrEWXnH91RGXc1Ver7a0Glf3zXU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Lx40H/0w3BqCxy+6IA6trt8DryRGXMrjtkpC6Hkzf4Bl3LwsAai8DDeEsJKnU3ggnXEmO6pqrcH/ZTo8djlP9Ex6yBh4/T804xxSbc6DQZwVl44owhblETcn0exogRy0byO7SKCtg8P27U+E5evF2pSHU0ojfj7jN2tOu90Zh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=AzfgWFiz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="AzfgWFiz"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso763027a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1784231980; x=1784836780; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oPU/ClEXdqKFs7z+OnL26xahawNai6l8KBwMmW0aWyc=;
        b=AzfgWFizXAS52hoIHf7i5QQb5+LZp0UiDBQjm/MYFs2wJymzxwFG0Z6MAed9hf3g/5
         dU8QAwphVt2VTJZ00RDE3rn4AED/2lliZD/PsPanVMeyEVHswyrsCyOncWZmlDcG5QFa
         yGNmVlENw1jkgVf7SiajF9NYRDAJlfc+pdKaFCWkoLq//ivt/E/0/Px0Q9qdA90lY7NQ
         m3Thxb8uMFqFs7VBPQnUrVXWjtZdyyO/hhyuL3QqHDNft99CYeSGiRBAxix+XRU5U/1C
         tLPBffVbkIogPqKz85ej/yQnGr+T9QNW+A34LNipECLpfOKlA8SRWsg8whdfU10WIAeY
         GVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784231980; x=1784836780;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPU/ClEXdqKFs7z+OnL26xahawNai6l8KBwMmW0aWyc=;
        b=eBEcdS4tfszW/Cnnb6fdLJYSfc+8q0/hj+yKLHz57VSitANrah4QZPHjnN9WcVoTIq
         ke9dfKfejIcXVqlovvTgxRI8xCgipdke4iYLkXZctLYthCGFuE0nRJbbX3LohOa5q/AD
         vuatqsgGe9ooHsCfrCVSuDiDnS2ES/x00z7UjLRtJchWIJcZS/1LaS6wBk9hOjW3XjON
         V3g5BOTcKHOL01DS7IwVPfBTwYfxzJ/NKCk6L3ShhzHiSbZV8xa6DgfCuibLKQHDSY9I
         mcmAlLq01cA73jVBNJ1vO0lmuedkq87o8huDUl5A605I6X1u3U7m0zARMMPqpPzENNUB
         rixg==
X-Forwarded-Encrypted: i=1; AHgh+RpKlAahHhTtsJG72iUJHKoJsEIEpM7VW87pke89JzQVzdxN7EdWY25pxOgA/s1BKrHBr9f67v7/QxEkuiGh@vger.kernel.org
X-Gm-Message-State: AOJu0YzRXZLr0At6Ef5looLRfpsD0KUn+IiR/RLjCmA/DiS7BlPDZnLk
	svDYyNgvJc+CNBXTVddC8vcdudZTA9feddU3DaOmpEjtBq9g74s/3UtjgUgXrZk9Gyc=
X-Gm-Gg: AfdE7cm9MjhhOW8+q6L/3o90MgeF6VOEos1jxhRm669y8Bjo6FVRTemYjrq1E3kdYlj
	5lXVXevbJ1Qng3kvkB4QekGAE54caFFn8XUMzn6GS4VREo4UAh8Ajfbjw3aG6pvrVGRELU34Jmp
	4AeygIdrRdww+BDxYmg/R3kTx1nuy/VYrgAx84AILC3uBaLIP0NBODR5+h4xB5yGka0zjaDFbwc
	M7a7iq++Lt2KYP3CE6W6j/y+f0btVrPwxnzNo2uCBU/5nf7nuEO1yf8tp57ZmdzfsHPQLTXIf8S
	8zqS4iaWLBBg3rXxplX+0Yamz9L7gXZhdO3FtCbPcEzzXiGX1ZxTwTHXGYNcZOQ+q26LTAakJg7
	XDhMWrPbbB71Z6rDoYYhTz3MKUjtSNbp0eGJSRc8i18IMlbJbzotrdRj6WcOIX2cTSvZaf4z6BY
	0EayLD9GEyhhUOIjEWGsjMhpJTz4odv8w=
X-Received: by 2002:a17:90b:39af:b0:37f:9e21:91d6 with SMTP id 98e67ed59e1d1-38e3d1d1815mr3010571a91.13.1784231980511;
        Thu, 16 Jul 2026 12:59:40 -0700 (PDT)
Received: from smtpclient.apple ([2604:3d09:3a84:1700:3854:7eec:417a:89dd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e3cf246c0sm1579706a91.3.2026.07.16.12.59.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jul 2026 12:59:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH] ext4: skip i_extra_isize expansion during inode eviction
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260715175253.2171303-1-koike@igalia.com>
Date: Thu, 16 Jul 2026 13:59:28 -0600
Cc: tytso@mit.edu,
 linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BDA9BA20-2727-4FCF-99E3-AAB52431CDBE@dilger.ca>
References: <20260715175253.2171303-1-koike@igalia.com>
To: Helen Koike <koike@igalia.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Jul 15, 2026, at 11:52, Helen Koike <koike@igalia.com> wrote:
>=20
> __ext4_mark_inode_dirty may be called from the eviction/free path (via
> ext4_truncate =E2=86=92 ext4_ext_truncate =E2=86=92 mark_inode_dirty), =
which may call
> ext4_try_to_expand_extra_isize() that could create a new EA inode,
> wasting work that will be immediately discarded.
>=20
> Skip the expansion when the inode is transitioning to freed.
>=20
> Signed-off-by: Helen Koike <koike@igalia.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca =
<mailto:adilger@dilger.ca>>

> ---
>=20
> Hello,
>=20
> I saw this while investigating the syzbot issue (see the stack trace =
of
> unlink "-> #0"):
>   https://syzkaller.appspot.com/bug?extid=3Dd91a6e2efb07bd3354e9
>=20
> While the reported issue is fixed by:
>  7f473f971382 ("ext4: lockdep: handle i_data_sem subclassing for =
special inodes")
> I believe the call to ext4_try_to_expand_extra_isize() in the eviction
> path doesn't make sense in the first place.
>=20
> I understand this is not a major optimization, so not a high priority,
> but sending it anyway in case anyone finds it useful.
> ---
> fs/ext4/inode.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ce99807c5f5b..cea3405cd841 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6603,7 +6603,8 @@ int __ext4_mark_inode_dirty(handle_t *handle, =
struct inode *inode,
> if (err)
> goto out;
>=20
> -	if (EXT4_I(inode)->i_extra_isize < sbi->s_want_extra_isize)
> +	if (EXT4_I(inode)->i_extra_isize < sbi->s_want_extra_isize &&
> +	     !(inode_state_read_once(inode) & (I_FREEING | =
I_WILL_FREE)))
>  		ext4_try_to_expand_extra_isize(inode, =
sbi->s_want_extra_isize,
>  					       iloc, handle);
>=20
> --=20
> 2.54.0
>=20


Cheers, Andreas





