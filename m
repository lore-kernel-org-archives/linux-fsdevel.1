Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC752EE268
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769557603; cv=pass; b=kVhD57/RrvHf6FRzK6/eQLxVuLwPvxfZoYjOEE5FC0Zwg7VOOnmophM42eBEjmmHUDUa0nIaD+x+AQd7TH2u9LKTkTYAQgDTz3d4ACDIcIBpEBYnfN1vBikSlHoHc64+YYK/fsfr1Dq1KrxrsmeUIP42rFONT9Cd7hYTXuRFFHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769557603; c=relaxed/simple;
	bh=vst6t4peh/JV4Zuhoe6fbMyUDr/jcG7JxMjC1bUj/HY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRCXnkKSaN7JOpzXw55Cu4JARudhFTI9kqnqbUJqr5RVl3BVPFrky8NEGJefVe33qrhKZdfV10MP6SuBRUKEmhWSlzn5YRBazCejfd9xKmp1zzf9OOUerEN7FgzcaFLwOmY9WMTl681MrffWiZKWH4Msb9lOwzVw8z+rml6qNMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0aMp+cV; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0aMp+cV"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5664634a27fso1009027e0c.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 15:46:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769557600; cv=none;
        d=google.com; s=arc-20240605;
        b=lB5ssVgQ9SbElL0uqS0B7WHbEC/dA5caHTn1AZ8x4cvcwAoinKMTBX7EhHAIW2TdRK
         8cspNDC1GT2oJvq4Mt/04xPlcRN/UZ+pCWhmqmtYtpEHXkWypt/kLE/IM79B2XwboRxL
         dGMZkfx/cENjpSH9UFpHUuxl8LB/PerXQMPe8y0l1scw9EeilbaxJiv/uZt+X16JIuYh
         HGuG2+Gk5Xjsf4q9O0FnHF7beiVktVqKzIwdz6SKMcNFP2FyDBd5oj48yRpxqwocMeFe
         0WL2putF6Y9QKi1RaSJLSnDOTFz07GW5/P3f0O9A1rF/8N052RXlJt0wLjp3/WKth1AS
         m0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=3+EqNzQT9TNRk9U4Wm8Lp51VnBAV17bgK1qxop8j5Is=;
        fh=iAtd2OpXX/8j7BubKJCLD0mgqfR4bFjyYQanaEoPp/o=;
        b=c0Jpz8+2tRj5IohRva3S41QMrDsNQuUIsCzyI3+uBWt1ypgVYgvcCEQPAq9D1rx9kR
         4+7zK0hTkjz6zDvOHOXRT0bR8EtgdTo1XpwaTxMsCqiJoN7dmB/bK0DFjGWw0qx0atXi
         NLcsydgFWSFxS5kVhH7FEl2ahRzH66zjZ020CkgrMYbRSLiEPaMyb/A72khgK9B1oUn8
         r9ems9OmZuHI4AcD9HabwEBQvpSUhgHbDhkbqFH7zc4FaVEfqJxVmF4rNZ+rmIkKNOcu
         +bj9197G5Uu8xHpiOKqJ3Px6okH7/1WRSQzEmhgLOYn9YNjao1wlnH0/jD0kWk6K7jOC
         C4DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769557600; x=1770162400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+EqNzQT9TNRk9U4Wm8Lp51VnBAV17bgK1qxop8j5Is=;
        b=q0aMp+cVQgIaUs+GKsnXsbB8/OBQGmUP7zTFWK6YuIMa/8RpGMvXMR/6bZPWJUz+Ax
         u/t64RKqMcpebPRbhQ1M6biN4IVbKs9gzGNSNkMp1uOAxFoKkJ3J2aIai8hAjHoef+oO
         yGAQYLHOusadvqilAz8Cq8+gSfOtTAksoE5xOrb8XOmbpk7FoWeBVa3hH5MKs834fYOA
         CLJ/rTfq30ymSa+kz+gatTy0HfxXCxyYv7Eitpa5Lcrq6+NC0vv4ZfQJ6bRsUKrik2+u
         PKDb6B/ERV/ZDxO60V/G5dT8DoTygTVKTspVy7XBm6gYY5wd3EUNYV8jaV8k+Y2+l26V
         yrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769557600; x=1770162400;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+EqNzQT9TNRk9U4Wm8Lp51VnBAV17bgK1qxop8j5Is=;
        b=nUddNz40JpYjOqa/z0H08s1teEFEbAiB9t8cuU3ZQALgeQXHuyo1OMWBKQBhzRBzF9
         9vXZvuZi/x271mT0+YyVAwfytwE0g6ma2c00dNMJwwwiWt5gpRNETULEwj7JNy6a4Pld
         jsxZWrRVpEfPGI7iZFwpcAVmNVff/1XytHh1zkQ+T4YOiQqULqDx49IrMEeuciR1dPnn
         Mv6IzVa4VyG3/fYoTYSXddKDxNAzA9IH+psGikBp86GZzUM0G7I1560aBi3q8lT+0sci
         Cx1NKRmwQQo4RlGezGi2ecBD3phmpnr6RjJLjX1AEmOVcCb31plAvHC4wn6tDbpDGf4H
         KBgA==
