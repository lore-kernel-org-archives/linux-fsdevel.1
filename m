Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFD35674C
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368344; cv=pass; b=fuEDPEzhN2SLM31JwYYjyDFEnVW1VwhhvPtsoSiOnrGho7/7Z1YcC1r9b7Dub3ePEneaLRvV2xplhofCOgjF+XviyJ7/sKvcZI0YW9kYixwe281I9eZ4qBJf/5kOLYJv8uvfBh2aaD3xK4AneccwIISxOcCgBNHZ5BNbEIEgFS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368344; c=relaxed/simple;
	bh=zh13oULehEKlvsZJPC18x7nrtMGI7N/Dari4L0S90kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoOow5xXGnszAGZADeGpkavj3rWwxZyy6nh0qhm8g6Amuqn7U0JdQSHjw76OthVTYmyqcFBnvwXl587JFbF6FJDE+vzDAA1UJo6dvxPvryyglQh4CA8XUP2MzUqO+pXgw/4AEcPf2FqzlUYuYEzhyX2nVqISia5Wx8ykLRvL5Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq2dy0Nv; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq2dy0Nv"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6886be3d39bso409367a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 05:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779368341; cv=none;
        d=google.com; s=arc-20240605;
        b=IrNAYIBjFx91+BA3KUIU5PmLjsoT1zFvHJhCUIG5z9goxX+2TEeUKJJoX5dQZ17ASw
         5xXOT+Ees+Io5BMN2NEvh/xPqP2iapgPerGvfZs75PHAHtugGNkm2LEWaf9/d9SoNP2P
         H2akjeNMKhoa2nrsdismb/HiBjirGfrSfN0qGrwvGxm97hlEuzUKPVzVdFAfzjHZJqeE
         emZr7BMXhCsEXNiNCoUdJPRRM6dLb4s6qJcmD0uzZKLu3yycPR5wV0anQEQmJObk1OnP
         ZCpoZxZVyofQiJ6G5H6FvK32lqHBBJg1domPMQPXMdmRm39WSYfv05j4oXwE2VKZOgHl
         yg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9sUFcSFNkiSL5JHdhtInnQL8eMCsOXkVXUtF+3t4Qns=;
        fh=xhdjjizhjcg8zo5M+asw2FHNbbFzDFqRBVmSBbRe1Lc=;
        b=XJhLSQ8sZI0jTfSw9XzQGL/2StNXjtqzXqgwT8Cnm7ihCMwiaDymRSutzOgbqPg59h
         aUGYccXMShY/Rt7HOgepH55Pfm7L6ETOjbD4MSlLmamrJeh8zxUhzD8LISaQt5/EJVl2
         hFxeRc7hgu5d3lhsqruBmNpPPBgUxjED8X8wDPSmHzk2m3MSGAy7XSE9Z2srJ0qCO+9O
         ScHkUR8uOccZGO4mf5np9WSSNm4+uM2xY607Tv4PuXyEuPVawEUw22+LErtbsj3Agqea
         PypO/8gsmkXq1bt6FA6XzJ8NENzQ/uU23oWmmLUsgGqCrmlpbxjZeCF/6cDmqiOGZrHP
         0UIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368341; x=1779973141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sUFcSFNkiSL5JHdhtInnQL8eMCsOXkVXUtF+3t4Qns=;
        b=kq2dy0NvQQQ43x9+vgo8d/oiAT0X14JuOGbhSHuoYQleApo2hZuPEZWosOuLTZCVbP
         28+1sEgCPqk4KFQ66n/yj7n2PbkVLmHZRqoDXRl45NsqinGSdVmeQf5uKX/3HmG0shjk
         kida7vSgzeHrqiKXxpyWhbhSpj/9B8iV/BE89H4SumsYVBWFWqFreiPIpxBcR4a5JerJ
         f/MkzX59+vKzljesoQCsw26+/h+qXxCg1ZbeoOOuJseXE8c0LNF9nybxOQoXGfW8dWsk
         8uZopV3mpdzt2vKs7CO0ykPe20ZpTg+lKEDYJ53qOwNwCqwjxptEbUyYlWkDXaNGgz+0
         6BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368341; x=1779973141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9sUFcSFNkiSL5JHdhtInnQL8eMCsOXkVXUtF+3t4Qns=;
        b=PnpnvOsG5SlU12lybjIcGIOUqSKgOH8MYvjCtTliR6YjGu14L9hm/YgYTFjgqtQPCO
         sj+gH5H2shPhbrD0E55bN4t/DCr7GGAFllmzWq9SI4nk+975sGqYpXJ1vlhnPIEakclw
         1zEhXPrr4JeLHC+PFT6JjWmCJwRsnrOExSNkhepfpyEn3PVNokii6YcHNC9NxoIKy4QF
         FFpVQQsPmYWo1syXytdajC+4IYCDmwgGgGH5lBtgyhc6UbCoXXXh1citYAQZ/0tN0Ejt
         TI31H4+g9+6V8J79UBDNFL5n/EPnApSQlzPIaHcx/0tPEC9IWXhLlsxoJauDu1JiEXBE
         697w==
