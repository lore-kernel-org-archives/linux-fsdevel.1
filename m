Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11EB6FC3
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601868; cv=none; b=SIQuJ6D7DJIjbo0LUjLUZs0N3QTjHz7QKSdaFXrKBe54Z5PmUMw14a2gPK0VL70lwmco/aH8S9h3V/2KcPqYObgm6XMKcNkBH+eMNYzoXBnmhXsic34fc+tQHi5mYKjdfHVXq5oC8r6tMVhvttOjQsu+Hv4XqppqHTS48MQov7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601868; c=relaxed/simple;
	bh=d97FFwmE32XoeNnLtg7CNSRYTgucvS3+TBVC4MKcTx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GL7B0SfwO+E8YfZ5DFLuOToVUXvEvvK9QH614TTV7TK0oSfd4Ex+RpJxPaELxPnLpZd0IcwJAQStjQu2yagw03obvYyawUJQlZm/k/B4/DfoxJK8tx4sVTHKNeAJt7ldr2JtW0UsQ+k9WnG7GEQHv7DnHJjPns6TIUatFWHxo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RQodwCPn; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RQodwCPn"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso1251604e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780601865; x=1781206665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/vRjXw0GxoiIE6driNbyJfpHo79+KlSJNRDFpalZAbE=;
        b=RQodwCPnvo8GCF/IsJ39RYufFxiR1eSMzFtIy2+JStXWzUAFF6Y/i/vzqGwLu+lM9o
         dkCEJtQafmg4mZPIBZy2q1qsZsKOkPS54mhuJ0J1MA/g6s0l45+T6N+1ADvYjwRnJ8Rw
         NoXsnTvQ3SznNCSikgmSPCY7EEL5b6Tj5Ga/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780601865; x=1781206665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vRjXw0GxoiIE6driNbyJfpHo79+KlSJNRDFpalZAbE=;
        b=pQui8Zco33at+uAGmDcIfL+93CS9b/xW+UpxgMyE4cBIAlhXkmemRZAKEHlyylN0Kw
         aKKGrPquDQVd8LWFtyF8EpAMM36i0VTVdgV81iq1S6GPx4HiIfn9P8hpn0BDlhQ0+Tjc
         vkwjMapTWs0AI2LXotbPJbyYf/XmR5SPzmVEFRNI08okC0JP1ple6xIlVmsgVgyrxkhc
         Q7YsfmViIzDOypYYy2INMbO7ivbUBktYq3jh4OmIHz/OVn2NPb/LqtZno1alDjret4vR
         EYi0XrJIHVW/IBKSFhkOmrsAMpJsLHklobeY7EnabJcDshcrwAQDqrvBuexrq1bRDH5T
         +sEg==
X-Forwarded-Encrypted: i=1; AFNElJ+stC77sdvWraR4fxhDBjPQ95XN0H0gBZYNgWtXoqxY2lXDH3WEyTTK+HqVdUCJLha39IKzLeDg4lgMJMww@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+uLyClY4Mn1ewMtGKkCllvKliaHz4OiMT87sqqFMbHI13LC3H
	Wp0D+0Mj7iUdTjfIKQLMKPFngSOUl9ZgPDtNiJAy2HpA3grAqW23fJUzCrh9QM9q5tcQfPwWT6K
	psOaWKhqe0Q==
X-Gm-Gg: Acq92OFhEU5mxrfwPzQeD6ZwvweoxHQlcHhG3unt+1xNa60Zgbv+fziGPeOgYo10fpO
	jcVyrQs5EPWffQ5lKr3JBcrNg0X+pAegqkMX50E2s/ytYJDh6SvYjUHaA1whpUi/ZApnfRaFP43
	nYQGxbEAGxG1mSwrqsvL2F21XWaXSLhAp2GJ7yiDDzdd5JSkCqVo9Fd8PiuyOWYJ48kR33jlebG
	ELWRD8ZJ8AmGdD8VFXKepbqYhcgXtEjn6cuvBKtpvYkBKpF4hgfhdix/7dxAAbINWzdYMxPmoRI
	wAlZknxsQ1iPeVvSIwQtDOMdD95mKwrrkDt9MmZ5Lchl6dOzy8OqVoeALF8XV8+vx8wMQejlm/r
	95nPYBDBD7C5G/vQHe256FphAJjCZYlqEwE0WnHrohGp9m3wGEFNQVXQkb6HBQbD44wz/D48aF7
	R8SsGiV5IcUqjTQQJJYaMRB/CCAe/ctB9u+V5o1NyMBypnpXq6QsYwnpFCNMXjinI+78HXulOhJ
	zgeqwXGbkzxx6bTj3e7cw==
X-Received: by 2002:a05:6512:104c:b0:5aa:6b70:325b with SMTP id 2adb3069b0e04-5aa87b66f3bmr61892e87.7.1780601864511;
        Thu, 04 Jun 2026 12:37:44 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b986c42sm1389782e87.58.2026.06.04.12.37.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 12:37:44 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso1251590e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 12:37:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ebGT32XjVxQw5wiHZabuBQoCnNjEVjUg8QIupMabEaPiZ62wM6yNSjce4JUZV/kyRRY8iPznVXEXfcaIK@vger.kernel.org
X-Received: by 2002:a17:907:3e20:b0:bf3:fe:1d5d with SMTP id
 a640c23a62f3a-bf373306d04mr3098066b.43.1780601447577; Thu, 04 Jun 2026
 12:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com> <20260604100609.6b37f500@pumpkin>
 <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com> <20260604183829.63c35fd9@pumpkin>
In-Reply-To: <20260604183829.63c35fd9@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 12:30:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
X-Gm-Features: AVVi8CdPQe90u6Sxnc7w9w1KvqakJpNEvGXvNsTMWUZWIferNC2FIUNZ3K7Amh0
Message-ID: <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: David Laight <david.laight.linux@gmail.com>
Cc: Askar Safin <safinaskar@gmail.com>, metze@samba.org, akpm@linux-foundation.org, 
	axboe@kernel.dk, brauner@kernel.org, david@kernel.org, dhowells@redhat.com, 
	hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 10:38, David Laight <david.laight.linux@gmail.com> wrote:
>
> Bool is another matter entirely, (IIRC from a couple of weeks ago)
> gcc will assume that the low 8 bits of the parameter register are
> either 0 or 1 and clang assumes that the low 32 bits are 0 or 1.
> You can't even check with 'if ((u32)bool_param > 1) error()' because
> the compiler 'knows' it can't be false.

Nobody should ever use 'bool' as a system call argument. Anything that
takes a boolean should take a 'flags' field with bits.

But this is basically what a lot of the SYSCALL_DEFINEx() macros are
all about - sorting out ABI assumptions.

For example, on powerpc (iirc - maybe it was 390), a 32-bit argument
is always sign-extended by the ABI, and the compiler *depends* on
that. But at system call boundaries we can't trust that the user side
actually follows the ABI, so SYSCALL_DEFINEx() will actually take a
'unsigned long' and turn it into a 32-bit argument so that things like
this are well-defined and you can't fool the kernel by not following
the ABI rules.

The same would be the case if some system call actually takes bool
(but I don't think such garbage exists). The SYSCALL_DEFINE() macro
magic would take the full register content and *force* it to follow
the ABI conventions, whatever they are on that platform.

              Linus
