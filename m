Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123183;
	b=MwLW7qOiolQqRA1pbfQP64/1banVKeozvsGTvaYnCfCRsgax1gvlV6+EKPeOsPLOo9Fn
	 Q87Qh//yl8s+p5qnzk1N9xy7rHZ7Y41H5BKTlQ2DNyuqF+lzQwXjoi9WpCnN/XWulCoyD
	 GskSbBUqeZH1Ngc6oHU+Aak9Uq5bp3FAbZv0L1OE1ZETvv1b0iXGHOfFCody9pE6e4BzZ
	 ON32NHCFY0jxy1mIy9MR4Y0fE3XZbNlIE0lTDl9oBEaO4PcxHZBhsZW3VUB0prn5Zmsr3
	 5LwkWmART+BmWWdSClVP8sZMZEw/8sAufSj5s1AAhsxlHuh5sqEcOk09o3/NZhqrouA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
	b=C3vSGUdQ7uBsZQCXjLtauNFuXU45bFaImRtTg/vjSBsCSkfxOHRan4L+vY45odZ7i+pW
	 knD9WUrr6E1CHr4pWHMt/S2zeJY6+QAXNURUM5OYy1eiCr0Y2inYeoEcqualK9yPPl+dK
	 FXWUZlFxHikOyZPBqc4ZTJixZx0W9Q0rk5mG3n6W2FUj27SoKJaNOixvcDLnJmTuAjMcy
	 p9s5IL84Rn3RZ+kR5BNmyEs8gFa04mMonEQHNjTXnUl39gPYrkcdhvPMzQuOKITcLvGiW
	 dP6hyMFLVpkvUpAybN54VL4kqN7JQnx0ZKWUNld8rw3Mip2fWW80sgr4wnr1hMSae+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dJZrWgbc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56E606A321
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 17:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F56E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dJZrWgbc
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c418e215671so12442866b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 10:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123181; cv=none;
        d=google.com; s=arc-20260327;
        b=a2rdsMY4uIybomYLhl++FAba2dOGA/e3uZNls4WvgI+9IFhdImn8PX1Ghk3Bln+Wjo
         O+9bclddFDveqBG+1H94NPHqFqHlILCbhDo27Sb+iRMVeXA9LUeoz1W3TZPC8Xw1xa44
         kWhl6vPKlcUpq+sZ200H3+es5+sI/2RltZ64ttx/qdTzF0Jw9sy7OM+6LAhVeNc+qlCU
         B1nprDDFiuBN+nw/fykzgth6zXInwrPI3epq6MZlL+GCVy5dZ9r5dbtDnhPluUmlupzF
         Vf0vj1leQAKLiLBydXhk4oU0gYpQFLkp2+eVH5L6PuvvqcVkAW+WEHqVEeqI5LQoU6YN
         d1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        fh=1TFAhSmfpaV+peEJXCry50C66NmupQHx3u13dAW8o8M=;
        b=ZlIdy4Y7I7hPJj86FUetak7bYC4lshK137YC3Wv3oRTwRHZuimEio1nlklygLNn82Q
         BEgMyf/eodJcGcALsM2CZn2ur5js96ZdkC/GMCDsORIgJ1ihYEN5+LUk81acIvRa1vhx
         kViDnQCeugNLba9hbJqsviNPpO4eE2fEMtP3bcMyg+f7crnlkIPqSz3UbSzUnCAUV9Jw
         /hS22IrdJjnk8gHpyJOYDIven2TvG4mu7bhPXIvi8kT1eUDBQ/ogdSmjqiOc508YpVWK
         ra7yJzoBw1PHWvNhNBqK1whdZDZYH19LJ810HLBcJmhTaHoPX7Akg24TbmC+7brdcC5I
         3U/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793123181; x=1793727981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        b=dJZrWgbceCcvybGI6S+yBWHGKTnRTkeoo+QAXarbXhuJJrcuUxjX6DL3VJxyeJguO7
         EIXUQuToxD9Oj2ADRK5huhz3YAPfLd6CErpWQOPm8uk8bar6rE79bi3bMLs3pZe51bGu
         X4MzPetzpkt4sIfnqO30iZNgo0TbdVmPtmqopEkvLhUnsg2bhmTSLgRVVzhYHy701dNf
         Q0OtvKJRnZ80/E3NbSjyx0npRgDvtmNSPb01SZjgkwzglNyd+xHEbqih3MUFsYvHWiHM
         BQc/ZWywC5lvAnEYkPeZz4JTWFyCYlKLP3X73YxsX8/hg+Ad4REwmoFnONsNmbYY7MNG
         Lt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123181; x=1793727981;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        b=gRMs+XwGKLVBQdP3XXTN9Xs5Yb48lNBUEykpVZgXZN0rn0HJdMAtiDC5E70IPdFslk
         KpXBA2AZJzl4ahKgiObTxSpiiKJ4qcw9kJ1qVtQHVlEFiWwxaFMu2Zt0bJoYNDPj0WdP
         /xvPr+oMRewzbP969MlohVQY3UHB/wOevCaUHKc+GhJ9KDvkAck3Rj7wBY7p1aOheu1n
         wDSWDoBPLKXnb/GIZw6HUaPeGPjohbL4rzP6sOyKtBn6bo6UueH5ID4YpBu9RqKZc0/k
         vVioqo7vJ5MtW4wfyxdXQPL9hFHpXAKgSbjRXu8kDZV91jN4BOuTGC/Q9Kd0LULsFTF6
         O0Ww==
