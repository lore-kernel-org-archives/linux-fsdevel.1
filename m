Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795828227;
	b=t3N1bNN8sl3FvC6Mp4ryjZ6KJmWjiQ8hAcl8gfIUmNX+SfsRT560y6fGQnqxbmrcS1/B
	 uUSxLq1Tli4QiYpjAHqGILTfAsA3iT5p8IgSWopd3uWLVDr2ojcZrqd1dRHsFr9sy3E8n
	 pRtkVx52DealQhAwQLkG184upXHbD2cmn23EOt6TpLC1eoE313XcPYJCICtSWCYOu/LIv
	 tdSdUFzXUUQT0kf20E2aOHyDNUIkcU5ICmAgUYMMx61avwNrkBdnzFpkxZSOoN6NLv8Pc
	 FWqDuIlFNQKmH72Z9simAknFxN01kiTh3QYej6M9t+BRavUz6eXxjw8ZM35X7gUgMGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795828227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LCoNBWE3kmGZQJ1kgw8zMrA5EDN0aulmwFxsRmULwsM=;
	b=A2/GY3rmklgZ20Pz+IkTYPF0A4FDiaEcXbP9WH1iWHF9FFQFhtQgoUcfbPkdevsNLrmL
	 cmDa4kRp5Jcs1XWAof4UCCtC7KEVlfb0ZuuinX0wRf8mpRsq4Xs+yPIe6jyf0y7OUD4sX
	 BStgrg1JMZP06n442lj9B+f9w8nDjjVnG3C5waCo9S7laeTuOVwHBjpNmxx4u10zrcYcF
	 BWEGvOIYAbeUvn1vaxHU6fJRlimGaMFlwbOobCvb7XO3mRaMXjjG5ppxuDJJInPNr8Pel
	 e8ANm9h7D7Q0SEevdkmMGVcwUxyNN8tFYyhzvYk67Wmhx6h4E5lwaRPi2XcQ/16EgIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.cmu.edu;
	spf=pass smtp.mailfrom=andrew.cmu.edu;
	dkim=pass header.d=cs.cmu.edu header.i=@cs.cmu.edu header.a=rsa-sha256 header.s=google-2021 header.b=CWjYKGT0;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13684606A32C
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 01:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13684606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.a=rsa-sha256 header.s=google-2021 header.b=CWjYKGT0
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-55d03bfd477so96031191cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 17:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1795828223; x=1796433023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LCoNBWE3kmGZQJ1kgw8zMrA5EDN0aulmwFxsRmULwsM=;
        b=CWjYKGT0Rxh7o04L3TC/JfK+uf4hcTv5G/OYgTRB1iBdL4eDH3e/LFFIDSlMTSh10O
         nTeD3sJ2hsdOj+qUENGI6sv3VZx0OdZm7gaYArds/UnZMFzu0txNbil2P2V49E3BSbKf
         fBFWYtcAxrxOXqE8cE3CSJ7ayej+C8/WOWoK8p4TehPSmjK4cVdj6nW4QQnR0rVwFURz
         FQHMbeQFo/sRs/DRuW4xea47NphJ6VklMieXOE0gjy6FzMga+PUhUn4yGX9iJcyWCFRN
         dHlM28+px1j6+Lb66EZ6+U6goVgQsWG0+7hHxkb8jYPOwUJKOuA9bMOR7OUMQNy1D4tO
         ehCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795828223; x=1796433023;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LCoNBWE3kmGZQJ1kgw8zMrA5EDN0aulmwFxsRmULwsM=;
        b=SCn6X6QeUlcppSCsBn9pnGROo4M1wkpvAU4EhonczuOY/YyU0UcUe6wRFqryyFLpfW
         sxl8AHabOqmNWN2o72z2NpzBPO10TPSjyjwMJb3NhqIMdlccc8YPUtn4UgofSB8d1JWO
         QDGooMnU9odmuKzI1qpfGyTz7zfAvOTSbEx5cMpqcb/cmK5qHA5BIuN+uXKAASBmM7xb
         +uj3xmVoQSpOxN/LrSA5WcBuoLvnn3LSExOU+M71Jdp0yh+KOiJPaED3VhWQDZrzGeWf
         p3NNCT81wYvGNlul74i9af/B/qlvedpB5wdSZ29E2cQO/HIgUtzlHHTIXyyHe0dcEChG
         X4nw==
X-Forwarded-Encrypted: i=1; AL+hErH68Fb8IUWTzh/xzXcDGGmUPJ0xpHKCqv0Cl7b52UnrQPP3xlKWBf3Y1vOv611Os5YAwh9jJCi5p+i/9GJ5@vger.kernel.org
X-Gm-Message-State: APuU4Z9NDKEQdKS/RfglLaVImbwRjAWN/DsklucH9/G+JV8OzvFuK6s8
	whwJ/qgQ0Nal7nswedzLy0jJfjk0Yfv12kEU8pJMZ+Ja6hHDLy3tf4FG/8M8/fJtRg==
