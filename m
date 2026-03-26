Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D281B22424C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568713; cv=pass; b=oCCWLC7DyNG7c2vCeq+0cldOjPskkNE2l3n37LYOkckw37/OtXukDd04FEBoJkNsUaZOkNeWZkjoeZjlPf9BJKVG9qcXJAibJQZjByE7bNU9/NTXOcrl7j41TQdjsEQIhtQ7xGepXsnVjBEI11BlogtF4VJS7XdQF8+ivVvV868=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568713; c=relaxed/simple;
	bh=xu6RA40b71J8Rif3fpjESEdRpXu7mTJtIso8FLjGmfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=steSNzmdT7+g14You7Hznr1/Uk5NyeY5ZO+bra9UKxgFpV96PY/LCKpw8hY7tjSWsD8YyXsCy6KNmqUUlXGXJLEGUcDFExBvKhb4kegbMnCxWNsFl8cmHAT3N5/Gs6FDuCm8vPL5Y79SuMgqjEM88uC84AtKAI0RKI0rXMrpR+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nETpCQ0a; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nETpCQ0a"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66971ccfcabso2070368a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774568710; cv=none;
        d=google.com; s=arc-20240605;
        b=aWey4kSnsQdMeDCcuvwnEqafiP1sOS5IjJjZdNYDRd1NhqjvxShZ+gQe0q0LAQPtyC
         teJp7ZLDRJMEy+KerrZiZyDcJLv0te5IMEOItqFJ50Kcal6vyB9oMWA6jS+IXqRqqZ9L
         LsEJdV08M87Ox4ZEuj6fGGK2WXYaLzGjjcWt5Z5v2dWsO19qLoFoQSszv7sEHaMS6dhC
         BEQed8FJyjqCsBE/2T5W/SxaaQuAkPyb+KzXLR4PQSaOf/gZV7zOeYI0KB2JXa5hF/AW
         B5rGLBL+ZthMcq9MjbsJdfiTz70WAm9jks6wtSfBMFhvLg5PdLoD2AEX6FAlS9Uwci8K
         J04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xu6RA40b71J8Rif3fpjESEdRpXu7mTJtIso8FLjGmfE=;
        fh=Q1xPlx+eHZSE7HVAk503az4UIeeJ2kJVgv6IzQbxIDM=;
        b=f18lqMcY59SZ7pg9MjNHvX1FL5ixITKC0L0uMCYkdaT9e1sxCNuW/ILGWAQbYfekSQ
         EXaB/yOJ67fhJXDlA227xxf0qSfYpQMz5b81eB9qbS3E/N2svaxZiQOChIroXhObeuiT
         ph7KJkktyr1A6v++o52PCAKEXGXS1GBYVBVm4JuoUSXxvJRhZ0wfWDmwX34tgtQtSDIY
         F9Lehkb7f7duBnN4SHn7hl6V2DTG1VeofsX/eZHXanMO1Wn1muK6aWXQyFpenh93m9Rq
         NkxQB4XHiaXspljvWyCDc6BAzH0FLPQ4qzRe4Th4CoSJouysADWxk9t9C41R/B0pcR7z
         e1gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568710; x=1775173510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu6RA40b71J8Rif3fpjESEdRpXu7mTJtIso8FLjGmfE=;
        b=nETpCQ0aUfqdzCavBwXuOz16ezJK01EerfGZc25TPsyMCMPB8CgeGMmJMqNuG3Pylf
         zdI2THWzAWdH9DLTV/TrfFfttv1SNvDvRWSiS1LCUoIWhwAigHxhn1yVCkqfG+wILOTZ
         ZqHCg/0naxg79ziDgYFMyDsBQCUBBOxTtXVLbvrh/XZeL5Pzr5Pdatrbb2qe6tDO1nJc
         s2eod21g3/00UprWPeq5DiquJVNv4zQxf4OF7hVzDM21lNSjTm3nHlCoB23NTMSJrX/a
         Ub+t7vsg6iJEB3JUIw88yMYpE23q07LisiQfULGnkTMy43XC753oVx/NtAzFtaIiP6j5
         nVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568710; x=1775173510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xu6RA40b71J8Rif3fpjESEdRpXu7mTJtIso8FLjGmfE=;
        b=HtCHGCovH17neUK5TPzUYH6mojyA1tQUOSJBR+gwdDW8a5jHe/wq19B8XwBXUwJjot
         HG81dcfmugLm7RLDH3e8wfLPYOg1oWCD6Crjjupvipydu4zKGN3yhkSuTME0DoCNVWar
         fl0vxgM4QCZatRu8T9DG66wcbvocPGE0H8d2JbbA5BASlayvPyhdiFdmAC/vv7uXRosp
         WX8e4AxZAJixxTo3xZ8MUEbJ6CrB+VoHycCdDsluhXQDje8yHw8+ocaAhx9ca0yADigV
         x+LLjdPa5itov6kh974d13VyVVzZA4H4Dhm+YJ+BCpWH01JoRe0euxd/1/ivHj7eL7L8
         mSyw==
