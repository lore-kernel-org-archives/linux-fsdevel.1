Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6505237BB
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763502; cv=pass; b=nz0qDOI56nIlU3Ual88PrUFGmjpWhbSNwnUIkVkQJT9QsBaKEiS+bI0rcHML0TIVvOLYUVnJr8+2qYAw3BfPZI+oZiVq3lYPufiLPpOpYfebjeyBLG33+F46taja1ak8ZvZLmzHL5iVc6RfKkdWmYc4Www4jHbHg+gUqDWWYTAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763502; c=relaxed/simple;
	bh=B8p7ihCHzGvnzup/C6y6XYLlWrQRIq7YUbOlQS6xj3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRJP6ASIyaGwJt7u9mOUfiW81lYtsCE6GVaJEH1Ez2rvm2R1B/n67XfcHNLKdWSybiWJf0riyzcWUk406/xEwUAUKNfVjhXFhrt7Iufexc80JoawY20Z74mj1Do5Qlofb/DJZzx9vab+PUsv1y/4JDZBHC2wLejlOvpzAS5RYKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UU0wjojH; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UU0wjojH"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53113d72966so9251cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 13:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789763498; cv=none;
        d=google.com; s=arc-20260327;
        b=ZlX/JIzZxensRDmRNHfnk+/ODP1oxyrAbu1WFr2TGKgIbv0rJKl8ofNzeQjruLDTCc
         Sn748WR9fjUpF/lvh0xZsRqfitq6AFXXpSFe1B9V9fw+aQ0YT+ByQSKBWcK03Wyun8VM
         NTnUTX/Sktb03S3WdW/A1tHN+XDRfohqBvJtAW4eAdVS52BDRRcT4YArEaRL1Id3GS7U
         ANJ028BpdfTDJpFaxZR5G0oXWvB0IJXHqhQU9kiH0XNg58YDiro4Me1xuMhlZz6wSYDy
         fkhfBnyB153VXAoDUni+qzyS+hHFfhLdK+enFtQ78Q1y+pPiE940POfrvj7J2Z2iAu8W
         peAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rakr0DVeS6w19WPN+xiAqZEbcFGWWdpHaQBH8HXSGgc=;
        fh=vIgjpq98sxWHjd9YeDIr3ETeMr9JMwC1ORuaht3wrpo=;
        b=q8x6apaB0xhI2+nn8taeU02O3vC7IGeiA+rb/pu4fdOqSGPFau3tsRAk5IUNXCPVqe
         WpG3bauMwDs7an9JQTmVea09A0fp8xPq8pdTIn6eFuycuwcA7KtOv7T4mZ3JnuMUo+lg
         sd4wRo2D6iIn23GBR1CSeGwJ3yg9Yav3RjGcShVpnOpla/tqmC+ezGQQQLdT3lWrtBpz
         H45siv4zn+Dx5Ctg+u8fOR+J3MATM5Jlm3r/ahx/+rXcyVncvw0UyTQ5YdRvgZl16NjE
         y1yD0tSc8XnEfJ25p/y6Qe03FzgdBcfF/HTmR/Ka8UNllWUO0TB9qgB0EijqPXdbrqGL
         wX2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789763498; x=1790368298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rakr0DVeS6w19WPN+xiAqZEbcFGWWdpHaQBH8HXSGgc=;
        b=UU0wjojHMZJdEefbV+oe7n3/1SeoG/dOO8hNK7Tj8QvphQy34bQ/TtZfJPFMbLM7Dz
         Y/YVWKsh9GRn1f4QL5Y0tAv574p+Z233A80/H7Il2x+C3qiCdyydEpXhoIeUomNkSzt1
         u26uedB4a+lTAzO3+lsk9SL/2xRHXFuNtkCjCNLqhT5/eS3sAp8P6KWPemR4yNW03+/t
         Y8eKGMCmYLtIa9slPbZ5/d3cujTWZUj7oR6ZaFLAEvvN8VjRm9Zsvsy20ZCKhB4uDz4q
         NgoOUOU2qI60k2fnz6n/kBaIH6Wtw6G2RqENciuFm00/6+5swPRTI5zkRENNInuJF/fH
         XfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789763498; x=1790368298;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rakr0DVeS6w19WPN+xiAqZEbcFGWWdpHaQBH8HXSGgc=;
        b=c21X/4kQl/w5QbAQCph9ToWHz9dFkCIEKtZU2DDuYIiA3Ck50beFsvZS9ZnkBKZDgP
         UtTObd4MixcDDYgS6kJYCDXjbabdvVLvLIAKK+Vc8noiutD5bmValuBjAMSC7pc6hiAA
         1vMDD0dz/qSoq/ehy6D1yMT4tYdTP6WaBE8VuQNmibsztrF2PDcnmsLPLTOL8u+5ZWv5
         DCTGCgD0q9AHfvih+4Sx6whKsdhusdVIejuK2NOdp5bLLeU2Htj8VBibnWHLdLXnupu1
         L/e8kreUDuTqa3X+7214hG7Jz9FXqArIla/Mtsc4OXQk7C4Iu44E+WpVc8OHD2y7PxZU
         3BKg==
