Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84C3932EF
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787519663; cv=none; b=Ur0Pwjy2gRmXFtDdKeQO0IhqM1lA8TqXJZ8lKOOHCXgwnJsrD9aU63eLybs5ygo+4oyxKjYx992y3GZvAFOjNxlgbUOxqbbYlcTVga75zVbQAz3B28fK+qsMsxZZc6PSTB0UhSqeUcjgXuL8Ak6p8mCd1cxURFciDxuOqrlMm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787519663; c=relaxed/simple;
	bh=5aIk5hjqNt5oNCOWt6NWdUPn77WlZIYMgpDkKjeT4gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlX/Jy/KhQopm4f1DMLr+IumRTgs8TbICPWblrb3jEHqKEsxum0Pu1jsqsfR69H2u04Zwe5uPY/C2HmGnXzJSXWVYoB+nGTm7Z/adT4jpUVkmrIUKGF1bqVSjQ3SLgVSblAZS1AOEOuEI+cqdUXkRzbr10eBblQcOZD6bKZw7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rhj8IXPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rhj8IXPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19121F01569
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787519662;
	bh=5aIk5hjqNt5oNCOWt6NWdUPn77WlZIYMgpDkKjeT4gI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Rhj8IXPa8+Foj6h4ON2DpulSKlWKVqUoCZ0tUxVdjkGMS6mDg62lftZBZsInlJdiY
	 9GpDcXsON4jAhZZ4UVxL0wFXACUuPm/gwI68BirTUDvAMlIkRrVZyk+5cvZRRbiXOj
	 mIMsP0r+NQ000h0QPDX0BlQLFJzRlaVf7DjRJcLayjputbhR+RqVLoXIA9cv3UeY6T
	 g+7X16+0DrTTjEBsO2HzSzyEX6cN5E+PoKo+V4ZVRro0mQTcU+LVyeyHH2bvHkAs89
	 6EyhV7sl/DZ/aqY81LkD1Rtdna0ZiI6SiNEZDZrVJ3Z/8iludEorqg9pW2Qb1bz9gR
	 MY6ogG7MytaIQ==
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so18565166d6.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 14:14:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrfMecJj5f4qWdLNa6RdIqI6+qBq+5ZbzHzuXntOazi+xkKzizdtslnFGe6ZTLBLVi79SMesJuaXGWfQ6hw@vger.kernel.org
X-Gm-Message-State: AFuF++kiC2dRWhODvvrvdKJRLvaaKWubhp/B5oqUv3dvZ4E5Mv+St2Nd
	Ocze7EIw6T1d6W8UeEIrqnZa84jUFFv3epHt7vyvKHfU0xABLG356i8v3upC4jQdeSjj+PWEva1
	uIBGJyj7lj5TfB5PPXEuAb/kHb4xswr8=
X-Received: by 2002:a05:6214:318d:b0:90a:807d:3668 with SMTP id
 6a1803df08f44-90c8f941e02mr144419456d6.7.1787519661887; Sun, 23 Aug 2026
 14:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org> <20260823-uffd-vm-flags-v1-v1-3-3086981b33cf@kernel.org>
In-Reply-To: <20260823-uffd-vm-flags-v1-v1-3-3086981b33cf@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Mon, 24 Aug 2026 05:14:10 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4w643aN5OY5RqSwPy5V=ost8fGyaODGyGQj4c_Q+LYO+A@mail.gmail.com>
X-Gm-Features: AcwNN1VurWkGDFr7vGNUR0UHyLbUPFfOak-4q4LksN87tuQ5GQ8kLbP5vUnF-Ks
Message-ID: <CAGsJ_4w643aN5OY5RqSwPy5V=ost8fGyaODGyGQj4c_Q+LYO+A@mail.gmail.com>
Subject: Re: [PATCH 3/6] userfaultfd: use userfaultfd_*() helpers instead of
 open coded flag tests
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>, 
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Lance Yang <lance.yang@linux.dev>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 8:18=E2=80=AFPM Mike Rapoport (Microsoft)
<rppt@kernel.org> wrote:
>
> Move userfaultfd_{missing,wp,minor,rwp}() and userfaultfd_protected()
> ahead of uffd_disable_huge_pmd_share() and uffd_disable_fault_around()
> and make the latter two use the helpers rather than open coded VMA flag
> masks.
>
> Convert open coded VMA flag test in mfill_get_vma() to userfaultfd_wp()
> as well.
>
> With every user of the per-VMA uffd modes going through the helpers,
> their underlying representation can be changed in the next step.
>
> No functional change.
>
> Assisted-by: copilot:claude-opus-5
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>
