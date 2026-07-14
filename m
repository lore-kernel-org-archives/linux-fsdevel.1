Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166773A0E97
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997856; cv=pass; b=sGz/dRznR7ScYIE0RFOXpMzpINTllcp9PSIuYocGOgVAWaplJEDmEv3WhDiO4Uj+vuXPn813taM9iRvXeYYR9BgROET+4OnbGiwZKDWSG1BjuCLnd8VjLtk5sYbTWOiqVy4U9SUJk806XDQafm1y7oR4eA5l0n8r6nnIcgJb0CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997856; c=relaxed/simple;
	bh=l7q20nS3xE3EPoxurUcncHqA2AclYEuzLDu4vC8Q/xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYX/JumNNmeBQwrwoFQg84xNzznlD6OYHzFrH0x/p+JwVFuXG7zlPCN6x0cFxdImp78oGy8xRL5FERGmJC+kbWQZOey6ATpixuvuSU25sd8WGCLepjoCwUlt5TL3HdWYVu29uiNVeTDx2YHiMJjn76mGw4pHtckRyPGwZxGVt2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFaqYT2u; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFaqYT2u"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15d5468673so69074466b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 19:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783997853; cv=none;
        d=google.com; s=arc-20260327;
        b=DBWY7X17fyL1WJCUji2TEJH4G+nKXIzQF9600JN9V3Rbw8VRnzHNwoDGI/VFDgJf5S
         p+uP/3/DaK0ju11w0pAgWZDCtCr4gSqF7GkTTEKTp67CcYTUVxoEhWDirs/BhxZrqvdI
         ht6xW9GmG1WW/n2Y2b7ITYsjgIz1fx6jCcP+k4tT0/tgjFlty30ig0Kezp1U/S6tzaSB
         ddom+i/AzVTd9vipgwQzijY77sUeLj8NOuje+EeB7+Y1kPfQnGndSg0SxPUiKhDXFcov
         /PmPneSVRIFE6HrKVHmF/zkqbY/BK17ebm+Q6H1R3L+EeSXoLryLYG4x0oX22A9r0XXH
         GiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l7q20nS3xE3EPoxurUcncHqA2AclYEuzLDu4vC8Q/xs=;
        fh=5yxuOxVgtu5fQNvd5ct+4GRERLZxSzZX3SWxZyvKgu8=;
        b=k4YAcx8P+pwWHdcUgalSwPUuaAwsyVKzuZpyUDcVrn/7dj58kRHIY4CxCZ84WRJVSU
         gS3Knz4ravYTtx44idv6G8qdddVeLfFLv/GfMYSStxEOhqmRH7CcIncvNKNuE8G2Z8Na
         tDQIJbEMKN+QnBb6H66WtpGalxppQ6ou3jP92XhmGSrKCrr1TpHqS2mv8EmYCAt2tZ9o
         +ySNAc15dHuHYNmzroh89mZcxleBIa9/+XwUKEZNqCIqo4dCGTSBKplmnWq+w1kVptjs
         01ewCBhdsLKywpSJv6FZ2XU+nDeCF1F+fapT9Uj6u0QtupCqrT5NsrEDs6aO86b2BFmC
         mj8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783997853; x=1784602653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l7q20nS3xE3EPoxurUcncHqA2AclYEuzLDu4vC8Q/xs=;
        b=IFaqYT2uZX173lavhmigZMfCLGC0bvBcA7Ft3YPc7NMQgH43ivMaCzyjjZ9Os0bcXV
         KWMs+aN5Uka/oAEw4b90dm75iAsCYcBYOf8L4iujnSALPb0tfyLPwf7mtPT2FtKMhEWw
         b9OFWVFD+wdRfPiVsNGKFme+oIfkdaL5NE4fHFFE6H4Tj3zKtOFeLnD75fQ70D8wpMpV
         ceqNMTYZJmkXCfLW4YEpF5uvSl8FHuHb3rCoizSKUUAe/2p0vJWUamlrJKITfZ1jOMvc
         IqblfhJGpbTsJLbXW9tObMyVubwvs5Memvg7C2inJrsDFHVY965QzuZt/ca9eGoUVOn8
         5sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783997853; x=1784602653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7q20nS3xE3EPoxurUcncHqA2AclYEuzLDu4vC8Q/xs=;
        b=l9pkx5sxeyYoapsJcV5/0YfDI5Ugs1/vJvIyRcC/kO0HvmIoycYNDVmjqnQShMEXgV
         60waMpjDFz84FTCV749tB2kZaAHks3xeVoL24RBS0N9iVyMeNbZBh1CxZYB0qSe9JYKT
         MM3EihB6uQivhSwIEycIYMO4a0/uQ9ezT8Mw+/GSTem7Dx5x13T+ne1D9DIoFWqzwhx/
         p10W3Djf+fKrKvn/YIgBG5D3XcCz2biWHjbT5ocOAzCfg7c4A5GXL3qAhb4E9q+pZpWR
         xOb13pAIi0kVNiBjXfwK/Bdhdz1p0fx48ZvTwh3kvs5CFeQtzav6jBYJhWK30chBro71
         5Dfg==
