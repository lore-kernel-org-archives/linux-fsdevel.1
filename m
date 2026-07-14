Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887D32B108
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066959; cv=pass; b=eakpZEizxsk3jV6OjSvpy+KGLUXEIotUSVckbnhKIrpflcIZcdEA0t3b1jy6FM7SBHG4EmRdQckc23nDIxB1R7Rern4o1drwGmTFcALcRNWm8vzSiBPJlufy+CLfy0YNeWv/Nanjf5YU25wNA7G7ivFVD51ABifGXjslty2v54M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066959; c=relaxed/simple;
	bh=r2iYkOkZqaZiczZDu8484dwuTk2brepREdMPjm33dmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVvmTJmOJrLOGaA76jcED/U3ODReyXlflqDrOSm0tp9OXhncHgcm1LHT88hysmYeEnQEBBEufayZYaBHrodNZCl0BaEfEpg+j6BBzEozrWQiMwyVsGzBH9dkVFqH4f3AxXApXnfIO8W9MCCRFhEG2gSCF5Zwl/SHyRrxliegXEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jJAqAVc8; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJAqAVc8"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso4988356a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 15:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784066957; cv=none;
        d=google.com; s=arc-20260327;
        b=JTwQQsNzLziSxxuHmjyQPBEdXiD6JjeLUQtPJBe0iTOoGWaHN6L5+8aaA28R+A0pFp
         Wd8MIigfTFLFchQHkz/b+lb8Nxv6dpCd0Klg9tTH0Sqr6XSd09mDyLRMpoz0iGo3e+K6
         KOxRcQ5vH3puxv/UX3PcETkEBo6ZavuwfeaknnSi7VowR0GmuzCYYFVT5nQ4FMFw8IAZ
         JBqgr368fenP+KcNVObZ7zmnGXwNzkOip1t1cGkbAbxoX6rdccjRDAwouOTf9owXTqM8
         Zj1OpuwD4/rabcUbUFK4SsC58ooG/LOYiqhVrSKWjXxRg1cRl2CX4OBysXbGX5SiT2e2
         BaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xMAuuyWZB7XoHJOmWQuRMJ1M8biAFJoe1pbNkAJBxPk=;
        fh=UTtNoi4fun5LHX9lXaf2EJ2YWHnNdJsPnjuZh7l+AE4=;
        b=g8X9YfEkE0wEeywP2/sVVqJq/anw1GyFyGPyczathU35BezgqstNRA5yjQLOkbC/tV
         TyaH3cV2Xa2kNyu7gFWHow0bPtLBj2XUErp8BqKtSoQY65uV3HSUU96qTkbgfMhio4ea
         6hVTZwhFSPJ6+b/+SpvGabXkDJelrPus3m4R4d00IkC7i4IBCAA8ace7CxZgJYAv9j8I
         wccHi12527w2U/Fst4JAm4+K7iQmmDutlTjh8QyQq/hYjCCGEG0zfrjOCojuvHIJBOOi
         dBQUZnzS6hozsgK031MGENW636fiLHcATfGexYTA6HEJLK+9AN5AjE9Gp2pnJL69BPIO
         PrYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784066957; x=1784671757; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xMAuuyWZB7XoHJOmWQuRMJ1M8biAFJoe1pbNkAJBxPk=;
        b=jJAqAVc8FKhcaLdtoDsofVWzvn8QRy/q9JG+pnR6ul0l0APtFbtQnw2S98upPKO83A
         FImUC4Y5PEHkn2ZaDf/DOxsXkA5yZFXC1ChC4AxZnrrxNDrirGLN9KwRrXf+AahOSU5I
         Sn578VMNvhNl8lNQarlJao+yNodAgJa2n3flLLMt4kgDPgx02zzpGMZ+MX1cbZtmqEXB
         BeQR7wi9BGvNAKWTE42gVMl8CX43REK5YE4uvIdBIeDKVr+i6fTMBz+srJzOjVHE+ggc
         KbZ0bt0MjQoJDgVO1T+SEg0A9O0z3VyF371tsK8rpWIi+PSipDoooNmwlq0Ei4Ry0d65
         Advg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784066957; x=1784671757;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xMAuuyWZB7XoHJOmWQuRMJ1M8biAFJoe1pbNkAJBxPk=;
        b=GXmuwEDtPEdJ5WKWA+xzrJlOyW6TcoMURxFi2p4FStUcpERDoW/AZeJl33gEWpOv/1
         +cw7eow7NsKqejc4KiMUa/AE6a62XrduruU2IjmW1DyVSYnDohx+dxQ/glILbKmdWKM7
         EyHAXybeq/q7kHm0ewc9wrq2kEWZlMrsMXG+aOKl8aJPntBJ9K6HJ0M3g0qJBCrVapWp
         yTE5ftS6S53KbRnHfR8HcdFBJgiXQb/d/28myOjkA8g3iGgVVJ3eU4oLbtHta0Mc7lhs
         22kGUeOEEGXaXGyN3S+j7F52UaatKRFQvaooGEYUuAHsu/w2Q9O73UcwDQ/Re07p0Ych
         og0A==
