Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793634216;
	b=mPp4PSoojfMGPN5DYQDmgjT4EvEQz4A4wq8wGRGwtexCWRe/50H9xl3WniuFwFXt7A64
	 A9CoDFXv3HX4de7ZO+UhJ+qJZXix9SlTcNvJ+dkGJXAYXO9Uz2VWlmn04bjA+rMKXkOAC
	 huyu3ySWfOXaV7Kum3n5nVvV8eYj6pc3O4dB0fPxgnzjIVCnd0GFXMuJUwOHn/HRSIZ5A
	 uECzsPV704Q+EE0G57Q88KaXat5xB3/ZmDwEdtdI2IF/CnOwMBsowsrKr8ETLj/M+lLnN
	 bRayRm1gzv6GsYgPha1TN2I9WPwdLWTVVQ9I04DTtZz2VbipthqQduHlqRavhBuES2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HK8ZrL+fL3c5ivUA8S9idB+tb4oTBF9gPah3Mf4G/bY=;
	b=dtTXQ2HPhcTEwD3TdJ0ud/T68NXT27I+CSF1vQVot4NVOAEhdyNvtC/3n5HS942k28Vy
	 jw8sjZHl/ZLkIFidfcnIrbxPpeJVTNN6nqv1EqiGU40shlaOSMO6znINd3Z2IHYDIO9NN
	 f66KSU61k8ZUkeukOLrv+aRre2vWjHpzTfU6yaAM0am3klm2EDE3X36oIBCPBwk07zf+g
	 cACr9kbEFEOeZBQESPjkTtwaNm5TTiuhVKG3H+nTDyFBet06pLUTAaX3WJzl1jfdfjhRI
	 VY8pkO++fZTaUKThx0pzC7IJ3Ecnypc6OzpNmrB3H2TdL1WyLGhnvberxl+bLrmwheQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R9j+jwxG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2BC606D80F
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 15:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C2BC606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R9j+jwxG
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5383c97c8cfso434931cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 07:43:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793634214; cv=none;
        d=google.com; s=arc-20260327;
        b=UVeePdf9n2mQw1va/fP9L5jBCiZEofYjCDx/Rr9l/d49ROuY+7nsqT0Dj02U3Vvfd+
         mRh5gc1/3pq4XKbXorfoBuk0R9BNbJNUq8X2X1T5akJtxuVmkSHUyBY2Zt2U/8nbMhhg
         a0AMUsXX3DOEY1oA5g6/0Kuv1KPipkKAGwDyHy+PDPRCWQHz+mnNpeROfF5nwOtDy6Ps
         BEaDaZ8gIlGhbjiCG1HXzXZfw9GCuEJ8qacCs9hO66hyrET9PJgSYBsUcrGWAa6yye0n
         32ShEN6uwd9RU/SLwV9XVZy00VMehpsrmG5CzbQMXVkMxGb8kEuPhogzlC02ZOCiPAvi
         LMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HK8ZrL+fL3c5ivUA8S9idB+tb4oTBF9gPah3Mf4G/bY=;
        fh=FecLiExcEhdRptjX90TPwn3IzToMhthqTEdrYd01KFg=;
        b=UWEzqNcs/8Jmrx5obOmOy4wXEoTCE8NdxZIPVqtvrVIWb6VCj3CkdDfAePGi++o0jn
         cHkXwaHd5lR3DjRmodYxifxDThquJ82EnSJfYPI7jK9/QXUx8/kgsZt5OOQ98//J/r99
         zGKydugrd8insukgLUz9IOFgvN+9SRerWxoZYoFtfPgjK9M5OeRv/D3+Sb0wf9xWpT0D
         nAh/gbp/aQlFMEXx8fe14QqD1WDSoYuSO6mLrpZZpXtZtGFrPMJ327Tur9H+OdtUZPsl
         YX8gENnkuprawiRRp8dwmUPUPj8shP42G8KqkrW+1dlXotNSJD07aXRtqA+67nJQxPgJ
         M2nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793634214; x=1794239014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HK8ZrL+fL3c5ivUA8S9idB+tb4oTBF9gPah3Mf4G/bY=;
        b=R9j+jwxGcRL6XdsG2JWiq2a64G7IoWEkfdsReSzCWmy68LqttG+ZpDz356XNZ0BE5G
         TiHv/vLz6oXwQhiKyDA10leH9Asnjacp2C88iOazs9HMe6omqyd/LuvDsfvaF/LhkmXu
         jJIh768DemfC3BPoFeTnacA5QUfKQCX0ifEEBWXCTbZfNF2R7zu/bCRQhLwYip77HQAV
         mDvcOTT7kSHBakijnXYkRDqCPCvEsBMSLeuJNm64FWC2Z+ffwG1thHZ/9/hMWUofZP+f
         8OLJsnD2d1bJBx8Mjf+vc0a5VwK5BDnXxWVDX9muRqCVRMiNMTcvbzjSKFEgLBhi2YIe
         8dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634214; x=1794239014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HK8ZrL+fL3c5ivUA8S9idB+tb4oTBF9gPah3Mf4G/bY=;
        b=Ro6mG79kMaxbkL1FHYK/8930P7WwAW5KA4MowlFqlKNpKUnR702Eod57vlM6V+ZkaJ
         AXiGQ4vDD3/m//USLQuQ2WkvnmnWqhqdaBX23exHsXcWo7gFL2sAC6sSrSLMPvecV8ig
         t7QntoC8hdDA42VEvUOdTzEI7boMb4BBg7/I+ybd5WC2R+rnlLd8JQLJtnHUgXasLFyN
         WOTxRIsv6DzojHdDumiTMY1zKmq1OXX4DXrTyOaGEwz2WWgRZTQpDD7PEGK9Ytl6lC7F
         Tq0mPYxFDphdJ2ODUKK6Nej0DxSuSox0ALeOwwWvaylccJsYYBGghtrp+S1+Rb0bHsRF
         V8bg==
