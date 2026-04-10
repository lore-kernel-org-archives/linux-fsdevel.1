Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB333D4FB
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855596; cv=none; b=O2/dgsUR4BHsUc4RjESqn1RKR0Q/ZGS+QypnjmizbxuxsFNGe0Hqx4JsKUUekLJtlXlLF2bSJB4O6ovDANWsvirTBwYWGmwP/ozEe/VCS9MTcdCRCi05vZGdYkdDVwdnI780bK2U99IcqBSggDz6lyPNwSFz6qvMosZhTqdADRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855596; c=relaxed/simple;
	bh=AwKePrIES2P6QRQcgB2moHB1wC6kKuua1+nmkI/PPws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXoK1YFzQYD/r5XVceOWpjZ+yIaqe0b4CMvcMxR0qU4zcYRcPE8gzCi6u1qR2m4v4oaLTgsIPV/jC0hWEAWVEfm9fkUlcqo6/XqExG38BA/wayZnVaJvpEVwNKo9j1FYJozwprDEwjJbD6LlY/O5t7VkkddpWAFBywz5zSmDM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=OuTcPgPI; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="OuTcPgPI"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1273349c56bso3492157c88.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1775855594; x=1776460394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3r+5YlFTD5eP3ZhgPXDxfeTiR5srRgwtJO/GNc4EtPs=;
        b=OuTcPgPIk1v5UPwRiYsT5NrLtqGvFyiHaSBDdDKaUEc7TXYopfHEUkL3M4PIoRen+P
         WcZR6m//Qg9jgJQQTlRLXV+0l3TyykaTtKoLApqRH92BpxdlFElYUu449rnLjKXgre4a
         Pw+AcBSEPo+VhPd/kdF6FVyAfowca49g8babmT/VueGrOYmMKlf73PidLLwZxV5fgjY2
         50O09rdwkH+sNVcimws2kgsUihf0at8MJDdP2Efr5t1U4cl5mDbDLRQbvdQPJeNavRHf
         WWoYnr53ZvLGQNmw+tho3ABMfumBcRM3SCeZi3TYlKtSw6zC4zJLhRIYynAc3eVjQb3f
         Bdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855594; x=1776460394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3r+5YlFTD5eP3ZhgPXDxfeTiR5srRgwtJO/GNc4EtPs=;
        b=CG50ai0SXPgXFT78xhrX6mHyrGeBh8LN4b3Qux5ixGdaGcRswVTrKzwf86sbTy2hpG
         Kt5bZpexKFlH/YBmJJO82Db6rpFrKCETN0PGTYwE7xsh1ZSDh+5S/OzWKv6lVMvZkofX
         6cW6f/nl+VGUKWi+WJMkw2Wme1NtXgrK3vO3iMgnD6oX+q96MnMcHJZWT03+McDPmK24
         PUGZWUJ2k/8fLWlPsEpmumzoGPMXp9FGx8ClBvvEqNuIh6fqHS4vcRoISxKI7mcde0+8
         KP3pwbjb66rWgwfOmSRjz4ETkXXG9dw+xxnSKKA/IUd2ckX2m7nmnJxoZZYpQe5gDrZf
         uvvw==
X-Forwarded-Encrypted: i=1; AJvYcCWO31I28slgsPNyCVsrRdw8EGzbsWqgoIai/zEsVUtQ8sl28tidfjLxcuoGvSxcMwLDF10lJpPV6eH+JSuU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9iITOefE5jEvCCbNg3qYKX8E0E4a4tHzF3HxA3B1tWCVhQrVn
	heOnsrBqagKFwCeJux6wjcfD7OZx5Qle0w/ue+BVF6WUsfLoDVTP3N+NUycgNe/Tr0U=
