Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55635372EC0
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843940; cv=pass; b=erDACaV7wIHFomni9JJe2CZmZF+GWhcgZQEtd/zojKKtQvj9xrLUqRj8Uvo5oBuuJ6fVXYuYyww6Nkv2ISO0ebxV4pt8Dif+qXOTpApe0d4uehf9rjBtlGumcNCLC/+Edfona4P8k4Pm8sdcW/kVIfN03DzpiMGydAM/GDjZQX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843940; c=relaxed/simple;
	bh=ZAAxhN8SKNjKA3Up6YyHYbskKLZJ/46kGXKUZ+PsJGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnqa3VWFK62UyOB2FIDp0LUCZ902iOH3dfMn9i0pOmpVRSV1vArDzBX7yHsH4PRhnlFXQiuo7D3OVnzH7aYJ2/JfFIc6VGCCbxHwrreGuKY0wXw2V6BC/J/8ScfQ1e4q5aHLq7BWq1rL2n0E7GSVUlfJ67sod2bnuBqIrF3xy8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga1v68Ct; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga1v68Ct"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so4961134e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 00:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776843936; cv=none;
        d=google.com; s=arc-20240605;
        b=ZGCedzcMNWkTFGBCjZeSzjgyfXM6JP8Ez20wRvyiI+VLFSWUK0OW+WgZz8UniLXFr0
         QWzXs30+4A59jJz/8P952IfJpeYDb3gpYo2iRCbxlYC41Cd0iK8tfPGBPxp2Ww22Rt55
         ttdTFE4PbWWUcQoyvJ87jHlq2Euhdc3clTUAXGguVEkAKw3NdjSbUIxoI+b+E3+S/M0l
         Ub+2wbiV2NhyFQZXhqgzKeUy2Zac46qElG0757JcFfpaoo75aNVybb6ZZmJX+tI2TCZr
         3kH2NEkTNAFfSP2Yh2Z2AiW95nf31g3F+PBKaSNJMZYGH8hWXwa7/J4Cnnk0WTPnjoc3
         uxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BVPcvxthxBvBAubnIyiJIG2jV89teRldW0ikd9cKYwA=;
        fh=yGslsiDY4NdeJLKk027fJJMnNkmmN3xNj/+tL/Jc8wc=;
        b=QLaatjtQUNM3ze+hpzHCwB2PCHC+lrfy9hkbKnVHKVoh5X1d3V7DzrESb1AfLYl/zS
         vtDZsiLM3N2NgwjzvmUgvbUVDMtBzc0C8TYr2EViJZ5oOa/1tWolL8opltpwux1T9sx7
         IN4Cj1DqduwwthyyxkMAOx5+l4CJbgx7H9n8o/hNYMlFrgMv5F0evukUt0DKOXEqIVwW
         sJKmspb3Oxya3arOXqHcWeUKEPLmZU676X/jdWeVzn81ksMFeFI13YEvUwUUx8Nlq9yx
         IgvGHSa+aX93uhVcABUt9kepiA//NlsYkEgjQBeCii3f34THG/XREeVQizEaIoL5z5BZ
         1ndg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776843936; x=1777448736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVPcvxthxBvBAubnIyiJIG2jV89teRldW0ikd9cKYwA=;
        b=ga1v68CtOvVy66oh4kSc36GNkmPnfnq6O1GEDeP/5+9gIn2H+aicO+KeBfc72nvidE
         EFR2iyrFfB3ittnL1i707cZnG+nGQK4n/RqA1d4cddRSuv9uwmZ/q5L8MjSB6w1n/jio
         HhU865g+EJX7FMFNPrYfwCVsXpv5CU8fHQVUxptVGgKx+l/zxiizPsG2bU04kJTH3w/v
         9WmMguQw3p+gEscLOkc5s0/oAw9N2f5VxoDMuI083h1C0RvKK3y+7q/8Q+D1+Zu0VCX2
         DzUjA/i3Mvdms8o0w8mBOn9lpMpnWLnDgxORLKB/yPm6VsKRKdZs1KHITMAD5fG0qpRQ
         plZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776843936; x=1777448736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVPcvxthxBvBAubnIyiJIG2jV89teRldW0ikd9cKYwA=;
        b=VnTvNFr3RkTAxMp1pxPWDXaCYjFU+g+T9MJNkuz4iHteA56nd60tITGSYJ4zBkBxIS
         EGuO4tNH0Xa16X6is6cUXimepbBko9Lt4C4UQi0Y5o1LzURZ6s6b/LQbFLtKgb/naqK2
         YPxvE4Wn38vI31aN6V1a3Fvx7XvPQdPPeWHp60o61mje1NWqnhltF4WC8VKuFAZ7/nX4
         X/67M3NG7wB6gQV8xJ90d5uGy6U2WXacTAuB9l3hvrvNzzmKQwIhyawk5ws2W0BfwfwB
         XP7ozNTTFNJt9UkbSriBTMOH1AM3hm4DXEohRCxqlasdNgZrI4ACNbbEUsYFN2mK4fho
         R9Ng==
