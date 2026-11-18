Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005642;
	b=IhRcjIX9FoMh+TiYWb/dxtOibNTEr2QJ41XrHjuc49zgq3//KdrNXh2jqhBp+amNJAF3
	 JcKjPh5Gm4NVrx9xiqiZckQiCGiSDOuYlsUYY6gxImpulzr8DGStVvu8OJHU9BIO+ksLN
	 mUGt1XHx+dNj5H7TcooedqpnawZiSQ79sYmAn6Tm6vkCtTJVrbWUmdpdl+MdCWKB8ySd+
	 lZXq/C5LulMYMBVu7A+BRLvCpb92rn/vnvxPxzWw0sRzt49ODE9YyzYqPcHGUSTQOHVkH
	 6Lkk6DWzEsrPeoMsSvYv1H9sYgCGhjNuDtggXqpy79bCMvrU5hQwiJijh7vyWEJuOYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3R41f+Uc35mAz7uI8DyanrUHiDzSxAIfTcbxQ5KsNGE=;
	b=mCGVunyBc2Shm/Wm9o0QMQAPyqn0N44o0DkhbPLrjqDyT5rh0MZzsLA2xk9zVtTdMd/4
	 KjMID7dREL5pZJo09NM8bMnI2dcnDMN93XogI4JdMcfYzoTkubawiNc971OF87Jjq/fhs
	 VyBrhVjoHWyeqo4gQpkUsOXc0h4SURWIWkOCXuL6YSU6VDXr81tZOMsNjz3mjSIM5lzV3
	 Ee/wXLZFqZFd5TM1prl3/aLx6Du+S9Xmco4WP/Yw42nw80rys03y8Gc/ImYmgr8C7F5Op
	 cXtNbNISlCm2Hzlj8H2WQ6NNuMj/+G16aIAM6CAflWQ/r8KCnCgSzbrRmGUcCnUT1qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xnqozYU3;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B5606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 12:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C54B5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xnqozYU3
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso5830975e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 04:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795005640; x=1795610440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3R41f+Uc35mAz7uI8DyanrUHiDzSxAIfTcbxQ5KsNGE=;
        b=xnqozYU3wqgk0WhK5PmP5yOZMWat21Onnf6+sgImG68WoTaifxU4e8NLRj9klqmAN3
         sBm/1rnOXRF7LkWjDjBT3N2AZPlXNCTYbTdB8xzdjhAmImSKRcbeJrv0ezW7XN2ey4AE
         WOuXU3cDDu3EuefcniQibYvNy3Xgfz2t48Z7+LXaagQEt4XqPnmPahYvJmtwCrOcCaNs
         +iWMdVJxJSZ6XXV46hM/zUu0q2n9y0OTQ+HzKNOoo0dz+qzoDMEeP2EIWna4CJzf/wSe
         gYGPNm3CFxpt0emTgtOOjWZwvzpfIYOEsKWqkAgig0pwyHHBgqrWrDYwlHFHfFT+9tFN
         sfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795005640; x=1795610440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3R41f+Uc35mAz7uI8DyanrUHiDzSxAIfTcbxQ5KsNGE=;
        b=XiCjXnr9iE8YlqqeqCqqYxgXWhyO4OBVU1i/X14KTnMyVcOT5Z5OFzBRWzfYOc+x0h
         BNENYXTjeM6+UVPPAHQgOtZAH7tqaI3LXAAXH8T63/axdXOXP5i726GQbokFnYsrV7hT
         u8sXdEarG8kaXN5te5cHkyxo6vnpB7vFmTZpFBWZbRezQNVZuZa143fMNB6rmNe4Z8wd
         1BghHNCx2ynWV4ZwjMBiexTSR3UOj1jKCwX+G16BzpUL5IDBce7GyqjRGsJey90tZKee
         7OjcgFHR27cWSPIwenXo0R7/H0ibekv1g1sAYzY3O8eSQfqrSGqtq+SaUqVAlJ945yf/
         I75Q==