X-Forwarded-Encrypted: i=1; AHgh+Rrhp975GhYmIFypdC41GpzwybY2H6HtPJntudt2w5NUflMZSWW1uR+nmJRFhh0xkP5CH1NHV2HBVbkDn99U@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTayogMP6+X/mnJN/rSilkAL1SeDiP6fI2HBjVwF9fRasP/aY
	o10Ek9liazZf0Q3ADfosOz0i0MT1rooKz+s1gTk49PoptPQhhuqSTXmlXKfFdtjWsbfJNIB3Prs
	I6936+5Ucjp1GGfMxZ9oVm39WqGwj58A=
X-Gm-Gg: AfdE7cl2tjeRcF8vO+ssg54ZSNFmCC8ooNMP73wPFMgC02fQPPkWacdR/uXaFuwNUSt
	2GJSGwvxLWSWlJ98S1448fdSvFSIzFNYouVgkOkAjp+Fmc/+LbERd3TSZ16bkd08wzraxugXQmI
	vUYHnFCfy6N5cqFvnLk/t3xq3RtIk2KRfMZeCTp8ct3srqpv6614ZreJryKHLByb1+n1hW9NTXG
	fMiZWf47ruiV7dbj/D0acBgE0XBvLBVoresiv9iEPUrTEZFdGANh/5dBjVSud4Ksmenzf/i9Irm
	dH8gLhC2egfRgyn1ZpT7xmgg+ufAIQ==
X-Received: by 2002:a17:907:7b9a:b0:c15:c2d0:ffc with SMTP id
 a640c23a62f3a-c161e90b539mr514287666b.8.1783997853218; Mon, 13 Jul 2026
 19:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713102129.1657-1-aditya.ansh182@gmail.com> <6917a254461b0633159feaf319f5f04a598a1f6a.camel@dubeyko.com>
In-Reply-To: <6917a254461b0633159feaf319f5f04a598a1f6a.camel@dubeyko.com>
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Date: Tue, 14 Jul 2026 08:27:22 +0530
X-Gm-Features: AUfX_mxIOOVl8x5yHBnohHDy9Qoq99uzLlYGYjLSsRJsTzcS-BOW7x0JEKLE8z0
Message-ID: <CAK5ssPNo7SZ=cnsMyO8E7L0GCJyqrfpw1WwntzxZrVMx6-ULvQ@mail.gmail.com>
Subject: Re: [PATCH v3] hfs: port HFS+ b-tree bitmap corruption check
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:43=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> Currently, the hfs_bmap_test_bit() is called only in one place. I don't
> think that it makes sense to declare it in fs/hfs/btree.h. Why have you
> decided to place this function declaration here?
>
> Thanks,
> Slava.
>

Hi Slava,

I originally declared hfs_bmap_test_bit() in fs/hfs/btree.h to
maintain API symmetry with HFS+ (where it is declared in
hfsplus_fs.h).

However, you are absolutely correct. Since hfs_bmap_test_bit() is
only called within fs/hfs/btree.c, there is no need to expose it
globally. Keeping it static inside btree.c is much cleaner and
avoids unnecessary header pollution.

I will remove the declaration from btree.h, mark
hfs_bmap_test_bit() as static in btree.c, and submit a v4 shortly.

Thank you for the review and the valuable feedback!

Best regards,
Aditya
