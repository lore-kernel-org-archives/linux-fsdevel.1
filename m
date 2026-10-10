Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99E2EEE65;
	Sat, 10 Oct 2026 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673931; cv=none; b=lbgmbG7K11WgkeesqGMTamHRva7NhosUnJ6iw2qdKL1A/zMaRaoe67wlp0GWr1csY6EsDIE/dcn49yIIRNZj7Nzv1cCZ3PdVoguRRpwLTFfyiZIPF5+fKcInK24ROjqvUhE5RCC+nJ+6qizC54zyBpyZ5UQ+yeNHkjd/4HkEAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673931; c=relaxed/simple;
	bh=K4/z8nr5k+jdg66aWFyPdtVPuiUttK7GPMBf9qKIYxg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fF50QTX3fy3RmVx4JkYln7Gq+Zi4BEIIhjCj/hFkq5h+pvhLYi3PUFP9jTY+rClkwSfXCJWfCPX/56W7E+cbzLVmS9gwE/H+KCqI332a6dH7vZUKQNb7VcizSA/ZSNB7V3ugNRWQLvt7YYhE6d1Iy3f8+AM8aPyiRBosyZBiXww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zcqw9uEA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zcqw9uEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00B21F000FF;
	Sat, 10 Oct 2026 23:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791673930;
	bh=QxX0uL7E6cENEk/lCmgjLZU49inEjO28XJafyT3VAs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=zcqw9uEA6nQigJgyrAdSz0qlDIkQEuoABR1ELlELzzXwL/X2WGZVrzULpe4niUTE9
	 WowmIHsejc6rOKkAyTX6elKvM9O0uCxqH3jIvk+4OhriKvZ+GcheaI3iBUuIotOnxz
	 zntiVdEngKjLv4kkpUxHjkEOjUCm7mqa2g95RRbA=
Date: Sat, 10 Oct 2026 16:12:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <yi1.lai@intel.com>
Cc: Yury Norov <ynorov@nvidia.com>, oe-lkp@lists.linux.dev, lkp@intel.com,
 "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl <aliceryhl@google.com>,
 Andrew Ballance <andrewjballance@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, "Qi Zheng"
 <zhengqi.arch@bytedance.com>
Subject: Re: [linux-next:master] [lib]  6b23a67486:
 WARNING:possible_circular_locking_dependency_detected
Message-Id: <20261010161209.a2c3dab9cb05dd0d4b9b18a0@linux-foundation.org>
In-Reply-To: <202610101009.240d59d9-lkp@intel.com>
References: <202610101009.240d59d9-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 16:56:22 +0800 kernel test robot <yi1.lai@intel.com> wrote:

> Hello,
> 
> kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:
> 
> commit: 6b23a6748698a7cbda7d18a3a28e59be63254571 ("lib: fix lock initialization in region allocation benchmark") https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master aac26bee2287c88af5be5a5ff96d783b19a28790]

#syz dupe:  [linux-next:master] [mm]  b9b1861d4f: WARNING:possible_circular_locking_dependency_detected

