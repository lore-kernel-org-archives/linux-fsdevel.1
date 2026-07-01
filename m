Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E74C900A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930601; cv=none; b=bhOOChef8IdrEBRD5tXaj/FvLSR3eA2qvabiP5ZvczqB/ZnExf1y1/+nVo9J2xy9nWBoaSQ0KvlRFwT9ICRVwWT6sxMsBgYv2UYUy2YkrDxi64PvJLG1sJlWf4gV1Cbc01oN4wR6wK4/RMg3NaRY4skUtbwJsTojgeWblASP6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930601; c=relaxed/simple;
	bh=VvWhD9uCe/fUG80tcSOwUJLgKXkBZvDeMerjAmF/+Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fR6ynhj+lgfxGEXZp78moBgwbiTTTwiK3dlKS8giWFFmOJGo/4BAZx+gQVXKMUKvslD1czqYpcTLoHTe8BVzYKlphJoriLCVIdSSRYNAVJOwzN6QBD8nXA7mLmHYN1KCpYKRjSCAGSJzlOPB/Mrt80m1TYqoynLHZqFjJyATGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCBAI0LS; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCBAI0LS"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66493875766so1265256d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 11:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782930599; x=1783535399; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CrdS8mDAZvbbMdMv1Nmz0bWnx+5QA+JrM0BXelzn36w=;
        b=iCBAI0LS8LIgqI/6o+NJc6N0nS1zTvc5fpFgza1X2m6aRwcu1QKes0dty/LI2jNa81
         vkmVSGjfK82Jmkvc8DE++yIZEJpiOQUCcfdHW8+62K51uBCKAcFsBu7CGPbFmPd+1VyE
         WJj50y0VBZYgEMyBlLAjHgdTJ3xW4WebaGA3cEQpzy+WPCGtvcsG8nRc734Ow2ppR1B/
         hK4D6r3aQNaiVYG5nx5yXnXb/XaAyCLEpT2USRUTdOoMQEErxTkvdHHScTTQ76D45+oi
         oXeVtoC0LIa+eggA80sWAdep/eeBmroMwmyqCCUR9JoORokss5zYKsZuPHg2eSTYZ7TK
         8gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782930599; x=1783535399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrdS8mDAZvbbMdMv1Nmz0bWnx+5QA+JrM0BXelzn36w=;
        b=PSUokcV/y28b+eZ0kGJYBy6bcD/hzP71lYKBpvG9OB/gEQ43yslluGl3+6OOl9ylAK
         n/z6NKsF8LJKrmZmrpozINohxvmhX2OJaUUa4DI07/xIqC/0CF5rXvI3fTy4uXWG2wlh
         i4NhogoPFbehO4y2wmwGyfEbnKu2zNcHXN6Gx7AyVDgvDOsAuzt2gJd1C+dFeSsz/Xz6
         hXgHj6DKyXlwXmZaAMBNEj8DbafqYXpTvSGVwFMkVx+Cwi+cEx3K9VN4jDX9oYf/m1a/
         zmhYuS2DNerWepvOArA9XJJc/ptUgMh35SMJdaB+B/4bFEloZPdC5wOMRdnzMWhmal4L
         TekQ==
X-Forwarded-Encrypted: i=1; AHgh+RpH4+0bKvS7cRATfjBnWRfkLFeYGz6oZHiOkluucYFfouUlgcPpLWuaessuuXqRacLI/ioceg5LgF9K2f8E@vger.kernel.org
X-Gm-Message-State: AOJu0YxAH/qQBPF8erhRJPm7ltfW/7MXjGXmBYOiklPHHrTd3vOGPWrp
	0/HkLsynWykWZpfmnOVhkN+piCWQuyIkrkkPIb09Orxf88YJnImndfsl
