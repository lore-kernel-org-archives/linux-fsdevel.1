Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C53B0AE6
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898983; cv=pass; b=kDmsqauueBMS3o/r2yjtdapgvk8cVC+X5Osvs0ULMF5exL9TA7za9KMyMF9MVmRl+SAlkP0QJscbr0jy1fYIJhZRQC8cqjrQSCdYU+hPPW7gvEQAOMnfDjHn9D0a3+5JrkHF9mV8vRY59CrFgAL/ZiW+W4PDQQDN6BRTOJBWFsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898983; c=relaxed/simple;
	bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0MZdZbB07ubEQOVFVmTH++Tkt6xYTpDrCpCrYfjCSo7yoc0QGBHsmeE3mzO5uYHso+nmsbIVyfp/PRB/bHcx2dSpi/+IOWXy3uU/hFLIt0TIhDLItBV443e02nLRlL+rq7Cpr7m41syECOa+dXau8DYAk2oZ0UphcSExZcqIUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IcPkLzE/; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcPkLzE/"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca07so1895ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 13:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788898979; cv=none;
        d=google.com; s=arc-20260327;
        b=O/ONuwUJxUY8p0HYtO1n1JTJgbVs4FOuPeL97k/PyjZ8ZNHMSW4s+vF16ldJquHFhv
         iVYqBu9yGyqMuCMxd8smak0FOlOn0iSQuSB0WgUGrsJJkNXelzXuq5PPLHiiPf/mzyQV
         BXdDq7EUJVG0tOha5eKHbXIDFhQjqDe/4nQNuUuavkeyGC9vufA/+yf4/oBrlODHPkVR
         /ERHzBGl+OZld/vOVj56wImjAWv21c2KlOaevxrWBFe1nmf7d1d2arcz1B1hNKfdK9GF
         +RC9sXki6hrgpW1sf3FS8tcUvHdoNwLJCfFpBE/OEtrtFbtupE1NyztNnBR4QVXltswG
         u2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        fh=Mg59VheZGhrBpJeRjEO7JIJVjdTZTG58dVzkNe9Dda0=;
        b=SjmSD1ig4Me6LsV3iFSvE/DPC0UQtsGS6wv1AuEvWKH/MYs50OcEtj2yzowr9mBmX2
         KtY9ZgmPNWf4S1MB7WcbBbmAHOqfcPcv5jkTIQ/O4mQaW7+x9Aubum7FSfCT753gPX59
         hozQvk7JZCUd9QBlGAmbNk1zD0EvReYIwMqIa38S4pVbiYWNy/MD69aENH1itl6TBvx1
         p6A91svbfGMZekfnf6MlwuIx29+HbtT6uYAQ1n28nxzX9Uged8ugB1IlohaGDwnhrJ8l
         /ql6fECt+IhXDe3svh47DUiEasTYC+SuHXD7F/SGunSu3C2JNFSshGcQhsQXetJAtxP6
         8cnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788898979; x=1789503779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        b=IcPkLzE/GWJgGQFgFjq3/BPu5Aholp3UD6OdBhJ355j7ahhQeEmYsZPEkfMh2aEMl5
         kHUyWUF+7Gsx3qUraZvXNlJnLnJQiF0g9Ms56lLpww/Qy1lXVKnPHtG77r2emwHYzjgR
         29ats7zhEVuqr/LN+0lRI5mQ7VWdrJWjQgAlCiR2iAQR35K53EjDk/rXhFfh40uzR4Jy
         RRI+QZWDqRc4KQgY+OCWmcvnTOnP8NhhpvoTwWYJ2q5xpq67mWPEnUw4qNJN1Bm0SzLi
         Qv7BYZ4pLiZwDkSBChbQ8ajWrWqXo9sO0KR94zXOkfUC2TZVByd27wmQIX6YkWcdIFtv
         GfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788898979; x=1789503779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        b=MTx0PQdhXh/q/ycb1QOdqjMS0S3duE1FCFOSO7IymhZeBzM783GFytqtFIxCehgYMg
         iwc5+4WPqKDxE8AQ1NTFBVdzCSjpmnSZQgxrNN7oI/vsRqHLWrBr4td9IyXrYSoZmZtW
         SisUPAcMeODMK2kemLDXjUjGuSF9QD7zm9XXCTxIRTQ1os/6HQGjszf9kg/ukwYg7D+H
         ljXSZZnu5hUkjELQgThNNI4RuOk2frb/nUYeyH+VggGqST2LblSfekdsYfuSH3HWQ43C
         3BxLBk49CYConq6OxY5Ct6eBBGJLXQn1BA2Jjt3Dnf4iVgVHcj3JyuJF/jyrj2dhFO3e
         6yXA==
