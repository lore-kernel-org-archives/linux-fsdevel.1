Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181510;
	b=26DlC5LuSloexcyNCqZDwHsbbevtqV17affQTL/1ymMh0xhDs9tvxZu1ZG/iztCOCslQ
	 rXicYC2q5MTR3v36nm4ARZFTsWVUskt0CcuCK6VP3W6JXkxFOtpbKzERkofU6QrFBWV1C
	 hAweT3zr2riy4Ms4VP3VLo1u5Md1yAbYyvEtQ96k/yW4v/4cXQAu3ayyDUMDjDYGQsajj
	 D9ogtDPKJ+vFEufEVzBeugwAfizzhu9oy3fmVs/z8XwH6uoSpUotmNbNp1OIVoOcRc9XG
	 yfnPWm3gQ51ikJ36/aInBS3OIuqkQjOh5eEw3yjs9aQCHe0DK5GrjuFGzuMVUJspFrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xPq8vHZRjZ0W9FI56EPWdeooS/iHKvZIxdKn8ZO3tk8=;
	b=TPs+dxqnCRnC5M7hrXv4SZ0+WaUWs58Ff3SrySuqpDJf80XzG8oC9G0hmmBOkjiaeZsu
	 Nv7x6V8/9TsUgBto06Tu2MKxjtiEIBAnCQLVEgt/BSoxkC2TjrhIkQA3T9jt96jJY5zRi
	 uh9xgPjPkKY24NonVAh77tfgsRubjWjznFYRJx/MPZFAsGFxWJmKZmwoti+a4qhVgOygn
	 qzzJocapGDgBAl/GiyanCyLSw2/yabvaSEahvzuG2FHQqhwc4ZmR2v7tebL9oaTs3NYzb
	 6Ai71tma4D4dw6dJfINdL+AGyi3GowQ+Zc3GKY4ZmmW4t11Rz5KSVqH63gxKS92hyRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqGiFZnr;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE4B606A32A
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 13:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AE4B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqGiFZnr
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c511cdd5a82so113326866b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 05:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795181508; x=1795786308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xPq8vHZRjZ0W9FI56EPWdeooS/iHKvZIxdKn8ZO3tk8=;
        b=hqGiFZnrjqYQFj881CYUJZtgImGi0ugXjpTVIWee9kUXRzlYa8/9BD81x/+zkFKwk8
         Db6t14iFQ/UnZINNbCXUWvuiqadZPfWQImoJEZZ69c5+JJUJu8MdxYvqH/BEaoeEhnED
         HTUthonTmsUiDPZ6zYrW/0oH5l3euOmv1Bk2XdsyNRXRXm7JwyjhNaXKy2h5vCBfKomd
         iXuTNYGftedtWmWCHiCAjgbNLR1YjZhAIi+Vgttbwu9+ZcoW1QOqlRLJLmefquEahX6Z
         kmJ9sS6uhjS9819doNiD8n7z6hBI0hE0SjgDO1S644sv/ie16h1NKkJz1l6+F8UHMae2
         niuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795181508; x=1795786308;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xPq8vHZRjZ0W9FI56EPWdeooS/iHKvZIxdKn8ZO3tk8=;
        b=dM+Z/IQ8jpTIpkhRHo4NTHiIgQW9YtpsVZsPXoQWJhX5pQ4dP3kYes4dfkWs5Ve83p
         72jGJqOEXvco6LHzrjJ3BZsr9MgihXQ5xSdHUt1PZb9gnLzpvsACTXtAcKuT0b/KWScj
         KpjA6LJqUFGaKKedUYqEcu90qYzkjl5PkEO0r8kawYdaTrRFbGyqudyqPyNwuDyWAqX9
         0Epb+x+REG4n+n8K8FWZkahd+h8fZi8yNBPoyWGJwRWzE8lLAJJ7uBlrfPvSszJW/EGY
         qOc0a6yqyg6LK3Hq/jgoRrZ4azLwyOrx5RxNOg4nAQeM1QMDblUQON7+udPsDqwvrA/e
         FNjg==
