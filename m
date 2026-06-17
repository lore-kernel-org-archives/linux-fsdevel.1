Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2D3F0761
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708251; cv=pass; b=XkToBjYGH3SAR7KBA/7119/DITOOuh8OnPYi8FbV+sFxNXNKK7GE1p/+WuoykLU5UUgPiFtDC2LpdVoMK/cXM2SjQ190MLrOBDnBC2Jm8ILxh0xBiGPE+aQkB6iUaz63nla/ZVKRizEIPcBEFEhJLQV8C9bhb/kg7GucH11GBV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708251; c=relaxed/simple;
	bh=7Fn7rQr6uDiBa29O6N8cOyu6iL0JrBCT1spb/eozr/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJmbmfAJNcd5Zj7rWYeV8vlhiL3NtQRZp93h8TxXaLhaLC9oRdb4bTHWJp0rK4P+BJ0WWED5b7q99aTvvEJH/vAnM35eJyZKBlOM5/s5GYJIoY8hipDp2FcWevLBv95vwRvSPYMc0AceLQzemvROtOx59QJbC0IpvR8SG20CJFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZ/6QCRw; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ/6QCRw"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6957ba52d2eso1087372a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 07:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781708249; cv=none;
        d=google.com; s=arc-20240605;
        b=JaiuHcqBBbwytH/IVirEnJBKNSvozCld0vkha4R2zNZs2AtcMv7cChq04dWJmAqm/2
         z7yZtsqwSGhV5ke7LRLiYl4OlUVvqxwTIIQVbd1JjhLNBvqBslKfvH7XWUt/dU+Wk8Tx
         GOCCkqqKz+IZ3u+7W4n6KhtNu6AKZxCMHCbO8dKb4xDLZFHCbEKCOp82j6A3PFZrDemA
         Hj5dtKhafzLJp1wTEyic9ExruCgqidoj379Cg+CH6OOwnlK9KOxo70SWtL9O8EW5GT2v
         aSRJVdak/nZ+unuKQYHvmRBoNlxaCkJZ/w7NB/KgSMP84yPvBB3ZhIFsVLI1YSjG2kJ9
         6QmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Fn7rQr6uDiBa29O6N8cOyu6iL0JrBCT1spb/eozr/U=;
        fh=gd0J9tAJGZBAGN8cxGmjDGhfS6PTEKiFlf5yqcfuJAc=;
        b=Wd+mKLgxuDQfg7YvIifrWvYbssJio7wilWQvCTsB4GIMfUZhGJcUDcqDXnztf8PKc+
         C9F1qlZ20gT2Edu50R+zX6W9K/tJ0hXk1MdDWhBw5GbPay9mPJUMgHfXWYuTLzwfAH2N
         TUA0KiPtfJCtV6g2j+Ex8ga/77jIDvdRm5YCqHR3drubP2aWoRNZAhld6ih5E6Cn/z47
         uhVvxUi1mtrl9/se/u/e0JqnCjILEtAl9hFBw8XO4ScNri4KR5OJq/bFn3OOiNBLgy6W
         XlbyTPOAA6X/FKhlae8srjnt+ZOS0pBduxEXqNRH9nDOO7qdJMfgLvKNqk8acDX1lVdU
         2KzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781708249; x=1782313049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Fn7rQr6uDiBa29O6N8cOyu6iL0JrBCT1spb/eozr/U=;
        b=ZZ/6QCRw5zImU5/bxhXjCnZKvGsomoI6Kf0hSgliDEeM3OWE/xpL6p+DyRpv1ke/0O
         YcdJmkevtLUdoeP/0chQLbl1CD5dZrXoyZuCqX4IQHDxalYKN9jEJgTJv38igxn/COHF
         zsclKBLFD12keD6O/BjcrkIxGXdP1JiBuVUDuPiKD7zWR0YRZ9jAN23k38xVjtbFdLmZ
         kI93UZiZOP/pZ0CPnX3oz+GJyvrkWBu76NIg8xvM445SC3c3Kix7GxpMC8K1MzuVeIxd
         gORjUwHL/ZYFAeYWGezGsuHjrVYr6w3DiJzOu/VKu3hSIJxx7J24Yvn1E7pW0mFMxmE6
         vC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708249; x=1782313049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Fn7rQr6uDiBa29O6N8cOyu6iL0JrBCT1spb/eozr/U=;
        b=IIpOBx32GXfyLepOjFJgYIBWh0XeMGrflkNQwDMRsq4xBpdjdTvBSwcdAj3uNRajVP
         7NhYsSq7xvh4cI7PkHJNWkKVmJYX9ZShqazW53TOHp1TEKW/NVNsrqeyVgcsIEvGeTS8
         rkz/6hAQtGbstzOCAjuS8KIBls7qh5zqbnHCLaeNQQN8PUVN7Vs/phzkf+a64p3+qV28
         mA5MGMndWCsd7ekh1Lz5bcLDipNTWu01mvaOQ1RiarCc9F9T5Pt6I39wuORIdgWeUSL7
         e+7KbRZqeKJndGVsKBNopHTOPE0/YbE4DFsQ6ZEc9hBBCASx/x2vT4KO56rfO4J71Jkn
         YfCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+X6z8l85/eMjx8xFwDNUQ2sCG+nLFHnJRpSBOLb+JPHDNIdnSkK0NKRjCT0/7kPUecCQhQbgXKht83LFSw@vger.kernel.org
