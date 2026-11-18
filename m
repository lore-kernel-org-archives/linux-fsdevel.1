Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795021194;
	b=c3ZTVvxpZozaczIIhqTxqTRtZQ28xuACHrqsijHvJzhMEPTT0EgKq86+ZobOnduyZZHg
	 yyejm4wCxWiwcGh/Ayg93bj7LCjlAypT7RGs+kpYshc0ukL9F8SGa6e2mqvwdfUW7B/c9
	 99h0/gA3y9Y1hc3p+AW98NRLUf4Ri4oTypP4wYt5ecIDMOHTSHyG/4G5PZAYsUD/YTf3J
	 QJU8OYx5n/5lzRNwBjplkjl2+R931LnNNxGWYow1aoX6D9jaUeFwBm+XEPhAMiCTRwTYv
	 zyQAa491yIIOO1y+MKDaBdUbzcHItm8/EqS2lyiGK+15+VMdT5rvenaRAFMNlf5EM2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=+eo4FKNzNbHf/eH43g1C8Z3to6Do7+2E27gt4uDxW08=;
	b=BpTsNiB4iKZpB6UqHp85qUdWTag9uklAcsrThs9Sbye+ifegsf6tyR6B/vYY8xtQ1PPt
	 D4OldSDw+RVd7MjCCqWzgHIgV9iPHYsO1wS/koPFYC5MY+MPvni/S2cHyAiv1oklKyktO
	 G6Vu7I0NYcl3Ws1U9xSYdWZNMpOX2o5Jz0xhLzMMbaCViYo8Ay35scS3hINysYfH/Uk5g
	 GKNkWuhfgA5XlPf+/1QepKLnfoVZCKxg/vm89/gaaj6EwYMJHm/qZpkX6FEgLS2LsWdCq
	 SH/Hp807yZ/4OlbbxEhLCaiGngMvybURCtlJ0WMBhky52Eizz7GQS5yGOokDCd9kgQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="tsb3jtv/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFCB606A333
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DFCB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tsb3jtv/
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be4a2d94adso1049649e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 08:59:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795021192; cv=none;
        d=google.com; s=arc-20260327;
        b=U5w0Y755wzfvsxmYIfIMUkiWOkZ1SpPCbPEjQ+MZJwrpnJ5qeb5VOkkMD0mZ96xTN6
         3GsDtUtK04CoH1uogF5o0fYjr8QcYXWseZOVKqAZnkT1dJauVyfzjObsSfE9tWYc2UP5
         An7xkEK/obn60ZFdUZCpiIPKN2GqEe165JS0DKRFqD4fyMvkLt7v1V+mWd4CP2U49iBf
         0Ddu9opwNPLp3Rs2BkWgTizBojT5MY3erD3zu1npv50H8vyarfRvGJ8EZaTscWyBVlPQ
         Mrgk4zSewDZMyhFT2E7ACJnJTMNeDuCt4QbZH4/s0QI5F0JBfy3oolihmezS+EDe0uHN
         K3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+eo4FKNzNbHf/eH43g1C8Z3to6Do7+2E27gt4uDxW08=;
        fh=WOF/u9Vzt8ymIFuSM9c0Kp2h8kn9MMnBEM4fJFepAc8=;
        b=IlCkWqQXNbuzqoC21NTsHCrjEH/30cfIFCCNZOnOeI5LGCSxUf3snwtJsE5Yt5COrY
         7smPNBi9Eu9sasVB1dsKNFECNofzLygsw0iQm+KP5Ydoga+lA7pwYUx0Ltt05lJviDPI
         ageicZW6PlPCdwn6ZW6jWYm4rqyBWfTcPMcU6zHwavzYzvwPbfv9nqIIHjeINdRDdG6J
         rmIvFimm4t9R7uCkyJfApgBqC+MZMSOK+H7AdlHx5F+FnMrT/M+2r80VXAaZhYNLC0h4
         pO40zEyqR61ikzpVFqCNNMzXlBh1CJJeP27M+kc77R/C6eKM2iJ2yR6i1TK2Q9vX4pry
         jQPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795021192; x=1795625992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+eo4FKNzNbHf/eH43g1C8Z3to6Do7+2E27gt4uDxW08=;
        b=tsb3jtv/d+zI1r94mKuk01oFSXaGJ5VfBd68Dm3Rzy3k/9SLJEJI9zvC5ERx83P8mh
         L/1k5WahXt+pRRzhHcYHDMSRuJM1TjD5VHtPSmgdvcsE7bgjMsIlMo+YJOsxodt6BDKE
         WgZi0KNeAOjP6r2GiyTfd+fHBUESbduG4DYdClB/Bqst6T6AYc3Y24sbaheI8lu+qMGX
         3hhYwGZJIpgbaepiYwepZXr+V9cZ/bQz35fnXnkTNzQzPv5ISz2zAb8tKPjJ5JQ0vFBn
         iosrC4gHAY/nVJ74V0i+yTKb1wxgWpU8SzcVufvUcALVry0duvdDvm8V8jy8r4h1xcDj
         iTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795021192; x=1795625992;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+eo4FKNzNbHf/eH43g1C8Z3to6Do7+2E27gt4uDxW08=;
        b=YBCiEdhVzAHu2bRYRJYwB2hQd2PyYNlewmMWbrsa+2hILJ7uuHK9SLrhqtDvv4v5il
         2j92CEeiQdi+9t0XX1tmgmZkdcyrqP1XbdEajSEeHpg3zHtAHpvou4sp6xcHEeBNdwWQ
         EcIcYkKusvrtUlkd4fRIAE39RH/sLec1md2Xg5ggsJoFg4+rUp461b0+GI8kp7tsCPRk
         rglOke4XKJCVPYPd9IXQBcoyst+Ma6JCrtywzJ6DIWobF70+Z+bJcG3LzdhSG3rwdhnV
         JzS+FT3beBc05TLCMeICNSnsgrgzrXnALakjGMF3pexciXDe7tmrf8fi/eG8PMdGOh6F
         SKKA==
