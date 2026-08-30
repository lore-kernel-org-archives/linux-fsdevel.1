Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030E53A4535
	for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788079528; cv=none; b=g2QgvIOdy0OW0gV1AAIyGHalSLGuSQI97SWZ7KHn4RJ0aa/BxiulpYL1LRjOJRkrDkK7XFsl42+XIW+IG4IVO/u5G6Z9lTjd4+RcHnZHxC2LtjB+Ub3122wVoGH69nGlSpEuTxN71mRnJXH67dbVUFXRaeh6pSAojUBUPYWWBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788079528; c=relaxed/simple;
	bh=6WhnVC+AjMiupX5xOGHcfLWtYRGleD+P30ykDNu4ocI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1Q2dcDeQfEZIF9yGgo6SaOt1KKmw3aN9VknDEXXLzz1VBv1tc7cbTYBONHlFIYnyAlJIUEE1bUFhuIZ6puEmjIF+c1D7CTa+rG46nBVh4AqzRLK/siiDFUmsZr6xgDh2OU+UQSycT/eC+UiKDGvOXLvPzwIEOw65kuNLBadpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaQVowwc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaQVowwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6DE1F00AC4
	for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 08:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788079526;
	bh=7EkBLffHUilXUOjYRnC67N1nxTA08hQD3hpd88dlmDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GaQVowwcTTHSnoV07mxxH7tp3H0PPNfB7ije6AYFDP9JHUlPWqBF/K+elcY4Og3De
	 GRq3QStCWJaF8QA6OJS/FKAQDCh9SKNZkwOA4qBzoTHiVe7bVHSDEzapqJAgsXKI3d
	 Q3DkG1N1RJF2rahVShFluAeUcQx46U54xKFgM04CSYYWYTSWFFIIAiveagZUCcKCQK
	 9Jb/Y6w+dBJaNEekiGVhwvlcE2pX7FUCq+xEuK3/cTtELO0MW0wXAmVZCWYoCq4TQq
	 5y/lkUeytEztpNhiVSsq8YXZjxOAOLCPWSPk345k06XRhUOeJsvH5Lk3zaXvmiN5Fo
	 XjD6LFXlNFxDA==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-936e393176fso143726185a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 01:45:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqJDLi6TMUrNiYCgTtfQ3/oynjiTVLYogwAWrf1UGXtu5k7UMpIB35udiK2Cn+Vv1cXrE+SjjEk2llKD29C@vger.kernel.org
X-Gm-Message-State: AFuF++k2s6n49uu1reGmIYrMLjZW3rnhfHEtuKE/3448R/xljZvChoMp
	QmzEmyjlg8n9WD2rwgHv0oa4j0YEoAhrODKUnB8rMQVQYKmkf4zVnNFGtsJhpZ/BnPd6JogRVSr
	2Hc9zgRxBDAB2e7WyzYmJYb/B8nimJ20=
X-Received: by 2002:a05:620a:1a1f:b0:937:37d4:5dbb with SMTP id
 af79cd13be357-9391390a280mr2106971885a.27.1788079525955; Sun, 30 Aug 2026
 01:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com> <20260828181035.ce6e23970d37e38b64818f10@linux-foundation.org>
 <20260829121335.3491374-1-qwjhust@gmail.com>
In-Reply-To: <20260829121335.3491374-1-qwjhust@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Sun, 30 Aug 2026 16:45:14 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xxDpeaPv9Uh_1qsuXsMLkx+J0X=2V6342idLFO5jkTBw@mail.gmail.com>
X-Gm-Features: AcwNN1X4DbE0lm3JyC3by5kykwuVyKlkaTLRkog7SDb_iT14PqwGbCiV-P3uFKs
Message-ID: <CAGsJ_4xxDpeaPv9Uh_1qsuXsMLkx+J0X=2V6342idLFO5jkTBw@mail.gmail.com>
Subject: Re: [PATCH] mm: filemap: tighten dropbehind completion context check
To: Wenjie Qi <qwjhust@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, qiwenjie@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 8:13=E2=80=AFPM Wenjie Qi <qwjhust@gmail.com> wrote=
:
>
> I kept the helper private to avoid an MM dependency on <linux/bio.h>.
>
> After looking further at the mapped-folio case Matthew raised, I think th=
e
> better fix is to retain a dropbehind folio once it is mapped.  A mapping
> represents a competing cached user, and retaining it avoids the sleeping
> unmap path, so filemap no longer needs a stricter context helper; the
> existing in_task() guard remains.  I will respin the patch on that basis.

But we still have `bio_in_atomic()` in `include/linux/bio.h`:

/**
 * bio_in_atomic - check if the current context is unsafe for bio completio=
n
 *
 * Return: %true in atomic contexts (e.g. hard/soft IRQ, preempt-disabled);
 * %false when a bio can be safely completed in the current context.
 */
static inline bool bio_in_atomic(void)
{
        if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
                return true;
        if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
                return true;
        return !preemptible();
}

Right now, it's used in three places, and I expect we'll see more users
over time.

   1   1925  block/bio.c <<bio_endio>>
             if (bio_flagged(bio, BIO_COMPLETE_IN_TASK) && bio_in_atomic())
   2   1451  fs/erofs/zdata.c <<z_erofs_decompress_kickoff>>
             if (bio_in_atomic()) {
   3    403  include/linux/bio.h <<bio_complete_in_task>>
             if (!bio_in_atomic())

Yet it really has nothing to do with `bio` at all; it's purely a
scheduler thing!

So I fully agree with Andrew that we should move it to `sched` and
continue the discussion there. Maybe the current `in_atomic()` helpers
aren't really good enough?

Best Regards
Barry
