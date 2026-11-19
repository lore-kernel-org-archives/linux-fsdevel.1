Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109458;
	b=vC94/BuzJf2J88yY3iU2U8VHPnchP+y4nBnu1lAIm7f40Vv3OsPumbxLtM4Qq/mHLFnE
	 wMbmCtlhztXvKUzj0Dh1nhzSrj2W9p4ykpXqhRJTzs5iVI7SS/7+s8ftxhs3EIP7LyXry
	 9OlPpJRIwPtfwIj1QW0/LKKnipR3cqb22lLRpLIR6Ebql55tMp8amV/RvpZDSmZ5kjh+e
	 vRD/N5uYlMGmO2yayuYGRs1CtWMT+CtljRtegQWUw0wev/3qKTQq08We10jHGc81TdNY7
	 AVs5K1KKiLUPvADM2yo7bo0WlDpINo5d+K7g8sLP3s84zKok0/CM5XVVvSLGB69csNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vs32yPthyobk2oEa2KkdNDnwUJjwL8zz25GmqC5+HvQ=;
	b=MKwCeKj8oH6yhqSmhZOiPYPfukmyc6yjw3/BGjsN7sRY4s2aPmQVVsz8MDjQnqynxFrg
	 V57i0V6ozNkIt/Z4GxUQQIlmnP8u4zYdnTHGGLoN5iaFqD8ppur0jlV6iIE73YPkFv3cQ
	 BIRD7hbwBmyFrhhxnN5UAkR2Dk9lzxFpu4eODP1/iyVJUR048By3q7t+IfeakQXokitDS
	 QHA5Tke4V79KgUg8vHgnG/Ru7y8Yp0siqJlFjMWaaqu053T7EHgDz/jRBh5uBJDGHTqoS
	 GcpVbolfBqIQfkbDHeXqsWS8lzRhY24L1kfXUpMo7typ1J7nKPtgeSQ50r0G8czw/JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kcyODoF4;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053DE606A32A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 17:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 053DE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kcyODoF4
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-92119da3d37so706566d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1795109457; x=1795714257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vs32yPthyobk2oEa2KkdNDnwUJjwL8zz25GmqC5+HvQ=;
        b=kcyODoF499MEItXJuafpVcnzdrYkl7/sScpUZDNuvzQ8x8TeBmZDqdks69cwQJPENI
         9iFlKy+JKSRnJ43XkhGYbKr6s8nEbIsy4qEBpMjCGf/q7zUHm+eoySF82h8iB9DE2E+6
         x6E285TcglmPmUWPzBeIw5GGsOfgrTK54KwCO0dY+Gad/9rpkfmJp+Fzuv7FM12rO3cW
         oVa7V3SRTkJyyHdCmKYhiZ0iNHkbMSf2mGIbRMegzCViN1JkHDoqRPAMPCRKMsFhAncg
         tqPk2hQGV6zgzsjM3kKOt4MztPrYgP6ISE5NoJeIoBzovYoyXvuYXpAuHCmOYhEhLB8f
         9Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795109457; x=1795714257;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vs32yPthyobk2oEa2KkdNDnwUJjwL8zz25GmqC5+HvQ=;
        b=qZWq0vypL9fC0z7OEAStIUq+IP0h+fXheOIjr4fuyaQcHO/CIn+6sEW82XG2isBrWv
         fY67j4EyfCdFTcpDm0f6hvhhq0jKqa6vBu90tUxGZ2vB3cH4blJbHZhdXlGS10XEYtS4
         TWVOqV9l+sNimP6IpDoCSrleR9/HovH0GjvffOdzK7Mh328payG2+fX+P5BjJYOYWXLT
         2U13u/O4JkdrN2ahJSve5BWlj+B70/opDYy0LM/bYEPrH32IJmGEN5ZSX1xfP8C6Eo3E
         mfydG8/7ACSqnI5NV1tCxp6VX/Ies0zt1PkllAmZ3sC+mgaT1sbQgizo8mcps7lEcdzN
         cUVQ==
X-Forwarded-Encrypted: i=1; AL+hErG+jm7jF6Mjj2VsXyxOOTR39TEn/tK9twsbU6HQngRRpY40MJONI1ugqMw5gUO1fuhDRl23VhEa2p0Vo7rw@vger.kernel.org
X-Gm-Message-State: APuU4Z+DppQ9n83K7ZVryb88pRuVaR5okjZEDCjhB84XvwSz3M3Oi3eM
	ktiQM8CPZoKzEVali0uy5PrO89P4nFoWmBTFiXrm5Svs+Xw7vsOtZZ47AyKoYeuP4Dk=