X-Forwarded-Encrypted: i=1; AL+hErEvHvXdyNtv1ps4CzCL7vvuhNfnaGSWOTCQu2yH6JCO3126hhslQHajyU45tBm8X9z8ptIqEBu1I0EZ0pct@vger.kernel.org
X-Gm-Message-State: APuU4Z8Xn6kr+oxn6PbYfuPdO6cIqtgTx7SgicMRzTIjeZJhgRxyIxve
	0qOzao1Pt0o0nZlwUm9iB7AbKUsIxyl2zdyX4pqICgCXYvbGnhZapacDuYRq+ZJc
X-Gm-Gg: AYBFou1xjS+OJ831BkkhSyBDeC09eNFhDl3sWlTW8Z60/h0em8q3KFwU4dJ4umm/Weg
	8VkOVLiqDlSUE6+NtBuuLHb97jJou+SDORzWN9pd2nKFEwK40h6wv1d55nhjm00sev72jhzICZc
	TY4VAzGE4BQsPzUyMPCaLojHdZCS4Imq7T5pS/mNQYRjvMm9KYD5z50AZ3lJIxQOymVNrLvWKqO
	hR9uYj57UHGqMmAOWjvX2K/stIDz0JXKA9cfYEHwlxDF23yrdlRIaJONLKAJYNQ4Q7QRGXlB8uu
	MVNTflu7ZKlJDB8lE7haQXs8HaXS2K+kVKLud1fLhgwNkyqJOkLR/fabLvb0r/FoJ9Q449QFxmW
	TAVjrsR4ag/uUrWAWlW5JcZ0yJmAJjf9FGyw44+olYwIcoARihCaG7QhxtShmfGj+3n3kRqNFja
	OCAwkMxWK5G0QZ4kGUXdCWHd7KTV8JRyUC+JTOIID+PDvn0zuU87nWaS7ZICxOn1j7MfQwAPjwD
	lyBYFZsuMmcEaO8utI8MrqkuUWPTtyBWnpJXsm4TSk3O3ks+OIamtNCul/iEEucVZTqjC6sxD/3
	FktBiUgwfXGcr9W3dgtmk62LQ1ZSuBOuRH7JZkgW/mtVPEeusN/YzGV1b9e2PYcX
X-Received: by 2002:a05:600c:8b42:b0:4bb:7033:de79 with SMTP id 5b1f17b1804b1-4bb7da4afa7mr45012725e9.35.1795005640059;
        Wed, 18 Nov 2026 04:40:40 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm202148605e9.8.2026.11.18.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:40:39 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: brauner@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	memxor@gmail.com,
	tasos.papagiannnis@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH vfs-7.5.bpf v2 1/3] bpf: Add bpf_path_getattr()
Date: Wed, 18 Nov 2026 14:40:16 +0200
Message-ID: <20261118124016.77086-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-spurwechsel-entwachsen-wildpark-e6322e9caf35@brauner>
References: <20261106-spurwechsel-entwachsen-wildpark-e6322e9caf35@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> So we need mechanisms in bpf to guard against things like that
> architecturally. Ideally it would not just be a filter like in the past.

I have been working on an approach that models dependencies between
LSM hooks and kfuncs and checks for cycles in the verifier.

In my prototype, kfuncs that need this check should be marked with
KF_CHECK_DEPS. When a program calls one of them, the verifier invokes
bpf_lsm_check_kfunc_dependency() to check whether calling it from the
attached hook could close a dependency cycle thus it may result in a
deadlock. The prototype rejects the program if it finds a cycle or if
the necessary dependency information is missing.

I have tried to model the bpf_path_getattr() dependency manually based
on your comment by using the approach that I described. But the difficult
part is to cover all relevant hooks and kfuncs. So I am looking into
whether there is a way to generate or validate some of those dependencies
automatically. I will continue working on this and try to send an RFC if
I can find a reasonable way to handle the dependencies.

This approach could benefit BPF more generally. However, based on my
analysis, it looks like bpf_path_getattr() would not be usable from
the hooks I need (assuming that it will be available for all underlying
file systems). For this reason, I will drop this series for now and look
for another way to obtain the information I need for overlayfs without
introducing such a broad API.

Thanks,
Anastasios
