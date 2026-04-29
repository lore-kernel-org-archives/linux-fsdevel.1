Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B466E301471
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496200; cv=none; b=FBQQkssnIloczsSdQOvyWWhugDrxUcPaiAKYSSwSkzIzQ9qHy1qjFhgFRE5PFTPl4oR9d9ORUhsGQYKs8CJQMsO6efv1cTx7/INnDP0Fotpe6FbUyYWFp71BHwHUqBKwFcF1E/gC0Gx4KJtaJDTK7P3hDVoYnMP+0k2dqgK7qu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496200; c=relaxed/simple;
	bh=KcM6bkgoovknVoO7DyH8RZjp7sIX9YJ7+Gg8p+SHoPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGIpP3PWe5A0I5yFLD36W0r2kB84sNKuwdNzegUORVD0p+sjZR09vB2PweqTPEpxhG6mgU7U4vaF/zS7Zsf8dRTtzMMswspj3i46nHTieqJMGhj5/5OiD9YwsqYduKi0+pHwPkm+8oS1g3CHt3CGzg9WZTTt99JLltGX/0l+Y28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o7ri0tpI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7ri0tpI"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67790429f71so477281a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 13:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777496197; x=1778100997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb9L8WftaoHrfrq4miMFqQPjpoEXQCa3yqkZ/uqlKz0=;
        b=o7ri0tpIxidoqyCZodGZdwHDV05ZqwchcenKXVoZ3C5KMYLzXZpuAtK+KsALM/VFLL
         7f/hPeSokPE4n0/ciMl7XYdpNWZHqjFev35z/QgSDuW8arSt67hT++VoKYBcxWs67Okk
         0hucZSGyuMKfXxbptbDM8a1ShMGaYyjdU1c//vpfUf+5q/X3EVZseLa4JToW3fjnCda2
         s0nBSUSZA4dosJ/C1OrHd1eDjkJqDzxnrWO1nlx00TSlLQwpYPyyH2fRVD0OSs5GPe4C
         whYlgzA0i0tagfGZkzSrlyUq/+HbwDlg3L95+pLSk8VxjbYxP+D805jeH7tv078/Su/k
         xkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777496197; x=1778100997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vb9L8WftaoHrfrq4miMFqQPjpoEXQCa3yqkZ/uqlKz0=;
        b=VH81dKM2/82q5Em/LyJ7hYwk9kDrmS94rjfRylCI5mXAiNf+X3HPLlzv3RoPoX/LEY
         bIycfGLxIxsMCQuCSVasC1azhn1DFNOW6SKoaS6v90rSh6OsPfmnJwqUITgmIARjhLQV
         bqmM+gIFfdUTS0wd1GXS94ZCPzOFl2NSPhMxsKwdCZ+soIX/G1keZw1NjQYfu5KCUgvl
         tg0igQIfNrwGa56ZbnZL9lcwaX6poig8WQmgotBbyRSvILJ9x9wSjmVJVrmz2ALCguVS
         xsSgSlwSq/P4H+HR+0WWs6nIUOVbBPFcEWmsmCwxh8Ld2knbk11h84lxosq0pXQaApEq
         oQzw==
X-Forwarded-Encrypted: i=1; AFNElJ9dL68IuHUN+xamvzPsYvlxpJ68Fx1v/w9U/R8tqVLIZ3KIP2I4QqxnV4lov3IrnpVX1YfhVQgbxf2jbyNF@vger.kernel.org
X-Gm-Message-State: AOJu0YyQaXlOdIaO+WUBFyv/RbSA6Oa3BRJiBiMWVXHDDZJ3Q6jGB1I9
	a1YW5U3iiYY0H8iUFCYD3fUbxZ7ld0sqltd9ad8kzRiiE9l5MrVJw0vx5nDpY6u5CA==
