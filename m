Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876F3CEB8E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739484; cv=pass; b=uWHFv1SjJCHUcQbHPzRiL2E63WzoMZubiuiIVd7RvGJybzMmlNldsZsKnzUvOMpuWUMMIDUNxFywbYBYntGJFPRlZS/+duQfmdyG1IbVu6ScylnAqjGbpaSHRd6bOCN5BIrfawk32jzyxsdeh6H1n8sgmPO4Z5/IKeQEAZSnHBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739484; c=relaxed/simple;
	bh=ZHo0GbkrJBYGpDJ/KY0vXCFuOX6g8CR7CnRcWE4JybE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRC2/KAz4d4sxGizfbXl7hUKR35QchyD8BNr4celfMpxMfbGJV3g9PC86YHl4jv942P+kPoPXN/fl2mgAPS5JswADTXw1KtGGijz+BrmBrqp8ipqJWYqVSdxzOWgbVyrDE8EzGe5KRS651bi0NHsnIQyRo3nnZsTVpdOIwWfVSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RImRnvfW; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RImRnvfW"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9382e59c0eso145244666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 05:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775739480; cv=none;
        d=google.com; s=arc-20240605;
        b=S7p6NGuHLyH3q3FIuSZUN+PQEjbc19IEwix5SheARPBv8x3r3bbDOI54yuNQO4ZWBG
         HNvrTNDkALzTsVos0Ns7Dbv6gvveoUcENUD4Zm2lHJLZhQ6VJ6scoFhjvMjlYRYld97K
         az94xjua5FFjrZub5v0GunVBPsX/V8DdL0g0mkm6McoIQVb9tdsrTw77Ud2T7rNhBqyz
         Pn4A/P+e6imxZjPAeTw+Q7yX6f63nFZinPTfoDYkIjdkhWKX5SwXUcCXgWL8nHhI8Zaz
         pd3Wo5jbt/asdVc4ZgyiEsW4P5CSeApSRnFgK7Yt5uTGOJjFocQDKW37iYB70nb1xUBQ
         rHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZHo0GbkrJBYGpDJ/KY0vXCFuOX6g8CR7CnRcWE4JybE=;
        fh=mPk/NY4sFBVz3JhjDAwAQUD5eRK/8yuZZFkgdgHoRFY=;
        b=ekTDIxiOoF0kP7F1e7fdZExQrxzJDhIB+Ah5ao6drH/CWa3LQAVhRfS8LQdM8BKdlu
         m3LWw6LnhDijnxoRBng5iQO8C36b06PmwjHv9RAwo37x5VSKxrmlfzHC9+6tSDYP4sn3
         N+QZpX7YSkLHQiKXkvcCK9pGDCXT2Tb7J9thneURXpn+NnaG9+3zhrx89ij+bxcarw2Y
         LznWG1OmCuIyNIlqY2k03rzaqQQyYBl7gcJys58mfryck5Uyxng5cP1BX+PjKs1Q+EvC
         64hf0mZYvq1XeAy13AgIAUrY+akxsV9GGGTf+FN+qvaf4bcxFlDJkEVR11Jfu0TNIq/O
         Okhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775739480; x=1776344280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHo0GbkrJBYGpDJ/KY0vXCFuOX6g8CR7CnRcWE4JybE=;
        b=RImRnvfWyx0/+lS8sI/jxtzoBQQl08/GPKGSuTzm2a7M2sNrnuXD6M7720no6IGq1H
         MlLQpoFOHDyCRMQKX9WwYVfHjCvSHlbYksX5P2cyZrd5003SldkzlIHKA65DYDl1qUya
         DACFvciRnpKbcP8UHTfNDlhyBirm9gU1v1jaUoeVrsqteElYR4zT6P70fYw3ZJ3ZLP7l
         nxnASazPKrDLBWTfwiR3L3nKfOPZX4Q8vtAoF7aSXj28v7BtUwzJz6Xp/p2zMF4s9XUw
         TiKAoqRPIYBBp9ndHfjuWhpNh+il8G2PbEcRn+JbRvpyJ4TBlzpE+pj/KThSKelZ5KPq
         2Mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775739480; x=1776344280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZHo0GbkrJBYGpDJ/KY0vXCFuOX6g8CR7CnRcWE4JybE=;
        b=eV3xAEJBKwWm1Z5SMdDYhY2GcqpbMNgGpA9F88X2Hflg5HCI1oqfN3CvyD7vNEbA+O
         ft/5Cz3coC6Ac6C4IQXecDwW8ZFFJRBAKDNuruHmLh4MfDTtG1qNWdmDSLjwEJzkEgFe
         rj70yurszKru0uSkPWVdHY16D4exz69gCN+51r7LzwSJJth0XyDXl5J4rJhOA/6taDhg
         KFDNVyTCMP9I/AGTZk16pegAOj9MT+gEf0rvxxmX5ZK7um6FWuGYRmWBTsmC5S4byvQs
         Tk08deafe2jH7jyVs3hQJMWNISZ0/nbNVmTuEVWLm9lOehbAAe2nwcAq7vXfpy0YljuE
         pXZw==
X-Gm-Message-State: AOJu0YyGZr6A633eybIxiQ1baZ9N241dJI7sy9ElXNrVtcyNJajVzFFW
	oTXp+nDvXAN6ykUWzOizqiITZ9aqsGjAyCTLYXlOPVKZWbEL5DuW7/h/4YXkB72TGe1H5BFQt6n
	x5bmB/CfLXVAxTbdmZkRlS7SeFz3ZI04aized
