Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.203
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795725271;
	b=tL7GAV7KedRGMNrI8rWTQX1su48KrE5/RA71fLigp+qju3CQfTHQpDMdU2BesITUpXrb
	 zT4waJlocl+UwhoCEsiDRedOZM07/NIkBboKzX1PrwmMCyLjdsBhzho6fHrpQ305ju6gp
	 /Dt5buwmX6gfnzFmEmbaTjHojFTqJbMJYkLrAuyxi9KL1tPZeb+NgVn5HWYc+PzfOCZgY
	 T+IXrJ/Hp4FEM0pADaX3O8s02iPaBob8U4CNPmNS161b38Hsm3gz0NQjEfopoow7w9Vt3
	 xTATR8xljrHSDPZDkPbbp3FGMK80EL98nuhWFKJRGBwaBlVzmmzh/+slGdzITTjDrFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=di3bN8TPtgKo4t9vFYgPIJtNT3UqOcDJowHuF819Ygo=;
	b=oH8fbMh3fubX45pqBGkp07isn6pHI+44hV94suZvUCBwA4BLdtuAZf5qaHtLJhapmBPJ
	 ngMZ+CVdBNj4bgmNgIJGlga3qFxtGDaZ69fJ8gGZinknhIGrJvIpI0m08ELXNJ+lxTb4e
	 4feFB6y2e8Owc0QERXU3QyNKYqa8nnCRNec+FELeacdUR6GdDl9Lc6/uQlsl7Yi/azPpA
	 NWVRP+6nL3OD//x9liRciZmq664H0NSEycwPDLiBj64bw6BP2KsVWSlZVgQD7ZjYxJpuU
	 x9pL4EtL9QEBorA37r7lqphttjgTWRQBudEbWDN7UAzxOTVKnxgO81XL2s7Wxkf3mEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uur42fxC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.203
Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AB6606A330
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 20:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59AB6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uur42fxC
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-568042aaf90so1060113b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 12:34:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795725270; cv=none;
        d=google.com; s=arc-20260327;
        b=drrmG8Eb4YHA1HWitXBi5NmuXNY4pggBonuwfzjGvQ2RhSmbI/vvhjCnfWWN4L998c
         veiELTXZ4vXwYK+aIvxaHFpZSCHjfSGWxnU4cQbjSk6MoSUO0Xsc6idBGjSvOCmdj7hk
         1IkUcSo3Dqt0LKxjFsX1w7VmpNZJm5Swf0YAIDo/+VGEBf215nRzBsqfFjj7BPfbfr2I
         gED2prldKeiusuyDdssfFYgSt6d5m+NawyNb6Ytvxcpr/mPgaN1PQ4AypLJL6TPZ67T2
         0nft/oYB+lYuGU+owL4FYKuV4u0WfGwNEYF977TQXRJ9Tdcsuqw6kPUBjoudnD6Swtjj
         PdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=di3bN8TPtgKo4t9vFYgPIJtNT3UqOcDJowHuF819Ygo=;
        fh=XeeM5CL3UqcpUA9UYwbU5XrpiHi9lFqW6A+GN+MtIoI=;
        b=bG/IOCZgRc+N+fyEuL1Ii2UL20HCy/dVfdAUmbXml8faJmq0mGU9b0QJJQOZMFFFvQ
         zg+reMTcty0+Uhe916ywKgW6dLr/wQ30bZ5KW+y9MhScUMUfUb60/kmBsMdCzXqsDW1i
         q8caDHOTIku6E2CMF3GTfQnWVFEkJV1wJOforprLzojwbXcjNuSJwuIZSWk+ZYQc+mnW
         h8hZVsbaP/DDuSN2wy34YA9N0DPFnb3xzl9D56gwO94+Tmtv2P7nm6AmKh6xk2yLDAPs
         tzlbpD21HL3fMea+PUD+BMg5AvovwBDNvomBG4kEIFAgfVIxKlvQc1ipdmsloOZ6pR/i
         U86Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795725270; x=1796330070; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=di3bN8TPtgKo4t9vFYgPIJtNT3UqOcDJowHuF819Ygo=;
        b=Uur42fxCErQVDiYgWsKaF8dmmmKy4JbHVbR4WBRfegN9yxGryufdu+g4xnFbfIEZph
         v/vJoHVkegwTYPi7Emfn5H9g3v8PMhueZQ/CnIOLCbM/w5Uyvj5Pxp9y+TNdz8tT+/C4
         9kd6riX88L1evvU5UNNw1K3SeFMFhUxyNW1hB445DwIrcvtzmdCTCi2+heFkfDzCF7Fk
         SCrwMmLIjyUUVOA78iXCeOor65sUMESkMXSQDLHT+RNVFuXXdQkREM47NXzwJYeuWSLz
         K4AMzS/yR+mP+hm5ilz8l0OoP9VM+Eeje/09DE206JP8k4AuPh0zfUpXpJiSkJ2Llc2a
         HTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795725270; x=1796330070;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=di3bN8TPtgKo4t9vFYgPIJtNT3UqOcDJowHuF819Ygo=;
        b=V6hhEaPfDMoAM7XajVQprrd3KyhJyFbdjuJ69kXHugZsrF6fYHnL5BMHzxqnkoOowM
         ab/nZAC8BIBrKGstlqHSQM6On8MWz0DyuL5DcmDmqoK/F6nN/rqNKIvZNqx86Z6LOjKL
         VmAdfx/qKZ+4Ata8a9nCDNAA53XKLURyX0MelgYGSh06V2vxD8m3bE3pIckeQSFzEyaq
         3ctsj3pBzTGV6auCmLS0du4aviE79W37tZgqxUmU4kSORv+zChN3qFrL1/FEPFj2BSqA
         5Xsgdzwb7SPkTsuZhISyZ1RJiO2K3B7B/s/tebkDKF2Lkr1RETCaFwxfp+wgIM9D6FgZ
         860Q==
