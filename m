Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914F48550D;
	Fri, 18 Sep 2026 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728167; cv=none; b=ph+HGsaHAfiarfmURfzRp02wJhWdiD9h0Q2wZfA6ge+W+CTDzPinZWwKrLTjDU25bdLX0IZXt2NuG8lMhVnI5kb04x0ZfJemuJ5xa2g4+RuUcdLvF2Exkk7bvFov0Tk5TjMeVKJlWhki4E/+EB+L7E6FOXVzE8o4GatlNJgmmd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728167; c=relaxed/simple;
	bh=ak8nh2SAnHlrH5Gov+HSivc8cOu/u80U/J5TpC+xpEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8LbURkhFQvBIXfDDOd+2Sj4FnQZknAhyPHQSalxI7Rrjc7Y5xm4nt2zShDR8ZfjjrlkpkmnK9Vny5Zbe3bd3AzlAhXkgxu+JJ76SQXKSDZdIVc+F4BIKwvz5t1UhqrUv5EZ3M8igZLZvLw6CwUDnGPwgZMg5PjFBVNHdpXdZdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nK+0EYK/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nK+0EYK/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ak8nh2SAnHlrH5Gov+HSivc8cOu/u80U/J5TpC+xpEQ=; b=nK+0EYK/9BTfAlJwWP6AvOQJLF
	c15I5JymFF9K2yedwWqzusksKy4eQ5viR8nw3qriMok9WWjsTGTBJqyX7vUZOYQXAgOrEVMbNrZuv
	mjim6c7AEHBA7MnJy/903HNCuWnYczSfYXW5QC0F/OBJf0dY7ju2961gPIkDrOT5ExmqAFKwzqxcC
	XiYLMxnLjQ39eErgrwFWiMno2NauveXgtxV+dkki815BfVZ5ZzLxKpclYHT585S62SVGSmWuPCJin
	9MSZjVXwRNN1boS/jdHCenBQWO8ruAfwzANSV4/t21AyyOLxCm3iTBm1RVzeREYUe38b8ciyJaWu7
	GijK2PpQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x7W1x-006f1D-2W;
	Fri, 18 Sep 2026 10:41:22 +0000
Date: Fri, 18 Sep 2026 03:41:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, 
	pratyush@kernel.org, ruirui.yang@linux.dev, kees@kernel.org, thuth@redhat.com, 
	gshan@redhat.com, ardb@kernel.org, james.morse@arm.com, yeoreum.yun@arm.com, 
	sourabhjain@linux.ibm.com, robh@kernel.org, coxu@redhat.com, tangyouling@kylinos.cn, 
	liukexin@kylinos.cn, guodongtai@kylinos.cn, maqianga@uniontech.com, 
	zhangtianyang@loongson.cn, blum@kernel.org, adityag@linux.ibm.com, chao.gao@intel.com, 
	kas@kernel.org, vishal.l.verma@intel.com, seanjc@google.com, piliu@redhat.com, 
	jbouron@amazon.com, me@linux.beauty, mclapinski@google.com, graf@amazon.com, 
	bgwin@google.com, eric.devolder@oracle.com, hbathini@linux.ibm.com, 
	takahiro.akashi@linaro.org, lizhengyu3@huawei.com, palmer@rivosinc.com, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 00/17] crash: Rework and add arm64 crash hotplug
 support
Message-ID: <aq0UR62q6gGJUQ49@gmail.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918100442.3841135-1-ruanjinjie@huawei.com>
X-Debian-User: leitao

On Fri, Sep 18, 2026 at 06:04:25PM +0800, Jinjie Ruan wrote:
> When CPU or memory hotplug events occur, the elfcorehdr in the kdump
> image becomes stale, potentially leading to incomplete crash dumps.

Looking through the series, it seems to mix bug fixes with new
feature work. Would it make sense to split out the fixes so they
can land independently, and keep the new features as a separate
patchset?

I'm currently rolling out crashdump CMA across the Meta fleet, so
right now I care mostly about picking up isolated bug fixes. As it
stands, it's difficult to tell which patches are fixes and which
are features.