X-Gm-Message-State: AOJu0YwQF7hxwyC1u8B52kIvrewAdBTschic7L35hcqgkbo71/U+PBBg
	7ATDXB2Sx9a1uOPh/IKUydv87K4HrJCwp/opGmT5SdtFY8kiDEOOh5JH/iEOyz11R8Tc/ZCSOqo
	i49gR9sQvayKSRki6BOtGyB2X4Hk09BA=
X-Gm-Gg: Acq92OG6Ag09X3PUlTH9n0nJUj0yF43Yhdwy6qmNu0O1MEa2VNRZiQbne2X8dzZFm/S
	JvnQc8Ez0TJEaM67lHOjEr6KVArurHwyggJ+m/Rpf5Mueb/iFqaTjoMxNtQZ8kYWoenV1XD43Mz
	XdJaQQz6gtPDvCdpblOeh9dg2uEZS0o0qNnqsDKRtKMXl5TiFiQxRnwmPt73jTZdRF4VB8WVGRu
	dej8DQ8DluXx86nXP3IcBi6xdstX00tvmC0aE340xVxfQu9otT3en28V6bOSc+KH2cDJOytjS7D
	hcPyzSMlMeo8D2SJi+NoGyFYyxtE97a00V55PA==
X-Received: by 2002:a17:906:5149:20b0:bf4:37d7:d47 with SMTP id
 a640c23a62f3a-c05a85a64b2mr256112266b.26.1781708248470; Wed, 17 Jun 2026
 07:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
 <ajG2bmhu6j9UWvh4@localhost> <ajJgWBCFYwz9OIo3@redhat.com>
 <ajJ1Xi1p9UhQvILi@gmail.com> <CAGudoHEyDz-Tbj=CZFK5XMLuLyE8B17NumdFVLf6MTTekFgRRA@mail.gmail.com>
 <ajKxJM5k9U5L05AF@redhat.com> <ajKy5ghjlgyN4tFv@gmail.com>
In-Reply-To: <ajKy5ghjlgyN4tFv@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Jun 2026 16:57:16 +0200
X-Gm-Features: AVVi8Cd8XzLyKTV0BVt6ddQATwIVjpJ95lzrBaEw6eoAbEr2y7xXrAQQ4A48W0Y
Message-ID: <CAGudoHGKyN6k+eSAUm35_WDSZcxxtm4QL6fO+4rYJTvtObMqzA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
To: Breno Leitao <leitao@debian.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Josh Triplett <josh@joshtriplett.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shakeel.butt@linux.dev, jlayton@kernel.org, axboe@kernel.dk, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 4:47=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello Mateusz,
>
> On Wed, Jun 17, 2026 at 04:37:24PM +0200, Oleg Nesterov wrote:
> > On 06/17, Mateusz Guzik wrote:
> > >
> > > There are trivial touch ups which can be done by adding a bunch of
> > > predicts and inlining kill_fasync if someone can be bothered.
> >
> > I was thinking about another change, see below. It assumes that in the
> > likely case another writer won't steal the pages from ->tmp_page[]
> > before we take pipe->mutex.
>
> Do you think we could eventually eliminate the tmp_page[] array and
> consolidate everything into the prealloc pages? That would unify the two
> page pools currently used in the pipe write path.
>
> When I examined this previously, it appeared non-trivial but potentially
> feasible.
>

I think I commented on this in my first e-mail.

In order for this to be acceptable there would have to be a way to
reclaim these pages in case of memory shortage. Otherwise, say you
cached 8 pages and the pipe remains unused afterwards -- all the pages
are actively being wasted with no means to free them.

Now that I wrote it though, I think this is very much doable.

Naively you could add a list for all allocated pipes, but that's
terrible from perf standpoint even if said list is distributed enough
to not have contention on pipe creation/destruction in a real setting.

But suppose pipes are allocated from a dedicated slab. There is
presumably a way to walk all of the created pipes, regardless if they
are is "allocated" or "freed", in which case such shrinker could be
implemented without extra overhead for the write side. Someone
familiar with slab (slub?) internals would have to chime in though.
