Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168135;
	b=CYMx6VpYd9PE0BjGP1ZiXYChcMF7kw5vKbTjAMa6DYpyBGETrkGXiggilv+a5c6MtPV7
	 lHSUdFeYhCnYP8Pwy9PJ0acOZ9h997E1GyCBd+HY0BjxIqoXw4S7UMiqx2NqndcUrC88O
	 gYh8/NKxpSoGeF4GLeHtmXGIJQM3XB7fI1RH7Jd8G5w6dQgDh6TJFYs2WbVVyCgknZqjj
	 wTPum17VcPAQcuWlkT4Omsn6SPzjh+Ad+LvCCw/Rx+I3hUgqjrNpaq5LkAG5ODYW9lDYk
	 E4tPFV6QffdQompe0aW8DjrxlJLT0CUam1+xmWqJU3h84LhMb2nvmptDFjX2pbZYEOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168135;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:Received:Mime-Version:From:X-Mailer:
	 References:In-Reply-To:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=E/BqrsiNEe7N9X/6LzAE99VV6mdYgIQRyh/LOdMxu5o=;
	b=BiAz+sNRDx5OkHkA4rRAlt6U+lbwfP6efFokZgreCj8BaWKrw9wtVeL5OCBaUhVTbew8
	 DGKBp87ZuOAHsZcD1LPEjo/8jIhO/fl2Zg+E5XSHhZnarH2IJ5TBL5klFGteqYS4v/V68
	 FPXhzxUJtuJY9Vkh7bbKw3eexjZ171Kax+i5ynxlNrkes0P9r05uakwmC0pMkFnZ+PAcX
	 Jt5GgYaTb1cDjGmqEeFfxa5RCAm/b2udsP9dQUZGDqYN8ehTMiCv1b7OxM7dfyS+45kHy
	 4GwatAjwG5TPAeGTLbDKSp53l+gCm39qNw5eLjZscE7iQ7YYrnwdxHOlt3/1DzyyLPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=black-desk.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499A606A33A
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 09:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6499A606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be47aa555cso788102e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 01:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168134; x=1795772934;
        h=content-type:cc:to:subject:message-id:date:in-reply-to:references
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E/BqrsiNEe7N9X/6LzAE99VV6mdYgIQRyh/LOdMxu5o=;
        b=FdjHauoPuDSz7AsfAHPqruhON+TYcwDV4TtYWuuEmwn1Hnd98BFYiere5lPkOsLmWe
         6B+vyeoozZkC6HbRxUFMUZkaDL5Ky3581dan7g5yvx/LTe5EFNoo82ibXb7ZvmDQRYVT
         lM5lAVg46MPOYgEknvCU+e5N3HBYQSAOByK+l3HnwfR+TtlMj97oy9x6Z8MOKwmiW2jv
         amcPTlWzSlLgs6BXM2Y5YgNLQm6QpfrJoUtNNpSLNiIjDKIoQjskQhdIegsuXv+OFS2V
         BRZrYWpBqANUCTPImJ6jgcErxO5yAnbtpzIFamx8FAlPeJPrzGP0LmoRAVqDJmsfhjTx
         jwIQ==
X-Forwarded-Encrypted: i=1; AL+hErFPoilSoLT51MAz+T8RwQYioVDijUAIgRhzdi6bdyC18c6a8MXm/ziryre1Uhj4E2HzNbCqZL7qMxEJhpPC@vger.kernel.org
X-Gm-Message-State: APuU4Z+wa/Z98HtGSWlzX0NPHvVGiY/rCPPxoNRv4uUm9Oe+HWztUMHh
	6zlP1XnCCkFuhqSiMoymHdgQqLKxfH9xLA63sGfeeMjfZzoy0cV0sfJfDA5ahcbwXgI=
