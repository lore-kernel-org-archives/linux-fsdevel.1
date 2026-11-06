Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793928167;
	b=nT1fQ+t2c4wWhOzw+NWs4GHfAE1FAfBkr68DGcmVnLhwEbm6XZi8evQ5gKKqXuGEeJ5D
	 p/SrWGK5zNUak7pUQv9ZQLGhwIRt7p+hZgIE/lOapkzPj95I2FGkdoEK55sDK0xjszY1g
	 NzlNtrZzSDgZ7GCzxmLpybLtxCp9xEXFzYROoi6VJg9MNcGM2cOgL4Zayb0xkkLZir150
	 RllHkLf4zCYBmXZDClkE89y1Qw3y8vbtG3XAI21yhixuFhmyPDz639/GE3NB6uX9/UFQZ
	 E9DNGE1MyUCDjKjo6itooJINzHVL9/EdbQEaPiR6T6+3V7XjWAcB+mw1fHqPmg3qbog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
	b=zTU+wiYBhc2mULPCLRiuF/XYkc2kdse5SXpwkfgDTnIsQdqK03tjcxKOyoXhqKnOYNg0
	 jGkXQRbegJiQx2l/QkyM4o44LV1uwaVZTckcC0+Q5g9GHjk6Zu7/Wt7Xb0k/aWM7xKVu4
	 rst245bsF1SmQTxeTzqvvj/oAetaG40A7l46+5epvWqpUcg7jBhL8D6dQxIWScrWPOu3J
	 8gg0eJ37/FoscDmRd+nvkib8y4PIzb1erE6KTmQXHIugQIsK9B3kD5hcokVZ0b06Xp3jn
	 ExXizbMWqc41qbCBUOKxcELUpzu8AEBc3Cxt48tg9eD2mou3YjkMenj2srCeBgrdrSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BXgsLCA5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB0E606A328
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 01:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CB0E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BXgsLCA5
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a070755c8cso32044b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 17:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793928166; cv=none;
        d=google.com; s=arc-20260327;
        b=aLGv595KExJs9tCH9q6b62nXe5KJF8vioGh7HaKh+bRwazYJpxMZBLdisY4ngJYLB0
         bmGUULIfSy7XGTMGn1OnbaRNMhTNSVgUyqlnwW2WtPN9KKKXlWkDpp7JMmEIgBVwyoX9
         AdNPJkBVn0wGZ7mXIvyyGc7MsGGi3dJppxDXNDkUsNe7itIXLHb1fU7YaCSdMHnHa1fx
         9Q2CZlWAdI8HEbG7T9O8DchoucMIgdb5YOHFf0ilqDJHRkO0nkqzMDrz0IFLprS7ERO3
         iJ0v/Wv37edd73Bt2/eu6qDRItbznpJCa+dk5zbq0xEbhDRx9scQa9V81QEkbCM2pifc
         FGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        fh=RV9HkUTmdvXDYVUlV+lcRNVH2EgE9aU+bYujs0u9GTY=;
        b=BKIysX0iBEYaUZqZAj5SSW9kn7K/G3AaTm1pDBuLThDJ2zO49VVAsoIeB5hkftWB88
         HKHY4SSlCRZ1rWIWFUbUCBOkOOdel78uOpnaZRkoHXg/ENz6jjtu3HptSgcTFD+zWLmM
         R0FZ7w/iHdW9VNcnY5BG3v8YY8AlcnF2dnEA6YcnnP+zjApVLB6J5LVRmnScDgjAO50O
         U0vmOl39x7Kx/JxyBgriWWnjXfiOLywtaIOVVJjjMxWirosytca+0uof7+Px6xvNYYg8
         ES5tJKmSE5hH8bKdhtMR4Lt/D7XRWh3AlOgYoyJDHUAL77xYDinF2y6BXIk418pbye1m
         N5DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793928166; x=1794532966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=BXgsLCA51X5/W48GvZrpBezpY+stGa03fvEbUi2MV56MnNmF4a2PjDTUVnBg0Dwtqe
         Pc0pFbbkVSP0pF2lMOwQEWZuhIoVpWFLaZww3T/CDXUanEMozEFBbg5xukYGZHM3dK7Z
         /fQ7M+BmNkKN//ilq5bRiwTE5y+M3XE5NT96+Mb4FuQk23KwrKKCtl+UAKDpUXGzEGJV
         USSryhSewq0S2ePnFYtulTY16RPJSyBaU+5La6UtGtX/D/3Czi9oUOP9+hhoTJe/0ETl
         gYSYGkR59nTYA3bP+5Nf3SMG0P++deg+hHNjH+z7C7raNaTFT7WIIduRah7XGk96iqIB
         wcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793928166; x=1794532966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=X+UxMU5spAyXEWj5485FUriKhnOPkn28Sxys+xaWixQq365ZljkEkAAbyvVfPy+qM2
         1MvOJjbSgCHHZGkPvrE+GITXV845BA9a8JQSYAq5BfT4IZLr4jx3V4ltoCzcfIUwOxZL
         O6VqmQeCOBhlXX1mOguh8ReHzBsblDCNomsWl2dfnbAClKKJ7ZtnoZIlUs2PKP+pS4px
         btof0e5NAQlr5p5lK0DEvqZp8EtS4OH3cvGp5RIhcpUFPn2f2a0KRWVObFVxGvUW0+te
         pCM++sLPDEe73V7BEMICtiQvCUsj5Is0mpcVoXseGFpw6zlsCeHP9Fa1QqHvjy/ux083
         uBfA==