X-Forwarded-Encrypted: i=1; AHgh+RrWVH38M+MsVqDs3ATHllHVqVbjiz/fNP/NSD63l7FKU/BTEhjgL4a5YC5SojnOoiU8M9SJdT7sIJrZhKm/@vger.kernel.org
X-Gm-Message-State: AOJu0YxJQcsK+vDahgsN4CIRckwZEBtfBoqZ+9qb6uZaIOiF9e5DB3BJ
	Vfe+FKksofLBzmEsDQoyYPAVxoYhTDgeoIdcRdbbTyhZB0LI1W5TsgT+p5iicV6AACqFBl9GN4r
	LrUWgMdg8+ozLE6gv7e0+pT5BNObd46mS3PUW4qR4TM4+2pbViM4TXLWgTVA=
X-Gm-Gg: AfdE7cnEjeg+S5SnXvpit8yWAOoP1Uk/Y5trRitXggB/wR0O9ysb2fLiBjpf06oJlCS
	lbq7U8IuksEcddg5bMRug3sDsrE5Sz+OYOiCMpyXKWK+AfZgyAVagvLursyhiHOWWCiZzgeB2PM
	/Xky5C6kdJw1telEsggww7tuXmYV+3CpZ9rSYKoohFDsx9zLUylXTTiglMI3MW9Y8xkAbsEm7er
	wRHGKREoRVrri6Zvur7daAyKlTFnSTHY/yGkOXuUzL1DjmJOGK1DIxiNjpUYqAx5AI/MqGv17vz
	bFcoapE=
X-Received: by 2002:a05:6a20:a10e:b0:3a2:dbaa:82ee with SMTP id
 adf61e73a8af0-3c34d5297f9mr6314687637.9.1784066957186; Tue, 14 Jul 2026
 15:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712165610.366474-1-timday@thelustrecollective.com>
 <20260712165610.366474-2-timday@thelustrecollective.com> <alT2yHlfzhTZ9n4T@mit.edu>
 <20260713164417.350710-1-timday@thelustrecollective.com> <CANpmjNMfQT6Z9ke4x49sp6z8+pt_5ZLUoSh0da-99bwos5-8Lw@mail.gmail.com>
 <CANpmjNM5CmQc_YG_5=zhdLCr7gGL3QYPcd4R4=m2NzwNY03d3Q@mail.gmail.com> <20260714211246.1046948-1-timday@thelustrecollective.com>
In-Reply-To: <20260714211246.1046948-1-timday@thelustrecollective.com>
From: Marco Elver <elver@google.com>
Date: Wed, 15 Jul 2026 00:08:39 +0200
X-Gm-Features: AUfX_mx1t1iYPhOzdPqbpB7WFQla88w25d073M0qcSXD45eo5bd5Svr3aBYrm4o
Message-ID: <CANpmjNNU_GiRW6y24hvbUsXze+jf+9ptx8_Acq1Y=mvPSr=wFg@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] ext2: fix ext2_xattr_delete_inode() context
 analysis warning
To: Timothy Day <timday@thelustrecollective.com>
Cc: Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jul 2026 at 23:14, Timothy Day
<timday@thelustrecollective.com> wrote:
>
> On Tue, 14 Jul 2026 00:56:56 +0200, Marco Elver wrote:
> > Relatively certain statement expressions were once again the problem -
> > this should fix it: https://github.com/llvm/llvm-project/pull/209330
> >
> > I haven't had time to test the Clang fix on  fs/ext2/xattr.c with
> > context analysis enabled  (please do so if you already build Clang
> > yourself, otherwise I might get to it in ~week).
>
> The fix wasn't enough. The commit message on patch 1/9 omitted another
> warning. On vanilla Clang 23, I see:
>
> linux/fs/ext2/xattr.c:829:6: error: rw_semaphore 'EXT2_I().xattr_sem' is \
>   not held on every path through here [-Werror,-Wthread-safety-analysis]
>   829 |         if (WARN_ON_ONCE(!down_write_trylock(&EXT2_I(inode)->xattr_sem)))
>       |             ^
>
> and:
>
> linux/fs/ext2/xattr.c:860:2: error: releasing rw_semaphore \
>   'EXT2_I().xattr_sem' that was not held [-Werror,-Wthread-safety-analysis]
>   860 |         up_write(&EXT2_I(inode)->xattr_sem);
>       |         ^
>
> If I apply your patch, it resolves the second warning but not the first.
> I tried to generate a fix [1]. That branch has both your patch and my
> fix applied. Those two changes combined fix both warnings. My fix
> tries to add some special casing for tracking contexts acquired by
> trylocks. It works, but I'm not very confident on the correctness.

Nice, thanks. I'll have a look, but it appears right. Need to get my
PR merged first (need approval), then please feel free to send yours
with me as reviewer/approver.

> About next steps, it seems like everyone is happy with the rest of the
> series. But the first patch should be dropped in favor of a fix to Clang.
>
> Should I submit a v2 with 1/9 omitted?

I'd wait for the Clang fixes to land. They look relatively
straightforward, but just to be sure...

> When would we be safe to merge
> the series? Once the fix is merged to Clang? Is there some kind of
> periodic LLVM release we ought to wait for?

https://llvm.org has release schedule. While a release for 23 is not
yet cut, and we do require the unreleased Clang 23, we can respin the
series after ~1 week of the Clang fixes being merged. Only some CI
systems build Clang at head, but it's generally assumed that given
it's the pre-release, they will catch up with head with some days of
delay.

Thanks,
-- Marco
