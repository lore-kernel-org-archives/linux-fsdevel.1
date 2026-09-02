Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8738E8CE
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 07:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332659; cv=none; b=eGLbyvxmskohoy5/zEpQfRrylNL9joPku011EdAQRnHtIWaOma1GwlbKC3BbaAc42n0ny4FaethvViq3ecmhzd4xWiQv5TGanh1+AcDwZujMJ1TAx4s5NK9Y+7bEOZ1wmdNWDp1sPqNnhACzlDYtVub3ty+CP9P7lnOzLJbdq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332659; c=relaxed/simple;
	bh=IlL8iaYajV3Wj9aNQbzvNV52XA7cB91i8FwkXwg1dmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d79VT90Q+j7p3XfDUra30v2NFoAyb6Y7amqpSs0IVe5chNSwPuQP5bKsuUkmC4n9ungMA2A2kv22DnIifyDIEbwE6VZGPnXzJ1CMoFEoqH4IOGIC1UrBcOkzC9U437X+D+4kRM7Y2wOgrjjmUv/X9bNWRb4Lq8kuzyeCZfQhVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKDJmYOy; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKDJmYOy"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398e9698a70so702813a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 00:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788332657; x=1788937457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EsDRbeSR3oPdTok/4rtWnAh/uOJC6hXbk8Fr43qwD/k=;
        b=jKDJmYOy5yv1PDwexMbEsnBG+iWxa6e37d9yEf2CItzzGBReLvKwDVjlUFzctzfsVf
         7JuIpufXBsQ4IhkhurVyuUnmt28QXeforDWu54Ar3gtFej6OLrJhimyh6T1llc9MzDby
         hlsYSE8Fu8fwrSFDaj9UZr8klUPEgkDFhEAQgvN7AKZAwXQVHeNOV8Tfgy+gJ2+StROQ
         HlQl0g8fSMMWKxLnWNEEv8dm+2wZA9KsxHXrEJC0FeNaKlh7YnA8KjpetqREzzAZbO/S
         5pHf7osdhcFRKYYHf8eeAxBwRSX1qhGJNORaPVTxZKM15csJvnYSrViywU6gGBxgZI/w
         0GTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788332657; x=1788937457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EsDRbeSR3oPdTok/4rtWnAh/uOJC6hXbk8Fr43qwD/k=;
        b=B17RA6GDQgUGMvyXTYc9bjk1dIajbZHSN9kPVKWtijc06qZfZby958jS5HJLelQfeA
         4JWj5g4bKsFPU9PkQWoApIEk7sYOZv0XhufLRlJEf0WGzcWRbu5gE5hk3bOzztPGjtXS
         kNkBef3+zPbAH71EXstw6faVLn2+HdSJGkCc3qo45KcQTe5g3oGvBCPVRb60g4DvXlze
         tFxr/qCURz2pK9TEPS4wmPCXgaEnp/jOcS9snBuQemdn6cmt/kvOY6xkL/6YLcBJJ7yu
         Xtb5Dj9OPnzl0bLkxikZZQOAnTdaBvsGAI0+RNco2MwXfi0Kz8OlReViV70OCaIhIWTa
         i2kg==
X-Forwarded-Encrypted: i=1; AKwUvBxxPeuMYFP4EIS03QDG10UFE7Ogu2pbOvqRLH2kecAb3JDc/S5i36r02kHaDPZLTI6uvvOQ+5Jqwk0+EAdH@vger.kernel.org
X-Gm-Message-State: AFuF++kaVntFv72wqIRyMobDDWuJK8JiE8qicjP08ZrwBwkQCALYEhY2
	TiklfAy/l7HZ6f4M0jNhdcQ6BOte5g0YK6CDi6yrYmFi/BeHP+FvqSet03R69w==