X-Gm-Gg: AZFdTZfIpQ93EpolVi6jmJTQ1BD5e26+6Ls5lc8ZlqMFh3Lv3t2J7rRZpDvr/QCiqiX
	cIPfPTUseEFyU4T6jXP7xvd3fyBjzGx7Tq4ANn3RK7qeUsx0kS1E4CCjmEe9NXjKezjlKJ9oone
	6bxXH+wd4RBvQ44LYz48xHGaojCXFCA0ZBBuf7irAEG74SpNH0pUJnSIAARh3vwkaxZLYy6QalU
	9xNo5hH9DTWD+yP/Fvh7B37iK38FwYRlP3CRYVwpA3Ny2G15Oydfz4gX75e4rsAXQEW0089nhX8
	6GGwGxn7rmhV3tnmL1wd3ui89IOQX/AVr/QrfD4IoKE2PC9IaK6EC5kZWIolLwfRqTNq5bNV22F
	g0dIB/G8/NO3c9RczuXOt9Hx1lsRo4dL2uvhxCYJ0MQkxNYNefxFINdguA14TIefWmFT+a7w34S
	/odM4uYGsawFB1ysCjbLVY6ZpSSW/3JDmcP4YAKPd9k6FWUu2PWd6jgX3IOsgG0M4tlbRPXyruI
	yJ8qrV7IlnKuTaA6pfNU08BO6gn3uYky6FZqkyCwSaz++wjeV+q6FIa7ebRpKatLwcmQFvJr4mm
	6uQ9iOuxcFF7jXGZpvO0ScDeCW8SKdx19aBIY46MbsbRdNMDTQ==
X-Received: by 2002:a05:622a:428a:b0:535:f92d:5c00 with SMTP id d75a77b69052e-55d76af8921mr488959251cf.76.1795828223013;
        Fri, 27 Nov 2026 17:10:23 -0800 (PST)
Received: from cs.cmu.edu (tempest.elijah.cs.cmu.edu. [128.2.210.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b3a0csm229263356d6.14.2026.11.27.17.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 17:10:22 -0800 (PST)
Date: Fri, 27 Nov 2026 20:10:13 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Hugh Dickins <hughd@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>,
	Alex Shi <alexs@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Pedro Falcato <pfalcato@suse.de>,
	David Rientjes <rientjes@google.com>,
	Rik van Riel <riel@redhat.com>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Muhammad Usama Anjum <usama.anjum@arm.com>, linux-mm@kvack.org,
	Andrei Vagin <avagin@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] coda: never point a file's f_mapping at a
 container's mapping
Message-ID: <20261128010821.irhzl7qcqahz6onx@cs.cmu.edu>
Mail-Followup-To: Andrew Morton <akpm@linux-foundation.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Hugh Dickins <hughd@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>,
	Alex Shi <alexs@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Pedro Falcato <pfalcato@suse.de>,
	David Rientjes <rientjes@google.com>,
	Rik van Riel <riel@redhat.com>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Muhammad Usama Anjum <usama.anjum@arm.com>, linux-mm@kvack.org,
	Andrei Vagin <avagin@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
 <20261127-mlock-madvise-mprotect-ai-fixes-v1-1-e46b2b1eb435@kernel.org>
 <20261127124428.f1f66c6244d3e5c2811f56de@linux-foundation.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127124428.f1f66c6244d3e5c2811f56de@linux-foundation.org>

On Fri, Nov 27, 2026 at 12:44:28PM -0800, Andrew Morton wrote:
> On Fri, 27 Nov 2026 19:45:40 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> 
> > Coda file systems stack differently from other stacked file systems.
> > 
> > On mmap(), coda_file_mmap() switches both the Coda inode's i_mapping and
> > the Coda file's f_mapping for the mapping of the container file. This
> > causes two problems.
> > 
> > Firstly, the container file may not remain pinned, at which point this may
> > result in a dangling reference in coda_file->f_mapping, and so a
> > use-after-free in mmap() or lseek().
> > 
> > This can happen when you open the same inode across two files, mmap()'ing
> > in one, which assigns the i_mapping, and open()'ing another, which assigns
> > that i_mapping to the file's f_mapping, if the cache manager gave the two
> > files different containers. Each file pins only its own container.

Coda uses open-close consistency, so between the first open and the last
close the cache manager does not make any changes to the cached copy, so
every open is guaranteed to get the exact same container file.

Now that happens to be the Coda cache manager, I guess changes that
would enforce this at the kernel module level can be useful, but
dropping f_mapping, I think will break mmap for us.

> Yeah, I hit this while getting
> tools/testing/selftests/mm/memory-failure.c to work on all Linux
> filesystems.

Did you test this without the actual Coda userspace? What was the
cache consistency model your userspace was using?

Jan
