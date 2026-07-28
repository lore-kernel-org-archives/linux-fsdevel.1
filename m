Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DAD369D57
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255391; cv=none; b=D6tMvlldCePg8xoBN7rkgrGr9pmwjHMZzlJ/kowJsVr27ZRBgsPnTTqad5pjDGoZw3b7JnxNZTzYTqvw4EgF0BvK3SYgVsWBRauWd29UIcmVI8wzcL3qv+VEDLvvQJcu8qSn90SmmKbRT6XQmUWjlOMaqSCVv3KFehCKKn3jkhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255391; c=relaxed/simple;
	bh=zbP0fgi+EApB+uBYo7yptEDQz6XO8DHNjqcRXnDFGI8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=tUl3ZQqsEulmF/SHnHWfd+ZG6M8PVdZY+Cc78dfGvBBss6GBKCcSNmH8RCIRZVcq2WX6GEa6ZO4uRlpfT87MU6qrWuS8SuW312OBAnJnbddOw7CDquDGSDWkd2pQduDPJMUIRWIY+d5jEq7PWOdmVSiiG/HE0hu9GfAL2qEo2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MLrO+Sc4; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MLrO+Sc4"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7475a4f8b05so2230071137.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 09:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785255387; x=1785860187; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cAriX3tLCmrnUO4qSHhwDGkR5q4S1pPXvajnZr56PhA=;
        b=MLrO+Sc4b6q1HMMDqe8zweEY+eTufkd72mEHrcIeunJYiD+DD8V3OG6GtVPpqOETgf
         5eiXG39R6K6hoE7+QJXkI2Luw5UzPtDYiaB8Gs17bACYCsCG8nhymMPxlcfrulcdKfap
         QLxp8M7Hzc07VUZqFr6zWw8gZyP9K0PJjQCoBwIwZULxzOeI3tZyALg8nhbKRV3nZzFx
         vHUYM7XA0Mi46VMkSq6YTUr8ySBzQxhvs1298n0Fc+6amab5jL3t5JlPUT9+pa5Dmivm
         29uFdxdKQ6eYJO+r6HPiqe6gD/VCbBJQ3FZk56Bm86uI6jWgJJXbAbLhRKFNkr+HpSB2
         ntLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785255387; x=1785860187;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cAriX3tLCmrnUO4qSHhwDGkR5q4S1pPXvajnZr56PhA=;
        b=FyYDyAUia/1ZmNxIcOy3ZMdkh7S61PFip4ZvTKSfonwqSaTwgcvVZK/IfvUs3KY3B7
         wBxUL5qaj6hiZtWGAy7mlAZ4XtmmJVjhxVPGoZCdN8M/gK9pX4suN7lg31Yrqg4j0quR
         lMYDpU2RyzDduSi2U8P40RX28Y4K/98D9yUeb+wC6rm2uTVgD6Do/U9q0ZQ2yUQy7hzK
         FRaaJaCk7Hup/Ng1B/DyyXcXVkZRKoKSE7rc/WtrqQ/lsQwYXN4AFOOCHBAVgJFQXaSc
         ihTU3Xkc6nPLOdwzURS/rD462k99cPZoH9dkryahC7hN4TPIjMuHzi7hmiBWN90u+eyf
         8fKw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/KlFGdjzB4DeGjv2ciKDR1hjDJgKuYynEM60PoM9jHQv/MAeHsdvjlPbWPisaJZ1Xo1+PzGz2fLSFKmWH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+9eTBODI+wjXM4hgOq80SBaRQ22Nm1BPx/DolPPZaQpRIUygQ
	cP6aJ/v4Fx6uj3q1XizctHIAgL/JuTaAevcQF9P8eggqcnBY0ulPAOlrwNrlMAZZkQ==
X-Gm-Gg: AR+sD12uQfMm8hLx7g8ZiMVWi9AKUHTWTCMH6j0lgQDDgQqxxkrNgIm5+AuRFppcyS3
	nkg+LlH1cYW+0NDNvJBcXKSqQjjXo5AU/erCvEudd4qm1o0nAliisfntm3ClODWpWt/oWZVkoli
	CAKtK8D45I+dEikRSsxnxkCya09gKbWIFSi6NSDETDVM9tQS0qyzU5wjghuhRveRrPY9zNc1tOq
	0jLV2tfl1QE5bwjVzmXYycVmaypBwFxsGM2zuEOK0r+PtCCFBjLj41mqCeijPr7T6cYLEJSQMXg
	1u4UafWrET+/bCmBGh+jGdVbqhI+x8HdDa65PQCHk8Pbo5vaMNbaAOx720QYlU5tXxaLDOb1XyS
	eyi5oZbH/4ybn+iC0nBQUeN5d0DOt1lSl2lWil7q3O8sXBh5wmnN9rQar2Vl98QHy+nVp9AF5mk
	nZ8tDyb8JBwmY5h+c3NT9QUtel0rte78QZqTBOr/CfcA+HI4g=
X-Received: by 2002:a05:6102:942:b0:737:ba2e:8a26 with SMTP id ada2fe7eead31-754a2dcd8f7mr1579232137.27.1785255386692;
        Tue, 28 Jul 2026 09:16:26 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dc44d0fsm2424756d6.6.2026.07.28.09.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:16:25 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:16:24 -0400
Message-ID: <2f53e3c8ee57824f1c741f76021eb2ce@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260727_1648/pstg-lib:20260728_1147/pstg-pwork:20260727_1648
From: Paul Moore <paul@paul-moore.com>
To: Richard Guy Briggs <rgb@redhat.com>, Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH v1] audit: free proctitle in context so it can be set by  fork
References: <d67349e701acb3125d733f833e6ef2e47c91daae.1785101356.git.rgb@redhat.com>
In-Reply-To: <d67349e701acb3125d733f833e6ef2e47c91daae.1785101356.git.rgb@redhat.com>

On Jul 26, 2026 Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> Original title: fixes clean proctitle in audit context on exec call

Please don't add stuff like that to the description, it's not
particularly helpful by itself.  If you want to link this patch to
something outside of the git log, use the 'Link:' tag.

> Between the actual process startup (fork systemd) and the executable file
> replacement (exec), systemd sets a temporary file name (executable file
> name in parentheses). If an auditable system call occurs at this point,
> the audit context will latch the temporary process name into the cache.
> This name will not change again. The patch clears proctitle into the
> audit cache when the exec call is made, allowing the new process name to
> be latched.
> 
> Suggested by Roman Dolgikh https://github.com/rmd4ctf 2025-06-11

Considering that Roman lists an email on his public GH profile, it
would be better to use a traditional "Suggested-by:" tag, for example:

Suggested-by: Roman Dolgikh <rmd4work@mail.ru>

> Link: https://github.com/linux-audit/audit-kernel/issues/170.

No trailing period please.

> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/exec.c             | 2 ++
>  include/linux/audit.h | 9 +++++++++
>  kernel/auditsc.c      | 4 ++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index b92fe7db176c..bd51489dec23 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1744,6 +1744,8 @@ static int exec_binprm(struct linux_binprm *bprm)
>  			fput(exec);
>  	}
>  
> +	/* clear proctitle in audit context to allow replacement */
> +	audit_proctitle_free(audit_context());
>  	audit_bprm(bprm);

Since this is the only place where audit_bprm() is called, is there
any reason why you simply didn't just move the free into __audit_bprm()?

Doing so should shrink this patch considerably and would keep the audit
overhead to just a single !audit_dummy_context() check as it is now.

--
paul-moore.com