X-Forwarded-Encrypted: i=1; AFNElJ/2yyjdfW1EQ0U5TAnYjWZ6KCzqGU7eLCXw/PRRny+/czbIz/JmdSS9BWTJKcy2xSDt/r6Y7qjKIPMseD2/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GbvEOdaPpX8zwv2iG8fUiLpNtd4Gs4pWwjiKrHpFclIcLXNa
	JB1IPgmG2UQAbYHqvqlTW/NaOuM5sDatXR19iSH2Q+XDx0Cvyr4VRQWDM7ZPj78VsJThf33KkQL
	RsgkZm1P88TCSlQQ1N2VWxNGL4rPeUO4=
X-Gm-Gg: Acq92OF2oz/Mg7+L4q8Wpr8/0FdDbxtBgqV0z6b4cWHPnBbVLS6mQQb+MNUBL2fd2kE
	wchM3X0evjZD8xo0GiCo7sfpv56MKxPVUV4qRQ7YIIhCWzIiBuPiKbNPaDoEtPozu5UzZy3zSSc
	S/OKpJ2Ovx3TFoAPYi652GsSMmRjc5OcTb8U3jtU3eFrrEvvOvScQ/6m6sb/Lcle0W2kSXXo8Nt
	PAwNIPprk/tzsIuMjHaqOvC5OGwYERDY9KwvBABSRtDPFfWmcmUeHIzITBF83A9YpWSSjwHLI30
	muMn72T4kiHha29lAS3/fUDN5MhV1wtKZz0RhIE=
X-Received: by 2002:a05:6402:5209:b0:67b:4aab:1f10 with SMTP id
 4fb4d7f45d1cf-68835ef31ffmr1480400a12.5.1779368341070; Thu, 21 May 2026
 05:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-fix_pipe-v1-0-b14c840c7555@debian.org>
 <20260515-fix_pipe-v1-1-b14c840c7555@debian.org> <q37bmptbjr2gysl2g67bqo5axxqor4lsrrnf7ajixxjdrumbup@tgu3kz6kien5>
 <ag3Ty3T24wjn1aFw@gmail.com>
In-Reply-To: <ag3Ty3T24wjn1aFw@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 21 May 2026 14:58:48 +0200
X-Gm-Features: AVHnY4IyXaaWqBhs6IESJo2_GnTxog12lj-M9bDsqmzguKJQgj3SLCFzEJItOAo
Message-ID: <CAGudoHGT+8FW9HsN+ymQ2QECVjmwkx=xNQ9=WnjYWirXcA6u4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/pipe: bulk pre-allocate pages outside pipe->mutex
 in anon_pipe_write
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	usama.arif@linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 7:09=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
> On Fri, May 15, 2026 at 10:18:19PM +0200, Mateusz Guzik wrote:
> > This change is quite a hammer.
>
> Are you seeing any downside/trade-off with this current approach?
>

Well there is a lot to say about the current code to begin with, I'm
going to refrain from writing long rants here as that's of no use in
this thread.

The idea behind the patch has a lot of merit and I'm definitely not
protesting it or denying there is a problem.
> >
> > Do you have a real workload where there are multiple processes issuing
> > large ops to the same pipe on both reader and writer side?
> >
> > The only workload I'm aware of sharing the pipe between more than just
> > one reader and one writer is anything with make, but that is mostly
> > operating on 1-byte ops.
>
> You're right -- most pipe writes really are tiny. On Bergamo, 120s sample=
 of
