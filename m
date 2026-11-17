Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794937497;
	b=eN2iKZ1GPhXRXOz+IO9UbS0zMNHQszQ4BGTvip7CuW5vJPZNDt+lglIXB0DsEuwtDBSG
	 MxWPwzxrjqjgsIS7CbG4/JtA5tv+IUxoEolh7mM3Noa3XEeMIVJYMbRYhGeDOhAUfPQ0K
	 6FO1olRn/LBktPCE+M8obvB7kxoMD9KLoLoWu+g8wvKE09BmMxffl8NEWIUcE99gXrD0E
	 s6EwldqV4EyJYhRYYMVxqcHKKcw0BBA54YimoApjeGTXTTAp4y3oZ2pI1vkt/h1v2NFx6
	 rSRsWuHANi2b5tz6GFvpNT1dP2wY30WawpSqfp6P/ejjM8Em9lO6iTZl3sB7U2yK+8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=eNNOnQUc8HQHxzszI7I5Z5MCWmY2JGLCloKQuWJY2Z0=;
	b=0h9Ao7bJ86JKZL+1Wn4P2D+APDIkWJWEzJ/GMlar5U6UVjGv7w55K7To067b1T6ZzmL9
	 8NeTij6rennLHb/XiJLeX/Pm8qaeUJRQBQpjp5T8w82zTNj1hsMoE7AzagYwQpGcM28vV
	 hiaEZrdeiYQkhA+wmK/Ir/SSHVm/e3wVPmn5DQ6/g1Cuy/9rPfeDBNAU1w9cDOHe++qSx
	 nJYqfRcBwXSvQpHvx80n0iEFIxColFeyJbCe0RgM+ihk5YTZPlNmmRB8z/uloMQ0kF2vv
	 3tkFdTMK9UWXBTqFEw2QReSyJp0AVvxIlOcaeFu07Qd2OyOlIzRTzbLsm2Ephla+FQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oAFIhfOA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E4F606A332
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 17:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E4F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oAFIhfOA
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ae25d9e2fdso1759901fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 09:44:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794937495; cv=none;
        d=google.com; s=arc-20260327;
        b=KlD3XaBpUWCFHn3WQpDB6G5eIiwXAUnQl730rSgiXUwKLDDKwBMsinvBGc5A10lydK
         VTkSxu4M2/cycp6Akm/6p5gDKljrP8QssioCqK0Tc+bxOei8QwKN8IWrA3ha49dH+atg
         UExHkHY7dyQUyhBsT0dGIlifZRb6QWpGmlB8oQzl82Qz6Aj1RnRPeVJ2jAbNKDKxJG1T
         Ru1FnD2wzh4HHq46Cv9WEst+oY5V3xwlI9wue+e+c/F9R8d4XBQpbROojO7Npp0+pQF1
         a0WdbZc23/N5dXvKeYqAT/jZU3ca/pADdVKGoH3Ws3JyKtroifCWjCHytSq+SN+/HSLs
         T1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eNNOnQUc8HQHxzszI7I5Z5MCWmY2JGLCloKQuWJY2Z0=;
        fh=FppMR6JMyF1YXQa25y6IQk8nx7nob/FsJ1gbH6Zr6KI=;
        b=eRTkWpAzVYAn9T6Y88bFpKT5ENIMYwJpSZvldrM6B5BDsirjnyveDiCyHwhhGnV09N
         +DqQ9D7f13vN2ojaPf1W2srTEBTriL6T6Om5K8gI/tSHrYeJ8ZmJ9X+WMz3M/uVwRLWd
         baNoZ6x0Is/lo6ikfOD1z7q7FW9ENBm1wl/3UjJ40p7lCnmnMdL5S8AOto8VYjb9AB62
         FnCCOLzymUVLoBQnCDdxJrUvn9ittLAL9/mJgXroSQlhc31/J1KKtTfdE2LsnbNmPtlQ
         dZikFjylnom/8YrnQptgnzIdNYvTtAon33CenELol1ZD5MbXqTPtHgAk2Yqi6SeGJdWV
         sFzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1794937495; x=1795542295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eNNOnQUc8HQHxzszI7I5Z5MCWmY2JGLCloKQuWJY2Z0=;
        b=oAFIhfOAkcB0Dg4mKVfkuis2uNtcfHHW1ME1slyaFUO4AI5iAHAmrY1Nw3LuN2VQnC
         6IGXyvAYklXrHuXDFIJP+OpIvCKpQXcsR6yhi7y7UMeoYZWd0Rkq8srCeIQr3Ut6yHo9
         s3QMrLw8d+7yQo0fv8lDR6N1UWY7BgFBjya/tZ7WAbd98chUjwhGKhZVz4B8CNKS2JVt
         s01yrFYXNsMtBbhpU0mHCjFVPEb/8RNf03yXDk0jC6t71dtVUAnUQlSNlv3yrv5kFy/Z
         7TcwXV5Nfa08sHn/NIrA4+u1dyH1Y1UL/1CiJgo3Ncba+UeXkhzzSc1rUH+9TFU6YyuR
         ZiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937495; x=1795542295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eNNOnQUc8HQHxzszI7I5Z5MCWmY2JGLCloKQuWJY2Z0=;
        b=L6Rh6CVikmgrbBEnqO5KU3UoC8srr5ltT0PnK4PPc4LsibpDebO55mLtXF8KdYLrI5
         hih9b9QrrdmB7paYk1DG8kRFJWiK3v8e/mJQCkg1AoLpskF+7i6r8RsD6FQ7pAWysklO
         RfzaBXrEWs5npDqpzQFr7+hCYnKM6/kh04xZWGclPwccuAlYq7NePmi2EP3UugJBEG+w
         VW8cMSKYx17DhDVhtL8kDeWoz25BQXjCmohidaLYYYddjql4PnqIHZ+DPbQreWq22KRe
         4+hz3VQZfsf6mFILQtAQI99DwOtoV7ylbaj19zOBnOBzJ33HKNht0uXkeQbq9Ataujn5
         oG/g==