X-Gm-Gg: AZFdTZfBfwaAHdztqT5OyF2+Kak9ulppjb/G/PRWjAY0kDfL5rBmOTQZCH+zgDirmoL
	SecV3qpeJxh9HyWkZkhVia9kl8xcKY8H66nfA2vBfFv5r8ruSJHURyYHqzwU9yWf2yaW64O2y8/
	xpRCq02YY/6BqXcwjVMdBn4SxqG5I6sqwRT0b6zSabD0XBWIMEYyBTTS9Bt3FhTaMSdDHhWbcdE
	0FsdvplATaZ5APceifS/BUdlbQdnLBSUegxbgWy/VcfuOm2IIjFr7wv0SlOvKREgqVF+mFE6psb
	TTs3gpmfEltHQtsvbblfhvWK9hwaSae/5mVzexzFHpKaQaDXSVCX3UVUT+d+yuh38+vcq3iAXpd
	0uxst2SLoqYqB1EDOK8XtPMLSUAFx009Jzxyc/0AiVD60QMjxSan3mQRqKlNQsBPFrUnDA7Dwfz
	K/Hu+9no1nw5vnkccqqWiMxOZWOZkKZWzff38kAfeFhhKtFkCLm8WwPhOh615Kb3Q71bn8enoVz
	bheCk/uxUWO3+Yr0aZAzqC7ZrZQEzlE3wv5E9tiwmmTkRoJhY8PaXZgT3FxWkeTs2AhGzPJmGtc
	8BX8BZi5d6z/O4+BgFDJgwPnbttI6I/hkxE1XdM+RcJgww==
X-Received: by 2002:a05:6214:3d0f:b0:921:2f16:4714 with SMTP id 6a1803df08f44-921349cdc5cmr6310486d6.7.1795109456756;
        Thu, 19 Nov 2026 09:30:56 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349ec64csm3556376d6.28.2026.11.19.09.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:30:56 -0800 (PST)
Date: Thu, 19 Nov 2026 17:30:55 +0000
Message-ID: <9463a969d35a7d5ec5a56aeb67644b94.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Howells <dhowells@redhat.com>,
 Jan Kara <jack@suse.cz>,
 Serge Hallyn <sergeh@kernel.org>,
 Kees Cook <kees@kernel.org>,
 Paul Moore <paul@paul-moore.com>,
 linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
In-Reply-To: <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com>
References: <20261117231352.3816603-1-jarkko@kernel.org>
 <CALCETrVUkbpoFjwSAejyA4b_9qEauAP_36i=O8Op1ifp8aUkqA@mail.gmail.com>
 <av3akYFOYaeQZauZ@kernel.org>
 <av3bkDnwmjunTleX@kernel.org>
 <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 9:46 AM Andy Lutomirski <luto@amacapital.net> wrote:
> cells: The dance where I create an anonymous mountns, mount stuff into
> it, and then attach it to the cell is cute.  But I think the userns
> interaction is wrong: you are making me assemble all the mounts in
> *my* userns and then clone the entire tree into a fresh, non-anonymous
> mountns bound to the current userns.  And that clone operation is not
> free and serves no actual practical purpose.

The copy buys us nothing, agreed.  That's just what the mount API gives
me to work with today, it's not something cells wants.  If I could make
an empty mount namespace and fill it by fd I'd use that, the "root" slot
takes a mount namespace fd already.  Extending the API for that makes
sense to me on its own.

The mount namespace staying with the builder's userns is on purpose
though, that's what keeps the cell from mounting anything no matter what
capabilities it was given.  The builder sets the tree up and hands it
over, so the cell only ever has what it was given, and the mount code
isn't something it can attack from the inside.

> cells: I find it *incredibly annoying* that one generally cannot put
> new mounts into an existing container using most existing container
> managers.  I hit this on a surprisingly regular basis.  You seem to be
> baking this into the whole cells design.  Why?

By design.  Allowing changes to a running container is what causes the
problems.  If you need another mount, tear it down and build it again.

> both of you: Can we please make it possible to do the parts of this
> that oughtn't require privilege without privilege?

Agreed, we need to come up with a design for this.

Thanks,

Josef
