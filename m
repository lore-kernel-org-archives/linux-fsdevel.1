Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795827354;
	b=QaAUZrqq/7CFavVrVSX5/pJ1EroxNrylEt67DY6q36yOs+SXOhkHqr9Vpfvi9IDTez+b
	 O51u7VGnib70oBjxNucORW8bf46I59cT7/cMs1FK1FW/Nk23dddFVUmmDn3Xb7CXGCIl+
	 XYh0v7cnL48gg7XSG9ZVELUrEjjxs0NgNOpbi4xiUxmfnDvG2YPbVA1t5D/sx0QPYKemX
	 /Q7InHOXODym6xjMPq1EBc1zzrmJqN0Smr0UUvPDMBKxBrbTFbmqh/VZ9h+xWumnRJH6T
	 1APMlv7T8jdq+eCZoAGGB/JleZ01NKBOVDgirUE/Jfp3a2QRs8tjV3zFOySfzbFiCSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795827354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M4YJXz2C1qqMpFfvawPlwYq2ZIDKs+0ke0HB93yAMqs=;
	b=f8VeiBozyTuKWxL40hwF+T4ubZre83jKCrfwry3HnJamyGxA2nAtm9v3SyNnVGTINx+c
	 NcZQ9Y7O8ub3j9QSqkkQAJ1+KiKVJGSnKlOe6qpz5eNXNRP7mIgA6CakHjghkSE3GMppE
	 BXdcav2DEtyWTLGO+yuD46o0Z3fULfaemIkoq4HsqCLFahKkc/8mq9g3FoADRPlJdjTsd
	 tLoePh5kit5F9r8WSKpRHEg7v9Et5crTtGNI+aK9uhjEmLLo/ZBSVwrmDVmj/OW4LFW6L
	 VtcQRsR4CtxDIZocxz+yApYDRUzH2Kr0qtLopP6K4ibP08ngTksPkq4lKX5xt41ruEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=egc5oRyU;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB3606A329
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 00:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DCB3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=egc5oRyU
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso46038705e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 16:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795827352; x=1796432152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4YJXz2C1qqMpFfvawPlwYq2ZIDKs+0ke0HB93yAMqs=;
        b=egc5oRyUW6VFDIcdxYwZDeGVcRPdqVVcw0/9bUs8kD5ZsjJsFc0wc7Ij4lq+IUwayF
         w2XgNkLL/plAb0xjtXjWDmbgHsj8BbN8y5QH4zabvGdDwwb8xzCpvOiS/FFDQ1pAmNwA
         4uiU6YjDORB86waZuFacytNoIhdLmWlhX93TlunzFDHBxP1tk3JWqemA4JUyNxNFOtfh
         CKwdIz1EOzEmUqFvrYxqw/6yXUkip8rv4zUWrx4HDc3q++gCUskaW4sXZoxU4kXNS894
         nnM8O1l8kivUFX2WTqpxfjbMSvlGbzGIvqyGbP1cvEGn8taKbCLd436XionhZ+TbNkl7
         Tb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795827352; x=1796432152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4YJXz2C1qqMpFfvawPlwYq2ZIDKs+0ke0HB93yAMqs=;
        b=cHFHNjdx0+zyvneDHICEFzDC1LXeaaL78oRcGKdFOtMFmRfopB3Q1BvWC2sG5SYg4n
         9Lo0bbNY5FweUZC8UDyO5TpvieOW82SizLyi/wkPcVrR37l7uImun41OkuQxqRTWUO8V
         3Z9SKw6o/mF9BRdEasAhA+sj4B5ldEWdMz/dXrXlmbpaGBQVIad/qIPT/2rx2q81QM88
         Ih26GJoQh+wNuARRJvkaP5nvoB/5EuoVQBBF8l6fML20AShhS7B5+sDR9zE7AtHWea0W
         9i6/alN+41LRvOBcwWrBxFXBqpHscpMzrmzyfJ5C5CnJyxQdwPka7ZS/wdtFawUjpT1B
         DMLg==