X-Gm-Gg: AYBFou14UyQDzdcGuWIRJY0mrx9xZ6HFVZ0Pxef8bnyFtUv4IdhZPgrW4Q3mnRRKKti
	a3bLn73mML6Ap3UFfRgcPUrRQWUi0MMbgopNUcpda0YzGlpwoslsflOcyhbE86WtuV0ERFuebqU
	xSe4tN19bykRGG6Y1TYdDc+KeM2ExrAFPY2cgsWzWsIQEgPZNXaK0FEuj/Zrd7zQ6MGLzctbYh2
	0ug2hIrWnFPhLmwGftYnHfYVVrFmon5YuUFkIV6pvUKbUdTBrImrqdbkQGaNHnm2reOu/oJV6e1
	tpt0Wn4hToAzo+yWM0sJ4RHAGiLZpDLIf+bnWNRzP3XZ9GZFdc4ExY7H5vcEDZ9pOVESCvVorz2
	mzpuWZW0WYWNiBvCrzvQM0cWYcnTaiJ7VbwM3jDMNfNpzGEeaEx3JUj1Z/tQDUddJeJzJYvR05u
	LVWvBUVb6sy3qx1VxuykA9fQ5M/j+x28yEXZIOcsUDv/SD8U/0dUuQwR71dNpPx799T5DGUlsbm
	BfwAU4WNHI=
X-Received: by 2002:a17:90b:4e8c:b0:392:6638:2e6a with SMTP id 98e67ed59e1d1-39aee0840d5mr4219200a91.13.1788332656800;
        Wed, 02 Sep 2026 00:04:16 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae610e5b2sm747155a91.0.2026.09.02.00.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:04:16 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	Miklos Szeredi <mszeredi@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached connector
Date: Wed,  2 Sep 2026 16:03:58 +0900
Message-ID: <20260902070359.4163607-1-4ncienth@gmail.com>
In-Reply-To: <CAOQ4uxjbEY12XMmfCXTPTpASmECCXcGBQR+bS93k=4vgqzFDZA@mail.gmail.com>
References: <20260827045007.3831259-1-4ncienth@gmail.com> <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7> <20260828042421.964822-1-4ncienth@gmail.com> <ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak> <CAOQ4uxgB9anyJcWem04w65VCJdxbbb2cQDZ_u8qMusw3xpB9Gw@mail.gmail.com> <63aj7jbfaoamdmcurlge2c2kqpliaifgq4vbythrrxpfyr5vtm@z64myom426zd> <CAOQ4uxh-NZ76hEFoNNGjyhodr9U=dvZuGVmYHVPGZ_=jRxCAsA@mail.gmail.com> <67hq7zqnvp6onwwjp24axucgxbzsko2dphielupdfzmfyk6x57@bdeef7fjkqfa> <CAOQ4uxiQF4M_YSBMW3h8VCKR15GV6g_K5nf=2odtYetEwKHm9A@mail.gmail.com> <6n6r5zvcu5ojihyb52rhejlky7xrn2a2p4l2cgfut5lsscunek@bcnpy7bifjrs> <CAOQ4uxjbEY12XMmfCXTPTpASmECCXcGBQR+bS93k=4vgqzFDZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Amir,

I tested the exact attached patch (SHA-256
9fa187507909ae14c8de8a117e775122e3daa425c69081b7115b3dc979fca14d)
on Linux v7.2, commit 8d3ae59288f1, with an x86_64 KASAN kernel.

The capless prerequisite probe passed as UID/GID 65534 with CapEff=0 and
NoNewPrivs=1. I then ran the original reproducer command

  fanotify_destroy_add_race 10000 1 1024 256

in three fresh 2-vCPU boots. All three runs completed 10,000 iterations with
10,000 successful adds, zero add errors, and 10,000 fdinfo reads. The complete
serial logs contain no fsnotify_conn_mask() warning, other kernel warning,
KASAN report, Oops, panic, or kernel BUG, and both guest and host exited 0.

This tests the originally reported race reproducer. I did not yet test the
new permission/pre-content, duplicate FAN_DELETE_SELF, open_by_handle_at(), or
NFS/export-filesystem semantics discussed later in the thread.

Tested-by: Daehyeon Ko <4ncienth@gmail.com>

Thanks,
Daehyeon
