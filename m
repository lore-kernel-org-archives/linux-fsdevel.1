Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793063210;
	b=cHdJqr04nAjt0Um6L1U5hjeUsNevIBn3QGSJyspa57xkv2EEy7vRGoNd5i+Ysooba+ZO
	 Ml7NkijyBe4ZIgKsaFCeBYMq9zNri2DAazx/838u3zzkEGDk4vynsT9LqYke1hI7nFV3x
	 Nt70mxHxraoNtPBxxKwo20scAfujqM/msb/OAP1Otu58WJLgjkNqjpssT8Od3zLc5FnNv
	 VjXDzFN43gShWDC+bkz73xkMQL+t81Hfv5XdVTAGttlhsc24YG5uq+k8QBlfZA5RN9lcO
	 pGkxHrexm+9e5dTtYH1rWt570PN44f3/Ot+LoyHQCBKwGjIgrvNCOso3f7PoJu+PvzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=aJI0hb4/E//vLxc2EVc1E27ZXseuwybs0SN1EQUknec=;
	b=RxOTFxq0vjt1EFWWRGTtMCROAjGOquq5QBSHISJHY8stxcw4pdueWK8Qd+5kCHcGhnQJ
	 6l7k4DATiCTD7VC79R2SiSC4PwscXHCxhSKmi2Ks2prMH9249PiDOfbCvjDvW3WRPV1Bm
	 ZWkAuqM93VZY0jEpeqn35Ms/i99FtQdmoZ5H3Sq2rr4DuEfP3CjDfi6JKH5NHWrvrOUZk
	 G/CFblyRtVsh0xSoMav2SKq/bKPY+Yblr0bAobSYJoLaJbgTck3/OimXXkj7F6SMBDyXW
	 bTohmS/WnMzKObYFdA/CSC6DtCRws7xait0CBxgt5gsRLFyzJHm/tTd5adTZ0A7Jj1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LTXvgnV0;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90A606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 01:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C90A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LTXvgnV0
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso5282859a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 18:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793063209; x=1793668009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aJI0hb4/E//vLxc2EVc1E27ZXseuwybs0SN1EQUknec=;
        b=LTXvgnV0kKaKCac/NWTDNj/xLVRA12SXR8oBYGVw7hB46ZT57gB4fZwYtR5nCCblkS
         peP+RjAszOk0dm1T6N+uNlAtD5zw0eE2lahff023hj5G//C919I++TvXOZ3DarXuZCiY
         CdA2bEl2sIvMMKXBmf+rpvs6JbfEPu5km1R+tIVnkFUnKRVdcKmH+9TFh7Z3Gp5SZGks
         0xu37F04qrnh8fsQxonydlDd+TPd3e3MYXPMIg4lN2SvnxV9ntsb1E0EcMW00ZocSO6d
         tuaikwD10/VduwJNndzh735UGS98Jmu+qk9VwbMuzMXhmtJEuPN81j0LyK1pZmjCEjSj
         z4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793063209; x=1793668009;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJI0hb4/E//vLxc2EVc1E27ZXseuwybs0SN1EQUknec=;
        b=qldNHK4WX3JscfrpFIeDC7w3kyhYrgTKlK3RtMHyQlSx2KspuQZR/0yJuPb+rI9Bvc
         1A0l+uMa6S2TnItJc1RJjl0yR7NlSy6vG1y6BGF7a2+RC5PBn/TouyqU1vmhmJiqpunI
         K32SYRlmEE8/xZbuHR12I+za7kV8Jy2KlsszuOmUT8y9CPdL8GWGSF9JPu7/MiFZyRNG
         W2N9TRlDpP5v3FIJOju01dug2CEMGXMUA2N+ifUhTQiSu1PbhtLMWsJIR6VnaSf7/Bu1
         TgcTsskRENcV926Z7DBeCpBy88hevhtHmgYKe+WmWfrfUSBj6jAT4FBlXMnCJvGgv/by
         khHA==
