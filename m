Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793127092;
	b=NIm/nXLHduevcrbmyHC0Okqxm500Voc4Pgt8dbBasl2fXeMnbMSseAI+IsoVCTJIvNZy
	 /mNpmARJoHNpsRzAYm0JCYRXaK6xJVjQ5T+NTPGfuJus1k28rP56owabenR6hvnqv+1Tz
	 JSSvIPMexqZuuLGpp0tOQ5w4X6+rWCrZpoTf1cggEHGWG+u3hacNR4R9xQUGjgPhPkQU+
	 6BCckH2loFFSA9Z6YQm5Y3omdtSCvFk60x+lHGWyMiDAHBua/7o73v6pvLqgBcgbHAuDV
	 4IvM64DEyK3TAP4ASSgwsJ60P++DKSljvn+xENXrqIEMFHxoQFlWZjH84z1X92yMs8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UJlLnl+V5fVkcEdrgjKFPN24Q/fJ++IZ4ZhlDmWxnT0=;
	b=x5JJH/2bFVcbbr1g1IOI2ODq7Ed7lz//kp6ShfgCpGPQYK08aSXSBOXRu1K7lZTIQ405
	 PEwQdtJetJFSrUyrxJgXsWaEDJWIqmUlNJ57T1cXQTpl6DgBw4nfdMnuidaFHo+0K3AmK
	 Dr4ec7JQu8aLio11we/et668ptXoahEPOEML9adKBtEfuoUg2eQ6TOMiu2KGU1VNjQ5By
	 aBld1WHih+f6HzDSrx52JFj1gdjGaOJjiQgdpx0qr/cDNC34pwUWJtf+bPjJt+bul/GLy
	 lZKWNOdzdUdWBJoVgWRrUGPQws9GsZLyk6TLdhy3A5Pf6xBj5LGQZFxtjdEFngQyFIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HFK9DQOj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3EE606A320
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 18:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A3EE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HFK9DQOj
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c3fd91337baso21459266b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 11:51:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793127090; cv=none;
        d=google.com; s=arc-20260327;
        b=ouLsaDMX5Gj1G1qA7V2bTW6/Kx7ldXUgfwNDcQwjLedzehbGlWhAUhW0FiTAd3TlQw
         BxTrOIehyCfDXE1DbMI6ScBu+2Js6/WU5HQ8L7pgJ/d9PXS/oU12DVSN5VoGmRx7u3dW
         gQJRJ52hexUO5wYTpTeHg8ZMJ1UAQVq+O/UhObIEF48ePpm45NOqJ1ZRfJDQmdhy2WVO
         3eAIIYC8grYeiJtw9mDxNkpKLVysTvE8JZst/I5aflR+r2apFpPM5imciCId1gZk6F60
         6cVUOzVQlpVV7iTzcaiaSMsLEHzQNBwOAWH3+I2UrH4YvFVlnzZyH9F55DzpoNrP9eG7
         ar3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UJlLnl+V5fVkcEdrgjKFPN24Q/fJ++IZ4ZhlDmWxnT0=;
        fh=P0T9wE9XWRETLbLjRCo4p4VIiuLEwWreCWgwsNX1bHM=;
        b=qRkqj744Yrrhy5R+hqDPZ4OaEmLXMCD2VnyWrPGrLWBjOwTvY3yAn8dAehmA7VcO7O
         inRkjxh4Z/MKF/8uWjlJNWeiYDzbxhNLy2QMIZ+JshdNSc8frAToZExDLyb8DCfevcM4
         D23zt030cYodMmbbwUT8lXLDH+AlntyAP1wpDJfAv2i7YvnO0/lVpsSUmEqaQ7v6YCj2
         wM7piI3BOZTIWvP8hMDxJ1luD2+dvXH4yZ6/unSLjU+T0230gsqg/bhiwzgKPIBQ4boi
         CHhjBhmPM57aafyWdK7dbh8EqXHoiP1FwMEAL/mKC1GadLl4+JeqgyhdgMwUwsLQTT9E
         Qe9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793127090; x=1793731890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UJlLnl+V5fVkcEdrgjKFPN24Q/fJ++IZ4ZhlDmWxnT0=;
        b=HFK9DQOjx55GzwyinowY3WKQr1IsXRiJeV+D7Z8hkiYPym2ZUBwoZvUifqN/FnkNGU
         pfa1ZewvhEMvZLoaCIPFZp4tA/umOO4oOn0eM3xlRhU2sdWIJfNsPw9HVJXR4LYjiytX
         dUAGwL90rw0Q5w+OWsW5iboZVP9RCytMSNYKe3ji15diP1zhAfgrHC9FvXhRMxxUMt35
         TQ2tHe1FHlUZ2NICIb0rhXxsSpvA5sFGf5zLgnOgSw/RZnKbxxQN9s376gQ8m4D1+J80
         lvL/AJdZ7uKnroRkKZncUslhbEYHXR8yj6xbpQX2rU8tK9ueLcaFgAw4VAp3h++AYDrG
         cmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127090; x=1793731890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UJlLnl+V5fVkcEdrgjKFPN24Q/fJ++IZ4ZhlDmWxnT0=;
        b=VoFp4Co/4TcY9UvxinL2eRzHrvDEG5prr0Kbjv6UgVkb0vMl7OQ166HoUTHTAiD9x3
         sPbo7BYUlUOmQKE8IBNWclhuR1z7jlkFGLnuVKB868PRfzc8gvJj4ECBydRBqjBK0bsw
         WrzKlf6DLL7rPfCCOMDSCqmLHGKIbjh99TsyAM8zipIH16LImgggWQbf63QEpyhRDFrk
         z3kjkwTPs0OjnNSX7mDsLNIj/5aHvGhjdqRItU0L+g6SReTJD8SeroewL6hKrnlREuvj
         CRgIo+LMxSlFXF2nAVD3ZmLqi2MSboxiF9fivAQE4izdsXESvdDexow8L1tuAyPeq+p8
         wUaQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjy5IeqH5C2MvGvJdBKWuXJ9x/vDHEtBPkyj4/JIht7RUxyDBQg0IbeVBZTtOwES7BBxIsUYvx5FpHgsug@vger.kernel.org