X-Gm-Message-State: APuU4Z+RHZbJjZ607bsMmR6LAY86iKs9iA81a9ZyHIfrjtejOxJs8ZUy
	rtBElrg852MVApV+DphYyorBVaRjKUB9uNEiMAusOZT+wFEU+U9rnjsF3Z1HonCnixIOftK+ltk
	vSdzvfMfB720wC4BfRMTTLChFtAUuCKiYWn0B08dk
X-Gm-Gg: AYBFou0rIyAd1TptGwiGIc82y1TFLKswqT4V4mgzmvHG5p4KU3wBwWWmFt1aEH+J7J7
	h9S4wUin9nwWuHZo0nz0h/HnSrTnIEdrmx9F4dKi7fjfvkF2U2Bw3utK+9X0u/v9P4wdu0mTomX
	oz5tuu7+4sFYSsEzkdXsG4PEfvTKipZpJgxSquZ7v2pSWmqgg6rlCtPmCHYNpbiq1IxTS2sVJeI
	TP6VkKQ9Wqx1vjrr/zVtHCYHjk5nG1xqWYpaQUH0wtwwx/bcEESqA8m3fpu9gtH6LeDSqtMrcB1
	u4zJ2yX3rcJmfKyf7KZJ46dbWwb33h/GLwPJCdtp4wQShMNBIFIFYyr8PYaRSEM4w76f7oQZE3B
	1FDjxDAdi6vW6pSRMN8cGh78lQhNZc9lzqg==
X-Received: by 2002:a05:6512:318a:b0:5c1:4e41:3cdf with SMTP id
 2adb3069b0e04-5c1a9c09ccemr1012943e87.12.1795021192313; Wed, 18 Nov 2026
 08:59:52 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117231352.3816603-1-jarkko@kernel.org>
In-Reply-To: <20261117231352.3816603-1-jarkko@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Nov 2026 08:59:39 -0800
X-Gm-Features: Aa3M54p70wvOKpegO09-C-J-9l2I7cJO4B_J5hynU_tjApdK664yCTjVeFp42MQ
Message-ID: <CALCETrVUkbpoFjwSAejyA4b_9qEauAP_36i=O8Op1ifp8aUkqA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
To: Jarkko Sakkinen <jarkko@kernel.org>, josef@toxicpanda.com
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Ben Segall <bsegall@google.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, David Howells <dhowells@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	John Johansen <john.johansen@canonical.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Kees Cook <kees@kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Manfred Spraul <manfred@colorfullife.com>, Mel Gorman <mgorman@suse.de>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Paul Moore <paul@paul-moore.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Serge Hallyn <sergeh@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Zygmunt Krynicki <zygmunt.krynicki@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 3:14=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> OVERVIEW
> =3D=3D=3D=3D=3D=3D=3D=3D
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
>
> Work on this feature started in 2025 from David Howells' container object
> patch set [1], which I turned into a namespace for namespace roots and
> rebuilt around that premise.
>
> While the patch set is manually written, the original motivation came
> from isolating LLM agents. Running untrusted agent workloads made it
> clear that OCI runtimes need to minimize their live configuration
> surface.
>
> Assembling mounts, credentials, and namespaces inside helper processes
> with a half-configured container is what I see as the main challenge,
> and the existential debate around namespaces and container objects is an
> unfocused discussion topic.


I've skimmed some of the series, and I see a bunch of good ideas that
involve using an fd to manage a thing.  But I'm wondering how much of
the value is added by that and how much is added by having a new
*type* of thing: the "rootns".

How much of the value comes from the rootns vs the new APIs to
configure namespaces without entering them first?

For that matter, the cells series also seems to contain a (possibly
very similar) variant of the same thing.

Would it make sense to come up with a patchset that does *just* the
configure-a-namespace-by-fd part?  It seems to me that this should be
an easier thing to agree on, and it's a big part of the complexity of
all of this, and it solves a real problem even without
cells/rootnses/jails/whatever.

--Andy
