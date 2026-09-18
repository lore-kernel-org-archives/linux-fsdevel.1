Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB66F2FD696;
	Fri, 18 Sep 2026 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727656; cv=none; b=tGWjSOx/S2VbFW6X2VX+5/MqutQ/FJP6Qxp0OjffKhorsG5DK5tATd9zQ6ZCI7QwRxXcfEpCFuPqastdg8CXEuF3Pn/jiQpJArFO4JSogc9mAqIF7FT2rZuqxhQq4iT/vZMm3/99grjq96m6s6zH4Z+t6Qs5/7NXvVbLVLoW0Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727656; c=relaxed/simple;
	bh=71jFtym32R/pNn5C3yPgZDDzaq5qZS8JIIHmgqqBkfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GVtfWHFgqaAVmlE7R+ECKcFWc5u3O+bs6M9LSOfxXXwjDvQo+Ol+HAOPwitDysAWXCyGxRcT0sqMMdO1UzDZyOoiOdy3gzFRmyiZU/sv2nzZCtZ8jo+RuUEYk3wGIh8S/6Oq7IRH3asVzJmSi3iFqUXBRZtVVrgpJU9WG48L2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQiwVwcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQiwVwcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8601F000FF;
	Fri, 18 Sep 2026 10:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727654;
	bh=71jFtym32R/pNn5C3yPgZDDzaq5qZS8JIIHmgqqBkfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQiwVwcrQYLLOMOj+NzO2JrLYChumnio/fc/mR5O1sf+FXz56jqfp8xu3Zrn/AQ+s
	 UPQyFX9daLLzA6NyhjGsoN+Am67E0Plu3Mfyd5MMPIetvbNA9eZOvvUVUwHG4KkIpd
	 Hm/jAvYbKzwaavhWLnLyf8e6cQcV9SfiClrlMIomraUmmkXu7tWNmkMAxTVqQ1kGvu
	 3PA8y2MCJUX2uWkWgRxGYr4d1uKTFqRc5E5X8XQb4BwZPPMAW4GtRKnetdW/5jxo5v
	 HIf7SrFWALwipQXYaKiwGiTgnED/7M//LvvFLI5CfiI/ADJfkSN8KaNbw2mngKa4Vn
	 EsC+2NfERzkuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/17] crash: Fix TOCTOU race in crash memory range
 collection
Reply-To: sashiko-reviews@lists.linux.dev
To: vishal.l.verma@intel.com, linux-fsdevel@vger.kernel.org, jbouron@amazon.com, linux-mm@kvack.org, sshegde@linux.ibm.com, bp@alien8.de, maqianga@uniontech.com, mpe@ellerman.id.au, kas@kernel.org, gregkh@linuxfoundation.org, chao.gao@intel.com, mingo@redhat.com, kernel@xen0n.name, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, chenhuacai@kernel.org, seanjc@google.com, ritesh.list@gmail.com, pratyush@kernel.org, tglx@kernel.org, pasha.tatashin@soleen.com, yeoreum.yun@arm.com, gshan@redhat.com, chleroy@kernel.org, liukexin@kylinos.cn, thuth@redhat.com, eric.devolder@oracle.com, linux-kernel@vger.kernel.org, kees@kernel.org, dakr@kernel.org, mark.rutland@arm.com, x86@kernel.org, leitao@debian.org, blum@kernel.org, catalin.marinas@arm.com, zhangtianyang@loongson.cn, me@linux.beauty, mclapinski@google.com, palmer@rivosinc.com, loongarch@lists.linux.dev, ruanjinjie@huawei.com, rafael@kernel.org, will@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com, rppt@kernel.org, hpa@zytor.com, james.morse@arm.com, tangyouling@kylinos.cn, linuxppc-dev@lists.ozlabs.org, takahiro.akashi@linaro.org, baoquan.he@linux.dev, lizhengyu3@huawei.com, maddy@linux.ibm.com, coxu@redhat.com, linux-arm-kernel@lists.infradead.org, guodongtai@kylinos.cn, hbathini@linux.ibm.com, ruirui.yang@linux.dev, 
 adityag@linux.ibm.com, graf@amazon.com, akpm@linux-foundation.org, sourabhjain@linux.ibm.com, driver-core@lists.linux.dev, piliu@redhat.com, ardb@kernel.org, robh@kernel.org, bgwin@google.com
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-13-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-13-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:34:10 +0000
Message-Id: <20260918103411.5E8601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> The crash kernel ELF core header construction counts system memory
> ranges via `arch_get_system_nr_ranges()`, allocates the crash_mem
> buffer, and then populates it via `arch_crash_populate_cmem()`.
> This sequence has a time-of-check-to-time-of-use (TOCTOU) race with
> memory hotplug: a concurrent hotplug event between the count
> and populate steps can increase the number of ranges beyond the allocated
> capacity, causing an out-of-bounds write. If the event triggers
> memblock_double_array(), the memblock array can be freed and reallocated
> during iteration, leading to a use-after-free.
>=20
> Protect the entire range collection with device_hotplug_lock. Since
> the hotplug notification path already holds that lock, add a lockless
> helper, crash_get_memory_ranges_nolock(), for use there. The regular
> crash_get_memory_ranges() acquires the lock and calls the helper.
>=20
> [ ... ]
> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
> Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
> Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D12