X-Gm-Message-State: AFq9FYLVPATohX9XcHorwOOpoybrrt5lPlhBO55zTHorsR1P+rYNBVcV
	KH3EJC9Gar86NiOgKAmvjJSSZGj85sjYqK3xTaV3Qxds28iVSqTSxxESLEfuqHEon9I6p54oyQW
	KBinEl27anUNRvfySP7d2zROPTYNLYlDFNcRymny/
X-Gm-Gg: AYBFou3pKPHdRXp6XuG8lGuTNoVtbF7OGudrgSBYuYXfR7m8T6OYaiAnehqhvPaZOF1
	f5w64hJw48mweSZs2X9jaCf4X+qg7TVPwMfH5VAyZwiAG8jOCaeUdbwjDWEFtLzxBY+710v+/gt
	3M1IgPQjxbTcBc7+xcu8yzj8PgJIqvNuidmtnTj3Z2yMvexcl8CigtK6cToBK+RL9JJrghnnBUb
	5QJys2Z326JNf67lhpUqfxnRC9NwZ6nqja1ufgMyqmOvB1Y99SyqTofpyRgTqWZJw2l7jZQvE9n
	XRguFXDoUrsTbzDFjfe8AsAoplPEQRbzMqP7GIdqVsoYWPZaPXE/ogQRqfRvyNkqYvPx0S3l7JU
	5kMWzYtCiFohFzRsEOAJ4BjgmMvuSqWG+wCxWLI37fK6k3iu1zh01qhqOS4VWrFaW5adfQG+r63
	y3i536l2lFmZETkk7Q43SDt6He9SrD/h10pUhgsjRt6b5afuHPKHt0RGJ2SeGMHnjvNsspAplI1
	OTjSOyWFLghdQqpalAoh3dAUSbP8lHd7g==
X-Received: by 2002:a17:907:a08a:b0:c41:8e21:4d5a with SMTP id
 a640c23a62f3a-c49bdb68d78mr15531766b.5.1793127089381; Tue, 27 Oct 2026
 11:51:29 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-4-jthoughton@google.com> <10ab2f3b005f0df2c0a88e93e6917826d928bb1f82c6a645f942c099e48f8b6e@mail.kernel.org>
In-Reply-To: <10ab2f3b005f0df2c0a88e93e6917826d928bb1f82c6a645f942c099e48f8b6e@mail.kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 11:50:52 -0700
X-Gm-Features: AclHuK8M0uftDAMQJptfiH_zotg0NLNK0vqcV1a8EUqq1l3N0gBPNm3WO8H3TD0
Message-ID: <CADrL8HVHCVoh3AToNzFCe7KP=yC8byCGCzGYzzBEGYtYNC4fJw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] bpf: Fail sleepable user copy helpers when
 current->mm is NULL
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, tglx@kernel.org, 
	peterz@infradead.org, kees@kernel.org, arnd@arndb.de, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	jmattson@google.com, axboe@kernel.dk, asml.silence@gmail.com, 
	James.Bottomley@hansenpartnership.com, mkp@kernel.org, dsterba@suse.com, 
	mason@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, jpoimboe@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:30=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Fail sleepable user copy helpers when current->mm is NULL
