Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295498;
	b=qFptYonAFANfH/lv+Ao4N1obgrAvcAJ6XWNgSqtNDzijKCRnMxxcUaB3W43z+wq/Xkxo
	 //NVfZMkCNIPfzrhHOSWANgv21W4pC500ZuUsn5hmbwXBC4qrpkaW9ODE7kk4TPjR5QFz
	 BZEvv+G3oNcGcZ9fgy9M/tN9r7Rpd6Uh3tiZJDr5OMkaP5RD8XCn4Elt7CIwcJWCj6Z2b
	 wzKR/lFwEFwkA61/lEN/0sopW0C0AlS645ke+ASKbFJ2Wsctq0tOlhMTaiKDb30gRH4nR
	 Zy7XmqUH7PIfDnC4OxNW3/nL5WPdAGBdFeME19eGUCc663fXO1GZGpYIZB8mW7WGyrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=+xEi/FXjAcaiOhZWzJNypC4CeC4XPVjT5VrS5d9n3Bw=;
	b=fHXLYIPXRLV0PrquWw0DILGh15VX+Imr2rLIAptzFDwpPcFJB+B7RFP7dLEr2R8Fkal2
	 psiuJemrExybAtflap5GkcI4S7tabWdvXQ1rRB/9qcuEsuXbO8opqxbFzl5qmmyFs/tQ7
	 U+9ZKXJyt+UDVBhKbIn7/D7X3ajPy1B8XiXzW+dODGP4H+Qd9okqBnwvnzRlDfnzcg9KU
	 ZrYc8lzO5+TBSjm2uv0kgFoAx/dNAhXEehn+5hQ04ATrRqTZotTy1/UXA/UMRrq3nQuwW
	 cEKczATL53mPpge6kbt5Jf7oO8esZ+5P2e9zAD1ZKhqE4doxIXMxMsExBz5Ku/ivBJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=F0yCYTRH;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA3606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 17:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CBA3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=F0yCYTRH
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1240305a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793295498; x=1793900298; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+xEi/FXjAcaiOhZWzJNypC4CeC4XPVjT5VrS5d9n3Bw=;
        b=F0yCYTRH1KCKgj1wamQyvj2+BZVTNOuWxMJPDP0xqDm8z2AXasRhnLVIjfTJB+urOA
         hYMOTEHqguCWwBanaJwRqINoqTBckwHx8a2498qdICI+n/lBDqGMFaBGSnDJTcqrlXwJ
         6N3EVeIucQlMqzblx8dYqq1ROCDLze9gT6aRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793295498; x=1793900298;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xEi/FXjAcaiOhZWzJNypC4CeC4XPVjT5VrS5d9n3Bw=;
        b=Cdu2sCDWpXugsdg0Rmm7h3Td2sEH74ynirUZwU3ny0fxszKwDo+kMxoRXgyMVFMMGS
         5AdK0BXSZf/YFkSlExo7gQ0oBbZhW3jRqwLqMbOgR+O9Hze5yiFB0LC51IXB0BPiYKrH
         FpVuh0zuc6E0mpA2ixtJSgI+cDGKh7cyXnpBYbSkV/zvLOf8iDbgU64eQYFlRcj7z0ay
         QbCwxrakaNAx0dY0WXfSGa6PCNjRZSnmq+Gww04zAsNAL3cGJCplaWi+EsMAX1/DaDp6
         yZuLGA4N6a4CjhutC/ybJZa5S9MBpSkSs4tocI8twL+l5WtJHzBVPW5e6tThzCEIRm/l
         j15Q==
X-Forwarded-Encrypted: i=1; AKwUvBwuXiSfKAewV8RscgGqx8VVgTCNXLQNtTZRl06oeLbFw4Z9131wZ9Fr4yhIfHcNBKY4DpjWXXtHTPhN7/3M@vger.kernel.org
X-Gm-Message-State: AFq9FYJsEJP9e/kK12330v+M67vAY70yfGpZDsILfz0/y9w5kTJu0ZCP
	n08WEKJ4y+zpmq/I68QJWC4+ZwtT18ISFO5cOWIN1uKJkUdu+VNhU+og8B6F+pmpdxs=
X-Gm-Gg: AYBFou3b0cpQDBwswc9capO1gwuD0m+R4dC9IkTC95lDi5i5XtMfmAf8AkLzTXitscN
	bQv8I6NgoQVws/CPBvuSR4w3xoMC/pkFFR/9isvWtzpEv0kRMQ3C+/fNruK983pBbCl6543/VCD
	1FrzZbLuRAZ3BG/KvhDW75uVTcZcvfHXcBbwpttYjELDb+ncCcaCGxNaJWstwtfIeAvie98Lnnu
	UPJXXardT4uOMeORVQvePtYIulsW6IJFJ/9NyIUJpbEuEuB0wg8CUcPVqdbZBZMh5Otmsv/fW50
	emt6+pSNQTpUHhYbRjEb3XojMGgqKpheWTkRsVehi/5n/gaxpEPRl7WoPw3NamLuYII9HBlikCT
	SMeJDfFPzmlQQMXJ3z8ks/pKqF0wNZNoB12fRW/X8n/q72js0CmqvkrHwr54Pcacynb7hRJ9KYk
	D98PfjvE9m55CvHi9kvhzbrPHqutn4iQEie6KOZzfjojfeUKJfKrSofHemrUbZ5aHcVRxGVUbnK
	LM6TQiLT1VhAtA3gC9bEuV5+hJDeGbeJYyryaHkk2qq0aeIzAiYuB7uNTV7GUk5KXRb3ht9fS6V
	NGlWBrvV9dj+WPtHovrDW58FSICbfyEsR+3htkpOOLCn3Q9QmuHNhH7gZa7mBWP8d+58yccBHN0
	rXb5+3CVDhMeIhQfRsrvSPFNCsc6vOOuqfH4PZRikTYUUc+EgHnW3noY+sCT50b7XlvbAY8Zz
X-Received: by 2002:a17:90b:1d44:b0:3a7:250:333e with SMTP id 98e67ed59e1d1-3ae57f631f6mr4570721a91.11.1793295497657;
        Thu, 29 Oct 2026 10:38:17 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb1ddsm5096378a91.5.2026.10.29.10.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:38:16 -0700 (PDT)
Date: Fri, 30 Oct 2026 01:38:13 +0800
From: Chris Down <chris@chrisdown.name>
To: Omar Sandoval <osandov@osandov.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] proc/kcore: Allow disabling /proc/kcore at boot
Message-ID: <auOEhTNaKzu8dgEy@chrisdown.name>
References: <auAmuqZyUodq3iqk@chrisdown.name>
 <auKKisespDm1xLLg@os-N5J97HY9XQ>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <auKKisespDm1xLLg@os-N5J97HY9XQ>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Hi Omar,

Thanks for taking a look!

Omar Sandoval writes:
>The code looks correct, but is there a reason that /proc/kcore
>(CAP_SYS_RAWIO) is any more concerning than other ways to read kernel
>memory (e.g., CAP_BPF + CAP_PERFMON)?

Not in terms of what it can read, indeed. I would say the distinction is more 
about who needs each capability and what we can remove.

Abstractly speaking CAP_SYS_RAWIO may be needed for hardware access without 
necessarily wanting to grant general RAM access. STRICT_DEVMEM already makes 
that possible for /dev/mem, but /proc/kcore gives the same capability to do 
general purpose RAM reading anyway.

In our case in particular, a process with CAP_SYS_RAWIO doesn't necessarily 
have CAP_BPF and CAP_PERFMON, so keeping BPF available doesn't make removing 
kcore redundant.  On the hosts in question, BPF tracing and BPF LSM are part of 
the monitoring and sandboxing we rely on, so we can't remove it from the kernel 
entirely, but we nevertheless keep CAP_BPF and CAP_PERFMON away from guest 
facing processes. Nothing on those host uses /proc/kcore, so we remove it as 
one more gap to close.

For that reason those hosts already run with CONFIG_PROC_KCORE=n, while other 
hosts keep kcore to aid debugging, since they have a different threat model.  
This patch, then, lets us preserve those choices while using the same kernel 
image.

In retrospect I should have explained that better in the commit message :-) I 
can update it for v2. Does that make more sense? Let me know if I can clarify 
further.

Thanks!