X-Forwarded-Encrypted: i=1; AFNElJ9sj6BdeL9D36iBBfJ4rKxPdAEaa2oUSplyCgWsvO5Mju+eneDjId7kZjWbVNcNms9/Pnjwoz+MZ38BZY+y@vger.kernel.org
X-Gm-Message-State: AOJu0Ywta/hwNXuBEMapZ97ZOh4UFzsS/ujosVuRj0RXq0qFrRQU8NZw
	u7jG6H7QnnbjACwVjovINsL2albE1GJS1SeFTDEZO+s5d0saVIga6pXeYJ1MsE83OvhF3Lr18K7
	G7L5CMqNJFXEiaY5nmIoNhNZVlyjYg4A=
X-Gm-Gg: AeBDietI9RjkLhB+/OgmchrNXeXj3BpaS//9C02xPHHt1YiR0a47HtJklrrB0H93QZA
	M7YKc9r5i6taw7ToP0z8S4qlggTXxECCsmS1pml/5KRFaixS92aHJe2SdUlxzga/kfSnKDOhKqJ
	pdNAd9BdndWgZOWBEifsROl/Otn6apVFHXnBATEhhAbYNbejTE0MMZcXTBP43iWCssiF64/1xai
	znNZ5DW7jUzi8q1yFHhxQxjIK05Sw9ynwfNYGiDFEuQGfnt1wv7zdPH0Gw3FCsZW/cRTq9eAZMo
	tNbg0+sKnmrxBdHNeoa6y46RX+C3
X-Received: by 2002:a05:6512:1086:b0:5a1:1b06:7e81 with SMTP id
 2adb3069b0e04-5a4172eac71mr6549450e87.42.1776843935222; Wed, 22 Apr 2026
 00:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422030543.125743-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260422030543.125743-1-zhanxusheng@xiaomi.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Wed, 22 Apr 2026 16:45:23 +0900
X-Gm-Features: AQROBzA9uud6i02KQjrblJbQnrOxy7-FdhIl0HlLi08M8YZ_StAC_-z9HLdDHzI
Message-ID: <CANFS6bY5KfZ34dAw8StDnXkrr59r883ETB2enZr++Ny++B6H=g@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix s64 overflow in ntfs_mapping_pairs_decompress()
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Zhan,

2026=EB=85=84 4=EC=9B=94 22=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 12:08, =
Zhan Xusheng <zhanxusheng1024@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> In ntfs_mapping_pairs_decompress(), deltaxcn is decoded from the
> on-disk mapping pairs array and negative values are rejected, but
> large positive values up to S64_MAX pass through unchecked.  The
> subsequent `vcn +=3D deltaxcn` can then wrap the s64 accumulator to a
> negative value, breaking the monotonically-increasing VCN invariant
> that ntfs_rl_vcn_to_lcn() and related helpers rely on.
>
> A crafted NTFS image with a single 8-byte run-length of S64_MAX
> triggers this when lowest_vcn > 0, leading to incorrect LCN lookups
> and potential reads/writes to wrong disk sectors.
>
> Add an overflow check before the addition and treat the on-disk data
> as corrupt (-EIO) when the result would exceed S64_MAX.
>
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>  fs/ntfs/runlist.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
> index b213b4976d2b..a32affb57d29 100644
> --- a/fs/ntfs/runlist.c
> +++ b/fs/ntfs/runlist.c
> @@ -823,7 +823,16 @@ struct runlist_element *ntfs_mapping_pairs_decompres=
s(const struct ntfs_volume *
>                  * element.
>                  */
>                 rl[rlpos].length =3D deltaxcn;
> -               /* Increment the current vcn by the current run length. *=
/
> +               /*
> +                * Increment the current vcn by the current run length.
> +                * Both are non-negative here; guard against s64 overflow
> +                * from a crafted mapping pairs array to preserve the
> +                * monotonically-increasing vcn invariant.
> +                */
> +               if (unlikely(deltaxcn > S64_MAX - vcn)) {
> +                       ntfs_error(vol->sb, "VCN overflow in mapping pair=
s array.");
> +                       goto err_out;
> +               }
>                 vcn +=3D deltaxcn;

Could you use check_add_overflow() here?
In addition, attr->data.non_resident.lowest_vcn also needs to be
validated with overflows_type().

>                 /*
>                  * There might be no lcn change at all, as is the case fo=
r
> --
> 2.43.0
>
>


--=20
Thanks,
Hyunchul