X-Gm-Gg: AeBDiev9yKH56qfr3SZF5IgbKdRcQdYy/ltUuuZC1xLnTZOv+Vo8kG6vBtzzfRgZcBe
	d8w5UFcxXJWuXwaPRYqiYl/Sb6na/r50qIyufd5Tj4SltepUiFsHVS0PBU8NGG2QuUtQmpugDKk
	2GXCGKsxIGNr7Q4X5qjD5yeZQvZKDknkWI8E34934D9uDRQB9ROcnid/9tiKHsDGRI1XSpdoaai
	ssMs/b1vosF2M5kFqbWQp+PCSow2xOIjldgyPwtVZzhBJsZMQAsiFLrpXA1shsuyEh8d7DqSjMz
	c+XHcihbUEWInFLdIfXTvnIfLc536EHQNS3hmVSCLQ==
X-Received: by 2002:a17:906:f594:b0:b98:8c46:fc44 with SMTP id
 a640c23a62f3a-b9d472537a3mr188681866b.2.1775739479605; Thu, 09 Apr 2026
 05:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
In-Reply-To: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 Apr 2026 14:57:47 +0200
X-Gm-Features: AQROBzD488QBLxf8tFQvWy4nXPU6xnyCMIBJtuUSx6jvGfNNYZgE0kkI12Vq1nc
Message-ID: <CAOQ4uxgYYt8LQqR+feSwqGccqD7Ns3sNgiVHw76mYsbKSwq5ng@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem inode reclaim
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org, 
	Boris Burkov <boris@bur.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 11:17=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> This is a recurring topic Matthew has been kicking forward for the last
> year so let me maybe offer a fs-person point of view on the problem and
> possible solutions. The problem is very simple: When a filesystem (ext4,
> btrfs, vfat) is about to reclaim an inode, it sometimes needs to perform =
a
> complex cleanup - like trimming of preallocated blocks beyond end of file=
,
> making sure journalling machinery is done with the inode, etc.. This may
> require reading metadata into memory which requires memory allocations an=
d
> as inode eviction cannot fail, these are effectively GFP_NOFAIL
> allocations (and there are other reasons why it would be very difficult t=
o
> make some of these required allocations in the filesystems failable).
>
> GFP_NOFAIL allocation from reclaim context (be it kswapd or direct reclai=
m)
> trigger warnings - and for a good reason as forward progress isn't
> guaranteed. Also it leaves a bad taste that we are performing sometimes
> rather long running operations blocking on IO from reclaim context thus
> stalling reclaim for substantial amount of time to free 1k worth of slab
> cache.
>
> I have been mulling over possible solutions since I don't think each
> filesystem should be inventing a complex inode lifetime management scheme
> as XFS has invented to solve these issues. Here's what I think we could d=
o:
>
> 1) Filesystems will be required to mark inodes that have non-trivial
> cleanup work to do on reclaim with an inode flag I_RECLAIM_HARD (or
> whatever :)). Usually I expect this to happen on first inode modification
> or so. This will require some per-fs work but it shouldn't be that
> difficult and filesystems can be adapted one-by-one as they decide to
> address these warnings from reclaim.
>
> 2) Inodes without I_RECLAIM_HARD will be reclaimed as usual directly from
> kswapd / direct reclaim. I'm keeping this variant of inode reclaim for
> performance reasons. I expect this to be a significant portion of inodes
> on average and in particular for some workloads which scan a lot of inode=
s
> (find through the whole fs or similar) the efficiency of inode reclaim is
> one of the determining factors for their performance.
>
> 3) Inodes with I_RECLAIM_HARD will be moved by the shrinker to a separate
> per-sb list s_hard_reclaim_inodes and we'll queue work (per-sb work struc=
t)
> to process them.
>
> 4) The work will walk s_hard_reclaim_inodes list and call evict() for eac=
h
> inode, doing the hard work.
>
> This way, kswapd / direct reclaim doesn't wait for hard to reclaim inodes
> and they can work on freeing memory needed for freeing of hard to reclaim
> inodes. So warnings about GFP_NOFAIL allocations aren't only papered over=
,
> they should really be addressed.
>
> One possible concern is that s_hard_reclaim_inodes list could grow out of
> control for some workloads (in particular because there could be multiple
> CPUs generating hard to reclaim inodes while the cleanup would be
> single-threaded). This could be addressed by tracking number of inodes in
> that list and if it grows over some limit, we could start throttling
> processes when setting I_RECLAIM_HARD inode flag.
>
> There's also a simpler approach to this problem but with more radical
> changes to behavior. For example getting rid of inode LRU completely -
> inodes without dentries referencing them anymore should be rare and it
> isn't very useful to cache them. So we can always drop inodes on last
> iput() (as we currently do for example for unlinked inodes). But I have a
> nagging feeling that somebody is depending on inode LRU somewhere - I'd
> like poll the collective knowledge of what could possibly go wrong here :=
)
>
> In the session I'd like to discuss if people see some problems with these
> approaches, what they'd prefer etc.

Hi Jan,

Is this expected to be a FS+MM session or only FS+Matthew?

Boris,

Is this related to the Direct Reclaim Scalability topic you wanted to discu=
ss?
We are still waiting for posting on this topic.

Thanks,
Amir.
