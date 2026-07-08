Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFA744BC91
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519754; cv=pass; b=ds1ErI4LMzr5Hotwle6Qv3fs3rb+84XV16V9O9D8pAGnM1q3qvvlb9NIB6yHn2s17u7GlQ0HK0PkR5p0eGhPr71ZSazmnpo1anmfmri/tMmsJPBrNFhQ4MFXsx2NAW0tzpL713KTFeNuM4Ua1vEbux6fd+VFcShFGyLfigtcgP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519754; c=relaxed/simple;
	bh=GiebgX43JHl1XQjvBe1+RPmR9h/Aa96mgIB3IChL5tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzJPDHHZ7D4MG8pclqCi5Jd2T7khfTTlxZPx48LeeqPLV/SqKHTZ4BLPZHeFI9PylaPvQDCMq1B0m+H2roI/p1IUF5jBv+X70/Y+o5cAHI2JEBWb8FMHKVliwDDb6KVXwur4qaQyVr5YxlleKtNmHhDLpv6uTWzaDEQmuZ7zEpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FNUcYtVK; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FNUcYtVK"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0a81d286so10525251cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 07:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783519752; cv=none;
        d=google.com; s=arc-20260327;
        b=SXBWlepsP19Ciz/sUwMqZy1DvtXMdONNRWPQngOinTtH3Y3kjEEPjHXKjqEdj43LXn
         Ns2aGeM/bA5Y2ieVH4IHsrt4ZVbZoAWtI1iDoH7ubwKmhdQzAw82bnuYjt5Hew1rXefz
         EdFtrZrAVqShVp86MOTOqkzMjJSXA1k8N3xOKpYWVT5o2e3UJ9qvIwGbYAydzErm3/XK
         zH30+ls+FO8wUnDW/1sjzEyYcHDKN4om76Mf9x1ws7Juf5z1Y38gYLttM6Yl1InOOPag
         AId9xkeJJ/wyc01ARbWezOfX+KbS31ZeMEFaix1ECmIXSQTAcs1koLNauig56Tr/PoW/
         0mzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z+GhnGa9iy5ZTH9B//oC3EDENHUg5DrCxZ+5xNsaoQU=;
        fh=y629vg7nqktb5q1GbZm7YhBki5oQ7Wu6i4Vb6/1bDzg=;
        b=jOaOjVP7gKSdTogBezZr4FzzXGgURq6lh0kfaNhcRCD5RqWZ39neYVzCcDFt8UBN8p
         t0g3Gj7q7Pi9BnBVnVM/imiAUPwjCL2SnR0RNA1AfvWqRPuz00QoQXsVY3Pg5QXdPbFl
         yWYv5jhyvzyC2VgrF2VmtRZOwYxSwonO0Gg9JTdg5fE2xSDEpvuqcXKyjSMoNlWdcwmn
         oTnnFv2sEOhvNFM/JICASeC20BLT0CaTClj4WrvDdBdYaHau6vX0z9W9LrxjubFe6Poq
         pH6wCbC9w3l92PkDtJoqVqiSg0z+aSDlfR3xNMkkpBRSFX4urLgYUJjEtz5Wk9g+8Hz+
         o7/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783519752; x=1784124552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z+GhnGa9iy5ZTH9B//oC3EDENHUg5DrCxZ+5xNsaoQU=;
        b=FNUcYtVK52u1sDCR1S5JRV19Zz+RV7UddNqE4lIUbniy0GD82UMuDDrqY1iYKLl/Bf
         mmdpWdY97k+Mubny93gSbC9ykroLB6Z7TYUfyDERuj/JJrhpUalTjuD8K9aMhjh/4tjR
         2TMi5OAc5sIP62mGbcTLwSNLnGHT8g6Aqm7/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519752; x=1784124552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+GhnGa9iy5ZTH9B//oC3EDENHUg5DrCxZ+5xNsaoQU=;
        b=HlKeTdtfnD5s3ESK7zTDt5i99cm6Qv+AZ+iT0nZzVQLXwA/BjtTODSk5yhG8cSN7Ms
         vijc70BP5aPl/ySL51ZDwQ17pqRCE9EpvWSliPADyZKIkExzX2d+9vCOdUWxMs9/vaXE
         /HiHLkmjfA7wikCoJy5mKuSCGUJBk7yIP9/JJMxlD1PKpehtK9bDE0vP13J+K8ZnpQp5
         yfGCnsO52w8Y45wrHU1VyqlJeaghL1eoRy9AW/Jkg6BpZXGNTdLnqFECtuyk2KoSylHE
         WXSsvykLxgGrzUIV154dqM1NRTp7BB56GzPxAx6dwzMMz5Egd/hikavpIQH/AOKEgYOG
         wUPg==
X-Forwarded-Encrypted: i=1; AHgh+Ro73cgOjosgUdi4nMse15TMq89wbYnZrnlM/cS3kMIPiuLVAzkso7CbrbMFjyz18Abtlx+ztz8mqgryNsfU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3F/860i8CLKFNFeghIuq4fQLjoqDu8iTeRypk7W0KNvid2Af3
	FTcMWFS73D2UoxtpvNbgZnOQp+YM5Q0jusoW6o6ml4VQ31+3ntJAgMGwsoPMDJwpvQAgxbz5e+S
	ijjurBPQVRin8m82TdLFCgFi6guVKWRdK92F7QTGtZA==
X-Gm-Gg: AfdE7cmsmQq6e9Cowh/9SPgWGPZu9xFLlZXz4HN05Qwx32ikWHRcsRZ2f9c8o+36lea
	q/2Y1BpIKcgPePkdMOdSRk6TX/1UfiJ4v7ir744NMxH8UITM/66LXjGfV3SIm1ovEm92mKzk+OR
	HRDHom5q17vCtKxkQGA4rzTFcf8WHMedbt/flFm7j67rfWntZ20oPXPBQY1liouU76N/KjdynhB
	o640jwtjr1KGGqE3XrmF0BXiy2RITZhm6fGk5bFyqbNt89SNUuk+OTIaaWQOetXMoPlik+J7TtI
	5SH2MGhUWmcWqNEeEtucy112gLbJgjWE/+baUA==
X-Received: by 2002:a05:622a:3c9:b0:51c:f8f:13b with SMTP id
 d75a77b69052e-51c7a7516b0mr72139411cf.23.1783519747404; Wed, 08 Jul 2026
 07:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com>
In-Reply-To: <878q7l8y4y.fsf@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 Jul 2026 16:08:56 +0200
X-Gm-Features: AVVi8Cct3OYBryqlcikbWlWdxAzz_Gr4yKGpmk-iVfq-KrBGvr4PWPMuDYrvjcY
Message-ID: <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jul 2026 at 14:27, Giuseppe Scrivano <gscrivan@redhat.com> wrote:

> is there any existing user of such a mechanism?  I don't see any mount
> specific info under /proc or /sys.

Not yet, but I think it would be good to have one.  It's definitely a
bigger bite than adding an ioctl(), though.

> >> OVL_IOC_GET_LAYERS_INFO: copy a struct ovl_layers_info to userspace
> >>                         with numlower, numlowerdata, and has_upper.
> >
> > Isn't this info obtainable via statmount(2) already?  If not, it
> > should be there, instead of a specialized ioctl.
>

> no that is not exposed by statmount

I mean, you should be able to get that info by counting the lowerdir+,
datadir+ and upperdir options, no?

Thanks,
Miklos