X-Forwarded-Encrypted: i=1; AKwUvBzIN186UBBw8aozoacIxejGV9pAZZqPlb5GnWCOun/24TvEhdMv1ogHEgZIwwhUuCurrzRGHuGsofsYyDCg@vger.kernel.org
X-Gm-Message-State: APuU4Z8Hda5NHAW4Kj0gjfSRL5b1egq92S3wfDSuQXg9NHqbv7Mg9DTz
	W+LnjO7JivV2aOkO0p3h70ao/xvTMC9gIyaTacB7UVuK0jROQ+omlhG0b3tIKbKSsxBn4zvR4Y8
	Zywjfhw+6v5j3KyEI3wSD+vztVvncxsHBTT7uHXr/
X-Gm-Gg: AYBFou2A78VWk2boUpPUn4RM83pvwo9otdUMmaXynY/osYCDgSBzb0Ic45Kpm3gEmoo
	QSFbSXlonzZv380Ho02RSweRouy6G8HttQJDlmxliA/MdFEQhqY/040EN+nocvLDvfVfnnkS+4i
	FQ99hNpZFSlidOlFE4ppSs3uK5wFIveT1LESpyqNqJOttWR2vDFlJgDXfOnH4mVJOx0soJRa1HF
	p8WmhZMDgzCwljz0X96x6WQlE9SSZG8V+C2wSLYtzopx4Zcnn9ZZnVcC1fdmAGfXK6eB2LRS/J0
	Kpno6UYBXI6T68XL9rKuzBVXvxUKkF4BxvXSD5Am1NalvbNVcIZEwjEAU00XpKnDH4uhFva4OUq
	GxV7eT543AR5P2Nnd4VT594bU2EDm7PK4WSrnbEcoN9SB4iSbF7CH2HjtTDbWakXfecOe
X-Received: by 2002:a05:6a00:4f82:b0:87d:e8a0:2389 with SMTP id
 d2e1a72fcca58-8b37b37d233mr903874b3a.21.1793928166471; Thu, 05 Nov 2026
 17:22:46 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org> <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 20:22:34 -0500
X-Gm-Features: AclHuK_C6UmASiuiBuBvumlcrlzJEUCTa0-vZyEfxhlZIjAFaCskKj-ONE1360g
Message-ID: <CAHC9VhRDVz4M-m_4UZZDKMgs4uc+j-+-jwYEdBDfSD0rtd-1Og@mail.gmail.com>
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
> >
> > Replace use of the legacy vm_flags_t flags with vma_flags_t values in t=
he
> > mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  security/apparmor/lsm.c           |  2 +-
> >  security/integrity/ima/ima_main.c |  2 +-
> >  security/ipe/hooks.c              |  2 +-
> >  security/selinux/hooks.c          | 14 +++++++-------
> >  4 files changed, 10 insertions(+), 10 deletions(-)
>
> Similar to the other patchset you just posted, is there any reason why
> individual subsystem maintainers can't pick these patches up, or is
> there some reason I'm missing and they need to go through a single
> tree?
>
> If they can go through multiple trees, can you split this patch up?
> AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
> different groups/people.

Since there seems to be a desire to bypass normal procedure in favor
of speed (surely that will never backfire), the SELinux changes look
fine to me, but please do wait to hear from the AppArmor, IMA, and IPE
maintainers before merging this patch.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
