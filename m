Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4383C944A
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Aug 2026 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786853515; cv=none; b=n2aBG+jWOC4py0Ns+5SuiHem+laAwSu6Yyb/GeGcjV4JSS0WBH50JFWq44H+AO7zNGHXkIGaPqNBF0sIgh4Jb6aSGo6uHDiNsqwL0PyoXHNxY1w6K68STFiwStxO9Lg2jpasl0AVr/GliN1f/bWnZ9EevCeNQD7eFC89HWAVXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786853515; c=relaxed/simple;
	bh=Yz589XEB95nrMlaKNE2uNEJora2fvRgX0MLCCPvYLh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUXjRABhD22uRnN+u9IRrLwxl1HOCzeaCXq0V66yZsDNT3LhWYBpHQ/NZqSxPzAo+3Yqk/xpQ9SXNns19DbKbU53c6GfeOJQjYkhhlnho5jzUxaDlN1LYn3Civ/VQAkUlExA5V3m2upug7eTyPeK6VI2EwfveYYDbn1+cNpzDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VY2SSwdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY2SSwdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEFD1F01559
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Aug 2026 04:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786853514;
	bh=cFHs8gvxJX+p37ht/u6mq8BW9d9iCfeT6c4xmXd4hIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VY2SSwdZm5JfG8+iBQZRwFRJMLS4ngMep8h6KAYdeUbB6oIo6JD83zyCAwYrFjP+N
	 jTNhohyLW/UrY0BUOpliJbtqESAllLR5e0HGfxBY0jmQ4+k9xTslglLxCCQRlnkIJg
	 Yn8Lq/jytzjPglAxGOPdrnLVY/sA7WxSxP7AkrBYJ8fRkSjOddZiHceQMujUzIY+W2
	 3V19HklDOJGOLuO6OSapcweR9vfCgnmnyUJNzg/pFq6pNZU+LPDFz2L7VMEoElXUMI
	 l6W4Z7mAmIx+s9lpc7N8s3nqqQtZ3umlBpRROJFRtO59QzkMjrajBgdjReNDMb9QfJ
	 YecFaAnzaxi8A==
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so20082326d6.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2026 21:11:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro1+nhViFNd/XtsWDYDrCUWoQN6+sGdlYVwQ1txztH5hBu+vzH1swf5Leg9cxgV06/Q+sOtL6A1uHdj7VaP@vger.kernel.org
X-Gm-Message-State: AOJu0YytMG/+3LZXtDinRMQb3puuro2xuk3/kygih3gql5ZOtyXKAQPL
	D9/rnJRhv74hjv2gkeRTsUexrsU3zOFrweAncq9cpnJZppo3RYW4RDjaHh8pXVCELB3GmXpuRlm
	o641bv0aDry3qmWb/51BHLPooA/uZ2Ak=
X-Received: by 2002:a05:6214:459b:b0:8ee:fbc5:8110 with SMTP id
 6a1803df08f44-90a91e850e0mr202646836d6.32.1786853512973; Sat, 15 Aug 2026
 21:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu> <20260730-blk-dontcache-v7-2-3e8e6850068d@columbia.edu>
In-Reply-To: <20260730-blk-dontcache-v7-2-3e8e6850068d@columbia.edu>
From: Barry Song <baohua@kernel.org>
Date: Sun, 16 Aug 2026 12:11:42 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wUvLoKGafR3U-ji1kUUaz6K_QdN6QxMT-apSaO5tXp0A@mail.gmail.com>
X-Gm-Features: AcwNN1WZkB-TbbPYLGbQZDybzjU1BQWX9MmsjrOiq9haH_bC38JheVA30gQpXP8
Message-ID: <CAGsJ_4wUvLoKGafR3U-ji1kUUaz6K_QdN6QxMT-apSaO5tXp0A@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] block: add task-context bio completion infrastructure
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Chunhai Guo <guochunhai@vivo.com>, Dave Chinner <dgc@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Hillf Danton <hdanton@sina.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 3:37=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> w=
rote:
>
> Some bio completion handlers need to run from preemptible task context,
> but bio_endio() may be called from IRQ context (e.g., buffer_head
> writeback). Callers need a way to ensure their callback eventually runs
> from a sleepable context. Add infrastructure for that, in two forms:
>
>   1. BIO_COMPLETE_IN_TASK, a bio flag the submitter sets when it knows
>      in advance that its callback needs task context (e.g., dropbehind
>      writeback). bio_endio() sees the flag and offloads completion to a
>      worker automatically.
>
>   2. bio_complete_in_task(), a helper that completion callbacks can
>      invoke from within bi_end_io() when the deferral decision is
>      dynamic (e.g., fserror reporting).
>
> Both share a per-CPU list drained by a work item on a WQ_PERCPU
> workqueue. Producers push the bio onto the local CPU's list and schedule
> the work item, which then dispatches each bio's bi_end_io() from task
> context.
>
> Both methods are gated on bio_in_atomic(), which returns true in any
> context where a sleeping bi_end_io() is unsafe, including
> non-preemptible task context.
>
> Two CPU hotplug callbacks are used to drain remaining bios from the
> departing CPU's batch, while maintaining the per-CPU behavior. The
> CPUHP_AP_ONLINE_DYN callback disables the per-CPU work item while the
> CPU is still online, preventing it from running on an unbound worker
> later. CPUHP_BP_PREPARE_DYN then drains any bios added between disabling
> the work item and CPU offline.


Hi Tal,

Thanks very much for the patch. I=E2=80=99m just a bit confused that
folio_end_dropbehind() only requires in_task(), and nothing more.

void folio_end_dropbehind(struct folio *folio)
{
        if (!folio_test_dropbehind(folio))
                return;

        /*
         * Hitting !in_task() should not happen off RWF_DONTCACHE writeback=
,
         * but can happen if normal writeback just happens to find dirty fo=
lios
         * that were created as part of uncached writeback, and that writeb=
ack
         * would otherwise not need non-IRQ handling. Just skip the
         * invalidation in that case.
         */
        if (in_task() && folio_trylock(folio)) {
                filemap_end_dropbehind(folio);
                folio_unlock(folio);
        }
}

But we=E2=80=99re applying a much stricter check with bio_in_atomic():

+static inline bool bio_in_atomic(void)
+{
+     if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
+           return true;
+     if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+           return true;
+      return !preemptible();
+}

I feel like something may be missing either in
folio_end_dropbehind() itself or somewhere in the
filesystem/block-device path.

Do you know why they don=E2=80=99t match each other?

Best Regards
Barry
