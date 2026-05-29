Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F17378D8C
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073155; cv=none; b=Lxf+IXlAyBEGQQ0vuJu+IInBVcDn/M9yRA+Qd8qkEGMXO9v6FGUG6/dfR8aBzqahqW44tz+k6YMDgfwBX4FfWRjOi0Z+eonBsa18icVE8RzdEwQ9FD67dcRq+TPaku6KFccxXptBvtVTyJYt+1pEaaU6v6dHRB5elQdg+Nf14lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073155; c=relaxed/simple;
	bh=aCI6e/l7Dth2yzzxP11p44pWFmgqpTitIRCmWKW+Zeo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AFu9fP/h/9PLZDRq3DawmzY3DI0hK4K5isa4p87gFZBVHueCUwrQkL7vjxGwxBIG3r9kmmO86cUH0ak21sODcWpEEdZdnA1QGT2/mAjlgQy7hqvhD5gUCysPpLBrJZvYp0LFKrdPwwHdyuEtOF3uJYJyY7TOwL26kJrJaRqEQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=U6YU6Qgy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="U6YU6Qgy"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so14658229a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780073149; x=1780677949; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCI6e/l7Dth2yzzxP11p44pWFmgqpTitIRCmWKW+Zeo=;
        b=U6YU6QgykwPA7soFByIMVg2vbXSf59v0zB9T82Pl5qEorozbfJvZKAlGI0zVP87zEO
         PyB74ETcPxMSukAmfp5cIQ3SdDvbp7bTDloQb2+VY7F/Gr5qHYiePCBvvx1I3ALVJLFd
         WknBmMA/H9QPmkOPAWyKHRRmVMvziPyQXmrXy2Dyk67UX1jBvkwEFAnr1QfXxjap/rtM
         XppvEPHy/pqFcyDgPQksoaM4rXhb/gZIhCryYwYUEJWCT+toO0MH4ex5qA9kBGdtKOGl
         rhFXfu67mnePh6eXQWmuZvM7pberkMaZMtaMtG0GpEsZ3s/rKHX1/RzuuydJqD3CneCh
         RIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073149; x=1780677949;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCI6e/l7Dth2yzzxP11p44pWFmgqpTitIRCmWKW+Zeo=;
        b=msnvnfL5KmPWPbQ7yHVzBh6yP+QoZX8xShQT73ZAATS9GK0oFw9ojdUYgas7dEm4pz
         T+7qUrs4hCJf1zZKnYBXujt0WbgXV6fh995vumfJbtZw7ZFecu3zF/mSoTMzmXbUoTqC
         tDvGQ5JHdSpNJR+TF+u6ooq273hwyoiM5ZnZcUHTBnqCfE+Ir3fwGIGdCsI9Qa+cOa6o
         aHRo0yApd1KPcXf9Wzyri8snG+wcRWL1lv/UHwQEOdM6teVAsaQQP+R8auUpW5MzP0H+
         ZPtwsHtoh9WVMp5eNgXUYijMc15i/IqGt9QW/VhWxpZXcnXKVC9GeZZbjqAB0zdVOcv9
         jZrA==
X-Forwarded-Encrypted: i=1; AFNElJ+rm3bgxD1AHqqL7r35qvxd5h07ymyvVifNSJLmFRQ04Kja5zHqCBKmkYsqZi0B3DvP0EPInSPGGvQm+jCi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1i+ycHB9Y55ipttw/8jlD41SF+4Ousa+OUVDyFEDAL0plu3c
	Eg5ETQIZ8BCqgWB+JT9BmsjmX6oLFzHbTOZdx7aQbOwnlciKK0Iv2T9vAWwOgDF7meE=
X-Gm-Gg: Acq92OEnDYgugPprGkXkYGuNeMLJzLijT96NoBLy2c+kD1Ro8JeWQN1B0J2XsHRC83C
	rOuUzbwpJqYHeNoZAiD+vDz5QK/JG9S5eIUwoptM2undy/SdnRrzdqPhJyiprYSY0O1Tf9BPQRP
	cGKqWOCTQjhZIXREgu+5wRdJvMTlD83yjt1f1dwbiTNKfLfdiwhuQBDxFo+nEtfUUwkb/HTtad3
	Wk/a8DwgZcIFV2GhkwFL1ukdXDOqjxSH+HZzKg6mVu0Sgx8MSJMEXbiYU4F3XcOoHVO+RNRTUuY
	G0Vs8lAa2sKLu6qsMzY7F1mnWS+oLuzWUHwgbh1Ui7ZguNFDMWxsa36g93tRz5w978Ud5lbWIEW
	fbE2bB0RvGrm9hENC4tyiT7E6Uq99ejIx8Uiw0R7S7VDfUZJUH2KRZd8B6w0lOLMtPJyG8BVWnk
	dxBefT3fDqgGNv229AuM1MPeqbQAYk0euSJ2U=
X-Received: by 2002:a17:902:d583:b0:2b4:5931:bc4c with SMTP id d9443c01a7336-2bf367cbf43mr8005005ad.15.1780073148788;
        Fri, 29 May 2026 09:45:48 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c26b3bsm25060415ad.64.2026.05.29.09.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 09:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 12:45:47 -0400
Message-Id: <DIVB9MNT5JG1.SRSKMZRPB4G1@etsalapatis.com>
Cc: <emil@etsalapatis.com>, <martin.lau@linux.dev>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <kees@kernel.org>, <joel.granados@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v2 0/3] bpf: cgroup: fix sysctl new-value handling in
 __cgroup_bpf_run_filter_sysctl
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Dawei Feng" <dawei.feng@seu.edu.cn>, <jiayuan.chen@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <0f50af7f-03c5-46d5-9d68-553dc6995df0@linux.dev>
 <20260529113752.2863465-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260529113752.2863465-1-dawei.feng@seu.edu.cn>

On Fri May 29, 2026 at 7:37 AM EDT, Dawei Feng wrote:
> On Fri, May 29, 2026 at 12:44 PM, Jiayuan Chen wrote:
>>I think patch 1 and patch 3 should be adjacent in the series.
>>
>>Why is patch 2 placed between them?
>
> Hi Jiayuan,
>
> Thanks for the review.
>
> Patch 1 and Patch 2 are actually parallel to each other. They both addres=
s
> pre-existing issues that would be exposed and triggered once the changes
> in Patch 3 are applied.
>
> In a previous iteration, a test bot and another maintainer pointed out
> that activating the code path without fixing the underlying issues first
> could trigger a kernel panic.
>
> I placed both prerequisite fixes (Patch 1 and Patch 2) before Patch 3.
> This ensures that the fixes are already in place before the code path is
> activated.
>
> If you prefer a different order, please let me know and I will be happy t=
o
> adjust it.
>
>> Change is fine but fixes tag is wrong like the bot said.
>
> Noted. I will correct the Fixes tag in v3.
>
>> I saw a reviewed-by tag given by Emil in previous thread. Pls carry it=
=20
>> when sending new verson.
>
> Thanks for catching this. I will make sure to collect and carry Emil's
> Reviewed-by tag in the upcoming v3.
>

Seconding what Jiayuan said in terms of the Fixes: tag. Also feel free
to add my Reviewed-by: on patch 2/3 that IIRC was not present on v1.

> Best regards,
> Dawei

