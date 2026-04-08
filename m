Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD533BE64F
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650298; cv=none; b=ATqkmy+rkaEzmBDbBfafFzNPuWQPm6hZqNCpSO4QtMOI/jY3CHmoWuyjk/K+p4q699ep9DhwV5fyLGwm8XmFqUAx0wr2eJ7SkBP9W9kgZv6vJGRHDFleS6B/8wAxB4pmyeNI9u1UKpkLpJcafSG/oG8O/lKaDFL5yZkl06aS6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650298; c=relaxed/simple;
	bh=8scfsOfxjJCA7PsheVSzcMVVAN4HZJ5wygd7fo905BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcgWHcayyqxRLq53KAcz+4gQP+7Di2P6l8sh2sDrzV1ada0JhZr8J0A3ob+5aHfzTCdStW0u2f1C2KCiisA0SIjbRB3JwEv4eYqJJXq13SRE8FCUqNt6Z6txlv8zkvyWn087HlLix7mvwXyelDDaOLwEGt3UOEYq71FR+Zi5aJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cfdac74050so715390485a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 05:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775650296; x=1776255096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGRbYznGbDw7bAVfW0akDmACi6u2DoC61pG2AP+p98k=;
        b=Xl8Ga9dWqs9zacfMHK2tXaK9Fc+Dvvi+gS1/RiqZ6YlkeDwvn+ZGinXOYRxp8fUJbS
         7V/vjipi29X64QyX+RR0AX1r0dMeQbR7VGvLNd4o2ED+3nSkbt2W9MHIJX3QotWQWnf8
         FooAxdinzvJYaDgoXesFQSUVefVZKfibxc6CD9ZTH0+ZkpF0WFIRqYD1IUeJT6u+p59Z
         emUtQG/2+hEHo2mX8KdfV5y6wtzGAkYSEDQl+MqLO5j6TNlDvJZHB/0a77PPk8PRYtIo
         I+64787sCbOHd/behVA01I7M1KsHZBQsmPK5/6aILg1j1IKLUjPSDcesFepepJgUTXHN
         PDSA==
X-Forwarded-Encrypted: i=1; AJvYcCUj0U2yZwmVObJKi9sPzb4uCm1eYjDEDqdYgZzB7vM2mcpPfv8ItdFhds8ue032ExQ8jMAOVq+BPdNCdLRw@vger.kernel.org
X-Gm-Message-State: AOJu0YzvrKUPPnen0Q4IMm1LZLQGG12q6fzSUPY5z0ivVYpwNB6Lyvbj
	lP/UKeb2FaX2FQPzY3ZE0g0//nKy8DHlo+8wFoy3pai/j/A98t2kj05DbaG9kXSo
X-Gm-Gg: AeBDies/8u4jmHQEK0ZcPZ0ksx22KQGFPXvyJqU8Go/BWl2Ns3RGymqv5yYOVnJv2+k
	SZfk1tFcBydT+Y8Mwv3K9kElAE+sCr+XqWOv3wSDRtEcB6pvuIcxMOlUTHW6ZCOZXnQ/gdRP46g
	XPEQMfBofEwIxdPaDypkCF7CYc+OK/IdnOKKWdVN9VaAks/+e6xqgnt5fEdgDWr6r9xJkuVxd+h
	alzH/QTvYwEYq1l0g0Tz5UtyVWDMpxdTxNI5pcG7YlmP5muCCQsM/K8VmfQ/lzX5H/LVvGrZ86S
	ngJSB1DRg5cpOobOA5TuNtCYJzC7cAECPMJ8uWDOVnL3OgVBmX7UjRxHFm6Btlj/Bn3PDLueisL
	KcQApJVDam1BnTTIlT6oIAnLGY+sRq9wTDTT1J4PxoxvM1tsXEAU1WI5rLOnts3vDrNW1nSLeVU
	CcqlhnhgleL5izxvAY54CpCeMcjemZShQyle5m4t/iiBf6ttBLdb+oLIRH6nmNmSN+
