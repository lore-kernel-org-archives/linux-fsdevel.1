Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4F35DA64
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013671; cv=pass; b=irANYX3+z2/rBGuKi8LYfdTW5lyr9RsJVAdT36xu6mhUHKWZJ90t9oEdT1KB8UT7Hb62HCnHyUMKMhnEEQKFoFVwHYBxRRcOHEVNmbFcai9m5fUoDRBGlJniaQZIbAzbnVOt34Amc1PPt/TEN2V0AilcXHnxLVSgEpiSr66oaqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013671; c=relaxed/simple;
	bh=dABL+RclHHEvo6AenqS1yr8ZCqinVWuEF12WIMeMDrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbzBQGzxA9EnXyyYw7GaBYwuyI+uPU12SW/7jPAKIbrYxSEUMLOeixXyupI+zeIkzgAUygt6H8+Abo3y688qQnBALM2TEbVqqL5umjfwD7R1c6ZJzg3HnZ7nK9Mh660o1vC9L1j5YHFYaQkg1Dh8bb+fhXbmRx5Weh95Ij8EGco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2mLMoKd; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2mLMoKd"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a48deebe95so57216636d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 23:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777013669; cv=none;
        d=google.com; s=arc-20240605;
        b=hWEYyDnGKcXh1GamwonMFaWD59Ojs2ULn4+cZGo0+1LyxccFxdXp5hje0UElspcAlc
         /lravHfuTtpPkc3MFh52v+/sDT6I0ve+BxNPE5P57J17en0CP23i6WfTN/oqQFRgjgZW
         NAYAs2yUDB3/5A7DQLAYlQ+7VGZtNszP4yWzUmTa5cNgyxf5+M6UgMQmKSKiPzTv8Gga
         oz1QsDl5sZqJ/KDn1hW1GKKsDzZkVmue1fk4fweYzfsAMEodCtVYFKYezsO1mQkkWvA3
         9RTziOuGJh0boZ3A2enJpooaaOagLcwGk61TxhFXhkqYC/OqzSkfUNHqOPOCA2p4puLf
         Tjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PY6x0drsie9DTFRy/FzyM357y9cc2vXO6VzIJJ4fYUA=;
        fh=3I2/VEa5R8nvqk3xtY+l5/4iiAHe7DgWE+eq11wtIq4=;
        b=OKYTp1uia++1CHpA1yE8UCSpzNHuY3gIXlVm689nDxriMS+wufbsdUJOZqq9knaxjG
         NEJDZAc/Ilxz2FxRElXi1oYifKZPpWAqiCr3bEfJq4c230R9mftL/r+H0i/NnXPNEUI1
         RpzZf8lRzbspGIkDAPpqnCah2N0uI5p1YBYdEE6f1QJ9KfuwoP3W//hVWN4eYVBdYz3q
         DE998KK6MhzU09B+H/vmCJY5d2nHJlrcv0LqiSsqXGLBwV4iSOwRez6xeTAddgjq8uRG
         lXbl56sgkCjPCOm1U8wzBMn0YZI2Nmvdh0dABTd8ruvYl9JdZMiaOuGx+6710rolXtvi
         Qmpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777013669; x=1777618469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY6x0drsie9DTFRy/FzyM357y9cc2vXO6VzIJJ4fYUA=;
        b=o2mLMoKdONolvwpELVe42lkoZJgdQF9BDyoyeesxKfKGt9Ab5BhQjKIf0JzckU6nNR
         KG/YdqH/z3JVyyYPPSH+rwBEMKYo82RCkYcxjB8QN2Vk9hhNVDUl/KOy1I6qumJJTuuf
         QyECPVWvQA+rG5Xsbb8KcYtZBNy5vdYwoP34LqEjdce69g3lXiWBUckwZEYEdWdFKfkG
         E1yeSkYdKSqXo4p7d6OCsxAFQvmvRh06tO16W6k/5W7tpGeNZyAhWPLA/rzFjaVeqbIy
         6hD9y1CqEnzruT+Ux7cfeIjrr5B3Y8deFlD+ePIbPDCGevCQfZsykReg/B6whCNxTGfR
         Ss6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777013669; x=1777618469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PY6x0drsie9DTFRy/FzyM357y9cc2vXO6VzIJJ4fYUA=;
        b=b6M4XLmTEYSKttCPVmJLXk2gIWoWKS31sk7PmOhHT0z5xzwgKHU+BZFJW1nuszxtRA
         ZPT8pDtgS9cnj0Db8KASsGktjqmdHwwhgODWMPbgO2QV6vSz7UEJ7/zB3t1R0AFZ68+T
         0URUucqIHyflScscqiNH/pROL5BWbbQ0ORYIXGhmq4360j93Gs7JK1dPVhDW2ntpobfC
         YP11ZlvyMA/rKS2hLE7T9d35ppichuKqtuIK1D/vI9Mwp7vdgxLwg/jHd0B+uKaJHPp4
         wIFXgL0yWwZRlqh4VSGhxHTd3dqjkG8EBkzrtQq8zsWHVI3QKAChUS/+GHrIT7gakYMu
         wfTg==
