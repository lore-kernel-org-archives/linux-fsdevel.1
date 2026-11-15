Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794767297;
	b=R27V2aIAD2j2lGMrLiuwLH2c6RRBGDarSBfuKpQxna3mQ8lUwLj73rhhn46nXZv1dwKm
	 W5GykTUK2P04aFo4RCEj+U1091E8ryY8VXdmhbUz5REAcGuF3+DMfO8nZLreRRPGNBDzb
	 nqy60KFqRog71GcEXTlpxlyfoRrkJc1vb8qS+NP9UBfPKyz3XsxfMvszeDurAPoDSM0OO
	 AAtbkecAwN53rVcMgyHzI4QEEuX1gSgZDztfONggr7CsQAIXgGp5mZOcEPdP1oT6s3o14
	 wy+O7g7m6qIbtilaFGRq9G0cNxFnCCXDc8hzpKb5Ejh7JwR7TKzcjbrTVTGkjOB8xzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794767297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
	b=QHRvELZyK7JiesWrDMqQKD7jRI5STKMoJ0+aZVUpYwswwNemviBZD6HPLND0LfZFvSpd
	 ODuH46jPV9ZD+k3gy+wifuSW3fn4SUWsIg+IZf4qA9PxJKGe8naSTtuQkI/NdXPkrtHmH
	 +Q+Vsa+ZieWJGxA5yOy1pz6ykD63g1RmEKmJ+hMCt68td+29Eb6GNILph3w6RWiLT1Xb7
	 kpLhQIeeAme+wfRlQ3d6ICi07QVsyC00g0ylX6aRG5UDaezkxjvtDCaKgPgDR2H1GXhHw
	 fEVsh1Iaw5T/zMcVvu/mRYYuXnIZ3FEBfgz6tW7zU0LQcLfO6wcrAyKwzMuh4kd/EbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBV5nxYv;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C2606A32D
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 18:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 592C2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBV5nxYv
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so1253073b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794767296; x=1795372096; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
        b=HBV5nxYvdpLlRvsxsYLbFKr5P34f8mj9a/XJil7dVolrFQomVVkyecHxP6BgFGwDxs
         /19GzczoyqLC7fuxmwJyN2rwUymD2CerKLMnjfS/2CRMvt+ynLs5gkxwuVBuAu3q9J20
         IzB2wBplZLjMFwEGGW7prCWCSa7Aywa/5h22qXYWy2au5OKH6AKODohFFnhhSeGrFYHI
         n+FqPiDDYHHddi3JAW7aghC+X3tcMJhczYrIX5Hp62B1gpJjhhKWZLANouBkWkfFg5wA
         r6zaGmjBjVlFtwZxS8OaoxZbnmYU5uIROK1UqsDLBtdOM41dsZCnP9Jsrl/zETDD4H/q
         kP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794767296; x=1795372096;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
        b=LrrxmqDTBj8CcSAMFl5f8RHIpD1bitmg6AVCKAFO1PgglaD7qlzv+cDK4dMXzYkvL8
         +Q0MOvJjjzLh5b9XK9kIH+j4/Y0tt5+lm8wFeBn0gyUoX9c8yidFVhv5NhEu4o4ot6k2
         4EwpPUABDaCDcwN3969xmPsHbeaCbMQZ4eICJCWxOOQyuHeHPfz5Z1ll7EOlZ77HXgoG
         hM9Zk6VJYHp+61RYHTAcf06dNsLN98FA2WmChv5Otio3cg6tvRdaa+b/dOMVMKqiVSh7
         JrsRohbmjJW1UunlT/LSdXZEfYf1Ad0YuSIFXDgsmLeb2UPdOc26QFRpSFHXGOQMiLJR
         aTvw==
X-Forwarded-Encrypted: i=1; AL+hErFvqn6JaMUtNGeQga/p2P4+Rc4er1qz60Pf7fSRGk8b3ppHXkb0ajhHkad1/aM/8pvkp/+SqYGH1JOQUVZg@vger.kernel.org
X-Gm-Message-State: APuU4Z+NDlvFN88ZXRS+WMj0cHAAxJ8tvkfoeK0VEFy8bt4d5CNttsFC
	dX/fdajMVdb3Z5YgA0vhrqJboK037pHjWyn7Bb1X4kxPfgn0NnWbxQ7H
X-Gm-Gg: AYBFou0LHzeV2frMNLqAAlXbjbo0aQCwEy4PUOBLllOyRlmOsFQx8W8Dp0QsujA6gm/
	XeWbgtoCITf3M6slTIksIt+KAmopZDOYeSi1/mAwUhwhfi6uSnqJKKyJNBQkdRUkl0On+L7Ms9O
	plekkc/UeXgaipiZkWkWuzKjRcVZyqfz7Kmx8g3Br2xNup21CHs1zku5qEU2P3nvro79PcN/Ysn
	OLCoFLlM46pG4xcbhMaI0U7U5AJ5YyHjFWmxmGAe07NnIA3xmm8PAmuJGrMiiFLgdWBE1SVGC98
	x0fQSucnlxoj2c6UUDww1zAyFWFcTZNxoJy8fd1ThpPazfiNr3jV7Q0uxTxHyla+Pow6IiYRziI
	ed0fhUsDQK4jbuoiAaekp7sCDBVqDmj1AWeXccqfM/xhJmAZdpAn5xJzc32Lq3IUoXFcUMH/pKL
	VLjI5ZTtzPY+zj0aBtUU6u9d114OL05/vR2Iv5P+lk4dJVJ4PshwX3Ch+AV9uo9e9Y38/7Vi71g
	+aquEK3RAzKwfboM3FYty6K2k8HV9OuuqyV47WrQM2LB4zN0XzEv//IlcQUr9d0EdVpgsRn0SWY
	Ffis4Ts103YOjF8VK5+giYjQqqZ/IQCcHin++bAJxar1PAw/e2LwkJ9gKx2Fb9QClPx7Ma2fwsw
	oyjGz5uNAe82jHgXFnEvs4/7Dow2GULZ0aQ==
X-Received: by 2002:a05:6a00:230c:b0:89f:d620:226 with SMTP id d2e1a72fcca58-8beb619bec4mr7100607b3a.24.1794767295502;
        Sun, 15 Nov 2026 10:28:15 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bececcce6bsm2804318b3a.1.2026.11.15.10.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 10:28:14 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Nov 2026 18:28:14 +0000
Message-Id: <DMVZWOMFDBX6.3HVETC9L8RUEU@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Amir Goldstein"
 <amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>
Cc: "Chris Down" <chris@chrisdown.name>, "Miklos Szeredi"
 <mszeredi@redhat.com>, <linux-unionfs@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH 00/13] fs: let d_real() fail
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 15, 2026 at 06:01 AM Christian Brauner <brauner@kernel.org> wrote:
> As Amir pointed out the correct fix is to teach the callers to deal with
> an error. So d_real() may now fail for D_REAL_DATA and all callers
> handle it: uprobes fail when they're created, IMA treats it like failing
> to hash the file, IPE denies and the bpf kfunc returns NULL. Then
> d_real_inode() goes away so nobody can ignore the error again. The first
> patch only drops the WARN.

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
