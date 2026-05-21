Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4E35C1BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353595; cv=none; b=UZMjwaACywLD/I3Cc7RDeQXai8s8bC0DHfk09onZnkAKP2nQRJkLMXSv3K8aVKehrf6cyec7SgDjvS1SpZ+yFAtec67ZOKPmjB26DSdyIgHe+H+M+XzR3eAJ8GpBKdHWDYo1jvhtR158O87t74LqAk3TVusPA1kEDWtUV0uvY5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353595; c=relaxed/simple;
	bh=bmcgmqSoIAG660NAk9RAaAgXzOjnzTzDFCbtRpPIEz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpmW7ASkyqgECoYKoefGdM1r8REU9hhjI12K6OaciaveiZsxWcVtHOkW/btL/608ojfJrB5y4khOsC9FS8ZPwHlIXrwBz27yuKm4HEuCd0ZKTPbPi6kEWjOEELacQ+XJZ0tDLkBYVgEDpj5ojRuTR3FjUzyqP8Vrfg7JbyXW3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6RdtQbr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6RdtQbr"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48e82c23840so47141055e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779353590; x=1779958390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLFMm/iBCeKuifSA9r1fgWxDtRtuFPgfT6+/MU5KPl4=;
        b=P6RdtQbrS+5V60HN94O/lXdQP0/yhZ2tfUp+fAcCa4lCf5hV5NRZYNVtQJ/wersks+
         v0bJiPt0mZSazADFErrZ2wOwgv/R/hKYSEwcn5TUkqstcrqkUZUCabHhIWlw7uN6aY6N
         18f+/p21iX+P4wDbCdmDVT1GZ27sIf+HV3IVSbiJL83grTYrdhCOGgKSH6TdRuJOsJRh
         KBs4PXD/vyEWh6yJfWFz3qx5MK+MZIXOMtDPH5jqgHOSTmgRnAnXo0EBykYUSO+T9BsL
         SFgB+QVRvJ3rBgrHi3GK3W4Cy63J/8ijaZWTGmXxTrEquqvQC7rSW5wA8SX0MhnlV+PX
         WXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353590; x=1779958390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLFMm/iBCeKuifSA9r1fgWxDtRtuFPgfT6+/MU5KPl4=;
        b=i5HFgEPAnAosw7mrmklUlA9GfwfQDbKbTuLuAZGpDHF0VdtjmnmzyyNAa5Ps+jPJhH
         aYYVeqogwRPhfu2lUlzquaXHD0FM0DfEvHDeX25p9BL8Q2006tkAXgOoDtYM8AgDxO/h
         nqW8R2dj3SoW8lqPntYr6e+8NxMqm3SGR/wSrsiSpnx9i3OzYqe/8LC39/xxeoReQ8sO
         t1fDrh/uZPSX64YHjSqMKPOKrE9PfgKHtXcK2ZH6M31mSix53ZeLKGFtY2ukMJu9vSz9
         gDK6IXL95oN8hUKdeUuBGh/Cuq3gboYMcGsGdogm0huf0HvpSylhTPQAITHdPTSpn0s2
         7qNg==
X-Forwarded-Encrypted: i=1; AFNElJ9j+CeqHiXhOyiBsOO1uV0Eas1dTeLdbpB7DHUW1vEkRRArfECVbu5zB3BgOJx3BdqneEIuzyLe1jcuCXE4@vger.kernel.org
X-Gm-Message-State: AOJu0YyFlJgKkb4DdoWbsibI7+ymRSd7IVkSwTZFXtHbUT4cX8csLQol
	CBI9B3bypkhhQnLurolHsdsQCSCB7tTR+5Re4IqrHAQDfjdX3T3zv4EO
X-Gm-Gg: Acq92OGSeEKz84Mvx+j8RDKwrImjjgxUw37S+YSmqsLcPYC46S98SDDLX2hfGtKouBh
	L26AJziRzBTODU5h/zxhzspXGSOFgvfNGGFEAqvJegLACjABzqIY3Q8TiZlmzOdr72exVx9YROh
	UBoBBM+DTJk+SevTlZA+6ybNLo6MMozf2dTg81OyqWSsWWgmpyqDfAF3lDaNkJ6ZZ+fShEN947S
	XTYCFR5y7CpPhMoS7F/ikpGIpORTUKTzrOb2743s+B/CbdWAUavb5UPFbO/7CSNfHpk8fPruU1x
	dBsdkBkE58cMIrFMyQgRkgbfa2z4vsio1HYrSLM7HbTJfjMT8InwF9fQhJEWBLgh/Kp61v3iOgR
	giV8pMVlFHkitwbgJfX+HRj4GYR3NC2YDtstLpASioEOXO+HSpk96jMRPIhagTOlq73U7vPvFnn
	5CbPGS5cjFhhjop21T4SV2H47HwJFFKM50a3VwYUZcXPN7YVTzpbIi/9XpLKaNzcovOrcEXX4=
X-Received: by 2002:a05:600c:548e:b0:490:2238:4021 with SMTP id 5b1f17b1804b1-4903605ab10mr26339485e9.8.1779353590237;
        Thu, 21 May 2026 01:53:10 -0700 (PDT)
Received: from f (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035ef2d93sm14280335e9.9.2026.05.21.01.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:53:09 -0700 (PDT)
Date: Thu, 21 May 2026 10:53:03 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Bert Karwatzki <spasswolf@web.de>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
	viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
Message-ID: <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
References: <20260520225245.2962-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260520225245.2962-1-spasswolf@web.de>

On Thu, May 21, 2026 at 12:52:44AM +0200, Bert Karwatzki wrote:
> Since version next-20260518 (with PREEMPT_RT) I noticed that my debian stable/trixie system
> would sometimes hang when booting displaying the following error message. After about ~1min
> booting continues to a rescue shell where I could save the dmesg output (The output shown 
> here is not from next-20260519 but from a step in the bisection).
> 
[..]
> So I reverted the this commit in next-20260519 (to get a clean revert I needed to
> revert commit
> 36b3306779ea ("fs: cache the string generated by reading /proc/filesystems") first.
> 
> $ git log --oneline
> c7321982a5d0 (HEAD -> rcu_critical_readside_bug) Revert "fs: RCU-ify filesystems list"
> 16ff8d6e7c28 Revert "fs: cache the string generated by reading /proc/filesystems"
> 6a50ba100ace (tag: next-20260519, origin/master, origin/HEAD, master) Add linux-next specific files for 20260519
> 
> With these reverts next-20260519 boots 30 times in a row without error, so
> it appears that commit dc651e25a6d2 ("fs: RCU-ify filesystems list") causing the
> error.
> 

I think the patch below will do the trick.

If someone wonders how come the missing unlocks: the original patch had
them in place, but when I was rebasing on top of the RCU-ifing commit I
figured I'm going to do guard/scoped_guard in there as well. Later it
started failing as the compiler did not like goto retry out of a scoped
guard area and the unlocks did not come back.

tl;dr there is definitely my bug here and it is most likely *the* bug

Christian, can you fold this in please.

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 771fc31a69b8..8f17c0abbc95 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(void)
         * Did someone beat us to it?
         */
        if (old && old->gen == file_systems_gen) {
+               spin_unlock(&file_systems_lock);
                kfree(new);
                return 0;
        }
@@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(void)
         * Did the list change in the meantime?
         */
        if (gen != file_systems_gen) {
+               spin_unlock(&file_systems_lock);
                kfree(new);
                goto retry;
        }