X-Forwarded-Encrypted: i=1; AKwUvBytkSh+5hL+QuUlUGlAECZ4AlxY/+VMYKuF+/w3lkfNvdamzliovFIHWxoNkidqigukFnvRTp9qjiJtGPqY@vger.kernel.org
X-Gm-Message-State: AFuF++ndMqTgYFjkf4/gHkEvrbGcAWD+KwfrXJZgVIrz+Cotr7SlaNrd
	1V/aeJ1yhvv3uzal0M4SMd4HbUDITvCUxDGbTI+cxixbYSU4Yq8X8OdUwjxJu3Ne7UMhpvomW0O
	eVwRbclQZ8efx2pJUankapPQ6Z5y0AZiA9aSPn032
X-Gm-Gg: AYBFou0q846PZd/1GZu9JbIbI1s+LSjuBh9vanynKaPI+d+sRVZj2BM+cjboxY3m6OH
	7BVv3YbuojpidoonrNit10GjhQD/pSfAUL5L2+4jiX6/3yIkj0F9QOxtw7XX/v8CseH/iE+QwJk
	QaGr6w+x7C0q914tz0dStt6e9YZElYpw8BqHo2GcxREi0Rmt7pfclxg1F7j9oIXVVhzpHrI5+7w
	40bSkUNPYvNNdByliF2nmFM/CqdRG8STW+P5HKQ1dH6QJwElmarg9auPxVn+R7DhCpGofgaLgA1
	eUaPXZsC6THCkvkHEwF2NEd9m7OwS1WBMtEAecGOSI7BWTuzrrcT7w==
X-Received: by 2002:ac8:5d08:0:b0:530:2f98:cebb with SMTP id
 d75a77b69052e-532b099561dmr605641cf.11.1789763497212; Fri, 18 Sep 2026
 13:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914180811.057cba8fcc48d6e0b53a2683@linux-foundation.org> <0b064fe6-ddb3-4f26-a1f2-2e9dd88d590f@kernel.org>
In-Reply-To: <0b064fe6-ddb3-4f26-a1f2-2e9dd88d590f@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 18 Sep 2026 13:31:24 -0700
X-Gm-Features: AcwNN1VqLTR47MatnNlBWbpWA8EMmoQNGykspJvqoxdaovPnF0EYfRCWZF-8zh0
Message-ID: <CAJuCfpFBichJH4OcmSHTb1rOuQBT6k5pXeua9_KgpWjDBKvsYw@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] mm: make VMA flag semantics explicit, eliminate VM_SPECIAL
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 1:21=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/15/26 03:08, Andrew Morton wrote:
> > On Mon, 14 Sep 2026 15:57:20 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.=
org> wrote:
> >
> >> The VM_SPECIAL / VMA_SPECIAL_FLAGS mask conflates several unrelated
> >> properties:
> >>
> >> ...
> >>
> >> It's all rather a mess.
> >>
> >> This series brings some order to things by both limiting what drivers =
can
> >> do with VMA flags and switching to using predicates that describe
> >> behaviour, not arbitrary flags.
> >
> > That's a lot of patches.
> >
> > Review is thin and I expect this won't improve a lot.  Lots of "no
> > functional changes" changes.
>
> I'll expect to go through all of them. Might just take a bit ;)

ditto

>
> --
> Cheers,
>
> David