X-Forwarded-Encrypted: i=1; AJvYcCUBAlohjm9o7/oDQir2j2/4TrY+8JO8fVKnaJLHrHFKbDIiIbogV3C/7PaeCNn1R31S23zNh5aeX8yZ7jcx@vger.kernel.org
X-Gm-Message-State: AOJu0YxLUvlcx0BnBpp7nyhHBbsA9/EvVSaLZbellIYsSGOzDmsMVo+k
	g49Qdnv9XtyXAzCxMGeF+hPPHYOGNTuJFqt0k74hWxvV+OTOXEal4EtuNj109EUU87KymN7SWBq
	gVNjKigJzzP17NPVzRu/IruwP5mFjnyQ=
X-Gm-Gg: ATEYQzyXrQz5z8IsX5IeaY3T41Z2USkDIA+5IF20Z604z1dZFieJIDJhoDxag7yTi7v
	I24fouV12Z+4RCEaebL+Homu6RB2dxZcZ+UFjMWvfYqBMxWZR51R+0xOe7Ds5ooVUwCOMFLAP65
	T3EY6mIG+kW3UHZuzyCEPvZLR7pYxZZ8MO8Pkj9QOQoXS02p6oggInlmTkFrK8YPld4zGc8jw1D
	UIiGjbvdYTIuXWDKtzQhQdZNowiGYvRl2feq9WJT2Z0stDKAV3dICygUF2EkiDXkL6csgdfZkhL
	X59Nvu05Vv/RPMcB+cWcBSX8kMH+GDTI49jKtPs=
X-Received: by 2002:a05:6402:504a:b0:66a:1744:5cad with SMTP id
 4fb4d7f45d1cf-66b2826a13amr159250a12.1.1774568710090; Thu, 26 Mar 2026
 16:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326232130.1891210-1-turyshen@gmail.com> <CAGudoHEHua4cA2-jZ0Yf54LQtuG_7=We-EMcW-yriNQ5JZzM5A@mail.gmail.com>
 <CAHLHtjzi5uKrNDyjL60nZ6TUZnae5gDaEHL8dwbMECBT1L6tdg@mail.gmail.com>
In-Reply-To: <CAHLHtjzi5uKrNDyjL60nZ6TUZnae5gDaEHL8dwbMECBT1L6tdg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 27 Mar 2026 00:44:57 +0100
X-Gm-Features: AQROBzD_V8D67SE_uwwGOkm1mH8cRd0Q8DyQyiKOH2Yauo2cvJ5p5x5nir2qSYw
Message-ID: <CAGudoHGT_8fBCq9BORhYqt5GN_rmWh_MY62ZMouSGqhgyaD-iA@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: fix deadlock in insert_inode_locked() waiting for
 inode eviction
To: Xiang Shen <turyshen@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 12:40=E2=80=AFAM Xiang Shen <turyshen@gmail.com> wr=
ote:
>
> Withdrawing this in favor of Jan Kara's ext4-side fix.
>
> Sorry for the noise.

It's not noise, thanks for the patch.