X-Forwarded-Encrypted: i=1; AFNElJ8UkKNgjO2fHo7tH7saA4NQHmWWUSzdGOZRmqO7XAVnbjiXqr4qgHDlO8T5+4UkPW2ZW3m/fI8CrOR13h2b@vger.kernel.org
X-Gm-Message-State: AOJu0YxlIxBEj/eK07yM6+9scXkEIz0v0QeVXX8vd/lRLzOdu1phPYJ5
	9be1Hr9FMFeuPOxDIPz6w6ax+V1GblOzCgfM+CZWN6+Dw6mVYsM0DhlsIJc+BzW7ZJy5/TAvPlS
	rWD/XgWOhUz9ssqSEAMevlXi/ZtBNW2XTBKLHYPk=
X-Gm-Gg: AeBDietCveRAUa3bItt9uTRMWTKpqrcw1t+H1mmB7uEq8fvfCNYLnqV051occyP1nfu
	rDEnMRtufVzzxesFn7sm7xpSCZ+FR14tQpg4jVOLSe+eQ3JbjhhmHM7ctnNX1jjlA9J4A7NnB0m
	LWGhb6Cmak2jRs3U/FlsSJLswuuN417Pw1TvqOkUgzGICKFxrgM6ivxCrvQPAFcl+oQi7XE4VGm
	jjjASMNFsdHA6M2Seih0mPEgoPY2894xZjZQy2YNSMRSEZd/SaBRr1FsFtDH+1aHZrFmdRKFDP0
	3MOpRpvhC8ERPyOc7g6T1Taii2xs55IxHtUZh4NgKaebU1+gXw==
X-Received: by 2002:a05:6214:20a8:b0:89c:5f6e:451a with SMTP id
 6a1803df08f44-8b028080052mr492516496d6.21.1777013669182; Thu, 23 Apr 2026
 23:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421020932.3212532-1-liuyibin@hygon.cn> <aeikm2e5Gh5reJ30@lucifer>
 <bc514883d6154420b3cfde4ab25a20c7@hygon.cn> <aejzSsiXZBK1emv7@lucifer>
 <a96c20b74b874248bc0cdc2b926a43fe@hygon.cn> <aerhh_tzSs5XapUz@casper.infradead.org>
 <CAGudoHGnOMj7O0P0pttdgdhGnJq8+Nv3_91x8kEAT5wR_xDmgQ@mail.gmail.com>
In-Reply-To: <CAGudoHGnOMj7O0P0pttdgdhGnJq8+Nv3_91x8kEAT5wR_xDmgQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 24 Apr 2026 08:54:14 +0200
X-Gm-Features: AQROBzA2h81VNcq2jOAQe_t2FwlCVNTmWCUZPO4gDdP4xuiwSERS1JEXtZu_oiw
Message-ID: <CAGudoHHC0wy9YrkTF4OZanjNPA2HKnzZQDv-Cv6_NnUChb_p8A@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIG1tOiBBZGQgUldIX1JNQVBfRVhDTFVERQ==?=
	=?UTF-8?B?IGZsYWcgdG8gZXhjbHVkZSBmaWxlcyBmcm9tIHJtYXAgc2hhcmluZw==?=
To: Matthew Wilcox <willy@infradead.org>
Cc: Yibin Liu <liuyibin@hygon.cn>, Lorenzo Stoakes <ljs@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>, 
	Jianyong Wu <wujianyong@hygon.cn>, Huangsj <huangsj@hygon.cn>, Yuan Zhong <zhongyuan@hygon.cn>, 
	"jack@suse.cz" <jack@suse.cz>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "alex.aring@gmail.com" <alex.aring@gmail.com>, 
	"vbabka@kernel.org" <vbabka@kernel.org>, "jannh@google.com" <jannh@google.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 8:20=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Fri, Apr 24, 2026 at 5:20=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Fri, Apr 24, 2026 at 01:08:35AM +0000, Yibin Liu wrote:
