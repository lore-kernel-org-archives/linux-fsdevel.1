Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9B3382F1
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802661; cv=pass; b=qLCr8jTNngstQAmKGly8db+BNofNLnC67KPhsjcr4yTWDQeLf48l9DOKthhyRMUhSO5J5gOdPqkAfmBjRJ8sVrBSSgtl2fmi2iDA36efPZtupDbP7TvlhUt7rd2Y1RHS3dm1GiiUH+VwHoQ1KYZRHKjZihg050OKzIBMjaMOn+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802661; c=relaxed/simple;
	bh=Av3YyhqaPC9VjXmoR4b1qeBoQTZSFU2AjT6raxzxRmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rI60+5b4sc+9hffad+tEM0IVdsRQ/S6b7yxiNMnuS4XHb6ZTzEIvki1Tg/FhIzIqUNiKK7k1SMNEEi3xFpZVpA3gdwPDBJycZ+NNB23NNArmGapbBVCL38sJfpE9yx5d3zXnz1adOxZvCwQjkon8qFDbOqfCcNbJ5IWc6RxHgEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0aBFU9a; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0aBFU9a"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a8c6fc5fd3so360461e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 16:50:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778802658; cv=none;
        d=google.com; s=arc-20240605;
        b=gE1bFY2MRr7wY0O7PoZYqFLYldCW9xjIHkW8NVCaxsGbcALHitxcCFb4F2APAQttvw
         R4hNbN/+sCJ4iXfFzT5XCkz3v9C3pNF7LKIQ4ytOohSRQCww1zwndSnorS4r+3oJebVA
         JWEVqDdzU5RDh342MZ5ZoBGdd74xLSLAPspr/wI7YquLX6FhA/CyzMdIzup00AjVUPfF
         xxeESMzXCvBQhlHGT9/rntzCtjDgA4T/B3u9iEzsnvrGBTFmV55gRFBc8DdPDanVkj8b
         5DCribOvWLjkxfPMZMugovJ3/Dn9Iw9IcUoodTPlFfSQPKealPuYK5x4WNSZTk+XavMy
         IoxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+bKNfb6YmYY9orMNU1OJ1Y+xlqv0zck98Fmtmzcob2Y=;
        fh=ezbvOJUc2JRc8Peb57EX54FWq8rfNvnT8c6U71Z6OvE=;
        b=DdOlHTPlV6caAC2SZ3ZN69RNQtj5tj55Dt1RF0l65QOBLqp+K+A0ZIyVVgaS4f3+mq
         85SeHCw3DQR7H3CPl7++THCRWqmcmZcq676nNidAx2pIJ3MDzP2vuUT3S8TxHfI8fzH1
         WRv/s69K1GotAyMnpknWB1P+DaWmzEVOCrHIeonF98+bkUbERi1FIDEGEOExvgsc90NT
         O1yz5F4BBqZhM/l7CQ9UzoMbzuBOKjgBiwj5caiJ8w/p0x043Bi8XQV5du+v2VDU1Q+u
         bOf2swHe9vi3evwSscOjpR6+KpS4BkFDRlHkyVdiGgeMRmppg+E5NB3lEtVUb7Cx7Z5M
         lL6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778802658; x=1779407458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bKNfb6YmYY9orMNU1OJ1Y+xlqv0zck98Fmtmzcob2Y=;
        b=l0aBFU9awDSdBd3k2vlv11KNfhO3Y7f8O2iJqbgADK9+y067PH9HPgEeqrhtFZCWca
         ujpMW5+mqRz1FPunDt75MJhbgCIr/zGhoYqIhwil3ZTCDHcdZ/hl8UReXs7h5VrlNcB5
         La8NBu9rm+nUb/m0Pl/Lbp/8NqifSWXq2A28BwXPvLdLAGRQKgrvYZ9DXvyllOtD6bBP
         ILYYt+jyTCVRU4D+Qh7lxh8nVqGY3ZW0xrDgvSr1Im5dXDu8tdNOp/YDqxy5JS/unB0I
         7b1cRMdWJwe9dNGKHvAGILUW2uixDI3pTcKeTbnda8PKvETAWV5aUQ8o2XAYMyJHfX8w
         FlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778802658; x=1779407458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+bKNfb6YmYY9orMNU1OJ1Y+xlqv0zck98Fmtmzcob2Y=;
        b=bWFfGIk6pO023BU3ZDfCT0veY81Yy88Iy3t7svlsgKFuuybQ5xJKsZSbbV4VqTGV6r
         0Psne+3ZbxlQBkaE40Q+dY3TA13TV62G8MEb7ddt757q1Rt+/A5vTFZn7SLAfifKLwhD
         4ZAwro7xkl1Fn3AgGTZPkT0FfFS5DHPteaRY02oaT8pNPrJexDvicaxCGwLVQTno5Skz
         GkQR/cp6vrYSEKfTo9uXDHnppdluBhzKl0ykz34qTN1UlBiQTRNYGk9hAbVepntdiKTr
         27ufrYG5cRQrn0w+wttwdjN2J44GEDsaIkynqs+6t93uguKghDgdM8j0VjYvjVYvBWHE
         LScA==
