Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF026299
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777640662; cv=pass; b=djxMz08VuPwu0nzYQjEtqcOzP+BPE6g6tf98b4gunTEysKYrjFuS9Fa2UR9dYcp7d2EiJZm6di7vuedltk5XcchaIRd2e0BpblTfS3pEL/23Jc+JNgb5HmLbogL++F3vjQsalLtSAi8vKvh9jH+ORcdqoVVFTYIgYe7MS1yH3CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777640662; c=relaxed/simple;
	bh=ztcImzzBZs43BSpcutRIx5kdbOlGkrn/6z5XPpRwF0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kv7YQeJFtamiMFR00sf4fLJrNVpv9YeCFtiIlGNpS4Otmgsv+9WwoyrXtRRfoyvCXYxLWTl+7X2/te8cUz7RtE9eQj5Jg1K+IO/+aCeDK5++5fOXXNW+4OzKHnR6n4dnHF23+XN4vFrc+gr0017XHrm9XCUhvDTZ9zHtr1h68xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9eMmg/Y; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9eMmg/Y"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso2169142e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 06:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777640659; cv=none;
        d=google.com; s=arc-20240605;
        b=TwyQLKvzzqBhsFZDz+hJejutBzYrfimaEpU7HtHTQMSeqMskGQVkEAL7cPZqttBoE8
         8APKN9RalhW66bTh1hTibkPTcvcEBCczZmndcm+28dAxEWvMZeWVz223AReQYAK+Aink
         1z7agnJEmAV3EuSUwaG6ZH0J4Z1Z9nSQVHKjxaX5dky5qrfON4Cu4MOGfj8fGusxLSpZ
         ga8W8LiInofWpF0IiD4wzeI7clLogc6h+paCMglxBQZgVNOP5esYAqoC0F7C1m7UEksm
         7Dmg4ZM+cc9CkFwYqeaTUYaBNzL4xY17TywZzC41w3LvCo8YWEkuFyO0jrRQk5PLhVPM
         wT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8LYZaU8z7in684eahVL/MOMoclY1o0LOecZOJcyOg2U=;
        fh=ACRG+h9YfeVSPeg2234G9AXV817brjPICXppyOFe2Ig=;
        b=NFJYXu5yiHeFArApU22L4PUl3JDJ0ZZJu5JRHZZGGIKXz4DqcmaLAE/LE2IrmfjjmE
         uz7rmTTLCcFfoOCjQjV80eEEcJ3kbIzt/PMD6AwKBYr5s7ko0tOtKzwHyngBozJijjQt
         YCLfYuNVSomSS/h3tIoHR6/LgAX1R5Lf5SkQkT/jfb63xpC434zHx/QWBmP4vb3qmRJn
         jRND4ZxSRGwVUPRMvg8UhbOGZKLFtI5sJuMe7fetg7YJSFx2RLEHxLeepQTLT6f3l4yk
         rjl79KNPQYUzpsnmu8933vrUKQxIU3nqX3SJkh8OUlkROGtdqp+MtyUJv9CQyK2WLSAN
         hsgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777640659; x=1778245459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LYZaU8z7in684eahVL/MOMoclY1o0LOecZOJcyOg2U=;
        b=k9eMmg/YlCzER95Lsz2ANdPWOMl3bK5MXq+CAi4DSEOYVsOQdpqLKETJpPrAQZKQhg
         eENH9f32A4sBu3SpIsWZA/CnGJjaBEk74xwoKJrje++m66nGAWKISEb2jnACuNHQQynn
         1eCBukJvGDsaNgw9zXKJlQGN9TKsxg2rXQCEgEeANPz8WFsrkKQpAjJf6qfLULtJTECR
         fJHz1Pgtc3Ew04dE+Tc/hBqtIplHcgzlG5FAGESK/W+UXys/UV8S5dnx8j47pikoPPUC
         btLBAC2rDn3Bk+8ocKuMw7LF3pit/bN9+CZDx0ovMfNQs51ijvrHtuM/BPY4YSKTLCm3
         Htfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777640659; x=1778245459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LYZaU8z7in684eahVL/MOMoclY1o0LOecZOJcyOg2U=;
        b=deS9JFqMXNSWYJKjh0TwSBV16b31fj5sXnLqViV8SxCTu+ycKBBJSePtYPG1DjJpTN
         YPnZlsdLd6AkRDhMcFd/4LbCs9yCkNNmPZ+07UXTygKN2YK5oliOszIcl7pjT6UC1n4b
         2aLGrYEoBVrq0aUP7sVVCZszeZESyiX1htJDsTb1FC3YlfxwX30UBF5W/W7oBNGjcA+U
         ePDw5vWtT1jsSKqbLEc2stR9qDqbon7fVSS/khPCWYPWB6EpCoenwGhC8CNsRnyrzeqZ
         z9KSPpd31wlzR0adi+5V12xQQLcDPIsXx/oF2gZUWaZWSkwezzSmB0FJF7n9aiqaTDHh
         5WOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EbW5SqXpM3/uZVCLl5qkOLjIRieGn35zAkCwCmpzv39MJAdmKBihja2HFQJjpvO1j8ciM+XXTY7LLbvVh@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCGZOz5cBidJluyuXW6KPmpvuEIQHWdRZAUshEjSeiRGgX6u0
	sqKElG7zJ4HHsq5j75y9nD6HWFzGjvGcJXtNneH91BDXzWStQddxcX2wAT9mlG2tHtG+3cAGC1B
	FKwgGqf/EfCKadzKtEyiBBcRsnKm2IcM=
