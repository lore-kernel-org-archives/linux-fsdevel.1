Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BC43783AC
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jul 2026 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783254920; cv=none; b=SbJgomcb7Ew58mPc0hbv4cIOEBbtp+Ct9oumCrzXrAJtdhoRXpA555q0hPBY4MlFNBLK/33TuowoIMxlYq+jlgQ+xjFQyW51yBvhM3v7Ate+bTWFt32hWozCk8fspRarRRIqxBnq3BLhTIqY70gl3FfO4GstMjjxlsWqalNLHJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783254920; c=relaxed/simple;
	bh=og4tc1Ixbb1Lb87pDD0lVguCyg/WWoBV34QfrHngqM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhCtnKQtRsI4koLrJ+2gjZHeK5xLpCkinEIkzYxJfHfsPKolJUnMlkLuqnEWfGIfOJaNYC1SOowpPfuhWUxSPBvQqmqR+iXP3QAXo00T6WplHdbS1D0uzf2eGcd0aUnuKv/wrAkBk66IxPFpcSnP61gyhky5q/mK7stANkYDZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5G9fj/Q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5G9fj/Q"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so20519515e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2026 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783254918; x=1783859718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHxGta1pA0jKEWoTfFEAv0UuPjTotnZKIGieZiQ/ujc=;
        b=C5G9fj/Qk4JA36wV8lVRwuNWzthXBpoHoiqfsxne1KU+UoDE2/HbqK4EVDUVkl0LdZ
         uBhYLZdXuzWfnFtd/IT1nBeeMGHPI0XYiPiL395QwPFV6U8zoQAhRL2n0S1DLvU9GiZ5
         ksuVUuN2rUsywHdiIqyCT2Yh1mP4oKBoBCIe6pF43dl0BM1suWy1Rn/RBD007sw8e3Ew
         v/TCrJ5YJ88aych/qWH7ZHJHdQ0TzDmTnOkONOWBebHNED3LzEqvF6re5TrRa6Fq/eNx
         rA2Ti3aO7PBhthvKO2sIZAj9G5SaGCT0Z83xWcOwAqga8mg21fraFy5gH7JhiCtDMVfE
         49Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783254918; x=1783859718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wHxGta1pA0jKEWoTfFEAv0UuPjTotnZKIGieZiQ/ujc=;
        b=R4psmbOl1h+2vX4fv6N83pqQ9rRQLyGUAb1GN10q7GGO7SHz8EUvqMCJQwQ4anmPRe
         jQtU9s4mfJ/M4Q/lN3OUp3MG6gyHnF8PMaXwnAk7N72WgfZS2F7JrtwUWeiQ01P3Oco8
         IAsvhAx9/VMu01046QeQtcMg3H6v+C7AIslWT6CvxOJ418q8f5SpEvydfCKS6Re3w9bM
         jeqRXr90JRUgt3Pva/bwzwQf1FCk7G/+hjokOiJmF7Mzrv8T8MA5eqS8Qy5LvxzEh7dc
         WfY+5zOUlb/VqMyzJ6xQ2DwJqQjO10ab5fn+zhIi4MNKaZIUnjk+qv3/Lo3H7WXw7iLk
         taUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+eb0E2FqMdGBK8ZUX+6ySLemULNAkU2UaH+JCWIpsC6BdjhUU/FESiDnmY8dRLgVQ5qZAEj4qlv9ITNvfa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+1TLxxgR85h5bMicAWcUan120xZQgMk35qiSftz1OSQcT+lw
	+F6Uo0qU6XsakS5vDqEMXN43/zVHBLxhPKo58vhcei6M9vS9q9rRaU/b
X-Gm-Gg: AfdE7ckuUY6Tl9M5xfBGHMAgjnRVp49GoHUX+hRappABKCXWWqZGQzqGNcghLBDX6Hj
	FF7uSkLR/QpiIhIh0xfYkDl8S1Gh66yFahlXtuTJ+E/ksldkhTZgXFOFEIRu2p8gJEVLX5jvxsO
	FrqP7MuyOWPlh65+vFPm85YcOqYFZa9mIXDKQfCAtmnZutD4ZhlN1wyO16q5/yMK3iYLhj9dSXc
	jcscIXv2Vx2yXQz8xr41j1IKPBZrGY6Q4HvnRJfT3qfSm8oNJ4WmhfYlBjtC3b5IS8mRESAVOM2
	thl2KFfTUFE6Ov2KSWmQyOv3pW9OR7GghJdb0nOblnCt4rMSHGw+fMDBKtFk1wwgdR/os6LR03L
	LlH0yPsx3DAcfTuQh+R2ka9eBEffNQKRg7NXf4uL0bzcExHu2iDeIB5IOZ9UMIqBgCPz9vpFbSH
	/MylWLTbAg
X-Received: by 2002:a05:600c:b8d:b0:493:ad1b:b38d with SMTP id 5b1f17b1804b1-493d5ff8f97mr30004695e9.37.1783254917425;
        Sun, 05 Jul 2026 05:35:17 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493c636e9e9sm275072695e9.2.2026.07.05.05.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 05:35:16 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: jack@suse.cz,
	jannh@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC v4 00/25] fs,kthread: start all kthreads in nullfs
Date: Sun,  5 Jul 2026 15:34:47 +0300
Message-ID: <20260705123447.742980-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian Brauner <brauner@kernel.org>:
> We now also warn and notice when pid 1 simply stops sharing filesystem
> state with us, i.e., abandons it's userspace_init_fs.
> 
> On older kernels if PID 1 unshared its filesystem state with us the
> kernel simply used the stale fs_struct state implicitly pinning
> anything that PID 1 had last used. Even if PID 1 might've moved on to
> some completely different fs_struct state and might've even unmounted
> the old root.
> 
> This has hilarious consequences: Think continuing to dump coredump
> state into an implicitly pinned directory somewhere. Calling random
> binaries in the old rootfs via usermodehelpers.
> 
> Be aggressive about this: We simply reject operating on stale
> fs_struct state by reverting userspace_init_fs to nullfs. Every kworker
> that does lookups after this point will fail. Every usermodehelper call
> will fail. This is a lot stronger but I wouldn't know what it means for
> pid 1 to simply stop sharing its fs state with the kernel. Clearly it
> wanted to separate so cut all ties.

Your approach means that you introduced new degraded system state:
"PID 1 unshared its fs_struct, so we switched all kernel threads to nullfs".

I don't like this. If PID 1 tries to unshare its fs_struct, then, please,
just do nothing and return error to userspace.

(I already said this in one of previous threads about this. It seems
you missed this, so I'm saying this again.)

-- 
Askar Safin
