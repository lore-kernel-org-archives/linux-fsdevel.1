Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5069B436BF1
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362324; cv=pass; b=ZeQXVeg90pCnHs2PLNcAtzXxS5yJkbCscpokhL4mCJxCq94pZiu54j26sWDT1IRHRyVnFEHWtIKvLBFGV58eERaj/qEnNWDTacalj/IcMIce7U0Edrvpgxs8wPneUeq6pYNnUtQIe76sR/N98S3ETgfYA3AxKMp5wHhhzxiOaPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362324; c=relaxed/simple;
	bh=Cn4wawG4GsG/KOE07esR3I5RCnLM2n9QtBSsL+V5LS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttu6rhTTkWGZyTEazVQ5cVBLYygDy3c00tTCTCrowpDpLxjdFNGwcyTsvaUKaBo9P2y+ohEZ9zse0zXwxSmgEKZj1nTD06VvnTvKf0PP6g5RxT9MkqWDxtDCEa7owqxG4/oZAamUgeFCIR9ym/AAvbXFk9aBBFhh6svuV/MhQjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDBvTw8T; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDBvTw8T"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so2934a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 11:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783362322; cv=none;
        d=google.com; s=arc-20260327;
        b=Wjq8+d7cFVXgC09XYi7A1V7WNfp/oQ17/bcYyZynUEpJpl8oRl9tIxYZPbGp7KBj6Z
         bQJtFoZ1QHHYaffFbH9wCN+OrPX3L7Ad10ftKE/9O6jsdiniNa8ilVRTANIy7zHRAFYa
         9T/PJW8l/9AYo8i2GL1QEhk41r0kzhUDa9D5EpCp+XB9Ic3XuuBS24dMxrNJmrtSj4cd
         dy3lbHIEIV7R+ncBR2OLpwohZvqrqOOoaqOq33CgsL0uo+LFYehOmtqv1hBEtuULTsxJ
         V3WX2PWbImebsLXNy2PnPmR8uCABz47S8C13VIWByr+0B/7I1OhsskOT3eQ/WtVNAUFR
         L4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cn4wawG4GsG/KOE07esR3I5RCnLM2n9QtBSsL+V5LS8=;
        fh=r6BjS1zATrQm0l85fkBJm4q5KTWk7JawLmrDoczIUjU=;
        b=AVW38yyjdJQlYEzdXHp0stOVGv02vdry5RZEEfbLYKUNhlrYqlq/oJHWGx3AulI56+
         yJFHb5mDsozqsGkNRyyFXek1Vhkxm+MiSdjcncowa1C0iKxToaeA3CHla5Zxfoqzrba0
         HrfDvCyBL4KaUCFy+ZnGhOAECphXa9+q9ecvcEQnTTO68GYi6JpEMOJdoASBNgJLU1UF
         NESIMIo1Y+zjDdA1TAi1AvU+lOmcQgvCSUkGPrtSVZ7rGzaA+syNKB1BVdsFbZnwBF4V
         wLqJlOWno127YomwJEJ5DgJ9NpHBzapI3b54E7U0Bkw4tOJ25FDbiVY1ABBCbTT/m3Ju
         zM1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783362322; x=1783967122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cn4wawG4GsG/KOE07esR3I5RCnLM2n9QtBSsL+V5LS8=;
        b=RDBvTw8TEpkyYCmXKjA98k5lZ0tH2NsPI1Y73XNQ0KnV42ILURMBGEN+yLK0g1ZS2M
         /taOsi5ppvUSbg2ef4aGcIS5kxHo4AGhKCxqLQLvp9XyzPj5DrX0Z5ESDAqpZ3y8wy/I
         jv9+XjR7801lDuz9hcQQNgXBWAd0P7eY/oSiBVqLetPCW+DNTUDjctKyRVbHzL96763H
         wsRh7H6GtgKZ4h1bj81RXwiK/6v2z/tn8AuT95cyTTUlp5nJeLcFS6aspBDY4e2JADME
         2w+/Nw6lZuAenBFiS6alFHJr67hZMeFvUuxyPo+oSXz9lTuqu3p2BeV6DLY+v3FJDG56
         0wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362322; x=1783967122;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cn4wawG4GsG/KOE07esR3I5RCnLM2n9QtBSsL+V5LS8=;
        b=OJu74FkyXH+gwBdNgD6/IU2MfOoNlU3tzMYuhO4gz2uoU9w2pgZk80SlgxzsIZ8e0E
         6esj1FEhjzjFJ0fDnCr0XxSFpy1bDLnpZkO1fLuxphk/zvkt1leihnldc6r/MQqRZzQN
         9/+8G4JOz1xhVEGFXATVpIzAkNjNEz6Z0FxlmSYMzhGxmSd1AtQXtPgDHDxDTSBFM/OX
         MAEpOtxzJ7HsxOJb4MLOhiae1oPHF+0Y/l0+YhqJQLiJ4lWCFR3LjRIcffD0T+mBplK5
         OFcnfZsONcEY/R+4d5/okOBBZWLGZYD1rCRaT+TVv8fzgvtJaM44j9KbLwgtU6LQKjo1
         U9AA==