> anon_pipe_write, 299629 calls bucketed by iov_iter_count(from):
>
>     size                writes      %
>     <128 B              293602    98.0    (merge path, no alloc)
>     128 B - 4 KB          1108     0.4
>     4 - 8 KB              2149     0.72   <-- patch start helps from here
>     8 - 16 KB                3
>     16 - 32 KB               0
>     32 - 64 KB               5
>     64 - 128 KB              2            <-- up to 72KB writes
>
> So only ~0.72% of writes are >=3D PAGE_SIZE. The dominant comm by
> contention count is a Meta fleet workload spraying sub-128-byte
> metric strings -- it does *zero* writes >=3D PAGE_SIZE itself; it
> just hits the mutex very often.
>
> But the writers that *do* take the alloc-under-mutex path are
> real. Lock-wait data confirms it shows up:
>
>   perf lock contention -ab (30s, anon_pipe_* only):
>
>                                 contentions  total wait  max wait
>     arm64 (NVIDIA Grace)
>       anon_pipe_write                 7660    4.39 ms     50 us
>       anon_pipe_read                     7   55.78 us     17 us
>     x86_64 (Bergamo)
>       anon_pipe_write                 3154    4.53 ms     79 us
>       anon_pipe_read                   817    1.72 ms     82 us
>
> The reader side stands out on x86 (817 vs ~7 on arm64) -- that's
> the symptom the patch targets: a multi-page writer holding
> pipe->mutex across alloc_page() stalls the concurrent reader on
> the same mutex.
>
>   bpftrace, mutex_lock duration inside anon_pipe_write, 300s:
>
>                   Grace-A  Grace-B  Bergamo
>     [4K,  8K)      1090     2799      980
>     [8K, 16K)      1785     1353      953
>     [16K,32K)       755      623      530
>     [32K,64K)       153      172      184
>     [64K,128K)       13        8       59
>     [128K,256K)      -         -        4
>     [256K,512K)      -         -        1    <-- ~500us blocked
>
> So the patch's value is shortening the long critical sections that
> the 99% of small writers are blocked on -- the contention everyone
> sees drops because the few multi-page writers do their alloc work
> outside the lock.
>
> >=3D 64KB, which are not common but existent.
>

Ye this makes sense to me.

> > This should move to a dedicated routine, perhaps:
> >       anon_get_page_prealloc(pipe, &tmp_page_prealloc);
> >
> > then it can also easily decide how much to prealloc based on existing
> > state
>
> Yes. v2 will have anon_get_page_prealloc(pipe, &tpp) doing both:
> top up to PIPE_PREALLOC_MAX based on tmp_page[] occupancy, and
> keep the policy in one place.
>

Note I lost the 'pipe' word. This definitely needs to be anon_pipe_-prefixe=
d.

> > All that aside, I have no idea about performance impact on arm64, but
> > there is *definitely* some throughput lost based on the fact that memor=
y
> > copy is restarted per page. I presume arm64 has an equivalent of amd64'=
s
> > SMAP which again will not be free and is paid for every time as well.
>
> Can you say a bit more about what you'd want to see here? I want to make =
sure
> I'm reading the suggestion the same way you are.
>
> My understanding: anon_pipe_write loops once per page calling
> copy_page_from_iter(), and each call re-enters the iov_iter
> machinery and pays a STAC/CLAC pair on x86 (PAN toggle on arm64).

I was told arm64 has an explicit instruction set to deal with user
memory, so it might be this is implemented differently there and
fixing the problem might happen to not alter perf on that arch. It
will definitely help on amd64.

> So an N-page write pays the user-access bracket N times instead of
> once, on top of resetting the per-page memcpy and losing the
> hardware prefetch streak.
>

This bit is unavoidable with the current implementation as backing
pages are not guaranteed to be even virtually contiguous.

The extra SMAP trips however can be avoided.

> The way I see it, is opening a single user_read_access_begin() region aro=
und
> the page loop and use unsafe_copy_from_user() inside, with a labeled
> fault-fallback path that closes the region and finishes via the slow path=
.
>
> Is this what you meant?
>

Yes indeed. This is however optional and even if implemented it should
be a separate patch.

As a nit you could sprinkle some predicts in a separate commit,  for
example "if (!pipe->readers) {" definitely warrants an unlikely().

The real deal is the following: the wakeup policy is to *always*
wakeup *all* readers if any data is available and *all* writers if any
space is available. In case of heavily shared usage this leads to the
thundering herd problem (and it is causing performance issues with the
BSD and GNU makes). While this cannot be changed by default, I was
thinking about an opt-in fcntl which changes to policy to only wake up
one waiter.

In case of a microbenchmark like the one your provided here such a
policy might end up reducing throughput as there will be more time
spent off cpu by the benchmark. However, in case of real workloads
which presumably have stuff to do, it should be a win.

That is to say, if you have 1 reader and 1 writer, this is irrelevant.
But if you have multiple and they block on the pipe, there might be a
win hiding here for your actual workload by utilizing the above.
Something to consider.