X-Forwarded-Encrypted: i=1; AJvYcCXxsYs8UNtzQZB/zH0vpGlnCd2OSaKC7oNUdVa3ngazncFNyU8g4rhl8oOC0OajBtHEmgcu7yGyYi2h1o/T@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHqgJspFDPZyg0jhMXUFTQZdzc6IFdQPkFoLHCtNVoamacLZl
	LLizaCrumWVM01zVdrWgeBbnLHB2rWGQJI5kW7Q7dM9jBxB+vP/4EWhA8E5S8bYC/kjyiXRzqF7
	dOk2UJoC2RlZiueziKbPxxbUeABKRIh1q7Jg2kTyx
X-Gm-Gg: AZuq6aJnpmM14degkigAa29HFoGmljC26wMEyKCkMXFyFRaiof6IKTjO9+O/WC8Q4tD
	DVW3AFIvkHhen7PIYlzq/izUf6bpjyyR3uCJUIESROE44X/QFdRwmoenEbDzRNMtcDGUeA5SLKZ
	aHlUW7bxxs8m5xSc0Z3HQNja2OlggedsighVRBTItuf6Y76jWgVFkLQ7+ggpRnOiT4S7B0Q6geR
	eZbU83gPvKzhl+TZ0R3QHeiqsPnnEZ5f8YnUHIQ15a3Ot3boeWSGLrN7AKcsMNhR6MUVSNotnzG
	IXCap9ub+SXJiba+U4p/nP7n5g==
X-Received: by 2002:a05:6122:488a:b0:566:36e7:8934 with SMTP id
 71dfb90a1353d-566795c5856mr1161633e0c.16.1769557600050; Tue, 27 Jan 2026
 15:46:40 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 15:46:39 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 15:46:39 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ce78da49-2525-44af-9cb8-301bf6a4658a@suse.cz>
References: <cover.1760731772.git.ackerleytng@google.com> <02aad35b728f4918e62dc6eb1d1d5546487b099e.1760731772.git.ackerleytng@google.com>
 <ce78da49-2525-44af-9cb8-301bf6a4658a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 27 Jan 2026 15:46:39 -0800
X-Gm-Features: AZwV_QjMPyTn9KuYIeoCwzon32JStKYHl7N-mpSbapwuTdPZlfrcWu1xEKHINOw
Message-ID: <CAEvNRgE07d_TaSVpkWO8gMfGgPsP9sBzrqMPCte8PET0THF=QA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 09/37] KVM: guest_memfd: Skip LRU for guest_memfd folios
To: Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maobibo@loongson.cn, 
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org, 
	mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	peterx@redhat.com, pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, 
	qperret@google.com, richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, rostedt@goodmis.org, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shakeel.butt@linux.dev, shuah@kernel.org, 
	steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	vannapurve@google.com, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Vlastimil Babka <vbabka@suse.cz> writes:

> On 10/17/25 22:11, Ackerley Tng wrote:
>> filemap_add_folio(), called from filemap_grab_folio(), adds folios to
>> an LRU list. This is unnecessary for guest_memfd, which does not
>> participate in swapping.
>
> IIRC guest_memfd mappings are unevictable. That should mean they are not
> ultimately added to a list (see lruvec_add_folio()).
>
>> In addition, the LRU list takes a reference count on the folio. With
>
> IIUC the refcount is temporary while being on the percpu
> &cpu_fbatches.lru_add, added by __folio_batch_add_and_move().

Thanks for pointing this out. You're right about this, I misunderstood
this refcounting earlier.

> When flushed
> via folio_batch_move_lru(), the refcount is removed and there's only the LRU
> folio flag that remains. The fbatch flushing can be triggered if you see an
> unexpected refcount increase.

The new plan is, to update kvm_gmem_is_safe_for_conversion() to drain
the fbatch if it some elevated refcount is found:

static bool kvm_gmem_is_safe_for_conversion(struct inode *inode,
					    pgoff_t start, size_t nr_pages,
					    pgoff_t *err_index)
{
	struct address_space *mapping = inode->i_mapping;
	const int filemap_get_folios_refcount = 1;
	pgoff_t last = start + nr_pages - 1;
	struct folio_batch fbatch;
	bool lru_drained = false;
	bool safe = true;
	int i;

	folio_batch_init(&fbatch);
	while (safe && filemap_get_folios(mapping, &start, last, &fbatch)) {

		for (i = 0; i < folio_batch_count(&fbatch);) {
			struct folio *folio = fbatch.folios[i];

			safe = (folio_ref_count(folio) ==
				folio_nr_pages(folio) +
				filemap_get_folios_refcount);

			if (safe) {
				++i;
			} else if (!lru_drained) {
				lru_add_drain_all();
				lru_drained = true;
			} else {
				*err_index = folio->index;
				break;
			}
		}

		folio_batch_release(&fbatch);
	}

	return safe;
}

I hope this is what you meant!

> So it might be feasible to do without this
> patch (maybe it was already tried and there were substantial issues, in
> which case should be mentioned).
>

The patch "KVM: guest_memfd: Skip LRU for guest_memfd folios" will be
dropped from the next revision, and "KVM: guest_memfd: Don't set
FGP_ACCESSED when getting folios" is no longer a requirement for this
patch series.

>> shared-to-private memory conversions for KVM guests dependent on folio
>> refcounts, this extra reference can cause conversions to fail due to
>> unexpected refcounts.
>>
>>
>> [...snip...]
>>
