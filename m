Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3609536F8F5
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620372; cv=pass; b=AuzpPMZi9g9EEQrbHfhWTqwR1mJsIwa3q/sC30ejVlToMDgcs6jSh6QWBeiCy4tupnVpMOiHqBZzUccWiq03qsRxrkgNrY0XiWbUGuCPzdPVQK61mINsHBrQdPlATTSBPTHqbJ2AwlLMJUGGiUmiFFJ94xn8SLsTNP499fb3pPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620372; c=relaxed/simple;
	bh=qYf76rQcTsdQm5oNAXF0ipWi+KiR+RGX2BosUuLXeh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7rnnsqyONPxdjPeaoJD4mNI0pvWjH5CGw8RcKr482pzx858lDPwOIqIXbwhqxqcsdIcnELTao9QZELxstINhWBHQj8nqNMTJHzYMQ5ms7zyio62gLDwyHoqv3MbiggibCfQpsYg5jVmpZAiWrijNZrz6JUbjeamSSYsNuvoWwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hNrlQDAt; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hNrlQDAt"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-915ab38ac14so630018285a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 07:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781620370; cv=none;
        d=google.com; s=arc-20240605;
        b=FMOWQQi/vWCRIPxTbML+3s5+c/I/IBmLK3f7rErwtnFzLd+usaOumauK3+Kem5I7Bb
         zN+kD576o4n7AlLD6Q7JBs20ldWQLKZA+Fr+WK2UZ5NASIMuazUbn71SZQ3nt1+lX+lf
         svm3WGID4h9NfPEMqxjh6JFAkoDV1hjS13WP3jC3xHKwFn3oeLjVdLnQI2QPlJoZ5CZy
         3N83qdt+tvF+l5eWAaZP0oJvch1gxvIwgDthjjc+PtWfSfOD9f4JmtGwEbVM8b3wEY90
         wLB451ajqewdwmpe3NLrY8TErTBwq7flgmRWdgMoaghU5khb75ZMULNh/WhKHzUuX/AZ
         wDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qYf76rQcTsdQm5oNAXF0ipWi+KiR+RGX2BosUuLXeh4=;
        fh=WqzVFlLfPs54yfmhdw/ogl3mDzgiAZYT/SCe7GIQxW4=;
        b=Q3Hb1PYmtKJjwX4BHINuvCPhXL9VAaSwezpv8AFtqgnqo9HcQyVJyNQDOk+1PMwsZy
         C8Qe4AwOL7H5eCTv5jRUcGS155RyI3PWzYCpW1TIeLPGADqWdyOTKyHgmJEzq04ycns8
         +Md4+bYKapbFf3opd7IdKCNferaJGl/EqsqqhqtZ/CDfzLckyl7JDKTx1IWVwYYV3AwW
         ZVhySO3/nALtlRWEuFZfubPJaYCQURKIccTjqxzVtceaiMP7gwuqJpxH0SzRZN+ydaDR
         XTihuP9vH/2GDQ+8BWCzxGohNaqt4fJA8lYlIMhgsy2EPY0csd0FZ2r5Y8Zf7/aK/5yx
         9jnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781620370; x=1782225170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qYf76rQcTsdQm5oNAXF0ipWi+KiR+RGX2BosUuLXeh4=;
        b=hNrlQDAtvO4fL2qLLLH73qb4VrOcY/HwigIfm43VUSDkFPlvzUsGuatF5NdzE7VCu7
         VTLp4ykJC3uY1TUZrzSa+PbHzkugfacTa6Q78ZdHSfMHFqpoPlb/pxZ8Geo2/KbIrBjh
         JKW3hBtk9Z3deJPnCqcixiDOknFPweWABXOjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620370; x=1782225170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYf76rQcTsdQm5oNAXF0ipWi+KiR+RGX2BosUuLXeh4=;
        b=r0SCQlUc9jaS2z5YLEIAuoFkIKv7mMVRJ3ojFPkgnChO8pBModojLkzcwCPSUEqLLd
         LUWJWe9YToF6zI2O2nzGXsOUJLPOaPU5NXcFGVMuRGpd4sV6WkECk7t+r1T8RUyQOaFU
         lFuBGDNLhGc3m8+g1o41NmTXgo5WEtJwkndt0FI7iPmUdKl93DVtGAqtloteh5Lulbt5
         jHFOApOUb7mkJ0MetnZXVkUWCMsB8ydGdLgWLYU8MkgY3Cf/HaDA/d9yY3YFGw1siqXc
         jI1hpYPx6sc6+DTOnRe3M4q2TyweEHtTDafLGVn4lXpJgaXGvdk43H7d1zIICEuaCVYt
         +wKw==
X-Forwarded-Encrypted: i=1; AFNElJ856JzX8N5SDlrtVdNYEoCCsGD2vXSQVv8R1WuINRHiDueV4pRCSTMaMcYgAlLLxVZFqEsHL3v/0aOxqLMQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlef+NjoLCmE94rtJ0JOQsRVhH6xeEtmsnDX1lFVDwLs1Gyykk
	ZPxwGYb7pdtlOFVMVWsjHN4ADuMqMY3MHepv8mA8ROTXk8irSrbC9fP6HcFsc8dRdj1we9p6tFA
	GgyTyElsUp8sFPdB1cFS3r2OwsDQZa/1a7v1VRmM0HQ==
X-Gm-Gg: Acq92OHHneMCLFF3itPHJfoWdDFwH18gwCUWQjdeLId91XA5Lk0AgcVLd6ox6u7xeVV
	gLSP9IqOxUM8Dfq9vqFEgg17NWuNhvtMnqHs47cv0oQxC8/sBc3lH5dk9p923brFoGyGwDO3G+3
	UFOTKNBWQGn7dwA/75Ii1oeEFuny8V2CT9GHmDS/NcM4n3xhQS4qDQnKfc3Aq8D0xfSHIcLifUe
	tlvINMbiYsnfBAmFGZ1WXW7Gn5Iovn4TXtqzIiL7Goz4sdHMLMPF2pHSXlZeCnL1WkgaUmX9NXU
	Mb+tyHqHUDd4EMQ6lij/ESRl/t0RkzNo+K0t0A==
X-Received: by 2002:ac8:5e08:0:b0:516:d557:15bb with SMTP id
 d75a77b69052e-51953554bd8mr239431781cf.46.1781620370090; Tue, 16 Jun 2026
 07:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529134302.1989958-1-mszeredi@redhat.com> <ah5-40YypaswEG-1@groves.net>
 <CAJfpegsJj8cZ=CXL-VGeVDOayAeTzstWJgvQye3N+sudHJ5L9g@mail.gmail.com> <ajAlcVPGa7ytSWOm@groves.net>
In-Reply-To: <ajAlcVPGa7ytSWOm@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Jun 2026 16:32:38 +0200
X-Gm-Features: AVVi8CdzKNX6pCMQRYh8T-XAvu5h6XuOLr8CoGsdpXseiXNTzAqHMmIMt95ja_Y
Message-ID: <CAJfpegvjUpVROuPgG1YiCd9Eg1V8fPtrYaQ+3p_1XhiNo11VGA@mail.gmail.com>
Subject: Re: [PATCH] famfs: FUSE_GET_DAXDEV -> FUSE_DEV_IOC_BACKING_OPEN
To: John Groves <john@groves.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jun 2026 at 18:20, John Groves <john@groves.net> wrote:

> Apologies for the slow response - I've been traveling and juggling the
> other parts of my job. (If anyone here has only one job, don't tell me;
> I'll just be jealous.)

No worries :)

Thanks,
Miklos