X-Received: by 2002:a05:622a:134d:b0:50b:30d5:c6fb with SMTP id d75a77b69052e-50d62b610a8mr318218521cf.63.1775650296184;
        Wed, 08 Apr 2026 05:11:36 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac56e3a898sm42515616d6.38.2026.04.08.05.11.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 05:11:36 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d59d249fbso64185211cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 05:11:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwnKPXpAxDQIK44oarwGhG7tVLXF7eKv/T27UHvymbh9/YUeDXd7948uWrDocJweCASxO1eJ9P4dikxQBI@vger.kernel.org
X-Received: by 2002:a05:6122:3784:b0:56d:92dd:a0ad with SMTP id
 71dfb90a1353d-56daba970e8mr8020585e0c.15.1775649953503; Wed, 08 Apr 2026
 05:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313150928.2637368-1-sashal@kernel.org> <20260314111822.63a2ba4a@kernel.org>
 <abZTg9ZwnE5J4qXa@laps>
In-Reply-To: <abZTg9ZwnE5J4qXa@laps>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 14:05:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU5Ga9WCzD8ji8kgOMmosS+uzf_8mp_OkhFdcAg2=3KAg@mail.gmail.com>
X-Gm-Features: AQROBzA3VNDAkN7JQ2RBFKXcNeNTnnQqU_cNeGRDhYiY7nC0FR4lVKTSqS90qsM
Message-ID: <CAMuHMdU5Ga9WCzD8ji8kgOMmosS+uzf_8mp_OkhFdcAg2=3KAg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Kernel API Specification Framework
To: Sasha Levin <sashal@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, workflows@vger.kernel.org, tools@kernel.org, 
	x86@kernel.org, Thomas Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Dmitry Vyukov <dvyukov@google.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>, Jake Edge <jake@lwn.net>, 
	David Laight <david.laight.linux@gmail.com>, Askar Safin <safinaskar@zohomail.com>, 
	Gabriele Paoloni <gpaoloni@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Hi Sasha,

On Sun, 15 Mar 2026 at 07:36, Sasha Levin <sashal@kernel.org> wrote:
> On Sat, Mar 14, 2026 at 11:18:22AM -0700, Jakub Kicinski wrote:
> >On Fri, 13 Mar 2026 11:09:10 -0400 Sasha Levin wrote:
> >> This enables static analysis tools to verify userspace API usage at compile
> >> time, test generation based on formal specifications, consistent error handling
> >> validation, automated documentation generation, and formal verification of
> >> kernel interfaces.
> >
> >Could you give some examples? We have machine readable descriptions for
> >Netlink interfaces, we approached syzbot folks and they did not really
> >seem to care for those.
>
> Once the API is in a machine-readable format, we can write formatters to
> output whatever downstream tools need. The kapi tool in the series
> already ships with plain text, JSON, and RST formatters, and adding new
> output formats is straightforward. We don't need to convince the
> syzkaller folks to consume our specs, we can just output them in a
> format that syzkaller already understands.
>
> For example, I have a syzlang formatter that produces the following
> from the sys_read spec in this series:
>
>    # --- read ---
>    # Read data from a file descriptor
>    #
>    # @context process, sleepable
>    #
>    # @capability CAP_DAC_OVERRIDE: Bypass discretionary access control on read permission
>    # @capability CAP_DAC_READ_SEARCH: Bypass read permission checks on regular files
>    #
>    # @error EPERM (-1): Returned by fanotify permission events...
>    # @error EINTR (-4): The call was interrupted by a signal before any data was read.
>    # @error EIO (-5): A low-level I/O error occurred.
>    # @error EBADF (-9): fd is not a valid file descriptor, or fd was not opened for reading.
>    # @error EAGAIN (-11): O_NONBLOCK set and read would block.
>    # @error EACCES (-13): LSM denied the read operation via security_file_permission().
>    # @error EFAULT (-14): buf points outside the accessible address space.
>    # @error EISDIR (-21): fd refers to a directory.
>    # @error EINVAL (-22): fd not suitable for reading, O_DIRECT misaligned, count negative...
>    # @error ENODATA (-61): Data not available in cache...
>    # @error EOVERFLOW (-75): File position plus count would exceed LLONG_MAX.
>    # @error EOPNOTSUPP (-95): Read not supported for this file type...
>    # @error ENOBUFS (-105): Buffer too small for complete notification...

The actual E-values are positive, so I guess you want e.g. -EPERM?

Note that the actual errno values are architecture-specific.
E.g. EOPNOTSUPP can be 45, 95, 122, or 223.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
