Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB2389104
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682370; cv=pass; b=MUKayJFk9990+HTPZvHFCzQR5dl2I/sbUm797GY2wQZMphpRRiC0sbBO9BY+9AffjUDPkthP/6KTsk2uzpgEbPN0tU+yQngN+x/LYadgQ7NNjCiy0kDDgLhZbJu9fYwUDtxmVpfeQxjS+lwRGvXEpq3VROTHB/LPMzLZC4iUHMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682370; c=relaxed/simple;
	bh=yQAbAJFgWPT0v1c+a8zVlS0XEdVBYRm7In73R3pbxXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KniVdRi8mUDTod42mFxZMJuAMmv+8DxSJlyfKPXHGEk8LYjL84sNLqocIPW5s/FjOWoptgdZP+keHO5IyiDskWkN8tK1lmO8BqnNZtShyRW5G56nDQufRlgDXGDbfkLlWn6vKXxC7EGa1MUvL4mj9jjsnPAeS2HAUhV4vdJA4wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rDGNvSAt; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rDGNvSAt"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ec37d52c0dso44397785a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 03:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776682368; cv=none;
        d=google.com; s=arc-20240605;
        b=l00Wi/Sk4TYWoZGBCoTdTC4ol/PhOqoGBKm8IzBkh3vAloqyfy/8Z5osVCdzGNstSv
         CXGS9xyYDDbMZ1SCJzOD3yAj8PH0Ocr8wp3d9MBK0w2mWcvSAleVFVSJOpWpZLm2gJ08
         40W4GtJzICAFX9GsENUSwibBK6ZURCPOODnZR/RLWxQwgiFzxDsZIxLwoOPUCf50wMMx
         LI9ncQWfA4pp/ajl46gQb5cvdNOyi+XPRKGJ+Vex9UFNE66VwYE5ioRl4/yg5s1WRHUG
         hbgM8p5H5r8W3bsRqkC99bm5qj3484hfXSa9/L8ZR5ixelSGw52MSxKdr5qVBF6TAouR
         qOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vc06ojz/9Ndl1KwPAbPM1ULdS1mAT5kujKvMJ1bDfkY=;
        fh=GRWMDMrfx27dSSu1FhOVeSAWIHPRIZVY/SDQ65y55Xg=;
        b=fU526DtaNLOInylSvX71RJcxcjC/wG2sx6hysbAIZhZGr9w2/F0nKAGSEP1E9X7h2G
         J7w88lwAP+/YTM9p3ww4fJF8nViGC33yk0YyHLYESgZqJBDkU5lhKCjo6RzUS+RYCVZv
         g0bMijG8Gvnm8kiILLlJMXz0ag0Xi8R7Nzm9Zvp+2WEF9m5hsYOUOqrIi9hMrxxxVp5c
         wiHBuJ9aYpMpmjErrN3R98/oN6y/1Bh2jIAxRsS/nLNetExg4NWcafrYoHDpLnKD2/fz
         zMy4dWtDrzT/xJ/CoDGz+rfJKfcqJ87mMatlDm4Y8JU9K2M6VlQ2mtdT9OSY39wg8n3p
         ZrTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776682368; x=1777287168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vc06ojz/9Ndl1KwPAbPM1ULdS1mAT5kujKvMJ1bDfkY=;
        b=rDGNvSAtQNSBjK/GETbRKHMDoagUDLkZQvIMEmPtveN+zm+oETDyMCyBX8Lebr1x5D
         bN2Ps6nxMR5VABFrpXpQSy4j6d3ObrAh0MthfjMbhldKY2fuWwHj9n9m4bfHKRHkC2Ws
         tt2m2mLsX1vQUvDPo4G2oi6rVum4PqVo3okEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776682368; x=1777287168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vc06ojz/9Ndl1KwPAbPM1ULdS1mAT5kujKvMJ1bDfkY=;
        b=rBB3B1ch9p1uF+98VWICgIdGJL5zyCHX425rEMan2djEXt4TpD3RdyTyxb7VzZANmx
         9E8PnKRrXm1fzdfgO8XZgy/l6KvgqeuHaKUGvxqX52TBpaATe/YYQSZ79ztN+dmOQgzl
         p4ZmlUjS7pp6CHqhu6y7DaowyF9Pi3LGodi8kgtUfkVj4JRa9xRjsiNT6z+TiAZ57IBY
         L7p4J5B6G+IQZi9d1VM8t7B0K3INYL2dbdJ45H1y/vaJ+aSdD4HJf4PubX+DtVC18oUR
         2MaGPPLVp/8I5mZ57Z6lpsQaDshXtOZu0BFgrBsbWviorhXOVEJW7Ni5noG0FUgT8XdW
         ZP0A==
