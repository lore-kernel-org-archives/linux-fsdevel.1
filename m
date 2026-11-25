Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611200;
	b=YI7uKZ3S1ahnTskmN5GzUzR5hUb2qlV4QswlB8xlvr4nlfVvFmwqaKhYlxXJNLj+PBra
	 A0JT8FVgYQKUisCQdzRFNn7vgO3nsd58wjcZDWlXN+CFPrBwM2S/8yV/Si/Sfxad2ltFe
	 Smm1S7/RsdvaaofWTw4BzRxNi61pX+oaEFelNrSfWiq6EAyfTQ41BH2aNJFmJ28QCFyiz
	 AAhpavzvZ7pGHRVaWutPlt6qViWVnfoxCZA1ER8z2hZXvVODigD7Oc7wZlApo914qDjQS
	 X2MDKBXlbOgZyGdnR0m5wXbrTRSAQBBlng/5I2AX8Goq6BoHRLFlEoJBXXYxbFa3jmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
	b=ld2EJapQ7SP0eAYN54DOoqTZTxv2shXIX/CVFB+Rt0X1vam+WWf/oC/j96BJPv6tmrfp
	 RMWLTQYmzi5NqhS6Q3ihho71c4nDmDBtlr+5iDlsLPwFSAPBXcjL5ceLrQhK2a7YPW+GK
	 LKOb2lwIa6HJTYmPK8WAEwk400N8k7jHEZgQz6bWy1jgB5jtntNkvs7xOY993GZh5IsQE
	 omKUBmkEQlBYzkIwq8PXwXvyx+XwpAwHfa7e+9tML9Gwl3YY10z2jhTBdhTXySsGbaGP6
	 4zdwp4J0Vhl3RjwhufLAsfQSN8XKbKl7ct22132Xl88f4CsJf07G5MBfVNq7PwmZALg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QOXEZ5Pu;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4834F606A68D
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 12:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4834F606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QOXEZ5Pu
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so49500245e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 04:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795611197; x=1796215997; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
        b=QOXEZ5Pu/EPca6q7kzgJRCmLrmsoVFR/ZRe4q5d58yeOdbJoHTuz9y0u/Nmk0CktwI
         CoxL971qgH9IAeYEJL9OV04KK9hoZrCZxCXphCDmaMaCEIiYAFkXm9z/Jipc+urQTX/j
         Fk8I31Tuids+3mCeGda6Q/7DCnEHSLo9OC+CFzZ1uqDLrPjUm6OialCUSj83o9zL6oVG
         iksZBRXktSiMRqpVyhlcQqbeKVyrA1zYnXNdKX3aSHnLNR56AH4l3EmMwrecUL/g6kYv
         65m48YXn1HMJU4OXkynxAivRZrQT+c7z3fBFxX7gT5o5ijKHn00slucTC0ZtqVCasBEY
         yyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611197; x=1796215997;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
        b=bK11T4Zgi5Hj+uKRwSUy5lwGLYUhDdT2tJsOzGUZllmnbslB7CdlInoW1HUugtoDU6
         xpj9A5xi6SyxfUvA6TYIjLN8GJsHT0y4/2xrpc89up9aeL7vTtnD9Hj23oLqVMFAg+2V
         3uicumrNZMzSNgFrlfDXRzYKOGm9lSuBE5sV/8Xk6RRvax/vlZ7238AI22SdWnusvKj0
         /qNPDu6+s03VlDZa0TN4+s/SNLX90i8Dj3gd0HQCoZQbZRk3bONHarMIPzRVTid6b9c4
         aAem5yXcCehg5Lj4ZvA45wwEyQhIImXMZK7pdjM9h8QkGE8NtZTfGHT0wchayIdGKMaY
         M+gg==
X-Forwarded-Encrypted: i=1; AL+hErHiqYpuRmydhge7IjGChRVjDJp6DMR0BWzug6lqIvZLMmftLbWAVpNqjFP9+2aWYRMczYrpPIhREC9Y0KOp@vger.kernel.org
X-Gm-Message-State: APuU4Z/+zq3JQMtj+lFg23zd9nKPI37noM1KNc2TKHkStO+C1wBggZfV
	wW/cLt567i1LgVFjO9JjE2jK615CNfa5+EWhFOwG5mdSTPhrUbTF6t3HDLCxqe7alLKv