X-Forwarded-Encrypted: i=1; AKwUvBwAKNDvtycaV3X+d+3N1QPiygk0GNkAfR7kyJRa/YJKZ6HqnpIAZjrkjvMDBDX4f0sTRBs48WDe3cOIzUWb@vger.kernel.org
X-Gm-Message-State: APuU4Z87NhNLDpFGTG95HO+U+WkByWX3mHD1gV/2TQOTaw9Gtdv3N1q8
	HLi6a6B1RUWLdoc79iFmCmKoLuyhx3+UGiGQSn2F1MUTXAYY8O1rScen54LWTiW1PMovycAzZaE
	pHXKwZfSc1Hhy7uL24OYlo3DVDXBEKJgAUWPyo4TK
X-Gm-Gg: AYBFou2s4l5azrp2qZ/7Z/AXbCdDv00SCeRC0s8kNW1+fwYlA4GT45sZXz1CSNjYZBF
	IloZxC4+2vd/4GwF2TAiwBGo9QHA9/0qvvIgP9g0yg3ct7o9q9OPfZzi9HPcOgtRRTuqX5NiycU
	KWOjL6F8BFVy3SfMc8Zq+KCw7pT4Ya30YK8jNhvi076xZN6Qyx7kGsXmJ5dP/JyCQscotE48TSw
	Ntu6o49iMDBGWvIhsybML3Vhn69WY6+G5ejeRHwM3h9Lp3UJXUO4qNOFJrSvkqqrlbKM2Is5+iH
	wkN0rQvIgY81kx2rihXseMf3wTurXSv2ScNuqktVEz6Cp5w7bCrZS8wZAiUMAxAPX3uWXz7hf6g
	MYeFJg3fYZnqUDqz8KRkB1n7JwxPaKd1CXINx
