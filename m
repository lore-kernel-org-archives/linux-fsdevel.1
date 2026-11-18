Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013259;
	b=0UcyuTbThRfvPQgMFanM5wJ1SM/tuJFpajE0dV5rD8tBmqbiatGhuHZLPpVNYuLssosG
	 fkswqfoRFBToqi/1NnpIoSfQrc1JJm3mjMGr13Y5FxVA1haSg+jVueeylY7zU6l2rfkbQ
	 Oycl/9KYKXlEvCVPOntcjXv5r2x2Xz942VoH29AWMkVTmQLIaSo1igJN4qhx3WLiPEwcO
	 v0eRIw08ADXk+MCyEeb/H5MSzs8+zJtZwZTxr1OZ2EkWAxPXCM7zg6ULtc6UB8d0Hvzu+
	 3hy2BLzU+VlKYKb4gG7nZQdB4KD3MYZNjdFEI7eWuy0kwy3d3IGpia1ejun+WKFSFcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=IgtmGgLwdp7YHZZLZXtmuM3LeEAEVVcvQiETOOFbu8o=;
	b=f3RAD4K8bJ45Tw50KSV44J6IYhnuWFh2MYGRj75pT6t9sfWZopN4/vTBE4HOEIugDRRC
	 se2YygkrVJI0eDAw1iS1z6g2kYYO2IvUNyW6HOIk0Lskz8qIZdow0rBRbIYhbNBHiq9Zu
	 vILmo0uyeRBeX8E/agw2KXcAQIWBXnbwXVz7QVJskOI9Xoq3VvG1N+U3tDszjcAiH3MCA
	 Q7Lnhr+T+U0ngBdTPo3w8Zs7seInmDmr2sV52KUF9niG83Sc9GwACJnXCljo8Mp0r3RKB
	 LOdcI75RNPsaPmtPEHHbuC6dfC3BhiVntikgAjVzDaQnAaPPaQDRw6/h5HRIHhNBKUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mce3LPT5;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809260A2616
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 14:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1809260A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mce3LPT5
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-949664ee41cso133415485a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 06:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1795013258; x=1795618058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IgtmGgLwdp7YHZZLZXtmuM3LeEAEVVcvQiETOOFbu8o=;
        b=mce3LPT5oG7C8F/QlXxfra+ftcUqbbosr68KVWr4liElvzqRdfBEqD/aEKIHceO+Aj
         +7TrSS0VWnGw72sCUYxtMjkg2MrGffSmsRtSP06tlj7q26d8E2nSTu4Z0BSvWs0M5cd8
         KB4LmsGi40TprWi9Dp8BnOyTEmFGkNYhFFanczHDzzKTNXuNvSPbFVnO0PIil/6+GCbK
         TBiO4Rkq/COIB6DJcfaHVgLG+7qjvdh1LPzUR7FonRPcRWRDNzUcdJW0Rcnl2JL9lKHC
         h5D0d4zczwBfyJqPh8GSUOsTeJtA1998BdswYK4nrDfVV55D9/VxOJDtpGtoQt8e5N5W
         k9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795013258; x=1795618058;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IgtmGgLwdp7YHZZLZXtmuM3LeEAEVVcvQiETOOFbu8o=;
        b=fLL43ZwsGtI+2c8Vgp2A02FQSZ2cHI0CF4Qa/HGQpZUa1wAVffLpBO1HfwwVYV9Kl+
         3zjvnsCi/EnQJvDSlmeHLaAYt1pxHm4X7nd8a9l2SwVV5irKW75HLIQWwAPF9S4RdQHt
         Vgk8saUXWerraVA8eTP6pZhLAxmTKeY9Y4U5L667ihRrJF8NERQC1YccTCB6tVQHtuDt
         ApzkyUv88rzJMilxnqZax9cg+9aKDON6Z62mQ+l2yA+0MnGndpuQj7zRP83qFEX6tKQD
         xk0NIMI/BVecVAirICfayY4fUaFeHxlkOWnebme1kXGGen08qHH5LvlGoBWkt2XwGYXr
         KEmA==