> > > On an Intel Emerald Rapids server (112 cores), run the execl benchmar=
k from
> > > UnixBench with the command: ./Run -c 220 execl
> > > Then perf top shows:
> > >
> > >   91.53%  [kernel]                    [k] osq_lock
> > >    0.50%  [kernel]                    [k] rwsem_spin_on_owner
> >
> > OK, but does this represent a realistic workload?  It's pretty easy to
> > construct workloads that hammer on particular locks; the question is
> > whether it's a relevant performance bottleneck that customers care abou=
t.
>
> This is a genuine problem when doing large-scale package building.
> I'll say upfront I have extensive experience with this crap on
> FreeBSD, I did not run it on Linux myself, but bear with me here --
> while FreeBSD is in doubt a less scalable kernel, Linux demonstrated
> to be suffering from the same problems.
>
> Say you have a box with a core count of 100 and get it to work
> building up to 100 packages at a time. Further, even if you use some
> form of separation from file-system standpoint on userspace level, you
> still want to share the common binaries to reduce memory + cache
> footprint so you at least --bind them. Then you are susceptible to
> contention issues at least on paper.
>
> Granted, building a pig like chromium scales great because it is
> written in c++ and almost all of the time is spent in userspace, with
> forks and execs of the compiler highly spread out in time, in turn
> putting very little pressure on the locks.
>
> However, vast majority of packages is very tiny in comparison
> (literally a few .c files) and this is where things go south as they
> engage in exec frenzy, looking like a borderline microbenchmark. The
> primary culprit is configure scripts, issuing an idiotic number of
> back-to-back execs of short-lived processes (notably sed, but also
> grep, rm and others). There is a lot of evil in makefiles as well.
>
> I don't have numbers handy, but in case of the FreeBSD ports tree we
> are talking about over 10 000 ports which on their own take few
> seconds to build. Since these are largely single-threaded, if you have
> package-building machinery which can saturate the box, you easily end
> up with parallel builds matching your core count. And when they engage
> in exec-frenzy for the duration, you may as well be microbenchmarking
> it.
>
> A sufficiently pessimized workload is indistinguishable from a
> microbenchmark and this here is an example of one.
>
> iow this is a real problem, but I don't have specific numbers for Linux.

I had gcc handy on Linux, so I ran configure on it by hand. This is
all autotools generated, so general theme matches the small programs
as well.

I ended up with the following execs:
    285 /usr/bin/sed
     95 /usr/bin/rm
     88 /usr/bin/grep
     77 /usr/bin/cat
     30 /usr/bin/gcc
     27 /usr/bin/expr
     23 /usr/libexec/gcc/x86_64-linux-gnu/15/cc1
     21 /usr/bin/as
     10 /usr/bin/uname
      8 /usr/libexec/gcc/x86_64-linux-gnu/15/collect2
      8 /usr/bin/ld
      8 /bin/bash
      7 /usr/bin/mv
      7 /usr/bin/c++
      6 /usr/bin/mkdir
      6 /usr/bin/basename
      5 /usr/bin/ln
      5 /usr/bin/cmp
      4 /usr/bin/sort
      4 /usr/bin/dirname
      3 /usr/bin/rmdir
      3 /usr/bin/hostname
      3 /usr/bin/gawk
      3 /usr/bin/cc
      2 /usr/bin/strip
      2 /usr/bin/mktemp
      2 /usr/bin/ls
      2 /usr/bin/egrep
      2 /usr/bin/cp
      2 /usr/bin/ar
      2 /bin/sh
      1 /usr/lib/llvm-20/bin/clang
      1 /usr/bin/tr
      1 /usr/bin/touch
      1 /usr/bin/ranlib
      1 /usr/bin/install
      1 /usr/bin/diff
      1 /usr/bin/chmod
      1 /usr/bin/arch
      1 /home/mjg/repos/gcc/missing
      1 /bin/uname
      1 /bin/arch
      1 ./contrib/compare-debug
      1 ./conftest
      1 ./configure

It spent almost half of the runtime in the kernel, all while there was
no contention.

So imagine all that to compile a few .c files & rinse & repeat
thousands of times in parallel on 100+ cores.