X-Received: by 2002:a05:622a:5148:b0:535:9aa3:5ebb with SMTP id
 d75a77b69052e-5414de19e54mr81585421cf.8.1793634213512; Mon, 02 Nov 2026
 07:43:33 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101154503.3203036-1-surenb@google.com> <20261101110100.90796bf33ef50307a7698dca@linux-foundation.org>
In-Reply-To: <20261101110100.90796bf33ef50307a7698dca@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 2 Nov 2026 07:43:17 -0800
X-Gm-Features: AclHuK9i5oa7VVhckAQGYTCIvZrhSt3SBl_wIVecLZ9aaFaoBEyuGC4XsLqeGFo
Message-ID: <CAJuCfpGmPLBRhHa_dmyP10QzyRyvcWMYDLU0+J9t-RCLBsTaWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selftests/proc: use RSS in /proc/pid/smaps_rollup
 tearing tests
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, ljs@kernel.org, jannh@google.com, liam@infradead.org, 
	willy@infradead.org, paulmck@kernel.org, pfalcato@suse.de, 
	usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org, 
	yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 11:01=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sun,  1 Nov 2026 07:45:03 -0800 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Pss metrics can be affected by map count even if VMA tree stays unchang=
ed,
> > therefore tests checking VMA tree integrity can't use them. Use Rss ins=
tead
> > and pre-populate the VMAs so that Rss changes if a VMA gets skipped or
> > double-counted.
> >
> > To ensure all test VMAs are populated with anonymous pages, remain
> > mergeable across VMA operations, and do not have their Rss changed by
> > memory reclaim:
> > - Toggle PROT_EXEC instead of PROT_WRITE between adjacent test VMAs so
> >   all test VMAs remain writable and MAP_POPULATE faults in anonymous pa=
ges
> >   (rather than the shared zero page, which is not accounted in Rss).
> > - Use mprotect() instead of mmap(..., MAP_FIXED) in split_vma() and
> >   merge_vma() so the first page of the split VMA stays resident.
> >   mprotect(..., PROT_NONE) splits the VMA without unmapping the first p=
age
> >   (pte_present() remains true for PAGE_NONE PTEs), and
> >   mprotect(..., self->mod_info->prot) merges it back. Both parts of the
> >   split VMA retain their non-zero Rss.
> > - Lock all present pages in the child with mlockall(MCL_CURRENT |
> >   MCL_FUTURE | MCL_ONFAULT) so memory pressure cannot reclaim pages and
> >   alter Rss during the test.
> > - In remap_vma(), unlock next_addr before mremap(..., MREMAP_DONTUNMAP)
> >   so next_addr is not split, use mmap(..., MAP_FIXED) in patch_vma() to
> >   merge the middle VMA back into addr, and exclude smaps_rollup tests
> >   from test_maps_tearing_from_remap since remapping moves and unmaps th=
e
> >   page from next_addr.
>
> Thanks.  This is proving tricky.
>
> My evolving reviewbot still isn't happy:
>
> : This fixes the v1 RSS issues, but two things remain.
> :
> : Alternating PROT_EXEC breaks with READ_IMPLIES_EXEC: both mappings
> : become RWX and can merge. A syscall test produced two VMAs instead
> : of 16. Could we populate everything writable, then mprotect the odd
> : mappings read-only? That preserved all 16 VMAs and avoids zero pages.
> :
> : Also, MCL_ONFAULT doesn't bypass RLIMIT_MEMLOCK. If mlockall() fails,
> : the child asserts before CHILD_READY and the parent waits until
> : timeout. Please arrange a coordinated skip for insufficient allowance.

Good point. That part of your fix looks good to me.

> :
> : The patched userspace test passed all six cases on an existing
> : x86-64 6.18.57 kernel, with a PID-namespace adjustment. That kernel
> : predates ca5480fb53fa, so this checks selftest behavior, not the
> : intended kernel's procfs changes. Separate syscall tests on that
> : kernel confirmed the EXEC-merging and memlock failure cases.

I'm guessing your bot was using personality() to make the tests fail.
Again, I'm not sure we should handle such use case. Should we?

