Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6201138CFF8
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529407; cv=none; b=Be2F3dtFDzw7IhqqeGKkgwXVM9PR40JUeeaZ0BW05MvZNeCT8ZV4W/lhaCNuuTX/i2VYzQv+3Oe9PKspNuHGivmPIQ7iKn61Vv+rVYWas/p7O5O9fcNtpDEMbuUm2kc5mjOFYJfD5/ikn8f9rPGUXuvc/557Kys00+bu1OPKsHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529407; c=relaxed/simple;
	bh=hUkGjqs6qcYuVfKb4FdP0YcKEPyEotgH3ArbHxEaHSc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=RFctILZfR87PWCZBTbf4LCIyaKHEhZ2DAam06VN939RTSmkmBUdWHoy1qzdCMORcCa7gEuwMIkP22c5EaZW4NaTzT6ciiBQha/vo0JgDcUEWyz9r0oX8P63e4mAQTJeqD8kf7jd3LvfHIx+iP7bXIIKObYJE3Pj0R1xfCJ4iwOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hlpw/N0H; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hlpw/N0H"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a0299c787so36366385a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 20:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789529404; x=1790134204; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Til9bgq45pMcrN/mAeyzZMNqicB3+Nb642mFgaUojyw=;
        b=Hlpw/N0HkHsQTYtj7U049Cw8JPDLlHumzPZoCMRvVh47ABqMOdKmPjM/3x/3R3bKBO
         HPYs157NAxLqMOkhAMr2Ta2nSZLPD7YObYHyJqdDqTOTlPlmTwxtC2b2g9pYqaGuhEtK
         6ikSZnxGyzN9HhUvPjqqjnENe2HJe57yFSgPmRRS8TOc0dkvWxRW142W/TKz4GTu4ydT
         R/DgB+IeB/0q4CS9LvEEPQsduNBFZ7aMdxBiesFkoWEZOIAjEhwyqbWzvASoni4zjgOK
         kLJ9oQXTHDilMuHbvuc85vKEhw3XW9rpt8vfVEbxcZOyryESZG2ogmm2hj++uWprY7QO
         Yl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789529404; x=1790134204;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Til9bgq45pMcrN/mAeyzZMNqicB3+Nb642mFgaUojyw=;
        b=dh6bhty0HHGtISE/2OaieTaJo+VnurJqntL81d1GYPmmZO0TlRR1C9bDjgk/bta9am
         pVAEsyH69yEAnCdHkJDCmtguw2bO9w+aYk9Kj1EnXIg+zt2HpH1iLgqwIU+p9VhanW0E
         ZUzQBEF6xoTu9LuEiGfP9AAk8yyU36AZ0lh1W8tPWfMjLQUKqAln2cheYEMX6Efjhg8e
         zE6NMyI0E6r/6dJ5xu5sQAaT/7QozJLWWqDJ2bmW3ekjpMeeyeWNhAXWZI+JZIeUPNcA
         zWTSFlTHnCLTq72hvmR4JXoFHvqmplKR6ujpZVHstRHgX3I8GFyVAmnARLh21rwZrZXB
         nIIA==
X-Forwarded-Encrypted: i=1; AKwUvBwNKdWW74Mmpno8P25bqPdJKRpeKlNNin74qGBgDi2dBFUnxtZI92vAW32tGX6i0p2VG8UVVXcWl/ypmgAr@vger.kernel.org
X-Gm-Message-State: AFuF++lmQ+mRPHJEXTZaBNhj7jyGG/hgdOD6xl2ugv4yKIuzRWseQDBk
	gfbPkMOc+CqNSylChWnViXijWtfk8eijpvgG5k5ZgO1JdUbBIbSsaRZ//sCwg+l84w==
X-Gm-Gg: AYBFou3u3jrMwC8OVCaLNCBOWB8eeatBEkl2EkyFnujZjZiNGCZPZLOguyfvkSSGh6t
	atipbLnAacYN42bb9iCUzVFBIQFnC/DpUyj6QiyPrRt9sfGk/9zeV72/JIFhUOu3xwZ8Wm/WuvG
	apeJns+NABstRaTFQ/BqJqRU226GMpAzdahRQrMj9ee7pEOB9XrQvjOZxxcPNY4s/e17XyAFncj
	R5evFRYwQu2T4teoaTw+0i88CxMIK/53JCXgGjp0i56gv/T1EL/6i6Td11KR951kTqvcWE+Mxh8
	p6mex5f/Nrxtce7GEEKqgGtx+EHtOUINkc+A2w/x5gv51EEDz9fhbJ0Gc7j4bs6KXspw+Ig7b8P
	V6sUeldFdSzw1eP4Rj4LIyt1Jjax8a6/5ndhKJrBjWRoBIOlL/6gopZlJFPZ//eugbs6G1oJ+ax
	R4MZfalLNmXMWaR6Kj2b7Em4S1pxMt4RhAlg9hiuUeCcieC0BCoA59k7uGenNIhnDQETkSntny1
	uvESIkMf4dxxaqhiSC5jjT2V5OkgkhY+H6GAx0rjzIPKziHTTb4o7/GSvWgT743IVmqiuU5hDE7
X-Received: by 2002:a05:620a:4709:b0:939:35e5:94ba with SMTP id af79cd13be357-93bb766747bmr170559485a.6.1789529404169;
        Tue, 15 Sep 2026 20:30:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be648e5sm15710696d6.8.2026.09.15.20.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:30:03 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:30:02 -0400
Message-ID: <d852b4ae61860446e038f69541f36f9c@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260915_1728/pstg-lib:20260915_1318/pstg-pwork:20260915_1728
From: Paul Moore <paul@paul-moore.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, Baokun Li <libaokun@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] selinux: preserve user SID across nested backing  files
References: <20260829213256.51527-2-kmehltretter@gmail.com>
In-Reply-To: <20260829213256.51527-2-kmehltretter@gmail.com>

On Aug 29, 2026 Karl Mehltretter <kmehltretter@gmail.com> wrote:
> 
> SELinux saves the user file SID in a backing-file security blob so it
> remains available after mmap() replaces vma->vm_file with a backing file.
> 
> For nested backing files (overlayfs over overlayfs, or FUSE passthrough
> backed by overlayfs), user_file may itself be a backing file.  Its
> fsec->sid is the SID of the mounter that opened it, rather than the user
> that opened the top-level file.  mprotect() then checks fd { use } against
> the mounter SID.  This can incorrectly deny access without a domain
> transition, or check the wrong target SID after one.
> 
> Copy the saved user SID when user_file is a backing file.  Keep using the
> regular file SID for the first backing layer.
> 
> With two nested overlayfs mounts and SELinux enforcing,
> mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
> mounter SID.  With this change, mprotect() succeeds.
> 
> Tested on arm64 QEMU with a small BusyBox initramfs and a purpose-built
> SELinux policy.  The original test was also repeated with Fedora Cloud
> Base 44 userspace and gave the same result.
> 
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access checks")
> Cc: stable@vger.kernel.org
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c          | 9 ++++++++-
>  security/selinux/include/objsec.h | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)

Merged into selinux/stable-7.3, thanks!

--
paul-moore.com
