Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793493545;
	b=w9awM7vLPUTGUFMUm5D0lS8Hf7LYerzOdVm1hh8OzwGV0kyARrzu5D0Rw2yATB0nBhji
	 l8KfaJPZ2V1NLGufoWAJlH8UBPnr70QCsAjcDfmZC25mHCXQOgj5Y9TbiYnO8/f0DFfF6
	 SiYenRsdsoKPaRcHohAtDm6g4/XwUtF47WW5KOdro0zdbpLlNAbD4v0JlQrOMULfTBYvc
	 e6poGCFss0eP747HP0t9WANROTsmGMhR5jyiIPUx7J+ahdOq534OC8SZMMO2WYhQfmzLM
	 VL6PMgfbSJoYPQHEhz+G0NhrX6J2SvcElCNgkHUTTYHENGkk7ZJ+AeQDzWP2vqodRwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793493545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=pn5P7ttPR95Kyhm5wG9WHU65Xv11dOaCkmGNVaM06ik=;
	b=jvto2lJyIgiXz3Lv7SXw/TaHlWh72Fv7hAABrtWjIZ+rusOyCB5eSP0zCyZGJYM2iF7q
	 Vdhz0UlQxJK4q3DDVgVi1MzQeWPUurt58xcV8FFJr9TO3XTsySA3S+V7ou1sMiVofsYMb
	 9NW9YLFYedFS0uCUYWR5/S6yw2zHqgW+TLlDsQo1/NgFldtXjIxQ+DUsCIaW4mJJLIZv7
	 UIEiG2QXenL/Za8kUlTSIbuVbZzgdFFzqZhJmfYYb8O7acX7b1mqaX9o3kIvjg01YRjW/
	 NW99wJFXt9OJ5okYAMCl1HcXShQVVwuugbF+XOMYLy03+DAmrACgxk0Z+EP+YrGY6oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=d0vep8HK;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B71606A31C
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 00:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00B71606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=d0vep8HK
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8ab3d3c5761so17932267b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 17:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1793493544; x=1794098344; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pn5P7ttPR95Kyhm5wG9WHU65Xv11dOaCkmGNVaM06ik=;
        b=d0vep8HKObnTFnsR66HLeDGvpM8oCn4wNkX8DxHRa03Am5jzyCOWSZJ1etN1i4TQwB
         vAmXEVbz/7pYacqJmHGiHs4FdnoIJ5qdcwlwCUHxccsJduj0Q1F2OFnz65yIakwa8rec
         OUHffZOE+HheJ4H10jq0VeGvp2NjofhSsMssgjDF2PETojMXsvBcNNLwDr+CaZzVeuOM
         zYpTfwHomcJZLtWHYWooQd4JDmH52wIqkZprgh6NQ4wQontan1zxpwEbZBbaK3g3OMTy
         B8n9MtxF+Ckup/QFjyiYUxSGpI8YwKjxmporzVfYct2LEgOfNLyN3pPK32jFEw1IfCBb
         aXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793493544; x=1794098344;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pn5P7ttPR95Kyhm5wG9WHU65Xv11dOaCkmGNVaM06ik=;
        b=L1bYAdBVcmII7rKKMuF8JEI6yGvrS0DfcuIE8KxQwaB0Tsnh+U21Tz96okC8IJMVyP
         wW9ODPp5TuLSe7eZP7f1+wE65/QAVRtiD2Xu4s49SO2IiQEa81CL/6+m0IRSOMQK7hgg
         g8WTyQd711WfJ/6paW/Omw9t01jdbzUB/m3xLd6sLUqxgUTgaryiHMljWi9MK091FaQD
         k/dN1r2Oe5iYoAf4S2ayZ3GeOeeavpzB8XXMKP2O0buGBCd5TKQK30D1S41/w0feQYPa
         l3QPLwF5RROmIdVFHCBD8tPtgcNQ9az49wE9KI1LqJf309bBd5KB8478Su7MuSpE0yLq
         GeTA==
X-Gm-Message-State: APuU4Z9MQZvzs/fCg3i/Dfc8wzNyyDURx8wojxsxMntOrh4yDFFRw1Wh
	O/EcsxSawAahDGuj0T+E9j34hkUMRq3S5ca1vTf6f2bIorCzv4XltMjt/hX4TiocMPc=