X-Gm-Gg: AeBDievucfCcbXy0ANuT7zLo0bTYHe5nnOv8hWanU6tws7yzi87V1VK6EjY7RC8+YIb
	m4cTWpDaJtXoG/KbAV7odabtZz4/j6gqpXRND0/leaPbOKnWetm86WS6XEJKsio1WgAp4hhKQDb
	MPxwcSrNAr8kwA6kFLmcsEC3hAQkwBCdEjjgt6lXJjwGPs2Luu5hJTCnixAcQwLowGgVY/WR+j6
	Zsh2aIn3DKa2le2i0Tlgqn26053ZoZ3GHONNXLLPsOo4EtPVofvDTYnORO4J75a4bMuRuVszJFj
	dDUiqyQ5iNdm3Gcjp9rrpsFFgl0S8aCoB9Ayj2Lc23MDpDn9S6ARsRqvK1qx30Y/D6HU/CShF5v
	dVR0Z+9CLTV/LqjaZGLxARMPVe1f+e58MeJcYxUElfyEeVdwoFKNCRddWhsgvUk8Q7MWVKZUrkL
	0Xan46XIBl+DdPVrIgG72KgQDT8U9nW84ShWezlVF4Wn97+B+ISHzEG4you7zFy42zq3+LiDS06
	VfU8DOSJlvD
X-Received: by 2002:a17:906:eec7:b0:ba7:8dd9:cede with SMTP id a640c23a62f3a-bbac4bd280bmr18426666b.13.1777496196643;
        Wed, 29 Apr 2026 13:56:36 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb980a6f9d6sm140892666b.10.2026.04.29.13.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 13:56:36 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:56:32 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Quan Sun <2022090917019@std.uestc.edu.cn>
Cc: daniel@iogearbox.net, bpf@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Null-Pointer Dereference in bpf_remove_dentry_xattr via Negative
 Dentry
Message-ID: <afJwgCvB3oV1wWCV@google.com>
References: <1587cbf4-1293-4e25-ad24-c970836a1686@std.uestc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587cbf4-1293-4e25-ad24-c970836a1686@std.uestc.edu.cn>

On Wed, Apr 29, 2026 at 04:59:01PM +0800, Quan Sun wrote:
> I found a Null-Pointer Dereference vulnerability in the Linux kernel BPF
> subsystem. The issue is triggered when a sleepable `BPF_PROG_TYPE_LSM`
> program is attached to the `bpf_lsm_inode_create` hook and invokes the BPF
> kfunc `bpf_remove_dentry_xattr` (or `bpf_set_dentry_xattr`) using a negative
> dentry. This causes the kernel to dereference a NULL inode pointer during
> lock acquisition, resulting in an immediate kernel panic.
> 
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> 
> ## Root Cause
> 
> This vulnerability is caused by a missing NULL check in the BPF filesystem
> kfuncs for extended attributes (`bpf_set_dentry_xattr` and
> `bpf_remove_dentry_xattr`).
> 
> 1. A sleepable BPF LSM program is loaded and attached to the `inode_create`
> LSM hook (`bpf_lsm_inode_create`).
> 2. When a user attempts to create a new file (e.g., via `open(...,
> O_CREAT)`), the VFS layer allocates a negative dentry (a dentry that
> represents a path but does not yet have an associated inode) and passes it
> to the `security_inode_create` hook.
> 3. The BPF LSM program is invoked and receives this negative dentry as part
> of its context (`ctx->dentry`).
> 4. The BPF program passes this dentry directly to the
> `bpf_remove_dentry_xattr` kfunc.
> 5. Inside the kfunc, the kernel calls `d_inode(dentry)` to retrieve the
> associated inode. Since the dentry is negative, this returns `NULL`.
> 6. The kfunc blindly calls `inode_lock(inode)` on the retrieved inode
> without verifying if it is valid.
> 7. Attempting to lock a NULL pointer causes a null-pointer dereference,
> leading to a kernel panic.

Sent through a fix here:
- https://lore.kernel.org/bpf/20260429205438.2601592-1-mattbobrowski@google.com/T/#u

Thanks for the report.