X-Forwarded-Encrypted: i=1; AKwUvBxMrIRo5KDFWGlNxqiSV1R7+VaoV4uIwK2yp4qjvdS4J0oCEQGN25Z91BzSHx1FXvFM2IFUqKJE8HNYKmHY@vger.kernel.org
X-Gm-Message-State: AFq9FYKdOhz3VNMMHhPReXGyE10qdwtSnUqhWctCgy9Dic+l8X6KAXrO
	1hVZMnQvEaixtJiQFWi59zYRbj5bbM9Q1JTSDufNXwRbgXetLrGPRfi8KgVnHVCWVAbsBA61U/I
	D7PbXyY/NA56c3ewzu2H/jTOt9KCseiFMzOoab/Ve
X-Gm-Gg: AYBFou20CBLO8k2dm+U8JcYxEBb8udkuKstx4mHawP5LJCCl8sJ9mDY/nDS1ic1DIqt
	/L4YS+JdzWOs6fXIZYgGTOXCNdelmeJALF2Pwtc7bQuxy2OkR5TIXDd/tbfL2mjnDZ18LsrCzbU
	Rj6aTXZLCKzf5HDinbPLX3icy0yksqbVtqkMGpT246pgXo5SE+XIbwKrPLugowQUzNecrmId8qd
	3em20pZ/om0+rbOTeWKDYCDIdnVn3m7B4nn5Ncz3VOAAF6y1xr9+vx6zUScQwwpZ8iN9D/AYeXj
	KUJdUigcLM6dsooIcwpjt11OGby0gP/OF/XEuHwqpiQuV24nVUvL9XDYMIwroUwhKNQJ52aDceT
	MsVxAabNjFt6yrnT6ClMx+gRy18T9/nj8nZX0dh3Dw2uEDgE2sV2ujKHU/YWvBaOFvxxSnY6U0l
	kDt2QOcdOR1jZw792wyOjwOXNpKNXUU0r3ynkuECspWJaddMj5YGZO4g4fmmPrA8wWHKhaKrcKi
	x8Liy+TvP/Iwf14ODY4gUDyVTH3bu79mA==
