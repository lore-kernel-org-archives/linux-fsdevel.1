Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36A1395D8E
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939639; cv=pass; b=u0K+aZS0aaSH2NBddev0UWXtYtwYtfzFsylbtlnCeYgRczQKEb5Bjz5Q64EkJq/kHyuePeunBJDmwepZ7zAm3GX046yY5I4+BBaVG6YTCoFU7qdGxJmyPb42JZauCABXDdWOm2jLK2g2T7D8n6t/2/Zct+iEv0uQkRx/QseKfk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939639; c=relaxed/simple;
	bh=nyFfkTBzK12fhUoJcyE8okzZBEr70euiIjvPyeMf/eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8EPoJw3zX5ZptzcKvzTZDb+zHIBGIzEXHM/nrjfze74V8zE3Ug/HMQ92R7+6iv6ivJXxh3U49O9dGfjzOM4ssjYU4Bj7zywDyXZGa7TZfCbQk2nFwFtZamCpVL3ECrwMC/0j7UvQ9rDqoaoN+bXUiZ+IrxFlw27CSXDOpddo7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFD+bqjU; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFD+bqjU"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c253425b253so220867266b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 10:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787939636; cv=none;
        d=google.com; s=arc-20260327;
        b=clD7GH42G+1jFu/3CNDPif7O6quIFwqVTEYZNAz4ZqQa9E58qX31LdWxczyp8KTf3g
         DORa/WHHDy/BfR1iftO0nWtVtq9dsh9aFQpT+JxtDp+DSg04dPSiC0gHMtxHUmO670Pk
         NXlp6ISuKC3RKLQpysOAHIDDthgRTneaTjnWHktwzCS37UFRrrptFGLfEvIZV/4sCv4m
         1r1pNICFLTQ+X00tlCQdWnPNFcq4dHClgXuFFTbSQzlqCyrCoLfWyD0SpwXmQM8B7y+g
         UjPyWQvEHRTlmRdSCIHKEMjJ8cTqZeXwBYPVfZ6ZCbs2rMr0qYdCJhIYX9+GgCWhhPY2
         +08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nyFfkTBzK12fhUoJcyE8okzZBEr70euiIjvPyeMf/eY=;
        fh=DmJaokyaZwpS38/4yoLhi/p1ZyuHiarCF30QbH31Tx0=;
        b=oWPy+v0KfQpZN/VRPpdUoY2qfmg5bVgkiPvt0XlIWKjkf3zMWzJ/8RxdaLlDpVyZ9i
         nmFKsaEEPlwbfK9YsV/kBgcuJl6rC9ao8wrOwpK/dfTmXqSRnuzQTaHjY0tewYwlP58n
         aZxmlfwaIVaU15W0fOChdpSpHhoSnTLRy8DodXwZyJcgwRDVOTd+8fe8ZetKF6WEI3l0
         KNlsndEo82TwgVtK+9bcxdwaYcj285w80VYpxwF/U0O6MybsuxDgQ7kUrEdrlCPPgVu6
         1UaMKMJKDyc+VYceVTDN3YsIk4XvS+cfaViwg3P8mcz4T7NtqBxhOWgtB3QYmdoQpBnA
         QEhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787939636; x=1788544436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nyFfkTBzK12fhUoJcyE8okzZBEr70euiIjvPyeMf/eY=;
        b=lFD+bqjU6qOG2vik7oa0O13yhya2vj0Vafm3uFr4PRPu4mtM3jhoffRvW/im1HdkXk
         lCirJx93uXJ0fc4jm14b0kVcGAGe4iqxzaEZI/+6ngr4UxzWSuKEN1eXamuzk3ngPLd4
         ZTZmxLD8N6PoEqW+tN/fS0kIzxuso1QklX8cLoRfMfx8JN9h0JzNSDlP9+VoHwDV2mv1
         g2Kt/ZFj+RgJyAYbo7TrpOzClJL9DhXJtKrVGrCN5T8wGBPb0DGiKUp7zRG0sfvdC2eJ
         vPTxn+ePIc7gggUslrgGlfV3J0x+RUg3QnGOUWNZKr6gwPLMTtdtuiy6ZReVd4v7nH7B
         kjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787939636; x=1788544436;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nyFfkTBzK12fhUoJcyE8okzZBEr70euiIjvPyeMf/eY=;
        b=mK40xa+mEb3qKI/HrpNyyx91laefIxXSaXW0iwAE/IV/9HlVI4oS4B/mzsSVEf+sKx
         PHo0dwH7Kt3aN5sisss6LcpSLq6oGW7j3S2y35ZLJ4eQUBoFAJnz6PM4CCtqYGLu49RG
         zrECJXCaaFf25GENsDtgXHuP6aaDwzvwcBMqdvoiQIOKXPDhnM0A1n7UBMO0gRaxbbPn
         LGL0iZl/h4oH4t8P3GHjCXRHvrFvxtDtE1UVWkf2F4B8BucCC4+r6zGzMVWphaB/8VLK
         IcToxXvPCxpJmpSUOwfVnpZ3YwxqDYU6JBA0jUJM2EPcEZb/GaHuWEeW1jc6mahscp7f
         EvVw==