X-Gm-Gg: AYBFou28z1QlPKU6ZxjRqeyykC424jdfpLOWFcGIZ4P6LkSB+UmedKpn0JDiBShRwap
	kff9sqlZsa+SPd9gC1BZT0Awh/zrsXUFXK4k6j1zBJ4GgkbfH+d8acSf69QzQWEpNpcz5w6VkEB
	yXpnwMXmuqtHX7wE7VTMX2m6ctxR1PXPLopKz8P9qFe1PFPl98iSCzM41jGwRUBZS/VqkgN6E1R
	QGBsvccAFhiRo1caXkoFsIbyC2kTRmGfOxFMgsZncUeoq6wzoGU18MY+Fb+Z54dgJgygAmyOnAN
	q8jq241h+8LeBNo0IV0wmAyNWnLPb6d8ivQa7svqaUTJSlO5w9ybzS1NaYVgOfvuM7kgOFWi3cC
	RQbVkn3gi/dW5GBJfGd5cJMoDznsEOP+/SYMIBBmgJPijhR7dwTI9WmVtC6jIic94bKzwJbF3ku
	+oG060nv4MrybfGr56+/O/+T3TQPVt+3wiqm1hE+eqJdsei3Wcx5iziufa9QQr3KknbXOb6i04k
	Z3O5clR0cuIrjZJwKgqNpystPXfCiuLSs4Dq5EGThNoGh8BU+ZQGmjlpxH4Lwm/ntYmVEee8sU9
	NAd+GMNtCkIfkE/Ki/8NMNmr4blBEfGRpZePvbMSlIJj+xJARCyyHJhA7ZQoqnzdI7/ke/lMn+h
	HPwZvFbsZQQ7bU+HS1QzdBNjVFTMBtdNN+fLOFSN+tnlGqVIs7lUbBt9izIhkloZFsKhNUTw43I
	aEuLMcNqZLpf4bKmeoNSM=
X-Received: by 2002:a05:690e:11c9:b0:677:c78b:f5c1 with SMTP id 956f58d0204a3-67ba4c80ea3mr5137552d50.4.1793493543967;
        Sat, 31 Oct 2026 17:39:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:6f84:fe3e:51d2:f3cd? ([2600:1700:6476:1430:6f84:fe3e:51d2:f3cd])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf27263csm2233760d50.4.2026.10.31.17.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 17:39:02 -0700 (PDT)
Message-ID: <7526dbc0d720a2d13b8a1d9cb7ac8357648ed6d4.camel@dubeyko.com>
Subject: Re: [PATCH v7] hfsplus: fix null-ptr-deref by creating hidden dir
 on remount rw
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>, Deepanshu Kartikey
	 <kartikey406@gmail.com>, glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Date: Sat, 31 Oct 2026 17:39:00 -0700
In-Reply-To: <179340981245.8403.4135841764755575334@gmail.com>
References: <20260717135706.42918-1-kartikey406@gmail.com>
	 <179340981245.8403.4135841764755575334@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-10-30 at 22:23 -0300, Joas Antonio dos Santos wrote:
> On Fri, 17 Jul 2026 19:27:06 +0530, Deepanshu Kartikey wrote:
> > hfsplus_reconfigure() does not create the hidden directory when
> > remounting from read-only to read-write, leaving sbi->hidden_dir
> > as NULL.
>=20
> I independently reproduced the syzbot null-ptr-deref and confirm the
> root cause: on a read-only mount of a volume whose on-disk "HFS+
> Private
> Data" directory is absent, sbi->hidden_dir stays NULL (it is created
> only in hfsplus_fill_super() under !sb_rdonly). After a remount,rw,
> hfsplus_unlink() -> hfsplus_cat_write_inode(sbi->hidden_dir)
> dereferences
> the NULL inode (inode->i_sb) during rename -- the reported crash in
> the
> [0x28-0x2f] range.
>=20
> I applied v7 on c339f4010 and tested on arm64 with KASAN, using the
> crafted image from the syzbot reproducer and the equivalent sequence
> (mount -o ro -> mount -o remount,rw -> rename): without the patch
> this
> oopses in hfsplus_cat_write_inode; with v7 the remount,rw creates the
> hidden directory, the rename succeeds, and the KASAN splat is gone. A
> normal read-write mount + rename is unaffected.
>=20
> Tested-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
>=20

I've reworked the v7 of the patch addressing my concerns and comments.
I will apply the v8 of the patch on HFS/HFS+ tree (for-next branch)
when 7.4-rc1 will be released.

Thanks,
Slava.