X-Forwarded-Encrypted: i=1; AKwUvBxlIfl0+szXYg5wYixQyyD4/AX2VqoAlruCiHQ75BbOkKxy4dnUMxBxe2Cz2bN+hru2+BGCs+6rEHD6ZqVO@vger.kernel.org
X-Gm-Message-State: AFuF++kLEa2ToEEOtiDZ8F2gmVa6Y8XHvmQKzFseiybLRw87e5scrWDX
	R8Sq4LGFLLmRuZt3izDT1GFRDTOtpTxsu35bDpDXAlyxm07lHsbfh8xT5OUgXMoDd5MJfLXNzVn
	B1F9Wy+PeG1C30MqUiB45nBnmfg1PGWwPD7UA5Opb
X-Gm-Gg: AYBFou0TdPWPCBO4IZlMGrhwheV1lchbs4SKs5DTRnyoBZOf2Lhme7WQj8OpcgDZI9u
	VVSmnFefFgfQPBBF1n2PDQHolarZCoj5dr6qXMVfHWDNZIn0w5q6PapRwroqwRAPf6FFVbsAix0
	SPXOq+ZwO4mWnFb8Mxyck9pTh7YdYJA+CQKKa09ck57bbhEk4Q0QZh3wkFXRQXH+gjUyDQNi7Y/
	p/nyOJRK0MHCrMwHiKHQCQKbf2cBXNNI3cnJL98Ik44+OkRQzlq+N6PD44ohniwyJZXjtBI8D6+
	ItS18etstaHJI2/YrS1VjVODmyYq2k6L44h0C2J9BvQ+4oi6hLSXHAgEKh7xl0sTqawIxu6zPdo
	9LN7u3aYFNBGLp+HZ+pI4ThmfS2v18k+L
X-Received: by 2002:a17:903:fa4:b0:2d1:1d3d:97c3 with SMTP id
 d9443c01a7336-2dbfeccdf9bmr1436185ad.13.1788898978067; Tue, 08 Sep 2026
 13:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 8 Sep 2026 22:22:20 +0200
X-Gm-Features: AcwNN1W16jAho4HwK_fzY15wUA-qa4DGJ92-DrEx1Ojg_VFhiHj2JxDdZTxOKSI
Message-ID: <CAG48ez3Ucb8HyhjC1-fijFiYJsnWcTLYHvJjzMyU710mgegxnA@mail.gmail.com>
Subject: Re: [PATCH 11/39] selinux: reject writable opens of policy file, drop
 mmap shared/write check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
	linux-sound@vger.kernel.org, bpf@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 10:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> The policy file has no write method and is exposed read-only (S_IRUGO in
> selinux_files[]), yet sel_open_policy() performs no open mode check, so a
> CAP_DAC_OVERRIDE caller can open it O_RDWR. Reject FMODE_WRITE at open, a=
s
> kernfs does.
>
> The file can then never be mapped with FMODE_WRITE, so do_mmap() always
> clears VM_MAYWRITE and VM_SHARED for MAP_SHARED mappings and the VM_SHARE=
D
> check in sel_mmap_policy() cannot be reached. Remove it.

You should also be able to remove the sel_mmap_policy_ops.page_mkwrite
handler, which is only for shared-writable faults, right?

> This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping that =
is
> neither a PFN map nor a mixed map, ahead of the core enforcing that only
> such mappings may do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