X-Forwarded-Encrypted: i=1; AHgh+Rr83i2sHSI8RymphJ0Nu0Wv5G2qUcVq3VMIRbcsP9lYoOK+3YaCBVicXidIVAnf9wuqN2/e04F7NQik1/qA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dPEx3OxhG5eVQZJxQrl8ZhWIymR4W0vHdf66vppJY6rhOR8n
	dmcGo/N1Q6Oy1cEO4wPsFe/2hdNkDENJHpCWAi+f9uADTg6Ox/NbTQr3LSHkLiKodxmYygrhQpM
	IXdl+SbXyCJIbHxF96pvAp9uptJ7T+FvKiRT9dgV1MhtKAkm9OKwQ7MFF
X-Gm-Gg: AfdE7cn1vmww3/E3ymjlqGKppSdO7fXnRPD95mmd1f84uwmO+J2Di4c7M0qyduBSGjb
	oMtR53g7aIL5PR18TgFT5vwSfoKaKKTRpgm2Bg1PhA1z+m/DY4OTcAiPVeyaH90P+nRMmAUz6TD
	AP5qq8GOm+G7dgsnR5lQJsA9FGr55/wqSih/L+jV7iV0BQwxPM5LbqLMZXdOJRF6nJEE26/aTl/
	yrbWIVYCWPQfuM+PAHNJ8EByaQm6xA7tcc3fw6N8OkLztKmIt8GjHkqGmdIvdachBfhcsXAzU5j
	wNtxrdvts72KvDu4NwSGiJlbxRWpWd7erLYoJm1+iSSfUvkzepd9jI+XMw==
X-Received: by 2002:a05:6402:3045:10b0:695:4751:c044 with SMTP id
 4fb4d7f45d1cf-69a8d5af200mr12049a12.8.1783362321335; Mon, 06 Jul 2026
 11:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
 <20260706170735.2941493-1-linmag7@gmail.com> <CAG48ez0ebrMy8QGKLuz0Qwao_Eiav6e5pAJ5f6GrUPJLRkwNnw@mail.gmail.com>
 <CA+=Fv5R=mUW_p_AFFr-588F_b1hB=7RhMbtODya-gby=_fjBgg@mail.gmail.com>
In-Reply-To: <CA+=Fv5R=mUW_p_AFFr-588F_b1hB=7RhMbtODya-gby=_fjBgg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 6 Jul 2026 20:24:45 +0200
X-Gm-Features: AVVi8Cc7kCan3qAeIhO9q8vMrkV7_74C6sIMx7nz-yuT58X80UFcpE6GMOhG30E
Message-ID: <CAG48ez094Bu70b6CjfV4jGK+T5ihnprFY2wtBYa4AZf8iHJsow@mail.gmail.com>
Subject: Re: [PATCH] proc: protect ptrace_may_access() with exec_update_lock
 (part 1)
To: Magnus Lindholm <linmag7@gmail.com>
Cc: arjan@linux.intel.com, brauner@kernel.org, ebiederm@xmission.com, 
	jack@suse.cz, jake@lwn.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:00=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com> =
wrote:
> I'll retest the strace pidns-translation tests once your fix is available=
.

I've posted the fix now,
https://lore.kernel.org/r/20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@g=
oogle.com
.
Thanks for reporting this!