X-Forwarded-Encrypted: i=1; AL+hErF1iZQYqpV1YCLR7g8/EiO/Z7s+ibY5ZDPK5XUKHa8S+A3F735Q0yf3vSKAZ1W6ErSCsJn9aYOuBrbY0Swm@vger.kernel.org
X-Gm-Message-State: APuU4Z9HdGS3kW3HuL2TNZz9rRkCaBRJ/QI9MSVoTuy1GmtT3AFAebTw
	N5+H2ke+tvpKq6SWa6PV/DzDNxnYV1uRI4y5hiuksn32JRdGfhtFNc7NyXXqSFEITD7LpamtpUl
	QCJYJ7g45BLhTuyX0ptLJmSd1+mEv9a8=
X-Gm-Gg: AZFdTZduSbdzjz1x6jWq8m/Su6ulW4UuC5Y32n1V5FBT0w/YAvobARzRrASJ73HWd/W
	vpSEuetRk1wcqW8qFHj5/AuZUTLZDeJPieu9EpBPT52FgWogiHMQWus736o6qFXYsXmh78Aradr
	qDmWgVz2SpsVBc71rGkePvT6MRDGCFidjOp3UCY8v8aiVNITFQpkAxsd+9/7STkGrZ9jbKrOx0v
	IeDoiu5SzEdC1iGyR/nr0p1QLpGy4VC4hccc3xKXG2xUlLQzZM06EjlGBjyjmDMd9EiBdww7aMY
	bLU3lqtKQ/FK8ODbSIqTXt+8vtuvGCtWxAcFaTo3snvDEPrPl4A3ezhlsDODMlw3pQZIScRrAtM
	LYOfFkUtw5nTNRkL/Wv7CVIarO+1G6x/xogTI1+hTuCVVD60F1CAztqJLPQrz56CXSQna7hUbzH
	zjbM7moEqWMFt2ynVk67bawXhQIDYZWhvIKQm458X4cS+Uk5oqmukW
X-Received: by 2002:a05:6808:c3d2:b0:579:293a:52ac with SMTP id
 5614622812f47-57a06a0f737mr23560243b6e.9.1795725270248; Thu, 26 Nov 2026
 12:34:30 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126045222.20770-1-dennylin0707@gmail.com>
 <awgPDmEbGpJsT_iS@redhat.com> <awhFQzXfWnDh1mKe@redhat.com>
In-Reply-To: <awhFQzXfWnDh1mKe@redhat.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 26 Nov 2026 12:34:19 -0800
X-Gm-Features: Aa3M54o9-WZCIMdpV3GauBo7bolCOn69ezMqv7eMAI9mQ5Mi_Dde3UYGSABQw80
Message-ID: <CAGEkeHeWU1=HjMX=GETdRnWkr-xqTBZp7p8RDdtTiUVw3+qBfQ@mail.gmail.com>
Subject: Re: [PATCH] proc: also check the opener's capability for
 oom_score_adj and oom_adj
To: Oleg Nesterov <oleg@redhat.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, adobriyan@gmail.com, 
	jannh@google.com, jack@suse.cz, sforshee@kernel.org, me@black-desk.cn, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 26, 2026 at 03:42:11PM +0100, Oleg Nesterov wrote:
> I just noticed that __set_oom_adj() has more CAP_SYS_RESOURCE checks below.
>
> Shouldn't we unify them or even factor out?

The checks below only decide whether a successful write also sets
oom_score_adj_min. The checks above already prevent a write through
an fd opened without CAP_SYS_RESOURCE from lowering it, so I left
them as they are.

I can factor out the common check in the two rejection paths in a
separate patch on top of this one if you like.

Thanks,
Hungyu
