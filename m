Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED0207A20
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075339; cv=none; b=NG3dsTL8ytj/K4dAoauAvC4CDzEqs97A/Qfmfx+vtyTfYOWF7ylPWOcVtWRXeZ/cpql+Yez1lOrZk+aFBGXzeQYQJKNH/JJKG9acFADPdgjIpEl/vG5NG+TztJrvkjtM10WNjXrCsj2yez7WcBLL8vvFcSLsJIvlvMBhE7R12TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075339; c=relaxed/simple;
	bh=mVH8XalEpQVWKwQH4hmeD5ib7D15mlvmrADRlbtsvJs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=DURKyMn13O+zaawDcSp0zFzR74tn8jLDmWEmKCaJaNsNi7iX6xYVzBoTzUGz1+z1SQaZoRguNY2Fat4r2k4kPjYSOgyrsaQDd3RfTP031gVBM3KlEY0bgQqHHBilP3mCyE0KwrknV9Wvgs94e8kALYYSqrWCVgYQyf65jbqeXSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V10ZRJ5U; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V10ZRJ5U"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso2333106a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 17:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784075334; x=1784680134; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0OXWiiZduWaFVZYnMUD3uONDkiNnSk/wggZx+AlWUVw=;
        b=V10ZRJ5UVM2IOH8M0lO7HRVmzsCvDT8aU8tEAiJoHDLdBkb5LiWog1FbklrgMC73E6
         FXUkEPnJim5sCOaBgKAy7KqDbNainClj4Dqrp1fNbA6cznvmSarHwyPqvMDEDgcWka3Y
         Pwkg9m6upbO1FXH9oCU8aFdfEwt8P5JMOakxtgj9n7JCe0nsqp5x7fzzXnBR2BrqhCvo
         tcj/y1fpHM1m/Q32fAuj0S+iTmU6q+ZEHVRanj347h3uoAJcvU2m+MzFSbsUu6MXnd2C
         s/lYuzqNBrm5IQ/ckag481Tq2T4ElCq+1s0KHeR62/+1y77xEruOVfJTp6gV8jQg/Xs0
         zvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784075334; x=1784680134;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0OXWiiZduWaFVZYnMUD3uONDkiNnSk/wggZx+AlWUVw=;
        b=Kz8lWBo9969UCkS5oidzlpO+jwphIyugiN0U2MRYNe4TDXgLtpTQuJVZcDHvxc0gaP
         YXutY5c7ry2DIkQ/IjKNsHsltpnRR3oUR+PrMyRYf2QWGZNCS28E+FoQkNdXG3bKvtKf
         AIh7wqFccLcwY8lotVSlOi9BFgpTs2DtHHpfgsvi1jd33r4P9+uil1XCU+xxoYeNqHTc
         MD9LG3RNQ1veRdjZsunPnTZcKjUm5pXQw8AQhpVSaK+nD/+YlMbV1AP4GQJ+BWyXO3A3
         Y6ybEKcQBlbny1h+1i9249ZYc31cJ2yqnoCkwSgBmwFKQcIae+E8N5VccrytDPxZgwYx
         Zhag==
X-Forwarded-Encrypted: i=1; AHgh+RpZSWfvO1L2TVEUcShh9dDWQW5pUq8pMtgDB3hiyz4Tipy4BfI0eI5+mJpA8OfSe08gLx6Neijq3ZlZwDEv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz25oVIzYeLTn/WXYACBzF/SnE922X0ujYnQCUV9MSF2T+Z1zYn
	2+B4ZoimdF9e66N+3uBd80FwNl31/Bf4sueC6eIyOEWZ+ywG1IeEARVC
X-Gm-Gg: AfdE7cnNJKNTUc3eFzZxK9KbaV8oDQxtcFkr2wKrBuL4jKfhWspn4tgQTSnPeYLWPhI
	jIs4GTmes8Vpfrv7x8zPtJLbUa9Hy4gVqo7n9oK4N/1N/dA27vuOWGLgDMlf3WVmhZxfb/0yb/o
	1UliwkLgDm30OSA6vmpoGdizMeMns5iwZ/o0elwjQrXI3Crs1N3A202jwFULhEM/fPoT7L2oWPH
	Q7w5bJhZM7vPK/IwK6wdn4BUC+ETKpAhOb1ltRjhSvDUwCxGNODTBDonLNAIL+ZHPx7/4loowWF
	ssoEGIzAh1pCkv2BOJ549Ywj1/Z3ql7lO72U02GosyBY6pHfqRTBrJ8vN36gkSZyHtLQO1xaIiT
	zNFCospgASY1CyjBwTC2KDn2+AGjDEU/HjlTuNRkvrzgbXXimCVGFVv7AAgMGdMt4TzfT9So6XF
	jULjNCMcT5Ax8Pq+J8
X-Received: by 2002:a17:90b:2e43:b0:36a:fcf5:64d2 with SMTP id 98e67ed59e1d1-38e17dc6ceemr4827003a91.16.1784075334195;
        Tue, 14 Jul 2026 17:28:54 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm86075098eec.18.2026.07.14.17.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/9] binfmt_misc: bpf-backed binary type handlers
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
Date: Tue, 14 Jul 2026 17:28:38 -0700
Message-Id: <178407531866.2243172.12944140194021045628.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 14 Jul 2026 21:58:05 +0200, Christian Brauner <brauner@kernel.org> wrote:
> [...]
> 		.load = (void *)nix_load,
> 		.name = "nix",
> 	};
> 
> Farid, this should slot underneath your qemu demo from [4] with the
> program ported to struct_ops. Feel free to take it from here.

Thanks for the recent update.
Is it still "take it from here" or was this left-over from the previous
series.

I think you've done the majority of the work here with the validation of
the few selftests and mentioning the gap for shebangs.

Please let me know what you would like me to do next. I just tested
reviewing the series with b4 + AI -- pretty cool. Was a little clunky to
get it to work but overall a good experience. (I need to tinker with it
a little for NixOS vim setup etc..)

I shared this patch series at my workplace as well. 
I think there is some interest in the work.
(If you are curious as to why, I can elaborate on that as well).

I hope you are enjoying your vacation.

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
