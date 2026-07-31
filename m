Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB724418CA
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512205; cv=pass; b=UuQeidlj9H7X+YXtUeYu2pI/ttwV0YSdfpC68KpDQ+lJSgiSK/KM6k7V6ZnDPhE270ywxQyNf21gZTomjnFIT15Bh1F/DDKEbTqW5J04kvfAg9CYjB3Hjv6J/8b14tQ2JQ8W7j8jJ3pKfZVplse4kkR5ouofNSMqoRvlWGKF/Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512205; c=relaxed/simple;
	bh=kPzEtdgmgmrhfEvclMUzFEFQMW3YYfNU1BZsWa7XSjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGowC/O1oXnOdfDV0/zwjtwJ+osNGFNSREpr+hMWK6opS5WsDYwfPoLzRETgQQfExsqTLwIazlUU8MrOiIrEjqlSCl9LHmjy2B3SZ5FJGH2RHctO5Rmar9TOtmv72RJ8sc6oMyeM2Zds4q7/h9LVtAlxVOYNg8wNjEf03XppfjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFc/OdTg; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFc/OdTg"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c08df8513so6398581cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 08:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785512203; cv=none;
        d=google.com; s=arc-20260327;
        b=aOvMRmI4eyYKwclWxmM6dh2tQeTVJEGYMCVrrrwNvB07eYyYwMy9XVkoC9SCI69DTE
         yIxAxZmvfDNIsppLJvdASRupKjDo2t1LEG7tIIOX4eaJlTODjkZgn/1kp9Q5mKYAaCNV
         K+81HyEaUatlSdgKKWltcTuIfNegkLNX/B6bnQt9jb2/1jO7xYvok2YZxgBKs5z7Zxet
         jMujtP0JMeBCs2qkewsNrjpqKHQF+3nTQc0/EAKKZptviO6WplhKN0ZYB1yVrmjWttUW
         19zpPWFJxpfZTp3A5qWzHDa3SNueIkw6Ag5A/5z0LHsq5qabSMXDXmOkCNyaN66IqWdq
         IOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        fh=Q6r+Vv/disFJ0Y8QqeHs+CUploSOfdgk80RrbcyGIy0=;
        b=riI+vSkGXJSo7pv7ERvMME32oOCet4Mb/betXTM7hjO8OM72Ddve1757YaLRKjaghy
         Df6Agr5Y6V+laLhmwE236r9sLpaazA7Z0SCztLGBSYlbCAsU8Q3vwujp4WXqnNUCf0+0
         LTkqepGnK6yo2r2vvnC4BC87vg5G3y9gF7OgNPjqRhU9n5RwtIBQTX4hWg5LQLAuGYRM
         glrGy+G4gp4ZxdvOQM17rzMnGhp1w0mmcBAPT6KxtRnlUIa31lMucWkFaS2OqosSjeCj
         UpFLSuyrPrjpT3d+jbpAZkbhfIILE+hqHOVo+An81lpmO0eX7rzv8+nBmBRy5LR9GraM
         U1qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785512203; x=1786117003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        b=IFc/OdTggyxdx71WMUkmunfFJv/VBdRsML2egv3SAZWPQsqAefG+GCW5wF/exbuiTa
         QR7uGfe2g2p08Fxi7cbO7yEIIN8XKQYDgkRTTzsgAQkPuO3SGaSSiGhnwIgPexrOySZa
         +pZ+yNZlpxVkvSZoEM6zMPBqP0Vph8OkXnbLafOl4HbYSB/gXqgS0me72Dh31n5iZk+V
         2TfcgprOH90j2Y/h/YyQJmhoWqYtQXHojL9LdYazVTSYgmVIeG3kvXXY655TfaDon/Hm
         OOzMc1jTW2zPFrgbpFNTk0g5clcA9sqMzcETIeySBrsKVqu/NoYYyuQ5t9XCId0uEIcl
         kJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512203; x=1786117003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        b=qHiD2XLYqEJIflKio1k4PnKrCQtHS1zS8oHFw89Pw0uwOtHTfeQIFR0TYjp0xWLzJ9
         SAxrMrfsH5LpPziWuve9rWzu6T0w63bqJWpSpo3VL8V4YIEUzh6WQQcOfN5lDNdaURN+
         jr987mreAhZABhE0RnYC135bFiaGYaTAJ5gJMk1MdGo82uE0V/rew3IQuokBZMViJVGo
         +NTNHzwHZRH56SIZf6fjX43XYyqj+Ez9b0vJ2f93TBZsBz8yGH9Vm9TqdbS9/xngBhyJ
         OcrmV1RetdaLLeroeHkkcgm7+LV8fi1aWBk435gZm1FW7I92mPfmRfKchoI19rLLMAWg
         yirQ==
X-Forwarded-Encrypted: i=1; AHgh+RqrZv6wp/TwH+9rjKIphvghYKFlvFhgjD7qJM+98LsEHBBv69wb+ZNEW6C7id072PeCy5cQmOuiWIl9Ucdb@vger.kernel.org
X-Gm-Message-State: AOJu0YwnEC4HSE3TZrPW8W4/8p8hN6h8s6ca1Gj7MWBtbW/9wlQ/Ny6s
	gtiuqFu46ciQCEOrkgSx3d2wQL8ONozFkCskuxPj4LqOGaVAMldFXa8Zn6WlXxjFq2sCC42LGKe
	vCIFEVKn2ZoJUpZoGm1v1Z3ZPM9FtOnc=
X-Gm-Gg: AR+sD10lJpyPYMTKrj3j/FtmR2hzcMeghYAl1fkGxqtm3+xo2WYgbmOtwYrpt0zux+G
	dCCbst2nDZ9QyuqKjGRQxak5GMDUOc5OodLJnQUkUmHcpupLoVDByia+j/ZiIPWXs2ETzeb1iXQ
	/E7GICUUyOoZ/kME081WnfkFEF0LihNhkru8Z99R9PGTj+xAQ2R2InCdn++GeFA0cukomPGu9Qc
	21CUVQ9T0r9yaiPhv/KLgXrkEOFNJIsVn5aCt5vADvu2j6sIfzPBMFDb+tZ7hvwP7m1FAp/VPUg
	PooI0N8XkDJVZNPy5rjBq9ohhdDPIbFAVatgkIkPejpiBanaVLynECiAOs8j6qRu4zlgvr+4D/s
	=
X-Received: by 2002:a05:622a:1e0e:b0:528:3c2c:5c72 with SMTP id
 d75a77b69052e-52b5679527amr12582491cf.32.1785512202948; Fri, 31 Jul 2026
 08:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com> <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
In-Reply-To: <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 31 Jul 2026 11:36:31 -0400
X-Gm-Features: AUfX_myF-Fa2Dx12J7XG4FMqMoM3YLOYocj4Wcd15kosvCgWFWfK34tns1g5ePo
Message-ID: <CAEXv5_i+OOJqr7xb02=5JMR2O8soLJARckG2CK7yvcv2Ycj+eg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:33=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Nope.  That patchset has its own issues, one of which is the location
> of the kfuncs outside of security/; I simply haven't had the time to
> review that in full and reply.
>

Makes sense, thanks, just wanted to avoid churn if possible.

> --
> paul-moore.com
