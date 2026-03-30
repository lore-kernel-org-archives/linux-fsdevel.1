Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77075340A57
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905096; cv=none; b=flhJsEXanbpV+mBE/7NojoNJ1C9fzGetKmOj8iZrU336RTC6gHNrbk12JZ5VTdqgDDeLpzNtEbjbtAjcz2/MHY/7e8GV4T449VWluBDAOSKcb+ypKxTC3I0RT4/iQtlV+3USolpyEIVxjjscfBkWXDKyhqTICpFVtuI8huKkyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905096; c=relaxed/simple;
	bh=WuW4P7HIvCgTqUS/kR2NzM6J7queKF9TF23AviiY0qU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrix3Jrs5vmHv7syGOTYO2iqzDQx6LPCyLAg6zK4m2Y4MGBw0s4eTrQbIsMxk58BHzXvJOEhpOfY7c6Z/0TgNQQNAPdHegBHP7+kn+PDww4Mqw6m7+5RbR0TMfAMLI1Oo8sh1jio/cF9iTqOpD/ryix21Nva5WXw+umtMlcNqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKSgzPkU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKSgzPkU"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4873ce69ba9so14933375e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 14:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774905094; x=1775509894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jc4DvY2MQK88Yewja1MkoO8icKiZ2EexxdGEKN37R00=;
        b=HKSgzPkUR6Ga3XxtxRJ6sEmp/3MMmp6aTkjsQEWk0y4gALZwmd9xr3krRCXrMwXxse
         SAnra+o7+prT9bp/EEZSOqV3bMZNMr7qJfnAWtEkomsNbEnhZibtQ3Ukg6a/9JkvITAb
         NqYe+4o9dzvAlIg4W+dHyclzLtflLYFMRTrJNTNiVoEVJbhFq+a6FIIl0nKUGPp3oLlr
         quNk2tN+EMK3Al/+7Ck9WlZypk3bnMmIpaMFiahlCs7jgfDQVG4KA6BaRg1IzabcSQ4y
         6poTSoSeRzBSj+GJnlInp+DuSbhxKAifG+KfgnkgA8Cf4cEZVz/J2RT1Zgj87edQCu+o
         2r9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905094; x=1775509894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jc4DvY2MQK88Yewja1MkoO8icKiZ2EexxdGEKN37R00=;
        b=VgR2aF4IdGyS9xq4GwzVpsFtgCI9lTFeZxcxRPvDG5e7ysWilFkjsOswKXt7etGSAH
         98eDIfTQH3BAYwqooblpBO7bEEnzbJ1adMPO6rOzpaMPdDgvkiRt44sN1iSVyDqKkqrp
         8GHfY5/fB5yQcsc8znI7U5vsRVq12gWNIcIkBpcyk3FkDShHgFZT7ItaqPKNqy2tnbmd
         1L//3kAruZdBeCJW2hJFsrprZzgR4zrEIRz0iXLIT/b2oQMq3J0AzPZhj7boVCr/SrLA
         1Ob6yjGuNtv+JDyDPNbZNznz/T5wR0k147FVaQzo9kzodyCHGxcc7RzQHSidA/ZSaO/E
         Rtmg==
X-Forwarded-Encrypted: i=1; AJvYcCWDXDFsMUhSHzX0ibgXpo291R7/BApg3SgLQA5KMlxuDQOdhsAJ2Lbxd0NxH8dISRLa5sLwMiY4eaPUMm8Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwABiTb2ymyQK3ouL0yQ8JxlTK2FX38ntov2n7t5n/liA6apjb8
	ZqkuoNc1GSL0b6KpBCzccTmpqePOUIrOgqobqD7kxqClsMbAPzFPPcE9
X-Gm-Gg: ATEYQzy0u7I3syLIOFget12UsTrAD/P/+KibJK9Y/mvCcBarK9a6v7fIkThevOeW06m
	JLbvCyommOjoGMVY2bzWn8hbWfOI7e2SdmKOvFSe3UmzXTAm7SOpisSI6mY0YLYoiu5uT1zhH/m
	3Uh3/4fk+HPyE8XtmEzqvqtY4oscg9Zge8EdCVey0enAjvYjkC4qhxgxqrKogBzpZ+wtx0mUkup
	hzN8MECt09JLhbwhoRfk/6pWTmYjMq1fqXb5gElhozJ2tcYfM5sDh/UbsZDeJfsLb2H5Z9S+Kyh
	z1cdSUrbNd90NHAtaH+jNwWGi13MohArigdZAFebc6JHYq9VbLM0Z3uV7z9KDvfhbhyI2tX7N/1
	tIl/9NcK1wi6B+VNMzBW6TRMP1pWo1RECj9INa561byB1WZ5dpgrtdG0kt9nXJ6Jx4ijEGUKIt5
	r/0weYE0Z5gdBys0BlrwfBHUxX2WDIDqO3m3IcuM+q/KBNZHUM37K+HvhA7qX/
X-Received: by 2002:a05:600c:1d1c:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-48727efacb3mr225543165e9.20.1774905093642;
        Mon, 30 Mar 2026 14:11:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ad8d58fsm1787525e9.24.2026.03.30.14.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:11:33 -0700 (PDT)
Date: Mon, 30 Mar 2026 22:11:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/2] iov: Bypass usercopy hardening for
 copy_to_iter()
Message-ID: <20260330221132.1e1b1387@pumpkin>
In-Reply-To: <20260330-bypass-user-copy-v2-1-f236179e7fd6@oracle.com>
References: <20260330-bypass-user-copy-v2-0-f236179e7fd6@oracle.com>
	<20260330-bypass-user-copy-v2-1-f236179e7fd6@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 10:36:30 -0400
Chuck Lever <cel@kernel.org> wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Profiling NFSD under an iozone workload showed that hardened
> usercopy checks consume roughly 1.3% of CPU in the TCP receive
> path. The runtime check in check_object_size() validates that
> copy buffers reside in expected kernel memory regions (slab,
> stack, and non-text), which is meaningful when data crosses
> the user/kernel boundary but adds no value when both source
> and destination are kernel addresses.

I thought the purpose was to avoid accidental overwrites when
the allocated buffer was the wrong size.
This is pretty much likely to affect user copies as kernel ones.

OTOH the overhead for some socket paths is really horrid.
IIRC sendmsg/recvmsg does copies where the length depends on
whether it is a 64bit or compat system call.
These go through the full horrors of user copy hardening even
thought there is no way they can ever fail.
That is the 'control pane' copies - well before you get to
any actual data.

	David

