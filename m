Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795393279;
	b=ekmKiqGaobgEYG/MQtGffo8NrxzTZhc79Vxri5OOHKRlK+pXBAvpeTx18zzxVIqjBvrJ
	 d7Zq/c5cZ1X2dbtXznhyHOKMp0SbkOvFzMl7iuDqKOBAhhfLPJVYm1lfQ+9/6CwCCQ8pq
	 PaszgSo4bJxyIQJgkH7ycwgxSAUCuzTI0g1kTbXRXouuPv14co1ZzaH+/X0vpfrA2KHJX
	 g0vSjQ6KdOJViBLXH0baDkS4OlWx4fzpm6Ju8eI6NCQC7eF1g/XFt7qMu2hVLwixnqImZ
	 LRg9T5VjLev2L61+VUrJNGbY0MVRkEv8QuuSCWI6AhviJMQ/NvyzWD6jFa82/3PUXmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795393279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=KF23iyWwR5yZnzbUCvNMaMixSGrIyVPB1oghCsOfI4k=;
	b=UmKWfDy0E11vFtXycL7Edxe7NnEOyR/8bTGx9cKgpqZvalbroRyfERbI3QbeR4xb/AG/
	 pCK/DXmXyLmN0i1p4iAEt0kbE/6VGQjh49jAFX7vUmsZLxjaGx1GeXJNC5PU6BKhKsZvM
	 U/cy7wzSiduMoA1F3j+pVWyPYFbHtG4Fogfngvuhc9tfJYx/Yntl2rKs+5wPatEkuq/+R
	 Z0EZ455YeNuMRniid3g3qn4QbK/MNUEsXETIQHB8qyWJTDPwMi8K6yM1OYzeQRYS9n3EU
	 jzd/Q34QbkcIrpLMiXAzu1sSijQN0toiFqFs7eJGtdZOKJRWS+lSz5hPjRS3MDt1uYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ui7qLXEe;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E61606A32D
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 00:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28E61606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ui7qLXEe
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso970061a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 16:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795393278; x=1795998078; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KF23iyWwR5yZnzbUCvNMaMixSGrIyVPB1oghCsOfI4k=;
        b=Ui7qLXEe5JZSNGGNnJt8YRoCIU9BozHUuGdwiGGRpRdbVOmZeySJsVDdurWv9z6VuZ
         VmOigNcxpt4gus56H5t3tfeT+jMthzm64QEJc2zAee84tuc3roRSTwD3Kv0m4dUfr0F+
         4ugqeQMPjbgSS4cdMlpNKVGn/lbd6gTEqFW9TDBlFLcgP5yn4h8g99RzjC8XXY/+LFBY
         IwZpe4ZfiOfxC/PDMkHtsl7/7xATK8AceJkZH0IS98SuaBuBBITDhuqsEsnfsOQEZ/PP
         u3myvmJEKPylm9aDUWQ7+IckA8eVXYDNm+iIKJa0jJHfttZyD/rjsrlkR7z95OGmKQPn
         RqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795393278; x=1795998078;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KF23iyWwR5yZnzbUCvNMaMixSGrIyVPB1oghCsOfI4k=;
        b=bi9H4h8JkRI3WDcFgAp6Y2bLXrlRHHESw66cApjKw/nanSHUpw8/WRPEUfFE22qpKw
         Ykky5w1HUh9uVjTEYCOogIjf2sxbh91vEkIZ7RkOtugpfS7jsUMOqiMhM4iXc2UB/2JC
         lgV3CA8oquLUm2T298WpW7BwYJYwGnYVQzqdcb4kozqErapQJEk2sp6BB3z5FQPp8cY3
         iZX60qLcETGaBOpZ/iRAF7cdNESJcGMG8sQKx0wqGTI59kRVNibNrcAdq3VSITXHtNzT
         F3kwE0tM82RIV4HKME+yKryTWV485FBQlZbLekUuQoSPsBdZgFJxR1w0wsj+/T5O69v9
         b7bA==