X-Forwarded-Encrypted: i=1; AHgh+RpgrYvs54Vfy0Df/po9W9yXPLulzG5OyiYKz+vm0oH92fbHZRXO+WjAP7S6UgRfs7cEPrHhRSBoysp16VGc@vger.kernel.org
X-Gm-Message-State: AFuF++nEpgKmwbGnFNwXaSZzVJrg1MydbVXoS8s0dk5t5kmi7TLHcmX0
	5N1zctgB7dPk7uPx3OLuMzwHudvsEB2ylpAfyGwpVIciBtWlkh7mnYXZhFvl9+IfpGjwLzx64FJ
	M94RqTear4lQSEsHDBn9ko9PJCHzRFn8=
X-Gm-Gg: AR+sD12iETAVzu1aBqqEgfSEQrrv/eNJpgN/rwi99mqqlClJ772pZAFQEv3ebh+5HcW
	it/k418PbKIGfkQxTa44xff8WtFFbKCHH4Te/rmtfRdTAkWmNMqDeKJV1dCq6Kebxdo8NRqsct0
	t8Wx6B7/SAZ4UGeqxc1IBJPa+uqB4vjKV34XI62pNGOrK+PVzs+8Rrx7A8sHgGEkTQlt9R1BaCr
	8VX90vBq7Z5NHUCzQ3WCJ7tEvMVxfRZu2Oa1slEOjTqDYwuW+8Rr6FPcjhC7hKmEHN7LaNgkFSu
	amgIVZvSTokncx//BpNbx9vv9AKFQG426XCXbSv13gfG7kmGYopwAsbnVSPzzDcTFdr8c/+CTrE
	6
X-Received: by 2002:a17:907:3ccc:b0:c15:f26a:3438 with SMTP id
 a640c23a62f3a-c255741f461mr608012566b.24.1787939635556; Fri, 28 Aug 2026
 10:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
 <CAGudoHEsGP1P+sAWaw_tbh1NesJhSeww8869uzmaqtgk8F43=Q@mail.gmail.com> <20260826-stauen-liedtexte-gesell-b88d4d43f352@brauner>
