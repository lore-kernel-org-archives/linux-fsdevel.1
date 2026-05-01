Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B33D902B
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651270; cv=pass; b=ofp1fcKGnr2ru4/TDnF1PxjRrL2/K40fFuu4WQxVYwCb77cfA4GDNmgBn+9IePCcN4sKurkoBgINOHhL6WLyWeMnVWxGsm5+dXt6KROf0PmdGJyPoVf42TJD1aElm5fzSMQJpA5VdVIdNbh6daZ7DDT9K4fz+in9PlFQEgljeD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651270; c=relaxed/simple;
	bh=i7dJg+Ad/jLF4unFEZVC9YnfPvnVtLzsZxdPQEi9eo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRphWMZgfdDfw0I4BGnQ0X8eEDaxKWTXEEjRein7s3awSsxRB/kOqtLBBflqJKo5iKOAJOg8uKo2J9ECQyamxuSgZxXXLmg4PPbdC2DAzp/hZ1xYj9kxQUrgvsRO0ZTBzGbNoXjf+kRZXT+rvgZRHQmaWNrJUdlrFFiHW7XZuaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CBpXWxAg; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CBpXWxAg"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36505450d0dso299850a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 09:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777651268; cv=none;
        d=google.com; s=arc-20240605;
        b=hoduB5MPdFAUHLE6R++7JK29K+ksxaFDaWNkMnIeDXLB+VJ72aWomD+aHL2yFmZ6gJ
         eBI5BnYHZaST9ty8ClneOG89+U1RWz+0aSxIxDnmctfSwBdVoCCi1ON8OCrYTi5YXoW3
         Dl2hHt5JO7pBVh41nkhbBK8vaAgpOpzsoxyc/i3Ygg1uPi9Zm/IiFhSuRrbXuFTcp6VX
         KI2JgxzXBjdZuxWxwtHPpKLzOT1jp2D1dD1QDoGHohDWOVqF4jX3gyeBWj0H0Ik+hK90
         QXHK7fdpeOjQsbdEtmoJB3K2PaRMqCuUrQpnwIyXKxl8m9gusB6AD8fBepoGOvcZn5mh
         Vlfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aWEjhQ0FAeyXxMzwj0dAwfsic/KJmsxnSKQcD3Tkenc=;
        fh=xp6ijg0D14FgjSAy6jatGCJ+JtkEdHW+rGWJ5uOiIQM=;
        b=dEVlWTO9yQl7nhQ7TDe553PZW2JxvBCV6I++R8V+cLVBlMo/Tc32V8QPsa372yANEH
         ONvNkyF7F0MsB1gBD0L62+prA6FAkGVzcJdCQNSorz3Hn+zZeTHAcbgkXMT78OgRCeFr
         FSRmDBGoss9Te9iQqZ/CtO08fE7eFHsmERykBBm6Qoq3ewtnW/VYgbTtdGxchmnHbewh
         oqpGTVF/CPJAyXTrtidT1t378SJo65M9dJHqfOqN4TNqxk7bZvcSvYI4Kq+qfCyieU0D
         NitaQqQaFGa6qgoRcFn8NrhFsnin4Pv7tBZw3VQh+Spqtwn3efbNX9jZP2WU9CZ3Sexv
         oIyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777651268; x=1778256068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWEjhQ0FAeyXxMzwj0dAwfsic/KJmsxnSKQcD3Tkenc=;
        b=CBpXWxAgBMkmjB8Xok4tXdUjTk929M0ao0dwZZEZEC6mdNe9MdvnjuOqpXVhH0NVP8
         MVcuN+TdNx4bHaIVDMKE2NTrh4B1QxcsMAFFACegusAQ4fwaFQEcNIXEDftiBSX7jwq3
         q/SmkzexRfa9nDb7/V4yLE9wStgCCclIsEHddAwRHNbOp2cwwrEp7vkLqK0InWac4bAq
         2zD4RQ/eFr/aWwBqnBxLLMBZP5q+wUfXpFJuQ84EA6yXWZPOJkY5TovrNl3CV30ma2gw
         0uvlQevr2alGJ+x1/OliNj9p21ToXn3hJrZVf5RvBTDJg7JZDaYqlcRLmqbLNnzpO6yp
         EHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777651268; x=1778256068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWEjhQ0FAeyXxMzwj0dAwfsic/KJmsxnSKQcD3Tkenc=;
        b=itjHeC+4qoTQbHKB8OwcNISASf/DDrSItrvwvYmMnR2gLIU+ghpyaLkcOXY26rsQ9o
         /gUXe0uNpD/TnNaF6QiXL8Ewil/tnrdWnVaRCn3ElzNyW2KyFwGgtaTTak4mtMWufuwh
         AFtu7sHm7M5QoAdtAIpnBYwUJZ2LhTy6RNUvdRbtJQSa7TV2xPeKsT1wOZth86U/whTE
         58XgMRxMvNKuEvdLpONkzFJlWZ9tCz9zLJV1zdsBl1tsQwkSxpg0laO+7/6zSbKbNE6p
         w1qO1XNnwTDvfz9Ptv5/rJqh/GyG9ziAHNFkKZYS3uJCXnPdb1B/5u8qaUf6xywjbaVo
         2t5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+f+D/uGbpZc+RHDeSf9eUBZxFyZLxvaSedpBdml3tXC/ocxn1KOeyh2B1b+xf5xzq+mhAuCyHF2EzaNHVr@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1ORSLaSgi5w3Ffn2UNA/2lBIN/YPpNfombbVH1QoaUZXQKoK
	8k9h6vHICbjgiJ7GXQNaGJeA4AeMY4Sv9s9pdub8XPfeyEyJNkTyEjEQOfzpo2AB1taft1TOYhy
	PKc7aNOEbwYc+sy+D1g/GydhRyvEu2pdK2kcFrQmv