X-Forwarded-Encrypted: i=1; AL+hErG48+Ht3IVWQw7bcqKQl0uFgEQYiun19PLRWB4xOL/vWO9siggQIHFs2fmTbmeuYLyUguqS13SqqBI6OA9B@vger.kernel.org
X-Gm-Message-State: APuU4Z9R8scdFXvVrkKUoSXZVH832PKAUlWF85wmWat64BWwwYY2BicL
	iY4cIoxQuHc8rNgUntNkZ4txnXdUalu5ymhoIzk8HIX5mtIyiX+nlsYS
X-Gm-Gg: AZFdTZc769hAfS7lFhF2nQwe12LxVbeuoX9VHRFqcpmQhOKd0O7lX/HoL/mHaq2Cckr
	TTz9Qi7XZVvu6jtAuIij5cSbSPLQXpxOARTYxYak6P0Np7tq/WI0O3Ws/upa5YwxrdMSLJ2s3KD
	juqTyIWR84wICBqfzvAg/sl24rTo4Dseo2tB8xvClPgBf8jcV6XmjHIXzUrzbqhLI9huHPeVr/B
	9D+dfttcKxnk21wSYpOpNJqjBv7ZqFX721lD6NEW30rE/yReIGbNZegpau3PCUK0v49OkbRtes4
	TzhtZMGNBPK+3LOcrNOLznkfkVcMLBbXOoLnk+s4CSv6nkk06DByZs2zC/TIfHgPYANpbyGdz+B
	EOBn7VGQiyWcYq6dRnLKlrkaLjFAUilM50ClidBRqU4+YmHD4CEzDtawddnUix4MqU4pER+1Emb
	hfhgMJHKuk9xTRydwbj6bgnKh9W9BP5agmB0yy3FrZHV/CmhJfwtbljXOjqqfBtVk3UvhPft3AT
	qzuUp8ha+NNuEj7bsB8n9ix1XIDvIgjGEGeKU+TJi2cJcnelJb7jdk1HYv2R70zSdWx8q0A7jKY
	4G/s/mZ/NC/cHjpxM5IlDYN4zQ==
X-Received: by 2002:a05:600c:4e0b:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4bb8881ae90mr541218935e9.32.1795827351797;
        Fri, 27 Nov 2026 16:55:51 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8538b09bsm1328407645e9.4.2026.11.27.16.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 16:55:51 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: jarkko@kernel.org
Cc: aleksa@amutable.com,
	alex@amutable.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	containers@lists.linux.dev,
	corbet@lwn.net,
	dhowells@redhat.com,
	ebiggers@kernel.org,
	giuseppe@scrivano.org,
	hughd@google.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kees@kernel.org,
	kpsingh@kernel.org,
	lennart@poettering.net,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	luto@amacapital.net,
	neal@gompa.dev,
	oleg@redhat.com,
	paul@paul-moore.com,
	ptikhomirov@virtuozzo.com,
	sergeh@kernel.org,
	skhan@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	zygmunt.krynicki@canonical.com
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
Date: Sat, 28 Nov 2026 03:55:41 +0300
Message-ID: <20261128005541.873229-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261122193539.3334213-1-jarkko@kernel.org>
References: <20261122193539.3334213-1-jarkko@kernel.org>
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

Jarkko Sakkinen <jarkko@kernel.org>:
> Work on this feature started in 2025 after reviewing David Howells'
> container object patch set [1], whose underlying mechanics made sense to

> [1] https://lore.kernel.org/all/155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk/
> [2] https://lwn.net/Articles/1102593/

You put wrong link in "[1]". This is not Howells' container patchset. This
is Howells' fsopen/fsmount patchset.

Link "[2]" seems to be wrong, too. It is not something "earlier", this is
very recent LWN article.

> While the patch set is manually written, the original motivation came
> from isolating LLM agents

LLM agents are too strong for Linux containers. They should be isolated
using VMs or using some Linux reimplementation, such as gVisor.

Bacik said that he tested his patchset in Anthropic. But I think it
was tested not for agents themselves, but for something else.

Anyway, I suggest to drop this phrase from your cover letter and think
about some other use case.

-- 
Askar Safin