>
> I said "no, do it yourself" and it came up with the below.
>
>
>
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: selftests/proc: handle personality and memlock constraints
> Date: Sun, 01 Nov 2026 10:55:37 -0800
>
> Alternating PROT_EXEC does not keep the test mappings distinct when
> READ_IMPLIES_EXEC is set: both protection combinations become RWX and
> adjacent mappings can merge, breaking the fixture's layout assumptions.
>
> Populate each mapping writable, then make odd mappings read-only.  This
> retains anonymous pages accounted in RSS while keeping adjacent VMAs
> distinct regardless of READ_IMPLIES_EXEC.  Restore the corresponding
> WRITE-based protection selection in the parent.
>
> Restore the whole three-page destination after remapping, rather than
> replacing only its middle page and relying on the remaining anonymous VMA=
s
> to merge.  The remap test no longer compares RSS.
>
> mlockall(MCL_CURRENT) checks the whole virtual size against the locked
> memory allowance even with MCL_ONFAULT.  An insufficient allowance makes
> the child exit before CHILD_READY, leaving the parent waiting until the
> test times out.
>
> Pass the locking error through the existing shared state and signal
> CHILD_READY on failure.  The parent reaps the child and releases the
> shared state before skipping resource or permission failures.  Check this
> status before opening the child's proc files, as it may already have
> exited.  Unexpected locking errors remain test failures.
>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: kernel test robot <yi1.lai@intel.com>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Cc: Usama Arif <usama.arif@linux.dev>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> ---
> On top of Suren's v2 "selftests/proc: use RSS in
> /proc/pid/smaps_rollup tearing tests".
>
> Tested the userspace test on an existing x86-64 Linux 6.18.57 kernel,
> using a separate PID-namespace adaptation which is not in this patch:
> - All six cases passed normally and with READ_IMPLIES_EXEC enabled,
>   using DURATION=3D1.
> - All six cases skipped promptly with RLIMIT_MEMLOCK set to 64KiB or
>   zero, exercising ENOMEM and EPERM respectively.
> This does not validate the intended kernel's procfs changes.
>
>  tools/testing/selftests/proc/proc-maps-race.c |   49 +++++++++++-----
>  1 file changed, 36 insertions(+), 13 deletions(-)
>
> --- a/tools/testing/selftests/proc/proc-maps-race.c~proc-maps-race-follow=
up
> +++ a/tools/testing/selftests/proc/proc-maps-race.c
> @@ -174,6 +174,7 @@ typedef bool (*vma_mod_result_check_op)(
>                                         struct line_content *restored_fir=
st_line);
>
>  struct vma_modifier_info {
> +       int mlock_error;
>         int vma_count;
>         void *addr;
>         int prot;
> @@ -696,7 +697,8 @@ static inline bool remap_vma(FIXTURE_DAT
>
>  static inline bool patch_vma(FIXTURE_DATA(proc_maps_race) *self)
>  {
> -       return mmap(self->mod_info->addr + self->page_size, self->page_si=
ze,
> +       /* Replace all three pieces without relying on anon_vma merging. =
*/
> +       return mmap(self->mod_info->addr, self->page_size * 3,
>                     self->mod_info->prot,
>                     MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0) !=3D =
MAP_FAILED;
>  }
> @@ -757,22 +759,31 @@ FIXTURE_SETUP(proc_maps_race)
>         self->pid =3D fork();
>         if (!self->pid) {
>                 /* Child process modifying the address space */
> -               int prot =3D PROT_READ | PROT_WRITE;
>                 int i;
>
>                 for (i =3D 0; i < mod_info->vma_count; i++) {
> -                       mod_info->child_mapped_addr[i] =3D mmap(NULL, sel=
f->page_size * 3, prot,
> +                       mod_info->child_mapped_addr[i] =3D mmap(NULL, sel=
f->page_size * 3,
> +                                       PROT_READ | PROT_WRITE,
>                                         MAP_PRIVATE | MAP_ANONYMOUS | MAP=
_POPULATE, -1, 0);
>                         ASSERT_NE(mod_info->child_mapped_addr[i], MAP_FAI=
LED);
> -                       /* change protection in adjacent maps to prevent =
merging */
> -                       prot ^=3D PROT_EXEC;
> +                       /*
> +                        * Populate writable to get anonymous pages, then=
 alternate
> +                        * write permission even with READ_IMPLIES_EXEC e=
nabled.
> +                        */
> +                       if (i % 2)
> +                               ASSERT_EQ(mprotect(mod_info->child_mapped=
_addr[i],
> +                                                  self->page_size * 3, P=
ROT_READ), 0);
>                 }
>                 /*
>                  * Lock all present pages in memory so memory reclaim can=
not
>                  * change RSS during the test, and use MCL_ONFAULT so
>                  * mremap() expansion does not populate new pages.
>                  */
> -               ASSERT_EQ(mlockall(MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT=
), 0);
> +               if (mlockall(MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT)) {
> +                       mod_info->mlock_error =3D errno;
> +                       signal_state(mod_info, CHILD_READY);
> +                       _exit(0);
> +               }
>                 signal_state(mod_info, CHILD_READY);
>                 wait_for_state(mod_info, PARENT_READY);
>                 while (true) {
> @@ -799,6 +810,21 @@ FIXTURE_SETUP(proc_maps_race)
>                 exit(0);
>         }
>
> +       /* Check setup before opening proc files: the child may have exit=
ed. */
> +       wait_for_state(mod_info, CHILD_READY);
> +       if (mod_info->mlock_error) {
> +               int error =3D mod_info->mlock_error;
> +               int status;
> +
> +               ASSERT_EQ(waitpid(self->pid, &status, 0), self->pid);
> +               pthread_cond_destroy(&mod_info->sync_cond);
> +               pthread_mutex_destroy(&mod_info->sync_lock);
> +               munmap(mod_info, self->shared_mem_size);
> +               if (error =3D=3D ENOMEM || error =3D=3D EPERM || error =
=3D=3D EAGAIN)
> +                       SKIP(return, "Cannot lock test mappings: %s", str=
error(error));
> +               ASSERT_EQ(error, 0);
> +       }
> +
>         switch (self->maps_file) {
>         case MAPS:
>                 sprintf(fname, "/proc/%d/maps", self->pid);
> @@ -815,9 +841,6 @@ FIXTURE_SETUP(proc_maps_race)
>         self->maps_fd =3D open(fname, O_RDONLY);
>         ASSERT_NE(self->maps_fd, -1);
>
> -       /* Wait for the child to map the VMAs */
> -       wait_for_state(mod_info, CHILD_READY);
> -
>         /* Read first two pages */
>         self->page1.data =3D malloc(self->page_size);
>         ASSERT_NE(self->page1.data, NULL);
> @@ -842,10 +865,10 @@ FIXTURE_SETUP(proc_maps_race)
>         for (int i =3D 0; i < mod_info->vma_count; i++) {
>                 if (mod_info->child_mapped_addr[i] =3D=3D (void *)self->l=
ast_line.start_addr) {
>                         mod_info->addr =3D mod_info->child_mapped_addr[i]=
;
> -                       mod_info->prot =3D PROT_READ | PROT_WRITE;
> -                       /* Odd VMAs have exec permission */
> -                       if ((i % 2) !=3D 0)
> -                               mod_info->prot |=3D PROT_EXEC;
> +                       mod_info->prot =3D PROT_READ;
> +                       /* Even VMAs have write permission. */
> +                       if ((i % 2) =3D=3D 0)
> +                               mod_info->prot |=3D PROT_WRITE;
>                 } else if (mod_info->child_mapped_addr[i] =3D=3D (void *)=
self->first_line.start_addr) {
>                         mod_info->next_addr =3D mod_info->child_mapped_ad=
dr[i];
>                 }
> _
>
