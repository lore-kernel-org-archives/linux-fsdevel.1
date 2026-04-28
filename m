Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B3B45039
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394320; cv=none; b=AdzdEPS8zbQMNxKVv3xfCQGR1VR17WWbi00iIet6ndK3aKoFM40WhFgSCi5g8kJfA4fTNDz6ZhZ3Qmd1hDxgpHLGsFw+/1i35MDghzpfulNYE78C7zyNmPUG2N4oq+K9sZpugza37UcsajoISRo9HHEQ85TaY5+Bhep4Td4m6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394320; c=relaxed/simple;
	bh=UXi3to+PEeM0vXAZmtoShs0caavlFjs/qq6Gqzz+kdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXXIesMmk7pIJZIVaqiaGrefNBV7rUtQVcbv1tnYyelwJtK2ydW+pXAvr96RCRD0QhtA1k7jaHjzPbmiRczpj4ziuDVaMtlHM3xBYl6fyxZE7X18nPDDB57MplLq66koBdUzEMKjE5DfiQbhA3grR489jF9ov5GLBprVaC8AH8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AfaSPynl; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AfaSPynl"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso110345281fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777394317; x=1777999117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zdQshYQj3noQptsym9r2OjNoPP3O2vv/eFEz4ctitBQ=;
        b=AfaSPynlHDiKN0vwbVslT7r+8gyZFNzDbcpnWRE09r02Mu8B59VfNkq0Y/tEVW2B2n
         Q3JjmOpce+QuLkwYZGxizM4SCOw53Twtg/yTUHrmNCarEgdR3LNp5+wfOJ8M1dbm7JAz
         4e6TvcG0znZU2X08OuFnlUltfu5ywtQgSymAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777394317; x=1777999117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdQshYQj3noQptsym9r2OjNoPP3O2vv/eFEz4ctitBQ=;
        b=p+iwqRyccKadGDiZQmN10BFNxoItiD869ugBSL9yT5HZ4Hpp+VUmyydyMU5nJpejvM
         OizHcHFJfV7Rkg0+KwCem2A/U4Ca3BHdETwZ0I788jdgu9u8URNYV9gc1JNKeQdpXcT7
         Cl/bkEuALB3ta2rro9BVwir3PPgse///1QyS9KMvRH9Z2sRc5RBM7fZKD0HgfrFV/u3x
         t/ls63ZDI3wKKTSgK4cd9/EKx4exrh2iyq/zOGzDreKh8ubw3wZymxsZmpy6JsHojNpQ
         zn/y3rARk8c/wb4TGcbV/+aPJAXaJaMr3KXhkWTgRs9PK3eK14KxkQRWtyBinYSe6ayq
         UPAA==
X-Forwarded-Encrypted: i=1; AFNElJ+4y+7jMnSl57N5DTrtqbCj0utMKrv6JJgVjOZEM4j7563LwpC2MnhTBKEWDLs23b/1g0JErsvolarUCyLN@vger.kernel.org
X-Gm-Message-State: AOJu0YwfGV58H3lr22fQ4qVRfg/8SUOcYbXAja5Wg1/flgcG0L3cZ/qz
	9VZZ+n4kaFYhxdT2zTAZDQQuvWg5bv1aYM1wO62xz6h586LwQ91j8wMXnGaVp0xU1bOGfgPBmYc
	wLaOGS6qoiA==
X-Gm-Gg: AeBDiesldtt3m3E6xVkMg3/c0cYvxIeJ2wVj1bFZldSkj64l9Fyyd0XbTcdLloOy1pm
	az01niBZUKH8CKLev7VEyNjWf1EBMwIA2Ct7rLgejVYwQjRYokyJth1GXqliu+94/tqP+d2nyp6
	eZl+pGYjt4aZOq7hCSfXicXtX8hzjVpsZHeP4Rzp3aviJxiWhOyvqjtwNiRycARm6aJV1FGu91j
	HzT/pRFQv47uki3k1Eg1x92H/dgDUqTr+BXZqhDTTC7IVO5MCA5eJu5IdCkKxwfKzRQUzJAyQFe
	kFjVih+NeyfZBe6XAuss89IfIBYLo3t6gSAxJQTdYv1H9NtIveON8LV8711IUZ0a4ucWr4ajSD/
	cAnf+VPJKw85Fp3c6bxDPlU60w9RUsvNufTkeIgRfXaMz50poaROm5idLgBDJFSLb+6klu5XgKV
	2/TXVSmSPYhcwcIeHxVo0RHO047L2Y/1JaTrwtP7qcGb8lrW5BdG4fycZfOeum27cR6ee6e3yC8
	XDZ3kboIEEp5V0MdwCcffzUNQ==
X-Received: by 2002:a05:651c:1504:b0:38e:be42:57b6 with SMTP id 38308e7fff4ca-39240cfcf5amr13209411fa.9.1777394316831;
        Tue, 28 Apr 2026 09:38:36 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3923f31f2ddsm8516531fa.13.2026.04.28.09.38.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 09:38:36 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso110345061fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 09:38:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+k/YOOsMJgVZjaNT3XRcZe0NXF+rEWSL6Y529xw+l3PR3+w1L0bFyCwpFnwbWCRYTx/B+WjFVXg4sydEqu@vger.kernel.org
X-Received: by 2002:a05:6402:4498:b0:670:e9ce:203c with SMTP id
 4fb4d7f45d1cf-679bb05d621mr1866002a12.10.1777393961533; Tue, 28 Apr 2026
 09:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427040517.828226-1-neilb@ownmail.net> <20260427040517.828226-5-neilb@ownmail.net>
 <20260428033738.GV3518998@ZenIV>
In-Reply-To: <20260428033738.GV3518998@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Apr 2026 09:32:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXZz=-XnJdMGzM8BCwDkoqU0yDNKWyrpZSwXzchxsPUQ@mail.gmail.com>
X-Gm-Features: AVHnY4IIvtSv2v5AokZFbGGGL2ooIu4U0QBZlzJ1iurrKn3dZQo8WV0HU53s1sE
Message-ID: <CAHk-=whXZz=-XnJdMGzM8BCwDkoqU0yDNKWyrpZSwXzchxsPUQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/19] VFS: use wait_var_event for waiting in d_alloc_parallel()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 20:37, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I definitely like the calling conventions change, so much that I'd be glad
> to pick that one right now.

Honestly, while a 19-patch series isn't big as these things normally
go, when it comes to something as core and subtle as the dcache and
filesystem integration, I'd personally be very happy to see this
merged in small clear pieces, so I'll happily take any parts that are
good on their own early and separately.

So yes, please take any cleanups in this series asap, rather than
necessarily keeping this as a longer pending series.

               Linus
