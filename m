Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCE3EB100
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477191; cv=pass; b=UGqsd+3Lr4vb+X24CxC21EL0lhfx/VUtwMRCbnBGW1ASUjBolXZeQ43Y23UZeWPcfCUGJFIQLN1lpGEg3T6ggX3hSIOzrrST2wpmV205+UMcWOQj4pEYQurdkAOED/M9qF52PFxcCyVd9Pf/pABU0SoYiRdYeUnlm6TgkpXelAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477191; c=relaxed/simple;
	bh=4UuIwl6rqjNT2GK6MHDUeAAQX29Svi83Q77R51FpwQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRohAtl7AsqqoJDtIQGPBOEvmpL+AVapNJ+fj4vyAnu6U6BnzlEpTecDmeP7vsikvEr7pl3T2PZvSQYJ4NGXiyeaek3HXlPlQY7ruu6dGZMNPlHiqYgnj9ADEtaFkjVQhpafbYVP88JwzqeT2Prs6nV4y3KF7A8kziHkRAXFn3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4IQV6NL; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4IQV6NL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cede6375caso3275ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 12:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786477189; cv=none;
        d=google.com; s=arc-20260327;
        b=R0LdwacLpUdF4HaJOytQcBO6qR46CHwyA+QM0znh8Hcj/hrewLWod8e0MzSGM7cbfJ
         dloOW5iFqRTq4F8CTi27st4c1mplr+qUWQKpS3VN+3pGu1QWv5qfmZQYv5yLEGSqTg2b
         IsViHdQUlYYZGELPelMsqGvh6vTKgR4VIMyMsGeeZwNGm7M2+dyT3ohDnPhgWpSio1cW
         mdtZAQzBFqNNCaAeeTvAwCfwAVL70M8KPRuaFjTJVurgglCJ/q4Au5/Jgrgb5eVNcPTR
         hZw9drxEyxcNVLNM8a+DTWUiH42ttmysSE+qtCdnI3uwa576lllesam/f4TVKJM0LLDd
         ozww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4UuIwl6rqjNT2GK6MHDUeAAQX29Svi83Q77R51FpwQc=;
        fh=b+zvk/l8uCxhpfOlRmfpSvrfU4Qa+SQfQEKVrqpIUIc=;
        b=jLw5/5Pw4giuYZ7dgIBZaxe4qlEjY+aZ6bcfG2nHs5XcVH5BztG3Q9wRyi+hbfhMLt
         GMaxVwPHIvVXQppmBojLlfmRmeYBrcMoqabzR2W61ddP336OhA/hnGgtyViVyM03SOmN
         WlfqyCAoc7PgI3miFWWCn3iSLg981ePYTCw90n3uU7L6FxSK9ZW/c/WOdO3a+KLc8msX
         aHXZ6dD69SKnegoXmB391U8KfmaV32Rcs3j5GoP1qrNyQ7gvajUaRAEYWYAz17n3y0eV
         ojSOQMcsM8OPWNoH33a2FLGQFJLi9IiU6+/snoue8JDzU6zw6QQDtHxftX0hAXYDN9RL
         IQfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786477189; x=1787081989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4UuIwl6rqjNT2GK6MHDUeAAQX29Svi83Q77R51FpwQc=;
        b=K4IQV6NL4pt8Zv7Fm3LFD71UHJcsxBoRBTgNZH4KWHOhUEqtKDqOHufV5hQcdK4FA7
         1b2h9mVVDmz4ue12polGkYzvn6bWKjOuSoCm8k6ufQNIvxSh3f3Pm7bbHtL8NdorGeYV
         kEb2YvhG/5Hif7PUGHDzjKgVt4dIUKfBM7dv1pSwiTdORIUicP+5GKpxxB0DxQbsJUCZ
         uuP+l+M/GAtNtISneHchNWdZiQRJ0WP/j0Px+92gnO8urjqeH94GoFJh6Wxec5MBq646
         iRK4OaLQJkIg4O3wXnyYPX0xp+sEq8UWV3L6GcriuxgEYwlAzj1k5B4Hp8cQ8Q7unzZc
         vPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786477189; x=1787081989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UuIwl6rqjNT2GK6MHDUeAAQX29Svi83Q77R51FpwQc=;
        b=lj0RoYdUlEpkqlTB9j5MlvVYaI7kfBebw3YvGCv5/yNiNC/mAKdPIH7qcgLSscPC6B
         +bxMaBvqthCcaX5gMFWH3OT8XpIQGAo++7NK/khsADnCjGt5iW0k/tCudr7/QIUdTqdf
         IDezVMRce1OUAVXSbCACPhZuxjqKlRo/99gENxMOwdZy45/1CtmFXvKyuQtVYH/BOXcH
         3ChaNzr+6LrCC5VJ1OvdhJwZuTF2n5J9Rd0ZOB97l/T+rxQycOMzajGl/8QnIm9Acute
         lQxNu3P02HuwRpu3vFEt8L5gRsKIbT17dOHd3KMRosQYNHDmuNDsx/+AT8mWdFheGB/m
         gT9g==
