Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4F44AB68
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143472; cv=pass; b=bf2wELTR/L5iDY8s9O5ldTUyexpHw2cBsl30uaiVJbQA7bmtwFSymYfv71u/s1fqUTzgnBlfIACXeC6iNBa5wUDDlCmIZgjVmZOftVeWVQBL/IUf7B+3QsrePc+u9JeCKGcsV/tBYAbiDy1vGiF7ymB/ok4WSNwLmPyZU6eEozE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143472; c=relaxed/simple;
	bh=CCqz5HPpG93l7f8Cn42O1c4ODT9r8PrlcLsz5Puc844=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgHZ88Xh5nYrj8CV/EwI/gU0GGB/wJzFE1CNpaUp6iiEPrcwfya3bSaKzH2u7IaCypWh+2MulhV/q3nP8jpc7ikfcXx17cNCkMXo+Q4cIlJQxDWow2wcun9wWvksQ0rI/nNINPqcMtGQ5SwzR+fyi/OIpuTFQzHpu8HZ/pQyl1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=g21dieDM; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="g21dieDM"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-141395927feso11989884c88.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 02:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792143470; cv=none;
        d=google.com; s=arc-20260327;
        b=IdyEOAoiZvox79oa0OS0Ot5oJ4m0ttKFwf+KG+Qs/ktIHp3vRR7KcPQoK1NEwnFOaw
         pMjUNGt1xGpcY4GcgcCpYZZDgkbmWonlXSNYlext73faccXePZlnUJbb8BlKJCfSbyEa
         bhn+FIJsGeUL9cwL3RS8b721nLDWGmnrIETwsRiPgC8dYbG3WqGhWdMSJPmiyxPGPmX6
         jg+lVTuwMDxsQoXTT4Ms4PbYhxnYMTqHEJTzGgBvGYsjH+HKi3UNEyWLPMYJPrsKt6J9
         QPCa9SJO3stBWNAuT/HIL29ING6SqZvSjGJRNZ5e7dTCsHxoOJcpsQLi9zVgslUbifZO
         Hg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vCLaDxJTvic5a6eu6i8PyS2B0rw8U286RI8yG0wvAF8=;
        fh=TdLa/r8RfWpIzRr0TsM4CreBQPc3VaxBEUulXTtN5Pw=;
        b=GwxODCtR79yLWAQZRXfVRsDZNT0u2ICFlGU3Fq70R09fQCzZVdsvJzpcNrO/r9x6Ok
         MGmQxJu3yJvQtt7HH55OsFP5bP6LZmWMg8UB19IhQDZ5SfdVmHc8wTOXnOVRkdJqOk+F
         GfCHedGPLXM0cA39HgWSmjLAyAOXhtTBYz5rdYD0+9yPkuisoFvo+v23gH24uc2sGXqI
         oRsVG/Q15mjkd5JQNonjJZLLvsoKlNKEWcPAmJhOkk6rHssiyAAavXSsJK/te89MjMKc
         N+K5NmrT699Qi93Q/vox9tIM1g4ZPqggTrJ2Khvty39ldaVI8pGg1UgPJ/DmaTR8mCYb
         f4pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1792143470; x=1792748270; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vCLaDxJTvic5a6eu6i8PyS2B0rw8U286RI8yG0wvAF8=;
        b=g21dieDM/hmtPcZooHRZqqd7tXcXv43J8LFgYm04u94lM1AARReVujmj71n3fOfGVp
         X6oP7wROILEPS0BGB/YcvQKmy4/PV8MjzEkNzEr4B3blBiwK2HaR/nWqewZrV2f1fqb+
         9cxO4ZqjrT+mVN1gNVq5ZXIFNngXktiLDGIug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143470; x=1792748270;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vCLaDxJTvic5a6eu6i8PyS2B0rw8U286RI8yG0wvAF8=;
        b=NTCTy/9XHiCDXgB88t8Gj/u62j0exuoExAgQ8EzU+/aOo7rlQ48cZQc4HmrbBAxceU
         4aDB42F+BLfXkn9RnWTBtqqCIjawlby3QwP++MN0kdyyEEv40wYEXGiQMToQEN0cAlqM
         DmDdjpkQ3IA3SlTxVg+OAaC1bq6FT2yyuMEiyTR04xO5XcLOqPDTy/un6EWzkSyV6i/Y
         AOSGNSCRM17o3JsROdbm87qk7yCjQhVrumC2xzsqEYwsEzZHxCW8EcWi54Ox5jv1yNwJ
         6VViUJIRTFiA2hwrTqdeqxYa62J1wQJqxkJcqvoi5ltNmqPB0gv71y80Zurs9/ke2zdm
         zC2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzvNc5hMVLiSWrr2htxjSRxuh0HUU7TbJKeGka1c4uSZOTcRP8GTp6vQ5K9HvXKm+t7njb+p3aln8QNI15a@vger.kernel.org
X-Gm-Message-State: AFq9FYLB1qX84uoSn9/j+AuouHHPKWk3aW1ZaEpvejFHeaN8lNrMC0pL
	CYRKNgxCxUKucp7L7dvqqSffRj41P+spLpvoGUnkZxSVqR2ymaNq1dXodc0i0DZZcjlAeKuxsFa
	O/LoiBo1IUIeFz52wNOrapKKD/jwZDRSPiq+BUZ6pHw==
X-Gm-Gg: AYBFou2IkwBNvVn2fWlQd0EHj62RK5LKRgncFyoLpheL+s89wr2wjAMcjpTmq3jMWHO
	uGbZKIZWQzovvVdoKFwqfcEEyYbZzTesML0egWaCB4XNN7KFH701uTBc8QsV+SlxuyavHY+JUKp
	umQR09QKVSuXfbDnut16Tt2dFymvDhi65Oj+spbBd0j6MdHTQsWAm7ZWMFkeW+87g7jOXAPAnyF
	lkA02LQO0582TalrZPLh7FsQn4F9Qet3YYw3BN+zhFlFItpRhhMvMYP2U2hS3cGd4owXA7Q/oIz
	XsBFLZVEc8Rwnm9zrBDKUdyVHmCjzpGlpz/Xnpm7jFvgUFkNnZcElu3L6c+8A38P7P1uIYIDrO8
	astMBrevXJ4KvhtXIcg==
X-Received: by 2002:a05:701b:260c:b0:14e:8d1:1012 with SMTP id
 a92af1059eb24-16a5eb5248bmr26677656c88.19.1792143469725; Fri, 16 Oct 2026
 02:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929032927.1451259-1-neilb@ownmail.net> <20260929032927.1451259-2-neilb@ownmail.net>
In-Reply-To: <20260929032927.1451259-2-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 Oct 2026 11:37:36 +0200
X-Gm-Features: AclHuK90baevLdZyUbmceJ73OjlsJVPDiUN_j3whqpwfuH99OUIsIo6LPDruDMI
Message-ID: <CAJfpegsUg7E62ixTrb1UJ+mFW4sKLV3pNmL7ouWSJBC_W6bFkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: don't d_drop() before d_splice_alias()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Sept 2026 at 05:29, NeilBrown <neilb@ownmail.net> wrote:

> d_splice_alias() now works on hashed dentries so the d_drop() isn't
> needed.  Drop it.

Applied, thanks.

Miklos