X-Forwarded-Encrypted: i=1; AL+hErG7Mkhwz6VUD5IbLx3PVe9qFVkmS7a7frk2qyAEf7M4oGsHHjQdDwKMLIHgIIDGIGdW9tAmxEhiJXC9mG9b@vger.kernel.org
X-Gm-Message-State: APuU4Z8FnJzcH2NAsWhKpMGPIYEW1+jP0SSQxf1wZyk/TIDe5nUsCGDB
	qtusePgd8Oc2XnZJsrBVQck2eSWXB0pVQTrhqvy/Obwv0aQ7IxJYBIyM
X-Gm-Gg: AYBFou3q4AqoQHLPZ8lMl0D89ByatEB5vjtn9BS566N6PapeBx7HhCb4qI/0lkfkQA6
	2R+G25XABIux9PbnouSVs+Lw7Zkag6G7jBt8GPbGosAZ8sFzLg1limw+nmK1+OLkXQUhdQOHLgI
	Gg5uvpYCYK0cZW+/7IouDTY3imgKeEB5PMuNWKZXA3dyrT79B5drPvbbXnMjp1IdzrhhrS+CoO2
	grULTq0towye2k3xJqvL0C2JEOZJdbWAnI6Gk5nBYV3umLX/tWMeBZgR+VtPfGFhrKFZtCdjGSb
	VWD/MWO8saqgHDbxP0p0KyyaSls5c8EEPk6BRvuxVBbibxVpRIPQCI/ZhCYOEr/FbV/3Ro8M2gl
	OQ4Tp07lSBeGgKOsXLUh6rp6gFW8FytOJyqBNxFoO5no722Va9XmwoYXeDOSeP/SdQ3gE3t46tI
	/qWKChUfC1JZLjIvWpwhi93Adet5imbIp18wmC0yRXqWsy9d99/B0HU5CBgkmexI4UquSsuBdNT
	hinYuKBHjz4W/Iu4ZSgXvcJD/wGO3qAOWNU5xfUSMpj6+V3NnNSf8DchWOvQaQpMmGdZ6HNyzHB
	ASoKHRQ0Ovsr23ZGq0qMaGmK0HDHbkKcIX4HIk61ECy12oLTmDMkOvDJGr/jCpjtDfVFND8nvMR
	bHL/OmstMJF/uITOdw8EuHJunQmbBXYmtfb70V3iWK2MEa23sM4l6YEU2ljQ4rlqSBqKtU6leNk
	hAAffm8DJzc2bYhDQAUxmateLnMQgmvadoaR0sugz1wm5+35r3JW7qFCRVf0KmakWJWyxO8SbX
X-Received: by 2002:a17:906:6718:b0:c16:4e5:944a with SMTP id a640c23a62f3a-c513ab0845cmr226867666b.21.1795181508436;
        Fri, 20 Nov 2026 05:31:48 -0800 (PST)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b022e84sm94908766b.84.2026.11.20.05.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:31:48 -0800 (PST)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Cc: Krystian Kaniewski <krystianmkaniewski@gmail.com>,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] WARNING in vfat_update_dotdot_de
Date: Fri, 20 Nov 2026 14:31:42 +0100
Message-ID: <20261120130030.b0aebd03565f5774f7f8-fix-9f08@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I first asked syzbot to run the original reproducer against the unmodified
v7.4-rc1 commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4. The request was
not run because syzbot replied that #syz test is temporarily disabled.

Commit 9f08e58149dca8453bf99e0af35cbb227ded17b1 is included in v7.4-rc1.
It addresses the reported !buffer_uptodate(bh) warning by leaving
BH_Uptodate unchanged after failed write completion. Local testing of
current mainline with the original reproducers did not reproduce the
warning.

#syz fix: buffer: stop touching BH_Uptodate on write completion
