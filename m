Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421220;
	b=Oor11ztvvtAzI4Y7Vq5HNliQl7uctUv7CCHzrcFWYlmUNokZhbDjswlZBnwXbOTPyrIl
	 /lMJ6J6tWl14f7dGhljxxdIpo/u3cCe99o8xAxuUUXe1fTjyEdV9nF6HFfPy5VXFasWhn
	 N7o2wbxAQ/VLTFjJyDpxEYMK7Z4USlzyyYCpxdG7jwUqL79tVD9/SMjR0Z6cPmXLZ+QlR
	 esbV/kr5UrhRneQT88QuoZBKlwL+QeeKl7N5f1u/Smd7tUA7tAKS5RkHYS3gphct6+tCm
	 8/XnpW0afnNIFDcaAdU4Ngh9TPPKow1ACfBuiVGCJqrZfGUR2qRunTOaiHrxz6OlaTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=GdWbto/GYuZDXyTvm+7T3nEGrjgUlN0uIoNMYNUd3jo=;
	b=pVpUUy+tr+/VA+CIo6q3/7vSo8sXolGlA4zlG8gc7w1pTHg+tEfT8i592NgjhkPjTrpB
	 ihBdpo7LgGJsUiMtofIaI6YsumLzbSfncG1Ny2BuoxIFSGrDkr0WeaWOzLG35JbGmeAHR
	 BtKybaj7j4bFnrD54eZl1tYmuXxwoAniHiTvufkQy5ELn8PwTC24rwej/xKAheLzz/EXa
	 AySEqZWLhMdKQ6m1b5wUo0Q65ZW2TU2P6jusjtcTRYUI2tCtZdv1DA99nBJ7SLE13dQfS
	 mSH7Pof6i8leW4fCyjSRvK9qxBhRmeebmG6nFX9hqjM46wHJCD6MIQmLBSlcxtE4GoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=UbEDloij;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C1607150F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 08:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D0C1607150F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=UbEDloij
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9496473b511so374273085a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 00:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795421218; x=1796026018; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GdWbto/GYuZDXyTvm+7T3nEGrjgUlN0uIoNMYNUd3jo=;
        b=UbEDloij11O9wu6jNn+7P7+RZvZz4DV6AR9vzS0fBzrCehXkVi8FOnGNXNLIlq3OFN
         rCOsnG3X3QGQiYNFwNBZQvVWlmIntqs5/WJfYWYXfHntN863rJIHHZTTX2sLk9DadYAh
         X7mwrYku1mJRpu7QCeTz76l1LWFiNv9wX+8lJ+dyFLhh7T7coDHq+YmCQpQmF0KSfLAE
         9axnyb0s2etYFlHigdYQlixa19gpIFF4IlLkDUP/DJBpH2LsHFTuoxzst9SFQAkBwo3W
         CxDF/n/80StXZi/eyfYksm+TAH6RyPX3cmBYA54kpqV7TFm36nQo/8FDZjHvtxTROyuE
         REoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795421218; x=1796026018;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GdWbto/GYuZDXyTvm+7T3nEGrjgUlN0uIoNMYNUd3jo=;
        b=CZi3RrT6b/+pPGB8si+KpY8n8VY5LAbGE3EU8izuWq2UhvAHWsTpdJy/5pliliQ2RC
         qosUn9db/xlBPtBjA3hR58aarLTwinOvm7MjrYDncC6SGMfJJuX6w6FFywDYYY49mSpH
         vrMDQEUKMC9zRZohNjXx8LAWGZThkdyQnwUxpGrwEmUFoGbu1AX4SN9wEbs0p1KXpq44
         aRKSS1m2ym5L21GbPyOruHthcFI5+148ed0RgS2cxQI5ZkPRtWa549Feh07LQovgZeWW
         Pi23qEjlY0KfW6pQFmbxRWXm1fl+JGPBWolrB0uyYxO2lqw8hyX62MtilOEJz0Gt7j0a
         EX/A==
X-Forwarded-Encrypted: i=1; AL+hErFWXCF5Rd/ZajeTs/mXma+HdlN6FDTFp1zAcX1F7Io4oD3w3IJnGeu9qs6Fve7ndl73jYjruAyDjFXKi0rj@vger.kernel.org
X-Gm-Message-State: APuU4Z+037L/w4U6JMxiEdM/CdkHzwpEqTW9ooCEYzPuHRqvTPAGkacZ
	LxwdL2YYi9n3k34hbguDUFR5mWcfO6zn/IrbI9iqMsU2jM6kP8QckrDHZ65SpY/86qc=
X-Gm-Gg: AZFdTZf94E8ABfnpFyV967sNP1Bimzvwb4TQuFsw49iqaRkMxHhvNrtOJCufEeI10SD
	NLnDyIMpx4lFwR3TEiwJkWK/iqOooHLkL3DRH/XAfZ3HOlMVKzqykpANBJ6VrPlPpBneT/qZbm8
	LTac2DJOPTaYoCKt2QvxD42oDBcj+1HKjeDPG7xI2jz1/v5vqlPzwXJ93Toj21DbsqG1Pb9DUVG
	nlUCDao7QALWtTe7o4+KEFX7vexBtimR9oM1m0vEZbZ0B2GlWDzs6m5CwA6NcAzRFRYeWjhSQUV
	RzjPe9aeAO3/RStgcxIVLIakSIJL+JyGquv7Nk5ea7uobCbsZFoB6D8dhXmdJFxIXBUbZgallqC
	QOAf00pPG/hZCstlxU3cAzSvW3TD/U71CUvKRyF+vYDuW4V7tn+VvONQfop6sX0NPlC4VpQedrk
	bmWQlPlqnMba2n4MDIoAWKQf+WKd8DkbixGPtDkxRYdFo+anuL+VyxUQHGqqzeg1LpLGRITkXp6
	J7/S/wQGbtu/AYWJI3+MfZcAVrJoLL8YS0LWVKyhvysRLoTxpD6TuXtQI6sinpH/dFj35rU6Gpw
	mEcaC572bb2j8tbhD6QCSkePZ282hTI9NUQi1dMIrOJI4AuOeL+/q0Wb+NAh14tuXBvqsMn8VfT
	zJm1kLlSTJXieECj7QT/VJfwuKzcZ