X-Forwarded-Encrypted: i=1; AFNElJ8m6FL2Pl+Bm8bQA8hpNMpAuAewfIYMtWLCtpRkFVwtnD7QsBR5NHLoi4q3wuTTepSoqA774IiExbHjyR9l@vger.kernel.org
X-Gm-Message-State: AOJu0YzSW1DiLls/YHKhzgECfoheEePgp4PNYj9jz5pZOKpsDobzSWi+
	sZtFe8YhCsukG3VSKY5BBvh8tF8kfpaM4lDgxOrm3h1ASSk4igRS7TvL7kwyN8nHAQsQjr+R6aV
	YvgHS44Zhqb1hsSeI+94IauU1tKwwvLY=
X-Gm-Gg: Acq92OF8YhKKLzWqgh91rFXoUQR7YdNYOLkSd2lp2WSaOHHqEJi5kDJv5v67F+vOaH0
	cERWnvxtOaoj7EFwl8OK6W9Yos1Kfk2Y7I8Ro3YEBkFetrcB/dptk29pozIYChaimtwxnvm+P4S
	14043hZQKBAv5isv4eIN2uZBt1zZtb0IP65XYgLZ0AUZIxvzZqe2PTMtZCNVvCGjFjQCB9Pmp5q
	MySd9Oqyr3QESThZRY4uPSFPPtO3YZ37MMcG06m/5Eeci0dd7W5moGbTAU2HeSVuil0iIJXTtbM
	5cec2vY=
X-Received: by 2002:a05:6512:3c95:b0:5aa:b6a:602b with SMTP id
 2adb3069b0e04-5aa0e0a0b45mr419912e87.21.1778802657565; Thu, 14 May 2026
 16:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511160626.1268612-1-charsyam@gmail.com> <20260511160626.1268612-4-charsyam@gmail.com>
 <CANFS6baeNEftv9Zwn7_tNxhH2B8kEhrWOT14RLyewr1_rhnrsw@mail.gmail.com> <CAMrLSE6ZwKd4cS0YnXuKRvYoRMfXTKz8_LH62uD7F-vVR1kGtg@mail.gmail.com>
In-Reply-To: <CAMrLSE6ZwKd4cS0YnXuKRvYoRMfXTKz8_LH62uD7F-vVR1kGtg@mail.gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 15 May 2026 08:50:46 +0900
X-Gm-Features: AVHnY4Ltzy9kxHWrXmsI_9y7jR3iAaZzf_Yll_NyAnQvyemtXLsoBCB0ImqBIv4
Message-ID: <CANFS6banT3Vc09bFNFTMP2UOjAhYK_EhHCNXPd2uZHX-dbWxNg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ntfs: mark quotas out of date on initial rw mount
To: CharSyam <charsyam@gmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 14=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:25, =
CharSyam <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>     Thanks for the review.
>
>     You're right that the driver does not maintain quota accounting: it
>     creates v1.2 $STANDARD_INFORMATION for new inodes, and it does not up=
date
>     the v3 quota fields or $Quota usage accounting.
>
>     Given that I do not have modern Windows validation for the exact quot=
a
>     rescan behavior, I'll drop 3/3 from v3 and resend just 1/3 and 2/3.

I think setting the out-of-date flag in patch 2/3 is also not meaningful.
How about removing ntfs_mark_quotas_out_of_date() related codes for now?

>
>     Thanks,
>     DaeMyung




--
Thanks,
Hyunchul