X-Received: by 2002:a17:907:7b9e:b0:c41:b94c:4538 with SMTP id
 a640c23a62f3a-c46bdec03f8mr1197886866b.47.1793123179946; Tue, 27 Oct 2026
 10:46:19 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-6-jthoughton@google.com> <20261027110948.GI2668564@noisy.programming.kicks-ass.net>
In-Reply-To: <20261027110948.GI2668564@noisy.programming.kicks-ass.net>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 10:45:43 -0700
X-Gm-Features: AclHuK-GDZyG6m8BFpUMWxfSIBXFJlvlZbCjTm5c1oLpEFzow0OEe9cdwDWWw7s
Message-ID: <CADrL8HXtBxf=qixBZV5-iz1sqfZAqSrMR4ZsJTFXS0N84G+nkw@mail.gmail.com>
Subject: Re: [RFC PATCH 05/10] perf/core: Don't unwind the user stack without
 an mm
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:09=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Oct 26, 2026 at 09:52:21PM +0000, James Houghton wrote:
> > get_perf_callchain() only checks is_user_task(current) when the regs it
> > is given aren't user mode regs. However, BPF's bpf_get_task_stack() (an=
d
> > bpf_get_task_stack_sleepable()) pass task_pt_regs(current) when called =
on
> > the current task, which are user mode regs for a user task, even if tha=
t
> > task has already gone through exit_mm(), e.g. when called from a progra=
m
> > attached to exit_files() or to the dying task's final sched_switch.
> >
> > perf_callchain_user() then unwinds the user stack without an mm. That
> > access does not reliably fail: the user half of the address space
> > belongs to whatever mm happens to be lazily loaded, if any, so the
> > unwinder may read another task's memory. This affects e.g. arm64,
> > riscv, loongarch and csky, whose perf_callchain_user() doesn't check
> > current->mm itself. perf events themselves are not affected, as
> > perf_callchain() already clears the user callchain request when
> > current is not a user task with an mm.
> >
> > Check is_user_task(current) regardless of the regs' mode.
> >
> > Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  kernel/events/callchain.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > index 9d24b6e0c91f..a451ca2a5573 100644
> > --- a/kernel/events/callchain.c
> > +++ b/kernel/events/callchain.c
> > @@ -245,11 +245,15 @@ get_perf_callchain(struct pt_regs *regs, bool ker=
nel, bool user,
> >       }
> >
> >       if (user && !crosstask) {
> > -             if (!user_mode(regs)) {
> > -                     if (!is_user_task(current))
> > -                             goto exit_put;
> > +             /*
> > +              * Even if @regs are user mode regs, e.g. task_pt_regs(cu=
rrent)
> > +              * passed in by bpf_get_task_stack(), current may already=
 have
> > +              * gone through exit_mm().
> > +              */
> > +             if (!is_user_task(current))
> > +                     goto exit_put;
> > +             if (!user_mode(regs))
> >                       regs =3D task_pt_regs(current);
> > -             }
> >
> >               if (defer_cookie) {
> >                       /*
>
> We have perf_event_exit_task() before exit_mm().
>
> Still, it doesn't hurt to be cautious. So no real objection, but perhaps
> adjust the Changelog?

Right, perf events can't get here, since perf_event_exit_task() runs
before exit_mm() (and CPU-wide events go through perf_callchain()'s
is_user_task() check).

The case this fixes is BPF: bpf_get_task_stack() calls
get_perf_callchain() directly with task_pt_regs(current), so a program
attached to e.g. exit_files() or the task's final sched_switch would
unwind the user stack without an mm.

I've added this paragraph to the start of the changelog to make it a
little clearer that the perf event case isn't the interesting one:

  get_perf_callchain() only checks is_user_task(current) when the regs it
  is given aren't user mode regs. That's fine for perf events: a task's
  own events are torn down by perf_event_exit_task() before exit_mm(), and
  samples from CPU-wide events go through perf_callchain(), which already
  skips the user callchain if current isn't a user task with an mm.

Are you happy with that?

Thanks for the feedback. :)