X-Gm-Gg: AeBDievYR+YL7mLpM+BYD2UC8oWJ4CNP8ifJTIAzq+b25vhAGcY4vekH1Q5AX96+0KD
	x/caADA0qbSMt2bHLha0eRVbCXNlhfwc6V19erV04Wb42lhhht9yMIabD5m0+N0j7s2EoJH3/PU
	glGqi+U896YFXKf+2GuXzUbB+O0Ym9qVSj4uCenrfz5hx9Eu9PZHWJOFfyeSjzk+8qL/rbkHalu
	jVjJBnLKLxLdw1LvDI706RvNUeZc/v+XLgB85OMzj/YJDnrVBIxnUDyhK6v31oS8LcEHrL1zxmv
	UQOvF1BOWFjW64FBzA==
X-Received: by 2002:a05:6a20:6a0a:b0:3a2:d838:bfda with SMTP id
 adf61e73a8af0-3a45fe26b94mr4353703637.46.1777651267760; Fri, 01 May 2026
 09:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <20260428192119.226244-2-paul@paul-moore.com> <CAHC9VhSDPg2U9UYZ7Na_A8RA-KN8OsNj5S+QwscW6X20tojhjA@mail.gmail.com>
In-Reply-To: <CAHC9VhSDPg2U9UYZ7Na_A8RA-KN8OsNj5S+QwscW6X20tojhjA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 May 2026 12:00:55 -0400
X-Gm-Features: AVHnY4L3FM6UrambQrN7cixYHO4W-gQ46kIRQQMq31UfNN7fq0b5uZg5p-YAHAw
Message-ID: <CAHC9VhSyDVLOQ2vr0YL1PUCdS-jh0gvwcDruW1f6t9g1WTDS7Q@mail.gmail.com>
Subject: Re: [PATCH ported/repost v2] security,fs,nfs,net: update
 security_inode_listsecurity() interface
To: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc: stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 3:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Apr 28, 2026 at 3:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > From: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Update the security_inode_listsecurity() interface to allow
> > use of the xattr_list_one() helper and update the hook
> > implementations.
> >
> > Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.sma=
lley.work@gmail.com
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > [PM: forward porting to bring this patch up to v7.1-rc1+]
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  fs/nfs/nfs4proc.c             |  7 ++-----
> >  fs/xattr.c                    | 11 +++++++----
> >  include/linux/lsm_hook_defs.h |  4 ++--
> >  include/linux/security.h      |  5 +++--
> >  security/security.c           | 16 ++++++++--------
> >  security/selinux/hooks.c      | 10 +++-------
> >  security/smack/smack_lsm.c    | 13 ++++---------
> >  7 files changed, 29 insertions(+), 37 deletions(-)
>
> With the security_inode_listsecurity() cleanup shipping in Linux v7.0,
> I wanted to get this patch ready for the next merge window.  As
> expected, some borderline non-trivial porting was needed, so I'm
> posting the ported version in case anyone wants to review the patch
> again.  If I don't hear anything over the next few days, I'll plan to
> merge this into lsm/dev later this week.

This has now been merged into lsm/dev, thanks all.

> The SELinux test suite runs clean for both local and NFS test runs.

--=20
paul-moore.com
