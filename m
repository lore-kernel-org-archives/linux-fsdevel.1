Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7013B6352;
	Tue,  7 Apr 2026 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566819; cv=none; b=EIjW70/bY4cp7gxDHAkaf7U4rj1SUOKhQg1RNXHvAv4xtapgEdHM1ys8B3aRgYq6Cm1ebwBSnZJEa1e3LUWq0Q2fA7Mmz1kp/4SpHaqFtEvMdt1yo8ztyaHUuAA5sPinBUrjrFaM/HOZ5cPBjEYbttXBuib3crEXXEksamazJno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566819; c=relaxed/simple;
	bh=9g/6ivrb0RmDwR1PLMYmA4o5ry8IP2rIJPVEZipn8ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrB0V1nQi4cWZcVpFqp5HIJPVXVlZf7akjQuOtIweJFn3u4RChoivtC6Axh52lt34OpNxl0JVgt+ComGj+D9nqsFyfZs9tqsUatVRbM7VlyHC0/HUZEap0FMTH841oDBJ5P7pp8p9jJNU/loVSsouGtWx2uiCQDrcUuIvUSwemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALLPTejs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALLPTejs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F93C116C6;
	Tue,  7 Apr 2026 13:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775566819;
	bh=9g/6ivrb0RmDwR1PLMYmA4o5ry8IP2rIJPVEZipn8ms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ALLPTejsosvRriKbnB0ft7zoKwKMrNmPb9R7yn9v4aqH6tALqAm59I/a0idyPZzZY
	 p0r3OE8wsv2cwLzpJkH6MkDcj8ubu4/Lor5PmhZpS7SWeQg/QesdCpek6WJcKOMWaB
	 wIWFQDp6vXIuNYzDDQ3atwxN/DLZ7LrMg0J/MKeXDrGH5CHQmk8SMXZEE3rZ74zNhs
	 oWalmvV5KEDqe893ikKqLdd0Y/VT1TuoKEuAJzm4GJYT5qOPUMgLNxwDbTlCV7feHu
	 LPWJMWFXqGKgAzDGdFze7n1MHuyTNh20mLKMK9NYA+F8MuNK5AAkNlBwh270IvLq7q
	 h+SP5S92+rFpw==
Message-ID: <ba56af16-c326-4abe-b1e5-3eb5015e14d7@kernel.org>
Date: Tue, 7 Apr 2026 15:00:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: proc: document ProtectionKey in smaps
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Yury Khrustalev <yury.khrustalev@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 David Hildenbrand <david@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260407125133.564182-1-kevin.brodsky@arm.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260407125133.564182-1-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/26 14:51, Kevin Brodsky wrote:
> The ProtectionKey entry was added in v4.9; back then it was
> x86-specific, but it now lives in generic code and applies to all
> architectures supporting pkeys (currently x86, power, arm64).
> 
> Time to document it: add a paragraph to proc.rst about the
> ProtectionKey entry.
> 
> Reported-by: Yury Khrustalev <yury.khrustalev@arm.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  Documentation/filesystems/proc.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index b0c0d1b45b99..d673cad7dbe4 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -549,6 +549,10 @@ does not take into account swapped out page of underlying shmem objects.
>  naturally aligned THP pages of any currently enabled size. 1 if true, 0
>  otherwise.
>  
> +If both the kernel and the system support protection keys (pkeys),
> +"ProtectionKey" indicates the memory protection key associated with the
> +virtual memory area.
> +
>  "VmFlags" field deserves a separate description. This member represents the
>  kernel flags associated with the particular virtual memory area in two letter
>  encoded manner. The codes are the following:

