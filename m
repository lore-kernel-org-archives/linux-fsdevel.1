Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868B3E866B
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464206; cv=none; b=SEgiDdhiX03DzKTqMU7BwzpWgFEBoEXKe9P0Mo8ZrbdYDyKQ/Gdv3AQ04Mpb3SKAkat2n0GSedrNfuuEoQsYXRhDZXWQUcuvbuAombrZg4wMYifP/YpeJ8f7/RvgD6NgOQzAknhlkYQSf/rSmgz1tSDkdDZ8E9Xm7STVYlsPUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464206; c=relaxed/simple;
	bh=zwe9FjlgKhgLsbgTZ5KD7tV0Va7wCEjGhd5pHgJKyts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZ44yyjhgNgRVzRRit88F2ywIcdYHZSYEQdDeb0nXAS7hpa6kc7DwM7n8Rd70SCQALUUmhMccOlbeu0TdMkeX+NqEUt+fE4NCu1PLhvMfobMYyd8EUj9PStkdxxwxgykeGRnJUY0aYRO/BJor8nOXdvBck7oj/2+Kr8VQg1qOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbtT+Prk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbtT+Prk"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48436216a98so190747f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 12:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788464188; x=1789068988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O5KqwQ8QeVoPOFqAteEdtspPaAzg6vItlz93/SfHCR4=;
        b=jbtT+PrkgmMD+zfP/77Hg3KGyIFBoX0mECwYfptj2Y1nwof6GiGPc+MXTWqEesexhi
         4YzuTe+QwAfC7HjJTHONS6qo5/owuhn5VY2Fuvj0BOefteMzwmYO6AjL6DO43HGGAFQj
         ngVVr2aAZGNL5gdcoiWZeCUEYiof/od1Hub7dLgO5cBFn10+lKGF1x6X8UPWa8BWl3Zq
         VkLo9R4C3KxbPwAect3UH+sc4ObsohAFHnOL1SzME9F5Pr4ICVwxQR85PGFZRJnXPoZW
         VGnk5NbSjVTWSRharBu8MQE4Up8nIKiI67UEuu+41uki0a3bJ/4MLXXYLqiHwk5Qw5I1
         74Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464188; x=1789068988;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O5KqwQ8QeVoPOFqAteEdtspPaAzg6vItlz93/SfHCR4=;
        b=ZYpIiK5CYEaviziVDKSf3JonIiIMrCQaDPJhQfsJSqgngpRSiDYkcxuQ8bxRIhiZlH
         f46bd5BJeZWRw4lbiYrIC5w4ZIxYLVNorq9LNLhJUahmRUSWIvOcZp10UUnfqreieE1s
         +tDfogL+o8aeBNJ2JbMEGRf/GwfzNcO7ZJ019fgVNzAGJUGTPwgBXjWGb3qb2AuSCR9p
         Tkj5XwHzYM/WSOUAf/ACCrwG9R7GTzqeeh58ZYv6LDjfH4HT0QrVjG/OBWZI7CAPetE4
         s5omIoX6pk0Bbdqa9QxY7qeCLVhe+M7AuYx3Nrnl352YGSMBRB2puSJOSaMYVNIMxYgx
         enUw==
X-Forwarded-Encrypted: i=1; AKwUvBwQJCkRsPOoiWnf528ioDTZfo07JZoMKAAjzbJOzOXfOM2baNA7ZZp8FoDT62LULzjxJCC7kdMWtAkFyQIW@vger.kernel.org
X-Gm-Message-State: AFuF++mFOa8cATv5E+QHRFYl7Ec+gnQjLWi/Hs8W2i4FHADSFX11cqyc
	280Gethk2NP4SgpWPZRg2FkEXqhISiDYN90ZFnNTS4F4BVwtSawc6ROY
X-Gm-Gg: AYBFou0cG77z9ZCvhLS6OVaN+BA0rIwDeYJngfLIMfOY4rcY9q//Nvozb8ii0h2voWS
	n+sbvhm1kXti7ou2So40F/xZfWSGjxpSY6DiDp0pzR9UVZR1yPw/QWSm8fw2GdBpLCHVc+8v6lm
	hicWQmzwLUUmka0eNAsLBEanKk5if0VP+fw6sKz/LPRg6nWlNhKHo8Jbagd0EUMECkF3Sj+H0NX
	vNgnFh1mcbxwpetQLYD+nLNeaDYzOjTCh8gDmAD8BuCRqeNW3Zk3Qgj3W/W1JpxG3Z+Zq8j+l+s
	nL6X4XPSdlUA3L3Ow2VfeS9MCjYpirdSvezEehnzdvVo+AKAkfTIlP3QkZ9uHMOGsjO2QoP1QId
	7bT+3WrwqR2Sc3lTcDwh/gIEMHT8/HaKWBwIjXZuve9VmJyWNyNROGRDc3cF9ft9mxoEfO6rfvv
	qtWXCYDc3SGBnKp0PgNCey8ncLEZACgCskgdMDfpKOfACloO2qiKDNGD8jql3UMAVpEpLWKcSab
	C4OBAlaTcqoBknaMwS+GltuOh+XIEhT/4ZV8txGb/AfzUxcBPLSxnkI+ZJeBguhZcar2ojGE8ml
	ZZ3TI7m6xrX2nHTbX+18C+KuZ2oFhR5HE+XGFf6GQV90pkRZG1knnKruH8XphPsF
X-Received: by 2002:a05:600c:a0b:b0:49c:cee2:1697 with SMTP id 5b1f17b1804b1-49cf8262133mr3691965e9.16.1788464187671;
        Thu, 03 Sep 2026 12:36:27 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588390e30sm768665f8f.7.2026.09.03.12.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:26 -0700 (PDT)
Date: Thu, 3 Sep 2026 21:36:24 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] super: remember whether freeze holds writer rwsems
Message-ID: <apnKz_3xD-zbw0dM@gmail.com>
References: <20260903060855.4610-1-kmehltretter@gmail.com>
 <aplro1ObQ5YNZT6R@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aplro1ObQ5YNZT6R@redhat.com>

On Thu, Sep 03, 2026 at 02:44:19PM +0100, Oleg Nesterov wrote:
> > Tested with a test-only KUnit case in x86_64 QEMU on linux-next
> > 32b6ef9a5d0e (next-20260902). It freezes a writable ramfs, sets SB_RDONLY,
> > thaws it, and calls sb_start_write_trylock(). The call fails without this
> > patch and succeeds with it.
> 
> But I am curious, how exactly did you test this?
> 
> ramfs_ops doesn't have ->freeze_fs or ->freeze_super, so
> ioctl_fsfreeze() should fail?
> 
> And how it is possible to remount with -ro, reconfigure_super() should
> see sb->s_writers.frozen != SB_UNFROZEN ?
> 
Hi Oleg,

Thank you for the review!

The original test called freeze_super() directly, changed SB_RDONLY,
and called thaw_super(). 
Ramfs only supplied an initialized superblock. 
It did not use FIFREEZE or a normal remount.

I have now tested real filesystem error paths in x86_64 QEMU:

Filesystem  Baseline                         this VFS patch
----------  -------------------------------  -------------------------------
ext2        write hangs after thaw,          write succeeds unmount is clean
            unmount gives three
            rcu_sync_dtor() warnings
NILFS2      unmount gives three              unmount is clean
            rcu_sync_dtor() warnings
JFS         write hangs in                   VFS rwsem is released then the
            percpu_rwsem_wait()              write hangs in JFS txBegin()

The ext2 and NILFS2 tests use real FIFREEZE and FITHAW and corrupted disk
metadata. 

The JFS result also shows the scope of the patch. It balances the VFS rwsems,
but JFS skips txResume() after seeing SB_RDONLY. Needs JFS fix.

Karl
