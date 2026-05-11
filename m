Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EEE37DEBA
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529167; cv=none; b=oOMAObkIaFLcyCbsgGAKU2+7WKG7CVSxIxQSx0PCQrqiKoyRfRRaXzGtlNBh00WvEyuGQjDtbbBalSnl6gXnMjvHFbZnsTYBHjuQwTrsuYNRN0PvBExmPS9q62BjCPmvltESfoAmgKWGOI9myH8+fnF5H0Rh8DeRoRrupnyT9v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529167; c=relaxed/simple;
	bh=rKxh87Y4Rj2/mJmQycKYsxIgVUIAEj71pDy+b5FX/ow=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=asm+WCIjU0HJG055c/oBuo7TRXR5AcwyuJL3JQ7WHpRtAqye+xoHvu4Nfm6FQeqdzZ7Q03BcSfCiGHIzTvOq2QEjBNHkKGI6moKF0PH6KYExtQdyFfjQXTo/bujszyEOTx4Voy+NeKUfTIL8xPVW8ghLDDUly8iea+8tdl7VVBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E9lVJyLD; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E9lVJyLD"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8d560ede296so516759585a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778529164; x=1779133964; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhgeQ/Hv8h2FLNPnpqx7Nq4djCqVR8s71dQNMbQD8h8=;
        b=E9lVJyLD68P9mb02OeDiuxB5mMUgH5x8C9eKQQXBi/kUsedChlQRKN28FBaldSCv51
         3MwfG4uglNXTJjoQORG1jvzmokZMB1zTDwCdmAALZToHJ4jEmUDTIK77fGVGaxGuv45s
         7oMTunZMG0fStvlKBpPxoxbtA5JV8dzbkFn4dwZL57ikpdXKjn0sQTdWkkFWIbsyHNdV
         gDlQPMutxdJ1m5CVO3wiiE56/6gf9+al5sqf+QJrAf38IiPwDTdHYaKgKp1MloaCqNMj
         Vyd7gx6VEdNGfOQYiMvMcvSBvCzZBfPfVzMwkkfiJbynwNQ2tVq9KF1f304SRsmECtYN
         MeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529164; x=1779133964;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhgeQ/Hv8h2FLNPnpqx7Nq4djCqVR8s71dQNMbQD8h8=;
        b=FIlseLz0nZyjF9Nqgg+FzH4kDRxKBkP+OjeZ8vM2shpR6ov3HDwBhwSe/UdBD01E6x
         B+0qek1H3iQ+2agKI9Md9a8dVnGfzDjvhO0OHsxB2H6/sIT28K8E4XqnCJkGNt7Kl9Zm
         FPSD1aVLPpNky++Q81d8ls0awjEHKgO+WWNt0nc5OC4o/NwdKzwh0BK9tj2VA5AvlA5+
         +sxBAq4iFinj7lHtn9W8ckQBdcd/Usn37xitJoiSU2wO45rNPNH+FhEjHNr1O5zgXk96
         /wQvNdL+ba+PZHmHGX80ecDNl6Kg2/MmSq7LbkVVP+XJyg4qPryvy43IlWPvNAKTH5Dc
         CSGw==
X-Forwarded-Encrypted: i=1; AFNElJ+e9E0jedPoxBMAEoLYp02Pap33i/YThCrKV+8zaQyRyHW72m8xaOrthBhdXs5T5g+0YCfPaXh6wYMsLs/o@vger.kernel.org
X-Gm-Message-State: AOJu0YysJNjsmD1zdeJMCeiFO1RrrsOavbvuRugD5ZwZx2jQWN0kyJGY
	zwVH221fNoJh7sN1eXsgbikMPWdL6IrZasMQ2YkaniZ3Ou3xelya27lKDgNB0E3EKA==
X-Gm-Gg: Acq92OEwu7KqLKBzjrQnQR3TpR/suxKxYZI/W/RBpcK3zz1afhU7hxNIA3pAlA1YnzA
	j9U8RCJAPpY1NvultJgebZ6XR+H/X1s1hiOPeprkhuKVQmKYd9aPYmYnUm4ErRMcgIwY7Ar1ZjH
	Ggm90yX7ULDJNnZYh9DBNtm1EySUObECVyHuqOUM8CglmkHH+i7w/PNeWcxB3IrBSHKwMXZozfI
	FmQcRL5u2/R41/mMPlk69NJLMwdZq//HQGxVbPEPd/2AbgieL8Zy7NQVZGmQzLpc5U61J5+RB6+
	vIdAS3PVMSkLfgQYlHxzfCImVhuHx+IjeXIaQBUSotwsLc+fBstD290w3kjsCqXhLFAVSsw96gG
	stO3WAlt4vzJ2yiMRDljzS/SBunNHwwuayc9Pmbr1lwrxJ7JSgknTA4Qt0skqhqGHERwE4FXsqB
	FFyutspThtnkJdWculmwrazkY0ySuEgIeYd74dEq0flw2rKCGExP+xlsM0fAGGhd6qEwko
X-Received: by 2002:a05:620a:318d:b0:8e8:ffd2:ef90 with SMTP id af79cd13be357-907b8d9e67dmr2467034385a.3.1778529164314;
        Mon, 11 May 2026 12:52:44 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9286f22sm1151090885a.13.2026.05.11.12.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:52:43 -0700 (PDT)
Date: Mon, 11 May 2026 15:52:42 -0400
Message-ID: <b32ee44eb833fad926f4667892f2259f@paul-moore.com>
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
Subject: Re: [PATCH v3 2/7] apparmor: Remove redundant MS_MGC_MSK stripping in  apparmor_sb_mount
References: <20260509015208.3853132-3-song@kernel.org>
In-Reply-To: <20260509015208.3853132-3-song@kernel.org>

On May  8, 2026 Song Liu <song@kernel.org> wrote:
> 
> path_mount() already strips the magic number from flags before
> calling security_sb_mount(), so this check in apparmor_sb_mount()
> is a no-op. Remove it.
> 
> Code generated with the assistance of Claude, reviewed by human.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  security/apparmor/lsm.c | 4 ----
>  1 file changed, 4 deletions(-)

John, Georgia, are you okay with this patch?

--
paul-moore.com