X-Forwarded-Encrypted: i=1; AFNElJ8XkXMG1fiiBjl/rLJLaG3TaKaLgjUTxBxhnWP5U+yJ1/FAJo1t0tQ8NGtSmGDW9AcB/YDKhoD0q7cQqC84@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg21uYSdC7SrfC6K8ZytIHeWZvQrxEYO97r8kh0LQAU6M0nYlf
	mEN5NF4QJ1j4SRes8aO3VGF0fENXV0dgJwz1cjGahyfZJ5uzx70L56xtxnHuuyDVYi7+8etFVvz
	heAyAkAv6PRbs8g3ScX4heMdFbycjKDT64yT71Rjhrg==
X-Gm-Gg: AeBDieuWCuNO+C4k898tn/RXK7z4A183zM/9WyGRQPHYEmI/GNzcyKnLvTiXK8+qkup
	eVMM+8C1/EVc0A1IgT0KWl1s5Hhn6Pp+J2r8PjE0p3FFI3qgtW39zHvjgGwE2IdBuzRUrgNttQV
	HXjC5D+KpLUCN/1udm8/WhfO8ivlrek8SyKQHo1tqbyffFwPP63Ayroxmi2pNdJE/iBSP0aPAqx
	ZOC4K4YI4qgk8bmBOLO9ijzgRckcsQwTZe0ZkoU0QO+gllARxepvr4T9rLtIaBk9Q+oMO7bdZ7Q
	33V7VZe/YOQkHfrnEz6xsROcdJ8Qh/hQb2XouDqSo7RTw3TU2aY=
X-Received: by 2002:a05:6214:20ab:b0:899:fab4:730f with SMTP id
 6a1803df08f44-8b02819eccamr214997106d6.49.1776682367879; Mon, 20 Apr 2026
 03:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69e1934c.a70a0220.7229.0010.GAE@google.com> <tencent_B2A5880DD99212DDDF5D9E9915CFAC8D8607@qq.com>
In-Reply-To: <tencent_B2A5880DD99212DDDF5D9E9915CFAC8D8607@qq.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 20 Apr 2026 12:52:36 +0200
X-Gm-Features: AQROBzBGuCUNb-c5QmM52sf9v1erLdFRGvs-qWNB9aFF5oB0xsPFA7kPrh-rG_I
Message-ID: <CAJfpegvAyZbc4t4ZqknDKTT9P62yiKwxGAPyLpqQfMaudfs1Tw@mail.gmail.com>
Subject: Re: [PATCH next] fuse: avoid using the same file descriptor when cloning
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+eede1fb91fb15bbbd5f2@syzkaller.appspotmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Apr 2026 at 07:27, Edward Adam Davis <eadavis@qq.com> wrote:
>
> In fuse_dev_install_with_pq(), after updating the chan for the new device,
> the fch->connected value for the old device is set to 0. This logic is
> fundamentally flawed in cases where the new fd passed during a clone
> operation is identical to the device file's fd; specifically, during
> an unmount operation, this prevents fuse_conn_destroy() and subsequently
> fuse_chan_abort() from terminating pending requests, and the wake-up of
> the blocked_waitq is also consequently skipped. This triggers a timeout
> in fuse_chan_wait_aborted() [1].
>
> The original conditional logic has been restored to correctly identify
> the new device file.

Thanks for the patch.  I fixed it differently in #for-next:

    Move aborting the connection (setting fc->connected to zero) to
    fuse_dev_install(), because it is not needed when the clone ioctl fails.

Thanks,
Miklos
