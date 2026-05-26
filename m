Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3851C3C2772
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833793; cv=none; b=Rux9Ym68vavoVbrjqeDCjZpRKY4Oyu+F2kEH887ghDjXdRhrhFji0dM6gXKBZ9yj6MGoRCiFyxqvSs8ztwNfXQTPh5kOI+YDY7/b8bWVAboUG5ohvbvx1dNPRRcyXGr1LaeCuNlIiywGwv0gUQxSCfl+1qdHb/x+FsJHIbcSMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833793; c=relaxed/simple;
	bh=8XRM4wiJ5jNXpJetksnmAVa5jpDVg6ilKLOp4qDmY8U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Hb8Hvy9Nm8qnHSrPi9vsGYczEGg4PsF+arhECR5gmh+8W1QZ6tpo+A65xRdVRm56XaWhyESBYkTMps4FjCPi7ZElq1rvIJcP/5dwy7xFfTX52Q+DY1nO6ZNMNlfOgimgSLREHKhpro0H1eKOMYWVr3ZIW2Lp9mCYieZ/gwF7GlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=aNk6PVhn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="aNk6PVhn"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso5052468b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779833791; x=1780438591; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXPmI5+ogRi0iUoso0vRs88WKRO67ENSRqzfnBRQpWM=;
        b=aNk6PVhnuElr7GD/d1bCzglzRHDgnYvgxdXWI8BTY2pnaPi1k6DdjC/pAPoGbKChu+
         vK2mAphY3VfSLhdQsl6J93iW4ZW5TIZhMI3agK4FlafYg5sefRWplcB/BnjSom/m53KX
         IW9jvIB90u8Wp70NrxnyAEtfYsnPT1z4Ur+goyQmG+/oy8b/mc/UGleOdkNeo+KW328H
         N7FwFfcTXSzBe25UKiwrwGItDd/Ba7zegdHXcIRjzZbXU3KaPApDME6xfATIXRY8LQci
         Wi55ec5nLN8Hidb9sKKBZ6UkzVstDyRlH/LBPwl8n6UaQJZjZ3PjwUIJyHxT/gGpoAiA
         zYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779833791; x=1780438591;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXPmI5+ogRi0iUoso0vRs88WKRO67ENSRqzfnBRQpWM=;
        b=IHi0UaP3U7V6GULEchT4bVgKM1uDKgJ1gRtmH9cs80HlN/nZRcyoTfGyxO/AancHF6
         sApFrYWwkz8TNJCXJF90tI+4n8Sk7J4b1h6gW383Bl3lpQjoTsXQ548dJ+vFmi8AOefE
         wTFS84pjlqy/daBzy+3YklHy1U1vTLvgmTDGzGyRSih6rKyNblUmFqdfwWi5kYALdkFX
         xwma8rqDnSkbjBLvCCRI16K9JXqJxSO6IBD3atUbAQ7yQSdmAc2kpSKVdDvkHhq5VYLQ
         j33Y0F3KxFBegO5vhj8g5ipoG7oA35I3XILtyuRZAiNE9rAGz7kV/ylo/n+Mvf8ClEOi
         CRIw==
X-Forwarded-Encrypted: i=1; AFNElJ8MPgYT9YXcKJleXXkPPvNIwlx0jKUqyUty6YvcSFhvf3EoIG6myaUIOIrgBOCXYBky9QafT5IL93qki9oe@vger.kernel.org
X-Gm-Message-State: AOJu0Yzne+uNTwe9tbvH/DVgqeCT5VFEGQbh9BAX0P/gwY/NNEruBnTg
	13Q14smRxV1lT5PKegXNgU10Bg6+36HYYk2jgnqA2UViMueuxYLmEpOaQsxs8hzsd7Q=
X-Gm-Gg: Acq92OEwm7vSTkOMyMyMx8zA7f71gc5hcGRygoP0GoKafPMVI2m3y3jJg8XQ0aT5kXO
	B1WXfagxEuNqa6Vv3c73YTHN9vNT4dyv58Y0g52kyBMrIpbfw6ELeyQQHexluWCJ/0U/5JyxwGt
	1Yr1Qkmkh4eNh7tq/i3V22RyKnhGYMVc7Mn433JmAWQ/uonp4tOkH5iaHgwQMzFTHzEiOUaXDzk
	mvpDkTSO87hLkv326Q1Tzi3WxWQ5Ms0meRzAsYrJ5k8+l6ezyLQs0heo2qt9LRS0199al7ysk/J
	lVgBS46d/p0/H4QiX/VcowDGy6o+bWKVFZkMTsEOyN6O+TA/x6FNuPul418YzaCy71z1VJe808W
	IAsiKm5OQl6/BtJPcwPvFKaNfNanTGk+Fvpf1FPIFATdNO2Af1a4tTmdIJrJCrMUGAEwmrKCTtR
	Q+WkSHUJhMXdbg+EZDSosmVlV8eL4MfiN+YN8=
X-Received: by 2002:a05:6a00:f03:b0:82a:6f69:7f72 with SMTP id d2e1a72fcca58-8415f588372mr19630265b3a.47.1779833791493;
        Tue, 26 May 2026 15:16:31 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bb18bsm305464b3a.34.2026.05.26.15.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 15:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 18:16:30 -0400
Message-Id: <DISYF7LAA8C0.55I0KJ1R3Z2L@etsalapatis.com>
Subject: Re: [PATCH 1/2] bpf: cgroup: fix sysctl new value replacement
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Dawei Feng" <dawei.feng@seu.edu.cn>, <martin.lau@linux.dev>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <kees@kernel.org>,
 <joel.granados@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <jianhao.xu@seu.edu.cn>, <stable@vger.kernel.org>, "Zilin Guan"
 <zilin@seu.edu.cn>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260526131035.1312864-1-dawei.feng@seu.edu.cn>
 <20260526131035.1312864-2-dawei.feng@seu.edu.cn>
In-Reply-To: <20260526131035.1312864-2-dawei.feng@seu.edu.cn>

On Tue May 26, 2026 at 9:10 AM EDT, Dawei Feng wrote:
> Commit 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value
> helpers") changed the success return value to 0, but failed to update the
> corresponding check in __cgroup_bpf_run_filter_sysctl(). Since
> bpf_prog_run_array_cg() now returns 0 on success, the legacy ret =3D=3D 1
> condition is never satisfied. As a result, the modified value is ignored,
> and bpf_sysctl_set_new_value() fails to replace the write buffer.
>
> Fix this by checking for a return value of 0 instead, so cgroup/sysctl
> programs can correctly replace the pending sysctl buffer.
>
> This bug was discovered during a manual code review. Tested via a
> cgroup/sysctl BPF reproducer overriding writes to a target sysctl.
> Pre-fix, bpf_sysctl_set_new_value("foo") was silently ignored: the write
> returned 8192 and the value remained "600". Post-fix, the BPF replacement
> buffer properly propagates: the write returns 3 and the value updates to
> "foo".
>
> Fixes: 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value helpe=
rs")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---

The bot makes a similar point, but can you swap the order of the
patches? Patch 1/2 makes the invalid kfree more easily triggerable,
and patch 2/2 fixes it. Swapping them avoids the issue entirely.

>  kernel/bpf/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 876f6a81a9b6..8715a014c21d 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1935,7 +1935,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table=
_header *head,
> =20
>  	kfree(ctx.cur_val);
> =20
> -	if (ret =3D=3D 1 && ctx.new_updated) {
> +	if (!ret && ctx.new_updated) {
>  		kfree(*buf);
>  		*buf =3D ctx.new_val;
>  		*pcount =3D ctx.new_len;