X-Gm-Gg: AeBDievsmI5qRuRppnBovp/NNUCNHcL+Ds63C/RddXHUU5DpogIXzW5ZcF/sBN3NrxV
	AV0Tt8Ibk3YqwEvwq7Qe/v0pas481OWJ6M472Blg0PAsfJz4YXT708LYg1XBfBb/QC53cvQA2vp
	U0wIo0rLN3lEREBMYyHCmUZLFxTnE6XlcO7EOtY4RUy9b3DQkk+91YkNg2RiyQpW3V63YK/HUm1
	tGyYOrOGKWZDNPqb43ig6Iea31wyyYm7A9Zkk1Hg1JyVCmPoUjHbU18tsIaYYo2edRCoLilBqO0
	TA9zmxLPJeBzqj4QnjzHf8w6s+oPEV42Rh6A2pHQdUZ/22WWV4Mpy5NmOSBeQdFs3LuR1yxcr3I
	ugNDqcqVlzfsnzg+vTUzY29RxB0YMGhOStOq+MOgFazckfdNMVod9kAiVnP7xkdE0sKhtwuuwEr
	2brSb8ldl8BiC0PDkccnHcWkSbRQ==
X-Received: by 2002:a05:7022:4399:b0:127:33e0:ea40 with SMTP id a92af1059eb24-12c34eb60b1mr3032931c88.15.1775855594133;
        Fri, 10 Apr 2026 14:13:14 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:c494:2bdb:81fb:43b3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c345b6208sm5704441c88.8.2026.04.10.14.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:13:13 -0700 (PDT)
Date: Fri, 10 Apr 2026 14:13:10 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
Message-ID: <adln5vp9HFbX-oz0@mozart.vkv.me>
References: <20260409190213.GQ3836593@ZenIV>
 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV>
 <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
 <adkk8FiLHnVx1Bup@tardis.local>
 <CAHk-=wjuOm+AGHtjF15Zx8cxJwYwbzJgi28EQ6KW=Ze-4YjN+g@mail.gmail.com>
 <4305138de599923591df7403aefc4d663f50324a.camel@kernel.org>
 <20260410191907.GV3836593@ZenIV>
 <30ac5108ada614560326636d4da353d6304c3f91.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30ac5108ada614560326636d4da353d6304c3f91.camel@kernel.org>

On Friday 04/10 at 15:32 -0400, Jeff Layton wrote:
> Yep, not even with that. One thing that claude pointed out: doing an
> mdelay() might prevent it from making any progress freeing dentries.
> I'm experimenting now with one that only randomly does a delay, but so
> far that hasn't turned up anything. I'll let you know if that changes.

Hi Jeff,

I've been poking at this one too. With the attached reproducer, the
waiter will get stuck in an infinite loop apparently in d_walk() with a
stock 7.0-rc7 (in my case with PREEMPT_LAZY):

        d_walk
        list_empty (inlined)
        shrink_dcache_tree
        d_invalidate
        proc_invalidate_siblings_dcache
        release_task
        wait_task_zombie (inlined)
        wait_consider_task
        do_wait_thread (inlined)
        __do_wait
        do_wait
        kernel_wait4
        __do_sys_wait4 (inlined)
        __se_sys_wait4 (inlined)
        __x64_sys_wait4
        do_syscall_64
        entry_SYSCALL_64_after_hwframe
        __internal_syscall_cancel
        __syscall_cancel
        __wait4 (inlined)
        os_wait_impl (inlined)
        os_wait
        _Py_LeaveRecursiveCallTstate (inlined)
        cfunction_vectorcall_NOARGS
        _PyObject_VectorcallTstate (inlined)
        PyObject_Vectorcall

It doesn't happen 100% of the time, but it's never taken more than three
attempts on two different machines. I've SIGKILL'd it and waited over an
hour, it really never comes back. Making NR_FORKS larger than 3 was
counterproductive on my 32-thread machines, but YMMV of course.

I haven't had time to dig more yet, but wanted to share the reproducer,
hopefully it yields something useful on your end.

I don't think this is Al's livelock, because only one thread is
spinning on an otherwise idle machine... but I apologize if it is and
it's going over my head.

Cheers,
Calvin

---
#!/usr/bin/python3
# sudo prlimit --nofile=10000000:10000000 ./repro.py

import os

NR_FORKS = 3

for _ in range(NR_FORKS):
	pid = os.fork()
	if pid == 0:
		break

for dirpath, _, filenames in os.walk("/proc"):
	for fn in filenames:
		try:
			os.open(os.path.join(dirpath, fn), os.O_RDONLY)
		except:
			pass

if pid == 0:
	os._exit(0)

while True:
	try:
		os.wait()
	except ChildProcessError:
		os._exit(0)