X-Forwarded-Encrypted: i=1; AKwUvBxPvhd4yDo85XXQZPYz0wxV/l6bMNfxYS9dqEHTtSCyM7PCtHJ25XwS/l5Z96XG+zUTRAIjLLvD/t9pb6Sb@vger.kernel.org
X-Gm-Message-State: AFq9FYLOap+lpuVsyPYpC+GuQ4i6n1Ylkt26tx6fLsKgXez9hdbQV/SC
	H8ImQp4oqbyFlAyiUeF2EKIGLkznwRXhTnrUJBNaXbLyXxhW7a7aE1mP
X-Gm-Gg: AYBFou2PKx+szMxTYtfwZ8jg1e6KVAbjedgjxmS0rCRwu70vyqr1DxuOwnyY/ZogKTx
	RtW7qGyybG5IbRXxCXX3xiUQITvDqHpOTDCw5V3/A24nU9aDlB5mKjKXdV0vynsNsOi8HuuIMjY
	L7OQnasZ9hPLVH+myrTRhI/c9SNTRFm39AgPoAB3JcIVceq9kTssEfuC12ssEdD5hPyI0Hx3laO
	CZkXvVzrozKGNzT4UViubbAkK3FG7FQayI4tuYFDkVyw9f5QXh+xEBW9TjRhZELra4/TIBqHUJq
	t48MPMZs8Ukv1eGF29kpGB64doOYeIsbHJf8Wc6VhT0Zca6mkSU7rG+Vs55+ZQfUmuEpzrr8yhZ
	E0/Ed/fHXKmquw8wf8KG4n2m+ZVDm/yy21PhS8jZSDWUN3i/LCRwh0Ycyuhg2LGkqcY8j3mrZY0
	itcCbRTRqlKpwTb35zhD16gIbvLQ+OEU8zGgQxDOoJWrWZa38uuGJQ2ZFc1EOrG6VieVhcRrGMc
	PkTEsSP57EOXqCflHkl9DqXaPM0WcsyYOs4H9KxcRJt8PNDTIJW3zjOpGRECuqiTh1CSRFFfP8K
	fZJSzqaYTnvu/z7ZXDfuCE9xTh7oBeu0l1jxRxUMtI7uDjSG26CBoGvDHJMKeceBcb6YPmoW+O+
	LN15nA63dbewZDvmCJTqAvpSeJuLSltVtLpzIb33bLArYQBXwVu4UPu4ZJonISVoZ505BfjqP8K
	6CmTACRsy78h+2cc8=
X-Received: by 2002:a17:907:160b:b0:c46:6a50:40b7 with SMTP id a640c23a62f3a-c46bdd690d3mr894395066b.10.1793063208643;
        Mon, 26 Oct 2026 18:06:48 -0700 (PDT)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e7c94sm373434066b.27.2026.10.26.18.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 18:06:48 -0700 (PDT)
Message-ID: <7c8d96bf-368d-4272-8cd1-94740a2e4a84@gmail.com>
Date: Tue, 27 Oct 2026 02:06:47 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] kernfs, autofs: fix pipe lock cycles through sysfs
 stores
To: Ian Kent <raven@themaw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 driver-core@lists.linux.dev, autofs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
 <cover.1792577179.git.krystianmkaniewski@gmail.com>
 <dc65c28e408d6b64d4b13b7ad30e5fe70ddaa441.camel@themaw.net>
 <4f56c93a9fc5fee152364974773df0a319c84af9.camel@themaw.net>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <4f56c93a9fc5fee152364974773df0a319c84af9.camel@themaw.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

One additional detail I missed in my previous reply. I reproduced the
warning on the unmodified kernel at commit:

        93f51579e7df248780214094418f205253383cc5

Exact kernel version:

        7.3.0-rc4-g93f51579e7df #1

I ran it under QEMU TCG using the configuration supplied by syzbot.
Both the unmodified C reproducer and the original syz reproducer
reported the same lockdep cycle.

Thanks,
Krystian