X-Forwarded-Encrypted: i=1; AHgh+RqzhGHWKyfGkgDelQQRJH7yEKHcfFeJQheLmUwu3LYZ/pB0RYJf962CuCv8ViG7cT0E1MRxIObfNePgqGdE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo89c8PF92XYSDh5uX0drs1LjMzX05qcWB6KztJm5KzpN7C+8u
	0AX+0E4TCd2RgJbiUw4M/6yJi0i5gbp6flG2V1iWA29N/ok1WFFDM6A0ia0jBwoCNnU0Bsas2Nq
	ZOlIA3YCRyfT+YVNfa27/NtjBdn/MVOOHKh9BSTVW
X-Gm-Gg: AR+sD13hIh7Nspzzb71ZT6gx93uoxFwMoblKGcTccOpuh/9Gk0F6FDZD50x2JTLED4a
	MIDGrvhY4b+aGrOCKK8q90nHLwOdW5e6uyKx3Rz970GnXQqyMPEu5XUSmTjO+E5LVN+2qRajhjS
	bnR7GqYBfaIerF0rBQs+TM+CGeZTvRV5Rrw31NaK5FkFSt838G/Kh3tOqreBSeDa+iEeWzvoxLF
	UCQJIR79Q9yIFnABtyQvKdr74K2xGcPNokEI9MF5v0D4Mh6HH46xfZBwBu3FCTFipkeU4Plh1FI
	Eijei2J+Dg6x5gw8BlNoaIUo80eX0R0djRaOdVt1aaR5tuerJ/n2uP8D7WIJRu7HS91bC7ZJE89
	IZQvlOQNQLzOCvnEOH907ywaFICtbK7M=
X-Received: by 2002:a17:903:3e24:b0:2d0:1aaf:daec with SMTP id
 d9443c01a7336-2d33a9bb8b9mr1376625ad.9.1786477188642; Tue, 11 Aug 2026
 12:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org> <CAG48ez3QwUopEyfB0tEc84A57g3GZdnptazJW+htiTi2e0Gc=A@mail.gmail.com>
In-Reply-To: <CAG48ez3QwUopEyfB0tEc84A57g3GZdnptazJW+htiTi2e0Gc=A@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 11 Aug 2026 21:39:12 +0200
X-Gm-Features: AUfX_myNWbh_52Kb4nyJ3nHpbMubkiK4TzA6UuwI2EkOKm05z8EIDPP_R-GhG1w
Message-ID: <CAG48ez0Ty5GTR_vYazWsWOigWP2=8SYstw13zaiJB3auBi1bcw@mail.gmail.com>
Subject: Re: [PATCH 00/11] coredump: allow to create sparse coredumps on the
 coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Omar Sandoval <osandov@osandov.com>, Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:07=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Tue, Aug 11, 2026 at 5:27=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> > A server that raises COREDUMP_HEADER in coredump_ack->mask doesn't get
> > the coredump as a plain byte stream but as a sequence of frames. Each
> > one a struct coredump_frame_header followed by what it describes. A dat=
a
> > frame carries its bytes. If a server also raises COREDUMP_SPARSE, zero
> > frames are sent for unpopulated mappings. They only indicate how many
> > zero bytes need to be written and to not include data. Reassembling the
> > frames gives back the same coredump. A debugger and everything else
> > still see an ordinary core file and nothing outside the coredump server
> > has to learn anything.
>
> Hmm...
>
> I think what you're doing is probably the easiest way to do this in
> practice. I guess some design alternatives would be:
>
> 1. (overengineered, not generically useful enough): If the transport
> was a pipe (which already has the concept of different types of pipe
> buffers) instead of a unix domain socket, we could introduce a special
> representation for zero-filled pipe buffers and some API for receiving
> zeroed holes through lseek(pipefd, 0, SEEK_DATA), but that's probably
> not sufficiently useful for stuff other than core dumping to be worth
> the effort.
> 2. (somewhat overengineered) With some refactoring, we could maybe do
> something like /proc/kcore and create a seekable virtual coredump file
> that we send over the socket via SCM_RIGHTS?
> 3. We could leave the userspace memory dump out of the core dump data,
> and let userspace take care of filling out the memory contents using
> /proc/$pid/pagemap and /proc/$pid/mem? That would also avoid task
> switches and SKB allocations, and probably reduce the number of data
> copies involved in this by 1.

I also wonder what userspace actually does with this data - does
userspace just want to write it to disk, potentially after compressing
it? Or does userspace actually do some fancy parsing of the data
stream to extract stack memory or something like that? Or does
userspace buffer the whole thing into RAM and then process it from
there (it kinda looks like systemd tries to do that but I might be
reading this wrong)?

Anyway, I've looked through your code and it does look fine to me.
