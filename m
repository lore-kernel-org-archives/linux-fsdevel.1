Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996406;
	b=RIy2f0O5fdCzz0miqeH3AiPf4lcxfv3Aig2cYbp2tzxD+io6jjjnbz1IHX08ufpZ64IB
	 y+RU32kJoRgVFWKcu87qb/IjlVUzh2WXRSxLB+M1jIS1H6eJ9svzLJqLquf+gWSjJnOIG
	 cuKOgrGMA23j8DCvfUEFyOgu5DRLUXXjBjDXZ2GNpsdWF6TKOzUAqQCJdPoKrPZF7N6Eb
	 r9kyjpRKVauQqc0Dr2zqOSf4eIOeswTz26YVOwSPYqUxvwtqMPxZn5M4aye0xsSM7sFKL
	 ALR8O+8wIsRMLk4axIcjT+Xd/NlzHpxFsxFF8stBeVYDu2TVX9KDWS8++gTr42YESDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=IGK4DQjcIX187U9vI9ioaxMrjg9ZTSKqMzVUmGClviU=;
	b=TEkHlzldRMc4JOheLX2LsBhuywOoz9NNAhDl6b4L+vtWihd+V1UHjXjToJ0a1Fkbhuz+
	 K/Cteq9OuX1cvcZuTcyRScnQJtBKfBOpCvZYt1WLF/0FMjyv+TjIZ1eanR8V1SwRJOUl4
	 DRe+4GzWVCy8UrvZPendFMKYipa095OLnbRAE44vivOJNEecZzh4ypgPcSOBoH+xYPW4E
	 a9yC2VZ5Uhjjja6Z4wuT8EztP2LdhYdHTkbjFGfhtILFwBUmRglMeKI3TOhelth8eYkQE
	 Td5nnze4CKqEbRnGt38rAIwv8lB4ApAV3gUMEzKrVLrs3UX8xsaK24wbDh371N2QTjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=hRhTLQV5;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB8606A329
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 20:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85DB8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=hRhTLQV5
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so1288317a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 12:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793996403; x=1794601203; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGK4DQjcIX187U9vI9ioaxMrjg9ZTSKqMzVUmGClviU=;
        b=hRhTLQV50B6IWErTtrVVNq+7KVVENRzQF3wBEWiH9u3Sucp0iVU+VUsKh4z3HIu5vU
         pq6VmUoBaqHfiNHy9giHsbE3tlbfaGcLcW2MYLpNk7wgm/mM2t2V3qndkulvOf/dk1TM
         ahADn/v32B/35/OJZ4dbdKMN9tzJXDvx3QbcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996403; x=1794601203;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IGK4DQjcIX187U9vI9ioaxMrjg9ZTSKqMzVUmGClviU=;
        b=2IQxy4yaIwIQNTWw4RwceMczQnP+GS0smVSN3Vb7W7gcZuf9dQ6Hy43QsA1Tr04fkf
         X6Aep/sm6e+0VFcITMmViFxiaGLzILMEdsAOxq37bKAmWLuvx1AW0pUC1jkSaS+UxUqt
         VX6/epvQLCRD2gYTa6IMzyu/KBjl6tw6dbaySQtndeyRl2YWsMjfnY/f47HgZ9B9Ra4H
         c5izbgS2KcSjEQKvHUwVsDyy/OfjQAcSSsv8G1OXte7VUsBKa6+hdQXrCsEiA+SpAod1
         sWamlyLM4b9x53kz+pz0QONgvuhIU0fHfVis4Ymret3NRy/DRGiRfDtZUE1/ER9okpWz
         w/jw==
X-Forwarded-Encrypted: i=1; AL+hErGSXtKp6MkESwsgcBfgAa2AiJLHYIlGQUK7s/JNhDkZ+oswzVGPwO8mXv00rug1y/ZprSBwCdMd0tuqd7Iw@vger.kernel.org
X-Gm-Message-State: APuU4Z9mLmpmA6w8CUqvSXb4h+i25dE+LRPSLXKksR35jAnka9mBfLJm
	siCUdSflsX6VN0eOjAbo7hwBWbLnZV5fWjlMvdF3UmQPiim7fkzNmD7VbrYc+jRamJ2KV48s2KW
	cqW3++NTfUQ==
