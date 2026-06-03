Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E92877F7
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 04:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780460437; cv=none; b=gjslAMa6P3Wjx8cRwoJQIHSMNTw3yuVyTzvh/X53o+Jt8eeA+Iy5KAxtMGUdciojvXPm7yk81zf/yq/L7/PD5s29a3rSZkt9bKvg5FyvpyPmKWhW+lOhmhsFH6Jn24T8uXW0L4IDtFXobUo9YF8XdHL99zqNGGmpsYs1JvupXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780460437; c=relaxed/simple;
	bh=9tQqNP43n5romnaq4BfFL2SfXA5Di4eDVrUHKrBpUCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fg7PaQm3Tvm5ai7NEubzHfFYpcs5oxGWI3F9n8ZXlyGll2ljRRqV3rfRS/b8lPsQzrRs23B+MOs0kS+qizcAJqBL+1y+JkYbmrpGvjRl/kVgNjuogDIZeaJ48NeHm3uLe3Ioc8H0gcYcElz0tuhfb6uHc7Yj82XmRQytNOCkg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BwqwcuOk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BwqwcuOk"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68c1653ea0cso7689504a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780460434; x=1781065234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3SJtr+8Mfjo1TPz3VKjCaH7CMP6KY0W4WXb69Cl5TnE=;
        b=BwqwcuOkkNb7tVHZLaGh6eXbo44FrMSBRw/0cHRTu8+ebGPkDPXOQ26GmL9HXReqa0
         Za1J/8tdIswPmx1kycMHEmhHsY1kWxLt/HPSfFM5jFGH8w9WPEhHo3LsDQVDjFl+MRLs
         tPAgmN7XEkogdSBpppp7LrsvFAQs1sixquNZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780460434; x=1781065234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SJtr+8Mfjo1TPz3VKjCaH7CMP6KY0W4WXb69Cl5TnE=;
        b=reZX6f3K/3sZwgpKOcIUq8+p3C8BB4f3pDiapwFj66sN+0cj4fCHgtceMUpMoTDpei
         krkh7nbwfxRPK1mTgUXDyzff9MxS8iDCVDFe1wAX1+VFqLk1HTlxMY1d9uIdEOMfFjjw
         f1VfFhcShttEiZpfwL3Ezn48pEli92Q5BFZJQfZRaWBHJtHcZAIpKdvmO6sJCYEZyBMq
         ERuEnAv5ynaCmA2bic4z8m+sPCUihEfFrCQpMi3PwTk4uQOMJz9bxnx0oarRC06jHkIH
         XV4QipoqGRlx28+OaWuy/DmDbCzsKOYUdvki0qzh9FxXZVYLJVv638gFqOVWPTAdVYe3
         xI9g==
X-Forwarded-Encrypted: i=1; AFNElJ8H6R9y+5BrjHvUIff5SjcdvZW+JhaYxUy/Gtc20Srz9fjZvoNj+l+u7NLKYfRcyGbjIJ0mqctT4HYf3x8R@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpMmBlfdKPojQbJ1s34a2Lnh7VhzjoyeP9t7nzpJHVOIT8QXu
	Jx8jTYqy4L9w+xcr6R+2Gal/muYsbA2GTlXMY4UPl7EPopdZgD0WoDDLgubJs8BCZlYsVJd8pqD
	RQJSoQg1JJw==
X-Gm-Gg: Acq92OEPfhLMN1nRDYzlkRttZupwADqyRP6UsNAHKHaEYuT1ibuR/8/JXx1wSRYyoHJ
	cuv3koxeoLf7PrrotX3Qw57Mamza7sOSw3W523iz+Z6egr6gmKPomsexdNU7EuNmawsYdubqrsh
	DJfcblo9yEtQXWLgVJNWWcAYzUr4Dr7Wtn1v0pnLsEMEMJ/iJtXYq1JcGsZ4MPmnPpo72g1ryeA
	nt0TC19VYJftIeQJz2q1+bm0CBhx/Kk4yvJ4zHQrRF5/9lPW0EkY8IZIKnAusihby+rlicO8RkO
	ZOv7hwisMHfnAJ0ySPiHckMi3aCJNISFe/m1Ex8cswo8ZHVvk7z5ay0hzHiuU0CM32rXHXFQuYk
	IK85MoWVebLpXjTe5Kp/D8W0ZpBrLeUtIGQk4lh54mfVz6BjJizVV1qbxamRbM5W3dAK/rKul//
	2hKL0WSAsmqHtveHCh4EHfmF79QrMAaW3Haba9p04o9VE/YOM/68CBecbQTUBXpbEnj2vrZiuag
	NU1InNBYgYWidF59iyYfw==
X-Received: by 2002:a05:6402:5408:b0:68b:d82b:fc2 with SMTP id 4fb4d7f45d1cf-68e7283a1e5mr602345a12.26.1780460434211;
        Tue, 02 Jun 2026 21:20:34 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e6595c72esm442903a12.23.2026.06.02.21.20.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 21:20:32 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec3f69d343so460007166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 21:20:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8n+MWYYlMGBo60VpuPpIUExXmywkaXVh/5JnIx91Nit77kGREcON/7SZ5jJ4RKZ4GMAuuZm9CF4USlzdqC@vger.kernel.org
X-Received: by 2002:a17:906:8a48:b0:bea:4a9b:27e3 with SMTP id
 a640c23a62f3a-bf0ac20eef3mr38881066b.2.1780460431308; Tue, 02 Jun 2026
 21:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
In-Reply-To: <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Jun 2026 21:20:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
X-Gm-Features: AVHnY4IJxv2Bq-ytG67gbyDgK2Xm9CPUNF4PNLBHu-2R4s_ONl3Jl_5fsF1zxk4
Message-ID: <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 20:51, Andy Lutomirski <luto@amacapital.net> wrote:
>
> Am I understanding correctly that this will completely break zerocopy
> sendfile?

Very much, yes.

And it's worth making it very very clear that ABSOLUTELY NONE of the
recent big security bugs were in splice.

They were all in the networking and crypto code that just didn't deal
with shared data correctly.

So in that sense, it's a bit sad to discuss castrating splice.

But it's probably still the right thing to at least try.

I've seen very impressive benchmark numbers over the years, but
they've often smelled more like benchmarketing than actual real work.

There's also a real possibility that a lot of the sendfile / splice
advantage has little to do with zero-copy, and more to do with the
cost of mapping and maintaining buffers in user space.

If you are sending file data using plain reads and writes, it's not
just the "copy from user space to socket data structures".

There's also the cost of populating user space in the first place:
page faults for mmap made *that* historical copy avoidance basically a
fairy tale.

And not using mmap means that you have the cost of double caching in
the kernel _and_ user space etc.

So sendfile() as a concept (whether you use combinations of splice()
system calls or the sendfile system call itsefl) isn't necessarily
only about the zero-copy, it's really also about avoiding the user
space memory management.

But yes, there's a very real question of performance.

I just suspect we'll never get real answers without going the "let's
just see what happens" route...

                Linus
