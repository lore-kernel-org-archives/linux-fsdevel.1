Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793005367;
	b=Q01q2FvLHzHEE+2Xabc3m0uULQNo6xYrx22bokWPdgOX5lA0y7wxs7YOcUWgcShO1vO+
	 9+GL1Hlt+np8ggZCALRWcNM2ZNS1DcOwKVJvWb5hdLzVYOptmIowP4qfvDiPka7QlSzXz
	 Jsem8qHzi1HJjy/p5I7vhhQ+XM1m5M5ol20UQP9oni2kSWvX+Z5BcTt93Wvr2MWWTmgga
	 bv3vryzlyJMWOYNIb0kxPKOUsYxiTgpdmK2iedijZAY20t4JDPTG1y6w3RDaAf9qladuG
	 plAn+ftajZd5omUTDjqqjON4AiGdH64hFh0gprzRYqzcZOLL4u7adpqQvX+fFQL4dpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=g4ANt8QiPje/vd+XmOCfwQ8O8188yDlc5I5mBp2AsQY=;
	b=aOPKilvkiodeFdVrGyI+c/an+BIYzR2MeNK6OsUIzcOStNWGj68QRHLeUUKFw5pCVxg3
	 8+a/GjL/46VgI2FUXokGsPA1KEpsftjz6hvsLFl9IWGuNc1ZS6lkK+U4XBDgR8CCE+IP6
	 q4pIGBc6rrj/yhi5JEdLnHLouVZoN8r66E59VwnCAJ8SsgtCwqJpPwE8QjCC0Go7UNwk8
	 khMMqWpOESamAKmNbUQlSk2E4mEyX1+ynesKAJxjBZos59tOLYXK0b0NMAC/Nx9atxhRR
	 /7GfEDtUFk3NG2+85WTEj7N2d972ozSKOPD9XeCekOEQJJnLcPhpgvlgZCMvtnY+T0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qLZsAbGj;
	arc=fail smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C59606A31D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 09:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90C59606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qLZsAbGj
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so2888325a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 02:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793005365; cv=none;
        d=google.com; s=arc-20260327;
        b=HQsKtomuEitTLd8tdWt+/nt/83DdaiIjby6BGevL4JT8s0gv+F+4rZbBPhvKgVAPJZ
         gFSUsyDvt43ydHcNePLNpoCrJxS8N1maEET6mrWHNGLp9J+nm9aR1qWkGcyM15h59/xh
         7ciO+5t0ERfenzQI6SxxPtg6x8sKTj+sSqfxPkPCnpb6ipZa5pS9OVoTmlI0TC6Iu0zc
         pyJOkExWpJX0X8hc94breFlYEvyKPDifDQBxii/N4DQruD6yGlknW7fQnIw3srqLjuB7
         0MRVS9ZUVbYCy2Xpnap74DTSMeMG+5Zv9AFhsuOUaaSzx9z8q3eKw45hu/G2sEZv9s+o
         kNKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g4ANt8QiPje/vd+XmOCfwQ8O8188yDlc5I5mBp2AsQY=;
        fh=PAilnqcIpWI8Qlww5ueWWwlVeXXN8phguuQMW7BD7+M=;
        b=IjhXahEvC3f/7V2Ln0aWeCwoCnrW1FsS4GKDhm4MCD5F4JZePGCr2YvxE5r4k1PqoT
         OVkZ3iHHhzAXdWBdxfwx4ck/TTls0BUWCCEtUkJVBW3I38NFZKvhnC1zSE/0agfWvJRx
         HK9nEo/QUT3NQcylenwnGy20zqj58L4Xd2ZkU+jdfyzI9MRkXZ4ObSL+3lVU+NN34Xdl
         4VNkkiIpMpxgZz3AAmf+ZVwaK5RjKUhYxgcL7JpNbCRv2318X/p2hfxEFk6PbugocWqY
         Yghb5A89CWXOvCd09qRDX47qPPkCftnXvRBXmnkA9QVof+XPQQLQikczE35RUbyWql8X
         Ovwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793005365; x=1793610165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g4ANt8QiPje/vd+XmOCfwQ8O8188yDlc5I5mBp2AsQY=;
        b=qLZsAbGjyhOdJYoX4EsSnYS4ZxHYKYOA5sWs+jPhLE8FVmdXf2M5MlK6AoPKeVw0EC
         IFKRqq3vpCOpcybm9W8p1utbSK78D+GC7CKCDRA7EzPslPZda9G4Hx+aUNowG5n9m5HH
         Q7zI0oz7lBoS+j8xPojdDeBhv5h4sNXUM2hnlQVTcSFrGFS9L4vZscL1pUk5xM4TGx+Q
         IshB5L7JTrlqlJsEkQ3vmOcc3EmCW2eFVJwkM9CUTM7ldURZC0zw8XuiLgqPiRLSt9P2
         GxnWMgavOQuFtwmggQY/pXnr3BrFQ+IyKQZf1tTCSMvUOPrN/ZKbUxJ70XDEAIaa+era
         wW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793005365; x=1793610165;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g4ANt8QiPje/vd+XmOCfwQ8O8188yDlc5I5mBp2AsQY=;
        b=Qt6YVU37DewQhWR3cCSL0jn7Emeov5zEcHYIin9/1KKsEp36l1VHginLyFMQQkDgvK
         5CesjuUW7Db9w5/3azWgBV9ArfVJ9XEYDt/wHsgtXqcJgRLpNik+RXDS6pBPFPz3jD44
         XKuvXlzCxdUrDb8+4T+hd9Dtt7phSm8Wr3QGDsQcx3jmfg8VqLJCk8erBqH1Aym2Y65J
         dJTidU9V8uI10ectiRBC/C6NcYWbgtfW8zbujRLKbx/Iury+lLTnwPU4Vi1UYQyCREuZ
         PFwzBeZVDV2dXCV53yQgu56DC/DIsQ8KKnq3iyr5pUtZUGlk5fSi6bqkqezFGi7xMtLN
         XceA==