X-Forwarded-Encrypted: i=1; AL+hErGEGrYfPEJHdwixXPhD4pkUJL+blCvYLhqlvsx7F6rVfd9yfjnKmfAxMsfqnE4hbAK1+w72FRw+a7esIsEn@vger.kernel.org
X-Gm-Message-State: APuU4Z9Macuzl5ZwftMGU5EpE+ybXLGt4L8wZTtm6ZcZpMuK7QBleqUJ
	rT97JO4Ihc5zxRuCBa86+RUwawO5BJjUGWhcQESswvFtbWo3IcjW7ydc
X-Gm-Gg: AZFdTZc/7Y5GZeSDm4cz8jrkXKENpxtDIZ7/vMILf7uJySFOyF970MDqIXYZc6lBu4M
	S8UquzAEjs7ER0rIZ7DH63WJHYZ6RnaTV//Ddiyx0woVLgaJ2EnBp2yls8M6F8FUc42AEf8Oj2P
	b9Sb2DwT3K3e90C4vJi/iIW855qLaJRuifnHxx65PEew7JAlLyTq5egrDemhp33cETE4yq9Wrhq
	2QgXiiYyjfVGyDKh4YZ4gRWkXM34sY1+B1hcRKH1KrArjnc4DdqahN/3xkY3Bvs2s9668VL14Lg
	6Dp/UG5aFm0nHbaLLo/qMv8oH6ZpIfXZWsLVUyDIyIw7a3+Wl5JY5z840SkJztVOR1YMygMgdWa
	XryoQCSz0mAwq9lzUCDw4xCYwMHLeCSNnxNCS0nhUtyTp2ZB/TbkMn3qivnHsNne6/veFt4dZF4
	ilfn3Qo7mpFO3oowOr2wccj+QuY8KUUC50sjglLH3r4RS3+pnOOKwfamFmryL7/0Sldq2ZOIKTk
	8+Mbqo+29oTNXHXsQbgwAHEWZCld7+FYkoqUMwVurAcZY50PQgXzOpWyvonw8l3VonNpDB+GbxM
	YpMc9CJhWpKgoLQtvEktPX/NBdGp9PXAfcMyrFIl6qv1Juve/rj4d7eSS83sL/JYYlUfphSEidS
	Zy96cY1YxrwRdPUWNnZERHC7lLcua+p16NeU=
X-Received: by 2002:a17:90b:1801:b0:3b0:9984:18c9 with SMTP id 98e67ed59e1d1-3b41c8e16efmr9088622a91.11.1795393278264;
        Sun, 22 Nov 2026 16:21:18 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b8733e6sm4860403a91.3.2026.11.22.16.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 16:21:17 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 00:21:16 +0000
Message-Id: <DN25ST0D5K1J.1NI5236BF2BPY@gmail.com>
Cc: <bpf@vger.kernel.org>, <containers@lists.linux.dev>,
 <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-security-module@vger.kernel.org>, "Aleksa Sarai"
 <aleksa@amutable.com>, "Alexander Mikhalitsyn" <alex@amutable.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Andy Lutomirski"
 <luto@amacapital.net>, "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner"
 <brauner@kernel.org>, "David Howells" <dhowells@redhat.com>, "Eric Biggers"
 <ebiggers@kernel.org>, "Giuseppe Scrivano" <giuseppe@scrivano.org>, "Hugh
 Dickins" <hughd@google.com>, "Jan Kara" <jack@suse.cz>, "Jeff Layton"
 <jlayton@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Josef Bacik"
 <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "KP Singh"
 <kpsingh@kernel.org>, "Lennart Poettering" <lennart@poettering.net>, "Neal
 Gompa" <neal@gompa.dev>, "Oleg Nesterov" <oleg@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Serge Hallyn" <sergeh@kernel.org>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Zygmunt Krynicki"
 <zygmunt.krynicki@canonical.com>
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20261122193539.3334213-1-jarkko@kernel.org>
References: <20261122193539.3334213-1-jarkko@kernel.org>
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

On Sun, Nov 22, 2026 at 11:35 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> v6: https://lore.kernel.org/linux-fsdevel/20261122011809.2667684-1-jarkko@kernel.org/

v7 was sent 18 hours after v6. v6 got replies from the bots only.
v1 was +2559 lines. v7 is +5782.
All six findings of sashiko on v6 are still in v7.
None of the seven versions got a reply from the vfs or LSM maintainers.

The way you're spamming people you're only reducing chances of anything going in.