X-Gm-Gg: AfdE7cm6u2xQNBpYO8irUG6QANfCElUAekjKrJiaqC8lGcDXEybQbtfgw2lhgCKU+lu
	NHw/NjcrjGhDHN3B/TMjCSgEFVin0tZ0psJkyzYhZkCW3oEPHy4ghw0YuVmU6UXo6VHF4A1gOGp
	x5rg3L/p4HdW46NPzKBtZqlpbyZJTainLxkOqMnChrdWdRXx0SckwtjReKbdnLuAIWVg7pnBSSD
	F+X3/sZYDxQFLqSLwXnzlaKCofCTJu60jNLJLuHs1ML3jdyQ66tpxgm3FYKJtqhn6kNcTFrGZJ7
	ZW4EsiRPn9Kd1t93fbW4suwRvYT444r5lCqCfcJEHUL1rodp1NHZWeSNh6a1mQ5vXZzeC7E96KO
	HHgyR5vYv4eAZftszPdPwOzflNB565F5c8/26u9yk29Y204bA/BkkbAWHK7+tDKzMyUGkVEiSBg
	CNBaVxKZIxwqG9F/6YjehVWLv1DBzUlg4G2yUVtU26xQ7uKMx4JbF7tkCtWQ==
X-Received: by 2002:a05:690e:43c6:b0:664:ca2a:e31b with SMTP id 956f58d0204a3-66521b3fc28mr2388069d50.38.1782930599404;
        Wed, 01 Jul 2026 11:29:59 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:60e4:f1cd:c4d2:6ac9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-666239295ddsm77740d50.0.2026.07.01.11.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 11:29:59 -0700 (PDT)
Date: Wed, 1 Jul 2026 14:29:58 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	jmorris@namei.org, serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, john.fastabend@gmail.com, 
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
Message-ID: <akVbLGYyafZq_93v@zenbox>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com>
 <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox>
 <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>

On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> On Wed, Jul 1, 2026 at 8:52 AM Justin Suess <utilityemal77@gmail.com> wrote:
> > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > On Wed, Jul 1, 2026 at 6:59 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > > > Create 2 kfuncs exposing control over Landlock functionality to BPF
> > > > > callers. Export an opaque struct bpf_landlock_ruleset preventing callers
> > > > > from accessing unstable internal Landlock fields.
> > >
> > > Generally speaking we don't want to provide APIs, either in-kernel or
> > > at the userspace/kernel boundary, that are specific to a single LSM,
> > > see the LSM syscalls or the security_current_getlsmprop_subj()
> > > function as examples.
> >
> > I would raise bpf_ima_file_hash, bpf_ima_inode_hash, as examples of
> > clear precedence for this. (BPF calling into specific LSM)
> 
> The BPF IMA helpers were merged back in the v5.18 timeframe when IMA
> was still standalone, it wasn't until v6.9 that IMA and EVM became
> proper LSMs.
> 
> > Kfuncs are explicitly marked as not being an ABI, and are more
> > flexible for later changes / deprecation etc. [1]
> 
> The issue isn't so much the kfunc itself, it is what the kfunc
> *calls*.  From what I saw in the proposed patch, the kfunc calls
> directly into Landlock instead of passing through the LSM framework,
> e.g. a function wrapper in security/security.c.
> 
> > LSM framework API can mean a lot of things. I assume you are meaning
> > like a pseudo-filesystem mounted interface that controls LSM?
> > Correct me if I'm wrong.
> 
> My apologies, I should have been more clear.  When I speak about the
> "LSM framework", I'm talking about the abstraction layer that provides
> the interface that the kernel and userspace uses to talk to individual
> LSMs.  The LSM framework is analogous to the VFS layer/framework in
> that it provides a single API for a variety of underlying subsystems.
> While not 100% correct, you can think of it the LSM framework as being
> the functions/hooks defined in security/security.c.
> 
> Does that help?
>
That does. security/security.c seems like a good place to enumerate the enabled
LSMs and to check to make sure that Landlock is actually enabled both in the kernel
build and that the Landlock LSM is up and running.

The above patch only checked if Landlock was compiled, when it should
actually be checking if Landlock is actively enabled.

So I will probably make a shim for it there that gates calls to
Landlock.
> -- 
> paul-moore.com