>
> TL;DR: Commit message only: the security_file_release() example of a slee=
pable
> program running from a kworker looks inaccurate, since such a program app=
ears
> not to be attachable there. The fix itself looks justified.
>
> > bpf: Fail sleepable user copy helpers when current->mm is NULL
> >
> > Sleepable BPF programs can run on behalf of a kernel thread, or of a
> > task that has already gone through exit_mm(). For example, bpf_wq
> > callbacks always run from a kworker, bpf_task_work callbacks queued
> > late enough run from exit_task_work(), and lsm.s or fentry.s programs
> > may be attached to functions called during exit_files(),
> > exit_task_work() or from kernel threads (e.g. security_file_release()
> > from a kworker running delayed_fput()).
> > In such contexts, bpf_copy_from_user(), bpf_copy_from_user_str() and
> > bpf_copy_from_user{,_str}_dynptr() (when reading from the current task)
> > call copy_from_user() or strncpy_from_user() without an mm. That access
> > does not reliably fail: the user half of the address space belongs to
> > whatever mm happens to be lazily loaded, if any, so the program may rea=
d
> > another task's memory.
> > As there is no user memory to read from in this case, fail with -EFAULT
> > without attempting the access.
> > Fixes: 07be4c4a3e7a ("bpf: Add bpf_copy_from_user() helper.")
> > Fixes: 65ab5ac4df01 ("bpf: Add bpf_copy_from_user_str kfunc")
> > Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
> > Signed-off-by: James Houghton <jthoughton@google.com>
>
> The commit message gives security_file_release() as an example of a place
> where an lsm.s or fentry.s program can run from a kworker:
>
> > (e.g. security_file_release() from a kworker running delayed_fput())
>
> Is this example accurate for the tree being patched?
>
> bpf_lsm_file_release is not in the sleepable_lsm_hooks set in
> kernel/bpf/bpf_lsm.c, so btf_id_allow_sleepable() rejects a sleepable
> BPF_PROG_TYPE_LSM program there.  bpf_lsm_file_free_security, the other h=
ook
> reached from __fput() through file_free(), is in untrusted_lsm_hooks rath=
er
> than the sleepable set.
>
> For a BPF_PROG_TYPE_TRACING program, check_attach_sleepable() requires
> within_error_injection_list(addr) (or a syscall prefix when
> CONFIG_FUNCTION_ERROR_INJECTION is off), or an fmodret set with
> KF_SLEEPABLE.  Neither security_file_release() nor bpf_lsm_file_release()
> has ALLOW_ERROR_INJECTION, and the only fmodret sets are in
> net/bpf/test_run.c, net/mptcp/bpf.c and bpf_testmod.
>
> That suggests a program attached to security_file_release() is never
> sleepable and cannot call bpf_copy_from_user() or the KF_SLEEPABLE copy
> kfuncs.

Great catch. Yeah, the examples aren't right (but the fix is still correct)=
.

> The fix itself still looks justified, since bpf_wq callbacks run from a
> kworker and is_async_cb_sleepable() is true for them.  Only the example
> appears to be off.
>
> Would an example that is actually reachable keep the changelog accurate?
> For instance, bpf_lsm_task_alloc() when kthreadd forks a kernel thread
> (current is kthreadd), or bpf_lsm_kernel_read_file() and bpf_lsm_file_ope=
n()
> when a kworker loads firmware with kernel_read_file().  All three hooks a=
re
> in sleepable_lsm_hooks.

I've adjusted the first paragraph of the changelog to:

  Sleepable BPF programs can run on behalf of a kernel thread, or of a
  task that has already gone through exit_mm(). For example, bpf_wq
  callbacks always run from a kworker, bpf_task_work callbacks queued late
  enough run from exit_task_work(), lsm.s programs may be attached to
  hooks reached from kernel threads or from exit_task_work() (e.g.
  bpf_lsm_inode_free_security() when the final __fput() of an unlinked
  file runs from delayed_fput() or from exit_task_work(), or
  bpf_lsm_bprm_check_security() during a usermode helper's
  kernel_execve()), and fentry.s programs may be attached to
  error-injectable functions called from kernel threads (e.g.
  btrfs_should_cancel_balance() from the btrfs-balance kthread).

I think all the Fixes are still accurate. The first Fixes isn't very
obvious; re-checking it with Claude provided a pretty clear
explanation for why it's accurate:

    This is the subtle one. In 07be4c4a3e7a (v5.10) the sleepable LSM
    set was just bpf_lsm_file_mprotect and bpf_lsm_bprm_committed_creds,
    and both always run with an mm. The LSM examples above only became
    sleepable later, in 423f16108c9d ("bpf: Augment the set of sleepable
    LSM hooks", v5.11), and bpf_wq only arrived in 81f1d7a583fa ("bpf:
    wq: add bpf_wq_set_callback_impl", v6.10).

    However, fentry.s was already allowed on any ALLOW_ERROR_INJECTION
    function other than __add_to_page_cache_locked, should_fail_alloc_page
    and should_failslab, and that list already included
    btrfs_should_cancel_balance() (called from the btrfs-balance kthread
    via balance_kthread() -> btrfs_balance() -> __btrfs_balance()), as
    well as btrfs_check_node() and btrfs_check_leaf_full() (called from
    the btrfs end-io workers). So bpf_copy_from_user() could be called
    without an mm from the moment it existed, and 07be4c4a3e7a is the
    right commit to blame rather than 423f16108c9d.