X-Gm-Gg: AZFdTZdovGyoP9gXvFkrs3Rr917IrVIrXAaYD18Te0JcAHT+OGiKcFuMx8v4hvBtAnS
	vKe7N25qMzGzzVMUj/X3koDTrXTimoDbN5oBHAOwHba0APtXWA/Q993l6TIMhhipfhJUAF/2bSf
	lpDPvLmvCLj6jdzHOXRVXh5vHryfpMZI3MCLtzqAtKFE2MJKRzHm3W5fhKdjiHwB8UGbzsQY7Jb
	nE3rPI69R8cgO7xSBlnRjpOk3z7JpnFmvhNeXBihDpJCJwHSsSAowIFwdih/O6R2/g+H5U1AVbx
	R8FefLh+eE53WvWf7g7fkh1U+s9RdGq47YkffXNXBmimybE3htiZW58fXYAeLiw5fJ6w3dgUWpP
	yxg+593Dnv1hNkHxT689P4yQs6JaiVQqDjo/aDpn3LcDS3O69EJTRVJ4LBRp6ufvwBgZIbtgUN5
	AygAO/+FIm4MH9DBJP6yRrcuOT7omHKkbThMiycV6id7/NI2huLHEddEfEuudiNc9LPIpur9YTG
	sdfLa4zIwsdsnbRSa+2Ywp/b4LZNfG7FUTOm3m9+QqtAy5V/EVFWeZ1WlaczjaOFbaqWX/WR1XJ
	lDUIQPMQsYDmM7cNQNSCg2F7VTd3vnUlq7G+LpnULYUaLA9MSlbpF/3U6BSEC3B/f+yBvUDEJRc
	fQtWQnZlwHXCJfKcEuiy1Wcn4sXgia0bqBgLcd/xQCBd5+c7rzg15JSVbpeupveyElcDGjKbkey
	c=
X-Received: by 2002:a05:600c:b8a:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4bb88818156mr356853675e9.16.1795611196651;
        Wed, 25 Nov 2026 04:53:16 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm736573735e9.13.2026.11.25.04.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:53:16 -0800 (PST)
Message-ID: <45510e886330ade6013838f94cd84c688b263aa8.camel@amutable.com>
Subject: Re: [PATCH v2 08/13] ipe: handle errors from resolving the real
 inode
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, Fan Wu	 <wufan@kernel.org>
Date: Wed, 25 Nov 2026 13:53:15 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-8-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-8-90564c4ae347@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-16 at 10:44 +0100, Christian Brauner wrote:
> d_real() is about to be able to fail for D_REAL_DATA. So switch
> ipe_build_eval_ctx() from d_real_inode() to d_real_data_inode() and
> deal
> with the error.
>=20
> Currently, if overlayfs fails to resolve the data of a file it hands
> back the overlayfs inode and IPE evaluates the policy against that.
> The
> overlayfs inode has neither a block device nor any fs-verity state so
> none of the properties of the file hosting the data are visible.
>=20
> Instead, leave the block device and inode state of the evaluation
> context unset if the data can't be resolved so the file is evaluated
> without any dm-verity or fs-verity state. IOW, IPE reaches the same
> verdict as today but without looking at the overlayfs inode.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Suggested-by: Fan Wu <wufan@kernel.org>
> Link:
> https://lore.kernel.org/all/4e9a39ac-9ad5-49d8-b0c4-09e665504609@kernel.o=
rg
> Acked-by: Fan Wu <wufan@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0security/ipe/eval.c | 13 ++++++++++---
> =C2=A01 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> index 4a7be96c84f03..a2366eb9a47b3 100644
> --- a/security/ipe/eval.c
> +++ b/security/ipe/eval.c
> @@ -102,9 +102,16 @@ void ipe_build_eval_ctx(struct ipe_eval_ctx
> *ctx,
> =C2=A0
> =C2=A0	if (file) {
> =C2=A0		build_ipe_sb_ctx(ctx, file);
> -		ino =3D d_real_inode(file->f_path.dentry);
> -		build_ipe_bdev_ctx(ctx, ino);
> -		build_ipe_inode_ctx(ctx, ino);
> +		/*
> +		 * If the real data inode cannot be resolved, leave
> the bdev
> +		 * and inode fields unset so the file is evaluated
> without
> +		 * dm-verity/fs-verity state.
> +		 */
> +		ino =3D d_real_data_inode(file->f_path.dentry);
> +		if (!IS_ERR(ino)) {
> +			build_ipe_bdev_ctx(ctx, ino);
> +			build_ipe_inode_ctx(ctx, ino);
> +		}
> =C2=A0	}
> =C2=A0}
> =C2=A0