X-Gm-Message-State: APuU4Z+r7FKnkHSISX1BBgHxjnfYE8S+TXqC5w9psLzM7z+taXzh9uKh
	MEpTY6XvOePLakgiSsN09/O9hLwCFK+Qqb9bnbzcjAg70tRMimmxrmmozPCUPzpA+G8=
X-Gm-Gg: AYBFou1np93KJkY2uzVMK6My0Mc2suHq71bBbahz04+Qj8T8dZ6WCpTSK79elw+3Afg
	6VVmYfv9BObjq58p1zVLmjWW8ibfolgkGBu8pkpqggXkNcLZSoVu2/D6OYH9tdcp/QOl0u96iYG
	Hpva2h0uy/nkZ5Dly9uIVbCb+pompl+yPyetbTma4KL+Unn6wPlekIYy9qMUr4OBMsogHJ4PWgh
	xZ2Ny0EJQZNGpfNFXDHfYramNb/3L/XnVfxKVbZEO2Y0FpNrstEsXamSss1RXuQH0i3wZdOHfdk
	rFn8QrkWmT8IPXZnKf2TldAaLkny45Mo0tHRnC6ZKXt+CYdqqhpr2DNShAk6VZn0A5OOfxxA2jb
	osh9oOh+fsGFOLy1Aoac0I2tnml5kkwMfprGmW8Q4O/Hk4vLNssUTU/u0FFrBXhaRwuascwjpv4
	0G4iMHrXgzEqOEPO0Tz4jh6S7eAE+6y6ti9kiEXoYBRWEhU3767dfcdzrW2e3WIubBI+70r/4G8
	aP5sd6s5mVx+6+CStsSuwYL+qtN9eL+5173VqSzM1sky0p1904N3XG3nNEGoK54ak1YVNDHLiKF
	znOxvJTWqdNwC4vTyxU/ZXrAWhbtBJoxh1vuE4wNei8OGFc=
X-Received: by 2002:a05:620a:880a:b0:93c:b5fd:f33f with SMTP id af79cd13be357-94999722106mr491978585a.27.1795013257845;
        Wed, 18 Nov 2026 06:47:37 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b81d4a0sm193898585a.43.2026.11.18.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:47:37 -0800 (PST)
Date: Wed, 18 Nov 2026 14:47:34 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@amacapital.net>, Ben Segall <bsegall@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	David Howells <dhowells@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, John Johansen <john.johansen@canonical.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Kees Cook <kees@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Manfred Spraul <manfred@colorfullife.com>, 
	Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Neal Gompa <neal@gompa.dev>, Paul Moore <paul@paul-moore.com>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Serge Hallyn <sergeh@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Zygmunt Krynicki <zygmunt.krynicki@canonical.com>, alex@amutable.com
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
Message-ID: <wdwc3b5edgtgvrgqfhlzhrachr5hrqb7ahipcuqdz5pffxlc5b@662cpwhxwjer>
References: <20261117231352.3816603-1-jarkko@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117231352.3816603-1-jarkko@kernel.org>

On Wed, Nov 18, 2026 at 01:13:39AM +0200, Jarkko Sakkinen wrote:
> OVERVIEW
> ========
> 
> A root namespace (rootns) is a kernel object backed by a file descriptor
> that binds together:
> 
> 1. A full or partial set of detached namespaces.
> 2. A dedicated PID namespace for spawning processes into, signaling
>    members, and polling or waiting on PID 1 exit.
> 3. An initially empty mount namespace (CLONE_EMPTY_MNTNS) that must be
>    populated before going live, without inheriting host mount-tree
>    ancestors.

This is what cells is doing https://lwn.net/Articles/1102593/, you may
want to take a look at that work. Christian, Lennart, Alex, myself
and others are working towards this in a more wholistic way. There's a
lot more that goes into this outside of just the object itself. I've got
my version deployed inside Anthropic for securing containers and I've
tripped over a lot of pre-work that needs to come because we can tackle
this. Alex has my rough outline for kuid64 for example, which is
necessary for making sure we don't overlap UID's on the system and
create holes this way. The cells work/anything that wants to have clear
security boundaries is going to require that as a pre-requisite. If
you'd like I can include you in our planning so we can get something
that will solve all of our problems. Thanks,

Josef