In-Reply-To: <20260826-stauen-liedtexte-gesell-b88d4d43f352@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 28 Aug 2026 19:53:42 +0200
X-Gm-Features: AcwNN1VUT-gKVh0gSwoQ6cH9gcK9IUJEaB5E3sV0YVS_YFYBeyfeM0_QjBX9s6M
Message-ID: <CAGudoHF17-aoMHFj+HMRfZmuHWfrGrZnxQCXvGVcG04rv-3L4g@mail.gmail.com>
Subject: Re: [PATCH RFC 0/7] coredump, files: exit files on request
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 9:02=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Aug 25, 2026 at 10:54:44PM +0200, Mateusz Guzik wrote:
> > On Mon, Aug 24, 2026 at 5:28=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > We've had quite a few proposal for exiting files before generating th=
e
> > > coredump (see [1]-[8]). The various proposed solution were quite
> > > unacceptable. So I took some time to look what a _remotely_ acceptabl=
e
> > > version of this could look like. Here it is.
> > >
> > > The first patch is somewhat unrelated but without it the code would h=
ave
> > > to become so ugly to the point of being unacceptable so it's a stylis=
tic
> > > prerequisite imho.
> > >
> > > In the first patch we make exit_files() synchronous and stop shunting
> > > all files onto task work only to run task work right after. For tasks
> > > exiting with a very large file descriptor table this means getting ri=
d
> > > of _a lot_ of cmpxchg()s and hammering on task->pi_lock. The cost of
> > > this was mentioned in various threads over the years. I found at leas=
t
> > > recent comments by Oleg and Neil.
> > >
> > > So let close_files() close right away. No locks are held, the path
> > > already sleeps, close() does the same thing already. Kernel threads c=
an
> > > just keep deferring. ->flush() and ->release() now run before exit_fs=
()
> > > and disassociate_ctty() which should be fine.
> >
> > I think close on exec handling could use the same treatment.
> >
> > >
> > > The other half is adding support for coredumps to switch to an empty
> > > file descriptor table before generating the coredump. That requires a
> > > bit of synchronization but I think I got the basics down.
> > >
> > > A new COREDUMP_CLOSE_FILES extension that allows a coredump server to
> > > request that the thread-group close all files before generating the
> > > coredump.
> > >
> > > The coredumping thread allocates a new empty file descriptor table. I=
t
> > > then wakes all threads in the thread-group and tells them to switch t=
o
> > > the empty file descriptor table and get rid of the old one. They repo=
rt
> > > back once they're done.
> > >
> > > So that handles most cases where locks would be held for an unreasona=
ble
> > > time until the coredump is generated but since files can be shared
> > > between completely unrelated processes that's not a guarantee and we
> > > can't give one. But it solves the reported issue without resorting to
> > > even grosser hacks.
> > >
> >
> > I find this rather unsatisfactory. What if a coredumper *wants* fd
> > info and does not want to stall userspace on file locks? Sooner or
> > later someone is going to show up complaining about it.
> >
> > I proposed merely dropping all the locks early, which on its own
> > should be easy to implement. I have not checked how fd reporting is
> > implemented, it might be there is no way to convey what locks were
> > held in a backwards-compatible manner in which case plain early unlock
> > might be a no-go.
>
> I don't understand how it would even remotely be safe to drop locks
> before we've called into ->flush() and ->release(). The only locks that
> satisfy this requirement right away are posix file locks. Not even all
> of them, just a limited subset.
>

That's my bad, I was somehow convinced locks get dropped before any
other work and did not even bother to check. Apologies. :>

Fortunately for me this is not my problem and I'm free to bugger off
this subject, which is what I'm thereby doing.

> So then we introduce a concept of "drop some locks" which might grow
> over time. I really fail to see how this is attractive at all.
>
> For a bunch of locks they will only be dropable in ->release(). So then
> we need to annotate locks that are droppable prior to exit_files() and
> locks that are droppable after it. Why would we place that analytical
> burden on anyone? Coredumps alone cannot justify it. They can hardly
> justify what I'm doing. The only saving grace is that I think having
> exit_files() run synchronously makes sense given how it hammers on task
> work. And then the coredump thing can fall out of it as a side-effect.
>
> So I don't understand what early lock release buys at all other than
> complexity. Without clear proof that early-lock release is elegant and
> non-invasive I don't see why we would do it.
>
> Exiting files early can be done cooperatively on the other hand and
> it'll satisfy most use-cases just fine.