X-Gm-Message-State: APuU4Z8lajvzE5RrcQ858i/RqeWEBVP4ptYos86DsXD4AKlxUHgFyli+
	ZOGg8PpEU7vAO6kcsHE1ZFjPI5aQQ2xRrFzu3rCj1Mk3WilCDRz0sHwkYemfHTq54aXY4Vc21ZN
	0WofWlSHB6R0uF9px/toRv987FWpuHoAHLL/cLC3w
X-Gm-Gg: AYBFou3JHk1DNI1CcoY24ftJPNW7ygy+/QyveGm2qupzHFAzuhLuAxRQDV0iBp/P/T+
	lCkCe96OvHZ6w+RiBFNo3sfirdTXCBgKVmHRaf50aOf7H7RPCZZf9OeHHzGfpX8442S3Ssw7dgw
	wQCn+ezAYxaA7fmLfiO9Nt/mDiOaCPtMpIK4BUcZ8pg43Uu1uo+H56tVhxtq1wzppLScDQSeLSq
	xxSC7NsF5xTwGRWaYRf/gTlu4lwHxmCijBurrzeq1Y5kbWtyrsRxe5ozjYPFrlhRtn5PKPGIzCl
	nyS/ZInwPW3azS6/9AM2V7GJNnUbFa9WR2inWh+Rb7nX7O6mOcwV8Re/6STuIUH0i2iMniqgC4D
	WeTJnMeFRS45wxqsygpK3UpZ4n5CcRZm+em3biEBjJzULHCDMwenWdX8=
X-Received: by 2002:ac2:51c6:0:b0:5bf:b945:4334 with SMTP id
 2adb3069b0e04-5c170a15b78mr6210350e87.67.1794937495491; Tue, 17 Nov 2026
 09:44:55 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117050841.3289652-1-jarkko@kernel.org>
In-Reply-To: <20261117050841.3289652-1-jarkko@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 17 Nov 2026 09:44:43 -0800
X-Gm-Features: Aa3M54pzaE332pTi53D1YpA5VO7WahNUrZvzEHccu8lFNhASVJD5SKW-Zdzq05g
Message-ID: <CALCETrUBUnJVhiMkft6hTZZMe8nTpMBRTGY2v=9x5ETBSvmPZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] Namespace for namespace roots
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Ben Segall <bsegall@google.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, David Howells <dhowells@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Juri Lelli <juri.lelli@redhat.com>, Kees Cook <kees@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Manfred Spraul <manfred@colorfullife.com>, Mel Gorman <mgorman@suse.de>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Paul Moore <paul@paul-moore.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Serge Hallyn <sergeh@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vlastimil Babka <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:08=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> OVERVIEW
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> The problem that root namespaces try to resolve is starting a container
> from a root mount tree that is pre-populated before any process is allowe=
d
> to run, without inheriting any host mount-tree ancestors.
>
> Work on this feature started originally in 2025 from David Howells'
> container object patch set [1], but I turned container objects into a
> namespace of namespace roots and built a new implementation around this
> premise.
>
> In early 2026, the patch set was left to gather dust in my kernel tree
> [2]. Then, the other day I saw [3] as was shocked by its over the top
> complexity and thus, here we are.
>
> Not doubling the number of container frameworks inside Linux kernel is at
> least a benefit over container object based solutions. Parallel plumbing =
is
> an inherent flaw of container objects, and it directly affects on
> development and maintenance cost of container runtimes.
>
> Also, thanks to better scoped implementation surface, verifying rootns
> correctness is factors easier than with container objects, and even my
> early kselftest is meaningful. We know what and where we are testing,
> which is always great.
>
> Finally, it is more compatible with pre-existing container tooling
> whereas container objects would have much higher cost.
>
> [1] https://lore.kernel.org/all/155059610368.17079.2220554006494174417.st=
git@warthog.procyon.org.uk/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.gi=
t/log/?h=3Drootns
> [3] https://lore.kernel.org/linux-fsdevel/20261105-b4-cells-v3-0-bc909593=
7a84@toxicpanda.com/
>
> IMPLEMENTATION
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> rootns_create() allocates a rootns object backed by a pollable anonymous
> inode fd, pinning dedicated empty mount (CLONE_EMPTY_MNTNS) and PID
> namespaces along with any optional namespaces selected in flags.
>
> Before entry, a manager prepares the mount tree through the control fd:
> FSCONFIG_SET_ROOTNS binds a newly opened fs_context to the target rootns,
> and move_mount(..., MOVE_MOUNT_T_ROOTNS_ROOT) installs "/" onto the nullf=
s
> root once and attaches relative submounts beneath it.
>
> rootns_enter() forks a child directly into the rootns credentials,
> nsproxy, and root path without mutating the caller in place. The first
> entrant becomes PID 1; once it exits and zap_pid_ns_processes() reaps all
> members, poll() reports EPOLLHUP and rootns_wait() returns init's status
> and rusage. rootns_kill() walks pid_ns->idr under RCU to signal member
> thread groups.

Can you clarify what this new API actually does?  I've read this three
times, and the best understanding I've come up with is that you've
designed a way to create a group of namespaces identified by an fd and
you're adding an API to configure and enter them cleanly.  Which
sounds very sensible.  But I'm completely confused as to why a
namespace needs to be owned by a "rootns" or why that ownership
affects even newly created sub-namespaces.

--Andy
--=20
Andy Lutomirski
AMA Capital Management, LLC