X-Received: by 2002:a05:620a:4481:b0:93f:2571:bb6d with SMTP id af79cd13be357-949bab32ff9mr1727268685a.39.1795421218145;
        Mon, 23 Nov 2026 00:06:58 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb349db3sm745619285a.7.2026.11.23.00.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:06:57 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 00/60] Private NUMA nodes
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Yury Norov <ynorov@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, SJ Park <sj@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 Jann Horn <jannh@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Youngjun Park <youngjun.park@lge.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Waiman Long <longman@redhat.com>, Ridong Chen <ridong.chen@linux.dev>, 
 Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 driver-core@lists.linux.dev, damon@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 cgroups@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <awNavE8dAGr-amfQ@yury>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <awMdeK8O-5mffg2m@yury>
 <179537469194.412063.13456998694958645706.b4-reply@b4>
 <awNavE8dAGr-amfQ@yury>
Date: Mon, 23 Nov 2026 03:06:55 -0500
Message-Id: <179542121527.412063.3452837736734095837.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-22 16:12 -0500, Yury Norov wrote:
> On Sun, Nov 22, 2026 at 02:11:31PM -0500, Gregory Price (Meta) wrote:
> > On 2026-11-22 11:51 -0500, Yury Norov wrote:
> > > On Fri, Nov 20, 2026 at 01:08:51PM -0500, Gregory Price via B4 Relay wrote:
> > > > This is v6 of the Private NUMA node series. The series falls into four
> > > > parts, each building on the one before:
> > > > 
> > > >    1-18  mm: introduce N_MEMORY_COMMON
> > > 
> > > I walked through this part, mostly. It looks like you can substantially
> > > decrease the patch count if you keep N_MEMORY meaning unchanged, and
> > > add another type, like N_MEMORY_NOALLOC.
> > > 
> > 
> > I don't see how this would reduce the patch count substatially, you
> > still need to convert existing N_MEMORY users and need to differentiate
> > between general purpose memory nodes and private memory nodes.
> 
> Please check this quick attempt with my codex. The patch count is reduced
> to 52:
> 
> https://github.com/norov/linux/tree/private-nodes-v6-n-memory-folded
> 
... snip ...

Patch count is not what we want to be optimizing for here.

Your branch carries the same code (+3 lines net actually).

The patch reduction comes from squashing the per-subsystem conversions
into one 16-file commit.

It also broke get_mempolicy(MPOL_F_MEMS_ALLOWED) - it now returns
memoryless nodes even if the system doesn't have a private node.

> The more important thing is that N_MEMORY and the proposed N_MEMORY_NOALLOC
> is a disjoint, contrary to N_MEMORY and N_MEMORY_COMMON.

The proposal here is not novel - version 5 was also disjoint:
https://lore.kernel.org/linux-mm/20260720193431.3841992-5-gourry@gourry.net/

   N_MEMORY and N_MEMORY_PRIVATE are mutually exclusive states.

I moved away from that because it changes the definition of N_MEMORY.

The subset model is easy to understand

N_MEMORY               - a node has memory
 -> N_HIGH_MEMORY      - subset of N_MEMORY
 -> N_NORMAL_MEMORY    - subset of N_MEMORY
 -> N_MEMORY_COMMON    - subset of N_MEMORY
 -> N_MEMORY_PRIVATE   - subset of N_MEMORY
                         (COMMON and PRIVATE partition N_MEMORY)
 -> N_MEMORY_<FEATURE> - subset of N_MEMORY
                         all N_MEMORY_COMMON
			 some N_MEMORY_PRIVATE

It's additive. Users pick the set of nodes they want for their purpose
and don't have to cobble sets together or remember special helpers.
Users don't even need to know about private nodes most of the time
(mempolicy being the one major exception here).

In the disjoint model, N_MEMORY no longer means "has memory". Recovering
that set requires new helpers, and the meaning changes silently for
every in-tree and out-of-tree user. Anything that wanted "has memory"
quietly misses private nodes.

Either way you have to audit each N_MEMORY reference and decide whether
it wants that state or a feature variant (N_MEMORY_RECLAIM, COMPACTION).

The difference is how a missed site fails. In the joint model the
zonelist and the common-memory folio checks backstop allocation and
access, so a missed placement site costs some additional work.

In the disjoint model a missed site silently drops a node from stats
and accounting - or worse fails to allocate per-node meta data.

So no, I do not think we should go back to the disjoint model.

> > And N_MEMORY_NOALLOC is not a good name.
> 
> Sure, I'm not attached to any particular name. Although,
> N_MEMORY_COMMON nothing better to me. It answers the question
> 'what for this thing' even worse.
> 

happy to wordsmith the names here.

N_MEMORY_GENERAL? _DEFAULT?  _COMMON felt intuitive but I am happy
to rename it whatever.

-- 
~Gregory