X-Gm-Gg: AYBFou0pCfgArEybyz/3DkBFth3uyxgz6QARWm/0lAK0p5p+OBgBgeK3UfXIWqzjpfp
	UG+QEkHEFEUeJpg8bKd3epWlawdIQQdOpB7HxbySgQxeRwX/CA2h0xgpRqlvOHWRQXkWtlFPdFE
	95M3I21v2XR5L/WQm7V4v7DakcibdCoRI9NLZd9U324VH5odEoSLlno+Q8M+Sej2mGVzgo7kGCv
	NVUej+hZor/TV3++t2hLKv5+USbTIljo/udu6t/ptckBsrhKyxor6+oTI4pQgX5JaAr8BtZO63u
	oGerdlawZS+NnPt+ILc3/yCewDVOo5TsA1GaFahRyPuNl9Kt8JxQRXj4xGuDpcqyGv8klH3xcXH
	bfQpg5HP1KaShihlhswiVoLAZt4LrG8DASNjreVLJRGwJc7abcEAguRTQ+EyMwA5aRdd8jqHIUZ
	YGQbst7NRtKlG2SY4ht46IA0mypfVvhh7wIJcHYGpTn7ck1FKKl3p3INImT03bfiByVban6vx5c
	ZXIwcLkK1ZUXWXE/oX2t2ARMDjSztMIRTOLIqwEKWc1/NChHL/MUd2HvENT3N7MMq+F2wymU8FT
	J1mYOW0zfVhQcn2w8ATSR5ISV4HBxfMBXQcP5iTCZ3zzHo3M+oFEVy1X/zyJNR0XfVj+QKc/uQ0
	9dwSt/UU0RdBjQ4lrv5sCIkU=
X-Received: by 2002:a05:6402:3894:b0:6b1:ef5a:6719 with SMTP id 4fb4d7f45d1cf-6b597802f36mr2434276a12.10.1793996402957;
        Fri, 06 Nov 2026 12:20:02 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ad2cd6sm1065056a12.7.2026.11.06.12.20.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 12:20:02 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d21051042so146894966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 12:20:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxIy1mudu8696WnD+BbAxKB5LznIUPN0FjAULUSmaeMNnB6nJqqKgEvTFz9t5pcSP/i4u5YRR//G/nFasKi@vger.kernel.org
X-Received: by 2002:a17:907:d22:b0:c29:659e:2fd2 with SMTP id
 a640c23a62f3a-c4d35519e9fmr286852966b.27.1793996401983; Fri, 06 Nov 2026
 12:20:01 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
 <20261104-allein-bepacken-hitzig-5e517d3c129f@brauner> <20261105-genehm-dachrinnen-infusion-9cdf4868d32e@brauner>
 <CAHk-=wgLpWDjmcNWphCMkKXKwuZsa8KWRPvJ4j=C_ktCL4gBzg@mail.gmail.com>
In-Reply-To: <CAHk-=wgLpWDjmcNWphCMkKXKwuZsa8KWRPvJ4j=C_ktCL4gBzg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Nov 2026 12:19:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi-B--TBQuYjz6J6vKtEMpNSm4_wVRzTP_vE=uTLb7P5g@mail.gmail.com>
X-Gm-Features: AclHuK94jU-Q2Wt87Ad4tvQ_sMRVW1xDG99ONHJ5t99rOlTRyHhYCt5Ue-I2zS4
Message-ID: <CAHk-=wi-B--TBQuYjz6J6vKtEMpNSm4_wVRzTP_vE=uTLb7P5g@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
	Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 at 12:10, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It does compares 'count' to PROC_BLOCK_SIZE, and then after that it
> just allocates PAGE_SIZE and does

Ahh, this all goes away in "scsi: core: let procfs copy in writes", so
never mind.

             Linus