X-Forwarded-Encrypted: i=1; AKwUvBxZABffuk9ZzsF4b6OAGDD5mmW7VjGSX9EMo2zTQfyfV3HIeI22AQt6VoD+hlixpz2Pt0rUYDw5fDHxPOC5@vger.kernel.org
X-Gm-Message-State: AFq9FYLtUIOrD+XueS6yyDwOCrwVIbPEKF21LnlpKJb9HwFXOtga7tae
	XlgNblm9RWp33Pgh+OI+cE9SAuLGCxtzLjR/n4pQmiCnSm2+z75jQr13FcfYKEp5ApGJmbWDYk3
	KFYZmCoEITYiiUohWiewFbOEHizPFbsY=
X-Gm-Gg: AYBFou1Zgz8bMxlBFWuh4A/Jgquf1Gr6agRbiKj/1WNrGA1ugpv0PqQmU72yMBDmbGV
	kwbwloylDtt0NS7ZkmEBcnBU04ZcwNaFVZ/GJId+7vp9fXrWNzcZ1nY5LMmheXj/qkgkhsHcM2U
	EiF3NM7Jtcsh7GrYbpvEAN4bHiE9Opx2v+ddjVCOI4fBJYiULNtQ4xP4bdzgQEPBCzBa6jD0GZZ
	Rk/6/csuKxuIbqY9HgdhD0tzb5ceVwiaPyOcTE89iOg9Az11fIl7AXPy0PG7DTYhsFI8X+g2sR2
	tZEEOBkNid5ct0uj+kHodcZkLt6vuNRNm0Hdb3pQXCfeKPVFoVwnuaDsoImgWmSeIFMrqVVl52S
	/tEf+JiD/Zsx3byZv2JZngpN8R9rqMSdJP82QECd8lCv51lgtR1RKagk10BU4LGEAJRD8Cg==
X-Received: by 2002:a05:6402:4410:b0:6b4:203:a182 with SMTP id
 4fb4d7f45d1cf-6b442a89b98mr8306001a12.3.1793005363531; Mon, 26 Oct 2026
 02:02:43 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026015738.46230-1-dennylin0707@gmail.com>
In-Reply-To: <20261026015738.46230-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 26 Oct 2026 11:02:31 +0200
X-Gm-Features: AclHuK8o2w3ue0fEsBYRmit5mrje2LPX_3oSwwLStLIHIXFr91Z3Gm5NRG4zIpo
Message-ID: <CAOQ4uxhxwOw4LNi6NV1FZzSePHZ4_SEg5QikvoH-L7GcKrkoPw@mail.gmail.com>
Subject: Re: [PATCH] fs: skip copy_file_range write limits when there is no data
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	djwong@kernel.org, dchinner@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:58=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> generic_copy_file_checks() reduces count to zero for a source offset at
> or beyond EOF, but still checks the destination write limits. If pos_out
> is at RLIMIT_FSIZE, this sends SIGXFSZ and returns -EFBIG even though
> there is no data to write.
>
> For example, GNU cat copying a 1024-byte regular file to another regular
> file with RLIMIT_FSIZE=3D1024 copies all bytes and is then killed by its
> next copy_file_range() call at EOF. A zero-length request can fail in
> the same way.
>
> Check write limits only when count is nonzero, as the ordinary write
> checks already do. Keep the other copy validation in place.
>
> Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Thanks for the fix!

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/read_write.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 4da846a2bf17..c05ad2c42e75 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1531,9 +1531,11 @@ static int generic_copy_file_checks(struct file *f=
ile_in, loff_t pos_in,
>         else
>                 count =3D min(count, size_in - (uint64_t)pos_in);
>
> -       ret =3D generic_write_check_limits(file_out, pos_out, &count);
> -       if (ret)
> -               return ret;
> +       if (count) {
> +               ret =3D generic_write_check_limits(file_out, pos_out, &co=
unt);
> +               if (ret)
> +                       return ret;
> +       }
>
>         /* Don't allow overlapped copying within the same file. */
>         if (inode_in =3D=3D inode_out &&
> --
> 2.43.0
>
