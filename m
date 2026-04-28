Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832E43D4EF
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381875; cv=pass; b=fgYsVh+kU8AJhwAzsoLyp1huzad8jzZhu4pdnLW7b1Tn1bICea5HGi52tzFCVLzh5ktxqeeU2GgUNu0qqK9QuU0tQFHAv0ZJv2m1npsivGVDvlgqDTGQfRK9fths1U1iwup0d6fJobnvZOwexCLwnJ5yP2gNMVbfukd8afW/O7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381875; c=relaxed/simple;
	bh=2PXkFh8GWhzh83Kpis/BU/Ka5YuA1wSPtI4Zd+aMZOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTVdIpGkZ8ugNRHZZ1K2zB9xIW/o9e2Fodj+huCywtgLlHsxNiL9Qkarbi+TIt/2ltE1P4QSQSCsGo91o6mDFu9WVjp/d0u/n7JrIcrTR/zEU60PwgEaJqGITvbFaPwoehZEw3kIocDCA/PsJ4F2P9MqN9oSsSzrtWGGZBfWgAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=YoALdveA; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YoALdveA"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89f87257904so93786846d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 06:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777381872; cv=none;
        d=google.com; s=arc-20240605;
        b=FITq+lxZWgBbPfrhsU5KC2Ez+vk1HM7UqR3k6oP4du9Bct987FK4ZpZF0Lf1FozSqE
         FqHcXlj8+KGdkGGqMYc1Y++hCM/qzslDh2FSuvVWMUncnrwUympfrMny50Pjv1NlcRVb
         W9akiPdbb9B4zU5wfV2xadH8X/sOZ5NPhE/oNMg9r+VKI6HkCLxdRMJdSgayW/u3MlGY
         L6OzkpRZVBr+OVk9HI5ZS3ZXwC6jy9m7eT/jfIxNp7WzY5Obx+0PYRqwVNRhlzmfeMMb
         ugnyMUCuzPbiea4iYjfWKnX88lsWUrba1vHdsMBls5ZIFu2YynDNtj43VLjTmD0O6zlu
         K0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sQ0kop8xDcm9PEnIMzOMkspkG4xjsdA7aPahAZouQKg=;
        fh=3EWIpzooDevRL9PVITMPTxw1OiOoj3cUsyossdXew/E=;
        b=YoUmrF4wxcMkVQIApplC1sPDfbsAtezESWSZlQI6pCsnL0sh1XZm3SDpQkEWS81bjA
         ysB2d3vUbRfGaoRtqu2R2sVIZ0fCY5gN7QF1dHPbFxA5c1veqQ9eunosSHaRuu0l7yuB
         QOTr83INvLAa2fWryGCBrQtn7/YlBW0fTjb7sPltm6e4CGY80Y96zMWiZNBe0amM0q4y
         nh4lFHH9h6JHavF6MYa8gj0VZq1glRIicj7mXahsNRxlX4Q68vk7YXTE4SiqGkwShsCy
         u6SyQt4VcA5mlCAnqi5/6S31ZeliBY5SueZTQXpq4u/fvjM0WcEpjfewidQ3BaQ7LCsC
         uWYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1777381872; x=1777986672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sQ0kop8xDcm9PEnIMzOMkspkG4xjsdA7aPahAZouQKg=;
        b=YoALdveAEOw7BTjYZrpbBMjAFNKNnYsdEVjNilbDIW0/GTzxRm6NXQ4V00jDWNI/o3
         X95OVVUSDi7a9bWx230feiuh1mbrf869wmqIoVvpdVUFz8/jUVSRqYCId4cHN3G/zHWT
         Xvk5iy/ZO1bJ0s+KT4hjEQDMSU5KQ+7aSxwAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777381872; x=1777986672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ0kop8xDcm9PEnIMzOMkspkG4xjsdA7aPahAZouQKg=;
        b=VWdje47EL7Vqd2Q78UFdGEsnKrqKUI7KYywn384WL7/j5yJLyFqUBZrzE6ERZpjSxb
         jA+YAtW1poarjQcKhxvddAkU8KkPC38O0owNRwiO9b8Gh93g6TiDpCZ/XKlFrrNTV/kY
         HSLsP1UlfAz11JjoqpAufEQP36ZJwE7Y3FwjmhxaDz+XHRL22pcgo5W6vPcXV7JTXwB8
         xTDfbx6zxJsZnCBxvw4ccPx/nfKa41hEU/WXpqrisax2DXr8wRrgLXpw7dAgvrBrqfCQ
         9bQRPYu5KUBClBKkltCY6mgpnKYquaokZp4hyhS0aNY3UTkw5tbbAGblsjOZwBuj2CjY
         TSWw==
X-Forwarded-Encrypted: i=1; AFNElJ/IFO/TW9jwRiZ8cqqLfRzyOhwFuH8OaebUDYL1M0Aw+XW+ln2CUx8GeNhDCEma1mIIGn4rpRu5YfbYIQTN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8FD7oRHPKi4jFNT8TwKxCBYLVxM2Mw1Zcvyk1EWgrfXBFSRXb
	y4i7Z+beUcQdX3iW8D/JjGbz4nFjCbI4VPWKhhUZUDEMBs70j10h7AqL/Sd1w4K8bmrvrhNpM0o
	CXtDaiWE9ph/iTAndp6p0fFBN+iUP9Oq9sHRjOtuO9g==
X-Gm-Gg: AeBDievx/eGo2u5VgnsqrGFmwWj0uFBNzCj2ywkZNO7AWaepUpqEHovYw/a/7tecUfz
	gYQt5kpG3Br/6/sFQRMtNroVg2xCc5uP3Dpk5E4ys1+KgruXz6MLHds4u/oLqB1QKowyiV3FPtS
	3b56z+mSQSEOl0XibfvdEEfahXcra6+xyPc0Rsx+YMIwS5ol5ATtSdIOXHYKm5VDyctm4pZHvQR
	N1avmIjpj19sTkLXa77GDHgmKgdYHDC0RbxvYZBvw3+tVAmoPuIg56gwmycCkDmm+YQnJNQZmvv
	GcUK7WzaJ5YShCG+JanAytImzFXOyPD7BecQxdjOatZy36biSw4=
X-Received: by 2002:a05:6214:428b:b0:899:fb4e:47aa with SMTP id
 6a1803df08f44-8b3e31ac152mr50521376d6.39.1777381872299; Tue, 28 Apr 2026
 06:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428021304.2338592-1-mochs@nvidia.com>
In-Reply-To: <20260428021304.2338592-1-mochs@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 Apr 2026 15:11:00 +0200
X-Gm-Features: AVHnY4KuqhJBOUqh9rg5qsmJEQclZpBku1Uo2RuOKjIVdiI4OqyYu7n23BussEY
Message-ID: <CAJfpeguzUDE1gegKA3WXCORZZRQrWCRsKe_sdLKtGHqRd_vyyQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: do not treat unlimited readdir count as a buffer size
To: "Matthew R. Ochs" <mochs@nvidia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 04:13, Matthew R. Ochs <mochs@nvidia.com> wrote:

> For virtiofs, the output kvec is included in the request bounce buffer
> allocated by copy_args_to_argbuf():
>
>   req->argbuf = kmalloc(len, GFP_ATOMIC);

Ugh.   The real bug here is inappropriate use of the bounce buffer.
fuse_readdir_uncached() should instead supply an array of pages.

It's a little more complicated, but would fix this properly: overlayfs
does want to get as much of the directory as possible in one go to be
most efficient.

I'd go with vmalloc -> alloc_pages_bulk, then vm_map_ram() before
parsing the result.

Thanks,
Miklos
