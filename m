Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77237E30D
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529170; cv=none; b=m2HKvvVXQSPLw6HAmlynbSnK448MJ+IQiRePzoaKsBko5Sbfc3ls65ngYE34GPi4I445wYLH8M9ORnF1u1Ckr/+hGFTGnpxZF13TkF945hEkO7kqosHjnEWE1wxxRAfO1KO+9JkYzxdQOoZb53ZhSXPkm8ZlU1kjF+Upo4zEo4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529170; c=relaxed/simple;
	bh=VcQxfTFcZTn9ONn/zVhnpsD0/DB1MuCe94obAIHqHbM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=k6hEoIlWUGMCwm/jViIj43OE4nhX1m4mUnPmRhB3ATpCRu8E89VPKwNPTNlyGHES2Xw0i8j7anT17YvCdAld3clKeaSTwIOUAHfg1/cLtmVLvSKBnxi2OWtMGQorGmbZ2zXoY6fzQ6YeH8rdTb4hrsYgCFQH3XkFBgUTDUNaOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=O1dCdV6b; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="O1dCdV6b"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so53240196d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778529167; x=1779133967; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LL+UPYnZCOjrePrtqK6xOAZ5G7o1QmvEfzGseYDEIaM=;
        b=O1dCdV6bVCNE0S2myy/TKrzkIxIwfCo/LphzIaKwCvVQeB+DzL4643965DQCBP4/OL
         UA2ARqxufDGtcWp73ZPeUbFdiEuAv6eaHc+UR8k/qQSQb3FKvmZQ6T1MPDkXjIRcbL/W
         e9x3gemRAy+fVWrZ1pXRYxd44F+8/HuoDe528Mxq/P9pFaQDxqAkMZ9NSMponXPGQKRw
         SXYZ+0xIMxGVKNuvOC7zOM51JfdDgEXdAmwVbXtzD2TuPhG7onHGUhCpVSMNfWarhFdG
         8o83kvZHZ9OwUNAq6CaF9Om9E+QlEL4KKmMYKwepIMqeabRywZ1/DVdgA6EelFx/f1SV
         KMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529167; x=1779133967;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL+UPYnZCOjrePrtqK6xOAZ5G7o1QmvEfzGseYDEIaM=;
        b=njDNrcvSbPcEALnHshQGT9ZU4KOQcIdCtpGC6z8HaMjHLoUjW8pStFW+EuPYR+cBEk
         wmDYYRlHSi8Q9vOhy3ZnvuajxyUT/yvesfuXmPGnEgwQcrjVzsR42q99mjTXbftO8oyj
         pjs9teLb9n8TAhL1zqp+Q5pQGgPje1w9vdyKmpZ77mu68qxu6OHbQQLEvSsc1E5AY1wm
         OaT8alpURPkv9S5uxmLjB/Q5MnJyyqjiElc6z2TDa2IIrU+Q5hRgiobPoKsWnC+JFr85
         sKqIIbicRdHAPTrievm4V6KSGhTfPBybZ6Rb70zcotw2kHIvPMY0JFcARAfwfEDZbFGd
         0R7w==
X-Forwarded-Encrypted: i=1; AFNElJ/lZyVxzZGrR4ensIM8i4JTKjGnL1TXVjvKeuKbdP3lKZouy3iTPp4sPyEv+vtkIPfwayidBWSN6uUd/BQ/@vger.kernel.org
X-Gm-Message-State: AOJu0YzmR9MVh2XsE2/IM1iepoXBmNLhnA51LNwq+YiaaQTh1kxReFAN
	flO3OkN2wdUFrX5K0rkZeOl+L/75qyiq5PQFswXLHeDEBZNgScmjLU6N5XD2tdnCag==
X-Gm-Gg: Acq92OFHKySt2DJGB0vLACBFZqHRbTIJpgPzWTBNBuVWutECz7IYK9gT0eui0LzQdzH
	lcC6ASMryACs34sdBzG9/C8Gl8+af0JOG8G6+4RrqQYwyyxIUwE6JKzeB/O89+slNN93WejAACL
	yLqAzSH2EkGIA0DeBUKqRAPMMKRWzNB/u2GvRePlzfu1oj78czNp7Ues6X1xFHEWgRWOcdzC865
	V+CDgjMJllTjAD6/HeIqSEEt2K4gNu9FciF+cefQOf8JdSeWJLr4fPva+VZ0cm9o/c7hPLx8DkV
	GZNDQVOY7+wP3AXUTboptZl4GomHdgap8KYVmbFL2Fj7jJBCAxSFVrXt6SKpGTB+XlYcXjw6NBu
	9NblY+iEWx3KHaJBjv7JRPiuL4SxnO9O7ZDth5vfJwV7BtOMr/OfU0HBG2JKE3bOptei4w5jIys
	pTBGlKGSrR2CIEH8k1244TeGGVhzyBHRGnQkO3C9vOUGfwMSBghNfUoB3bpQtbvuVzXXoWsEv6V
	cWOe4E=
X-Received: by 2002:a05:6214:2301:b0:8b5:e126:e77d with SMTP id 6a1803df08f44-8c1a2531e7emr167597196d6.8.1778529166775;
        Mon, 11 May 2026 12:52:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d450dcbsm322404436d6.45.2026.05.11.12.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:52:45 -0700 (PDT)
Date: Mon, 11 May 2026 15:52:44 -0400
Message-ID: <ce407923a8717656e21a9f59b45043d4@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260511_1539/pstg-lib:20260511_1103/pstg-pwork:20260511_1539
From: Paul Moore <paul@paul-moore.com>
To: john.johansen@canonical.com, georgia.garcia@canonical.com, Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Cc: jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp, herton@canonical.com, kernel-team@meta.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 3/7] apparmor: Convert from sb_mount to granular mount  hooks
References: <20260509015208.3853132-4-song@kernel.org>
In-Reply-To: <20260509015208.3853132-4-song@kernel.org>

On May  8, 2026 Song Liu <song@kernel.org> wrote:
> 
> Replace AppArmor's monolithic apparmor_sb_mount() with granular
> mount hooks.
> 
> Key changes:
> - mount_bind: uses the pre-resolved struct path from VFS instead of
>   re-resolving dev_name via kern_path(), eliminating a TOCTOU
>   vulnerability. aa_bind_mount() now takes a struct path instead of
>   a string for the source.
> - mount_new, mount_remount: receive the original mount(2) flags and
>   data parameters for policy matching via match_mnt_flags() and
>   AA_MNT_CONT_MATCH data matching.
> - mount_reconfigure: handles MS_REMOUNT|MS_BIND (mount attribute
>   reconfiguration) which was previously handled as a remount.
> - mount_move: reuses apparmor_move_mount() which already handles
>   pre-resolved paths.
> - mount_change_type: propagation type changes.
> 
> aa_move_mount_old() is removed since move mounts now go through
> security_mount_move() with pre-resolved struct path pointers for
> both the old mount(2) and new move_mount(2) APIs.
> 
> Code generated with the assistance of Claude, reviewed by human.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  security/apparmor/include/mount.h |  5 +-
>  security/apparmor/lsm.c           | 99 ++++++++++++++++++++++++-------
>  security/apparmor/mount.c         | 37 ++----------
>  3 files changed, 83 insertions(+), 58 deletions(-)

John, Georgia, are you guys okay with this patch?

--
paul-moore.com
