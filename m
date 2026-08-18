Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3003C175A74;
	Tue, 18 Aug 2026 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092271; cv=none; b=PQvWFIIwHNHzIVvqEYqWkjTA+6Y//pFnYsFsuUNPePzGvtGdEd940P0gNrdHYfPa0z8AWgZgsDpCcPPSMXaAfup2abOOvMhuvA1tHCO2Q5KBwcZuIST2nIBD4aUKxNIufDk6Yaf7MVXqh9Gg0kt7kGjmywNnr1Qr17wPls+rHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092271; c=relaxed/simple;
	bh=dcrnCJZEHS15iygEOpNyfKBOYsdm1SlvWer2/5Mqbws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsLJm1EmLwOziem4rNbIqwtnFjqvPaKbqL14o082Kx03WFlO/RMNk4VhCMSpvRYCDZ83k+0byjg7Ny1tbbDSzE68NQznz+cA5Ttg7NSFS8UWVBXMuP16l/dLzWqZQOFcRtAlipgH2r6HSGHBjnsFrte5s/D75W63pNWz09aMJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FmS/YmDV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FmS/YmDV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UaqxGMxzHtr9Ya2RMyocZjMUhjkF4gbNc0ELvmXVlJY=; b=FmS/YmDViSepx/ic1GAGwQa10V
	zHPwLTF/ad5lmViehrQ+PxzUmuWPojojopZioi24/bcbur14WhfrwmKVMP4qu5s4VHtnDr8HHycQr
	xPAtht6wWP/utzGFFOAKfPTNPpXGN8+5RsGQTzaVEntFXNHq3Ku6J7dbqDW/a5bSi72RYq8iz+BQ8
	IRnc0XBiPcSCfw6F5s8+INVabyYCIV4w45ykjtY8sJ102nEXIHw0j5I4O2rAHHV0pY+zXo9CW92V7
	kKry5UghnV1A/p14YlcQGtZS4mOeuGNhUqEYNgMAso8sTXLFv5B0AXKA3YgcLpkAq7WuW98asKUUG
	Ddu2n5nw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwSKm-00000008jUt-0rOW;
	Tue, 18 Aug 2026 22:31:04 +0000
Message-ID: <5ce7c073-67a8-40f3-ac30-f6c085551b85@infradead.org>
Date: Tue, 18 Aug 2026 15:31:01 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: filesystems: proc: fix typos
To: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>,
 corbet@lwn.net
Cc: skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260818214604.20349-1-drifabdelmalekmohamedsaid@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260818214604.20349-1-drifabdelmalekmohamedsaid@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/18/26 2:46 PM, Drif Abdelmalek Mohamed Said wrote:
> Fix five typographical errors in the /proc filesystem documentation.
> 
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/filesystems/proc.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index c102b62023cd..78a632fea2bf 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -440,7 +440,7 @@ ioctl()-based API that gives ability to flexibly and efficiently query and
>  filter individual VMAs. This interface is binary and is meant for more
>  efficient and easy programmatic use. `struct procmap_query`, defined in
>  linux/fs.h UAPI header, serves as an input/output argument to the
> -`PROCMAP_QUERY` ioctl() command. See comments in linus/fs.h UAPI header for
> +`PROCMAP_QUERY` ioctl() command. See comments in linux/fs.h UAPI header for
>  details on query semantics, supported flags, data returned, and general API
>  usage information.
>  
> @@ -576,14 +576,14 @@ encoded manner. The codes are the following:
>  
>      ==    =============================================================
>      rd    readable
> -    wr    writeable
> +    wr    writable
>      ex    executable
>      sh    shared
>      mr    may read
>      mw    may write
>      me    may execute
>      ms    may share
> -    gd    stack segment growns down
> +    gd    stack segment grows down
>      pf    pure PFN range
>      lo    pages are locked in memory
>      io    memory mapped I/O area
> @@ -719,7 +719,7 @@ size, in KB, that is backing the mapping up.
>  
>  Note that some kernel configurations do not track the precise number of times
>  a page part of a larger allocation (e.g., THP) is mapped. In these
> -configurations, "mapmax" might corresponds to the average number of mappings
> +configurations, "mapmax" might correspond to the average number of mappings
>  per page in such a larger allocation instead.
>  
>  1.2 Kernel data
> @@ -2008,7 +2008,7 @@ For more information on mount propagation see:
>  These files provide a method to access a task's comm value. It also allows for
>  a task to set its own or one of its thread siblings comm value. The comm value
>  is limited in size compared to the cmdline value, so writing anything longer
> -then the kernel's TASK_COMM_LEN (currently 16 chars, including the NUL
> +than the kernel's TASK_COMM_LEN (currently 16 chars, including the NUL
>  terminator) will result in a truncated comm value.
>  
>  

-- 
~Randy
