Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD04AA56A
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512919; cv=none; b=ENjAylAApIHBwkfMhd49rQq+ukeePuRV6A7RyND+g2OhfUp+t1LFruvLS7EwR+A1mQAXK7gbsNFDlGgAX3fmKpS1SoGix7Ai3cgkUTmNNqsfGGV4px/4GNXmtb/Ar/mOGE2/dPGNCvz7yUMUfxs3uXz6eI0gMNlZKdBnJ2Ff5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512919; c=relaxed/simple;
	bh=ITz7hBythv5OWTbmQ9c4e1mzRPysX2+YTMbCrseTj6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGYo+fPq7jEKjY56gAJDlYnrvmY94wbQ81dMfGMLFsQ5gizK9qf4iMSr37fxQhjgETYxtVSizXneXDfsAFXy+YjJ8mFW5Xka+mqjQdCdiva2kpgYSmVuFx+PrfNhZGpVafgYnNrKICxLIzCUKQyCwrd5ZbLgu8Mb6C1li9naTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Bgi8Y6Hp; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bgi8Y6Hp"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a4aso50887166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 15:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789512916; x=1790117716; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=Bgi8Y6Hp01v2wSiRK4NN1xrqLDsWw/k6UUibIG/WnbKUEGBhTXuPUalIXrRmMhf8H4
         BCQqtiAjs5VUB1747pSTAWA4WSmSNQ0d1mMncEgLoomGr0rBY9r6REBAjkkyerUDIQ+N
         Vv6W4NN+2I5tbd814koSQQ1OsQqiO0xVDbfJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512916; x=1790117716;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=IWcasIOjTQuFKfFsx5J47peFjorj8ma1bXK7WpjF1RzKq9Sp+haU93bR5yPVXEjuUH
         RDzczkY4In3abwVmSzT6h5TzwBfGQibd9Odi5PaqbLh8KTmUveFIQ0eGIMlbUWzvWgDp
         oBh2RAuCSKFdfu0a3urXVAahG6nMx0CszFhw2Wzdcmfebofz4Iis9BeZ/wRPks/Auk7E
         FLjwOk41MPWy0aTbFsPsvmofpxamFar3QUMym/aL3vB46TIrLY2/gv1j7za4sTvHXV1d
         0gLMnawcyyuRdRa6h3uMZqOCziZTCu4fi7st2jefTWQNZU+zSPv39JlUzWI7ARW9fU3O
         kzXA==
X-Forwarded-Encrypted: i=1; AKwUvBwab6QA+hY+baZzNyQbQjy/qW2gqYXnZF3vVsuD2J0D8uDRRHUuyDK2LcMONyS9Psfix9ywfY4iHAyB5Zk3@vger.kernel.org
X-Gm-Message-State: AFuF++kFOW0bHSCr87lT2XfDZ4sKxHLMtbNLERJL6QlO+Vqi+TO5wM+T
	uUjlIzXjdJ+xPoi3hWeLDZoXcVIj2OYleaJlg1FJ69PZ8NRINRJTw8MKijbhEZG0QS5oDLuG/Zs
	2LaHg4+YtZw==
X-Gm-Gg: AYBFou3uoY1qXJ3eqMyS9UlwLfxixx5eBaSkvWRYPboV/KAxQkCxZMDNKv0KLsct6m0
	9puj0aK3RipTJLW2cqC/hA68+XMaZuIcBniX1hWBxjWQLUSiRB9w3C/Iy5Di3C/3HR5D12uyeCC
	8SnrfYg07COeyNqnBEJlWDq1v2zBoAJr4gvCchzzG3Jd8tou9ojuKw/tAoOxNnUIACdD2hTA6e3
	t135y+9cf+9Y3mnyZDi4IjbYa8mQfmv4IR6DDDkr3Q4vkFooA89LhJQPkQ+ORPMl0rEjMBE4vfJ
	92RXsAuTRtHaNWLicAIqjzAc7vpRAReJGDL9ZB6laJ1LKruC1NlLq17tU+hhxDqII3C4E3DS4xs
	kKsXn/jyowkeZmke0fxovapGk09dvmcMjf5mG2dLteqKOFc730Zm6bfFJ75g9fuHiaMytS+xFBK
	bPkcRhA2AP7DUgL0aiaRunZRpj0nuUONLw4Q+o4j2z4ulmvUbsgCBMcKx21jvQGxER+3sgD6PiJ
	t5BrlVF4zcXIR5eimqUI6pj+VBpsM6ATU6WDRDbIpF1DodQ
X-Received: by 2002:a17:907:9626:b0:c29:5420:cf78 with SMTP id a640c23a62f3a-c29e5328b78mr9540066b.45.1789512915900;
        Tue, 15 Sep 2026 15:55:15 -0700 (PDT)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com. [74.125.228.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de453ea0sm34746466b.11.2026.09.15.15.55.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 15:55:15 -0700 (PDT)
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98dfb8002so490825a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 15:55:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxudt49SWvkaSVp9OcsobNcuMdv6rJXCSjBIcIxGEhL0Np72ciH62YzpJaj2/xbhtfhLg7mLrACY9YvmnVX@vger.kernel.org
X-Received: by 2002:a05:6402:5d1:b0:6a9:a6c0:e5ef with SMTP id
 4fb4d7f45d1cf-6aa2244ef06mr218172a12.37.1789512913950; Tue, 15 Sep 2026
 15:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com> <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
In-Reply-To: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 15:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
X-Gm-Features: AcwNN1Wx2MaYDtFtmeOlL6MnzYY7doY_FEPpziKatTBWbLOeKsjmritQ5JuAL3M
Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: rob.clark@oss.qualcomm.com
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 15:21, Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> With fd's it is more than just about error rollback.. exposing an fd
> to userspace mid-way thru an ioctl is an easy security bug to write..

That isn't very common code. It's something that is done by a few
strange cases, and yes, those cases should just do it right.

But "those few cases should do it right" does not mean "make a whole
new subsystem for this thing that makes a simple "open" actually be
slower and stranger".

             Linus