X-Gm-Gg: AZFdTZeeviuq16mHQxyGvw8PgOiQl4jC890tQyHYUi6TMWHZ1fO7qDheJPRnfhGflYa
	q7piDfaip9BR6TuYwcEU6icNf5R0CvOmL492dyOKTJ5PfzhybJFLQCXpcTkfRUTeULUHH15PbXf
	GcYEs0nnysVjySHei48hVzb2E7bqDlKVj5lDZwYBSKKhtxS+p3SVuh9q31b3+ZWXgN7nB00WNMB
	EN3FSyZmFrs6zkbzsHkgVSfqRE18eyeEjjgN03CpARBJ+8L+NXmV/ZAsua3wf/muhj696WlEZQT
	pkOqwye38KIDsqb/vhe8tJ/fOSizpar+UsGgNfqZgB43nO2eUy7IQdqhD+B1IbuEwFqQe+SyA2U
	CPrSml3BO5AG4yIugfYfqFr2fFFZLNc7n1o+nH/6sMQBX4/cvS0DZuGZOZb97u3HN1rsNNxfaFD
	qv3u+X9HA38jPIdjwaf2HDqXb/YDMriv8o8JzOmj8LtH89MxwDMoIrAsiq3Vicc+4yngdLh1ZAr
	fOQhzJGTmoT2hWkA2XfW41/qqy3wZdYkb9AL2+fiY6MHcMRSKN7ScIXJVdghSxq4fXQ/Yc6/+81
	nV1JKMufqUpYaVH2vJD4eTIynu10R5IVOrdJXP5cyOhbYjeD2YY3Bw9M5/d8edn81CKw4zjCN//
	nlVWU/VIEw2agmNhnnQ==
X-Received: by 2002:a05:6512:3d0a:b0:5c1:ac60:3c65 with SMTP id 2adb3069b0e04-5c1bc7bc049mr871442e87.21.1795168132432;
        Fri, 20 Nov 2026 01:48:52 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd07b270sm436254e87.80.2026.11.20.01.48.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 01:48:52 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c1479a959aso509853e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 01:48:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGFpu3QIDI61+W6JbRGHSjsmLjuwOoKqWBGlFhZqbU7S3KlkiPKlM2Bhd/84HBjvtnN5yNmVcXw4R1NNdgv@vger.kernel.org
X-Received: by 2002:a05:6512:104d:b0:5bc:b659:2e15 with SMTP id
 2adb3069b0e04-5c1bc7f36d7mr678438e87.36.1795168131847; Fri, 20 Nov 2026
 01:48:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Nov 2026 01:48:51 -0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: Chen Linxuan <me@black-desk.cn>
X-Mailer: aerc 0.22.0
References: <3e4103cbcf7b76535e2f957762174515ef00f08d.camel@amutable.com> <20261119135452.990-1-arpe1618@gmail.com>
In-Reply-To: <20261119135452.990-1-arpe1618@gmail.com>
Date: Fri, 20 Nov 2026 01:48:51 -0800
X-Gmail-Original-Message-ID: <CAC1kPDOSS=w6mU6ruk0f5=V4NNdyr0NfUCA3npNdKPVGx+JVZQ@mail.gmail.com>
X-Gm-Features: Aa3M54ogGYoYwMNHk57gHJJnlwKfTwwkirw9b7KG6c57d-KoNPXDISSoVm4_K7g
Message-ID: <CAC1kPDOSS=w6mU6ruk0f5=V4NNdyr0NfUCA3npNdKPVGx+JVZQ@mail.gmail.com>
Subject: Re: [PATCH] pidfd: restrict pidfd_getfd() to the caller's pid namespace
To: Jiwoo Kim <arpe1618@gmail.com>, Alexander Mikhalitsyn <alex@amutable.com>
Cc: Christian Brauner <brauner@kernel.org>, Sargun Dhillon <sargun@sargun.me>, Arnd Bergmann <arnd@arndb.de>, 
	Jann Horn <jannh@google.com>, Chen Linxuan <me@black-desk.cn>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu Nov 19, 2026 at 9:54 PM CST, Jiwoo Kim wrote:
> On Thu, 2026-11-19 at 14:42 +0100, Alexander Mikhalitsyn wrote:
>> It it an interesting point, because pid namespace itself it not a
>> security boundary. While user namespace and capabilities are mechanisms
>> to manage permissions.
>
> Hi Alex,
>
> thanks for looking at this.
>
> Agreed, and the patch does not try to make it one. I followed the rule
> Christian suggested in [1], requiring pid_vnr(pid) != 0 for operations
> that grant access to additional resources of the target, which
> ee8323fdc827 then applied to the namespace ioctls. pidfd_getfd() hands
> out one of the target's open files, so it looked like it belongs to the
> same group.
>
>> Currently, you can do something like this on your machine:
> [...]
>> and this will actually print hello in the Terminal 0, while the process
>> doing that lives in nested pid namespace. But this is not a problem
>> because this guy is a root:
>
> Right. As far as I can see this also works for an unprivileged task of
> the same uid, as long as it can reach the outer task through a procfs
> instance of the outer pid namespace. So pidfd_getfd() currently behaves
> like procfs here, and the patch would make it stricter than procfs, in
> line with the pidfd ioctls and PIDFD_GET_INFO instead.
>
> The case I had in mind is the one Jann described in [2]: a task in a
> child pid namespace that gets a pidfd for an outer task over a socket.
> When it has no procfs view of the outer task, as in a container with its
> own procfs, that pidfd is its only handle to it. There, the ioctls refuse
> the pidfd with -EREMOTE, while pidfd_getfd() returns the target's file.
>
>> So please understand me right, I'm not saying that your point is not
>> valid, but I'm not sure what was the intention behind pid_getfd() API
>> in the first place and we might want to have semantics and model close
>> to the one procfs has.
>
> Understood. If pidfd_getfd() should keep following the procfs model, I'm
> fine with dropping this patch; the inconsistency would then be on the
> ioctl side. I'll leave that to Christian.
>
>> To conclude, it looks like we have a little bit of inconsistencies
>> around here :-) [ But please, don't go and change anything in procfs as
>> we might break some tricky use-cases like CRIU and SCM_RIGHTS users. ]
>
> No plans to touch procfs.
>
> [1] https://lore.kernel.org/all/20260925-gewischt-auftrag-tierzucht-c153cb3f9f74@brauner/
> [2] https://lore.kernel.org/all/CAG48ez1T5-tUHVK_iHsgUtWa-inVdrZxA3E-ZCW0iENJvasKfg@mail.gmail.com/
>
> Thanks,
> Jiwoo Kim

pidfds provide process access without requiring procfs to be mounted, but that
does not mean they must expose every capability that procfs may expose in a
particular mount configuration. It is reasonable for pidfd operations to apply
stricter checks.

The existing handling of the pidfd namespace ioctls follows this principle. Even
when procfs may be able to access a target, PIDFD_GET_INFO and the namespace
ioctls require the target to be visible in the caller's active pid namespace.
This does not treat pid namespaces as independent security boundaries. It is a
conservative restriction to ensure that pidfd interfaces do not gain additional
access merely by bypassing procfs.

The original pidfd_getfd() commit, 8649c322f75c, used the following rationale:

> This syscall allows for the retrieval of file descriptors from other
> processes, based on their pidfd. This is possible using ptrace, and injection
> of parasitic code to inject code which leverages SCM_RIGHTS to move file
> descriptors between a tracee and a tracer.

The syscall documentation in the same commit says:

> This syscall gets a copy of a file descriptor from another process based on
> the pidfd, and file descriptor number. It requires that the calling process
> has the ability to ptrace the process represented by the pidfd.

That rationale assumes that the caller can actually ptrace the target, rather
than merely pass ptrace_may_access() for a task referenced by a pidfd. If the
target is outside the caller's pid namespace, the caller generally cannot
address and ptrace it through the ordinary pid-based interface. Allowing
pidfd_getfd() solely because a pidfd was transferred through SCM_RIGHTS,
SO_PASSPIDFD, SO_PEERPIDFD, or fd inheritance would therefore give pidfd an
operation beyond the ptrace-based justification in the original commit.