X-Gm-Gg: AeBDievL62q39XO5We722sa1gGS4K09nJFM/y1b1eVd/yFh03yeP0flZ4EI0zb01ssM
	H9xUyX6xb/97vcWzAg52wm4nmI/XitTB5uO+jLPzlu+tKz7JRtMB0uy7ZFuSqV6jAJa4TySEzGN
	ws/iRH8d9cAw3quo0bUQo4Vd7syws7kDpexsPsowKQR9F1pu5KJnqtoLPEQb0Ksd0RYk5qcQBWk
	fisMp1fVhhcpc3d/Oz09/xELlRgJ5qtL4paFp409dAEzPqdJvMH0lmiCFZ/66nS80SWguhP0ubh
	D2BCge8++OiOxk359ko=
X-Received: by 2002:a05:6512:b8b:b0:5a8:5699:6d3e with SMTP id
 2adb3069b0e04-5a85ae89c27mr949609e87.14.1777640658827; Fri, 01 May 2026
 06:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430115447.2604683-1-charsyam@gmail.com>
In-Reply-To: <20260430115447.2604683-1-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 1 May 2026 22:04:06 +0900
X-Gm-Features: AVHnY4JVBzEzZJBN43jH8DU7aOTUMWQ_4blNBePXJDuOnMe465o-9ZowOYugS4E
Message-ID: <CANFS6bZXre76ZT4gn_hrFDLzJZTt95N2Qn_TK0aEBp51HLAmdw@mail.gmail.com>
Subject: Re: [PATCH] ntfs: use base mft_no when looking up base inode for
 extent record
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 4=EC=9B=94 30=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 8:54, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> When the mft record is an extent record, ntfs_may_write_mft_record()
> looks up its base inode in the icache. The hash key passed to
> find_inode_nowait() must be the base inode's mft number (na.mft_no,
> set just above to MREF_LE(m->base_mft_record)), but the code passes
> @mft_no, the extent record's own number.
>
> find_inode_nowait() uses its second argument as the hashval, so the
> lookup lands in the wrong bucket and almost always returns NULL.
> ntfs_may_write_mft_record() then returns false and the writeback
> path (ntfs_write_mft_block()) skips that extent record, leaving the
> on-disk copy permanently out of sync with the in-memory one.
>
> The original ilookup5_nowait() call this conversion replaced used
> na.mft_no.  Restore that.
>
> Fixes: 115380f9a2f9 ("ntfs: update mft operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>


> ---
>  fs/ntfs/mft.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index 7d989267a82b..ef423303565d 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -833,7 +833,7 @@ static bool ntfs_may_write_mft_record(struct ntfs_vol=
ume *vol, const u64 mft_no,
>                 vi =3D igrab(mft_vi);
>                 WARN_ON(vi !=3D mft_vi);
>         } else {
> -               vi =3D find_inode_nowait(sb, mft_no, ntfs_test_inode_wb, =
&na);
> +               vi =3D find_inode_nowait(sb, na.mft_no, ntfs_test_inode_w=
b, &na);
>                 if (na.state =3D=3D NI_BeingDeleted || na.state =3D=3D NI=
_BeingCreated)
>                         return false;
>         }
> --
> 2.43.0
>


--
Thanks,
Hyunchul
