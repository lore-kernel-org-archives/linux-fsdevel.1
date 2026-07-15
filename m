Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6347220F2D
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075340; cv=none; b=PzFjFhZYKcQlxNdWPiB60qyeAB47a+y5pHCudQj42seMgFLaeK9ESMK1VDRhptJEsag5/CieGnUqpOt6UQve5HyYa4F2czVG71p7qhD+JaSE6bt7Wimn47hyWQakCLXP9APRfZKkv/Tv3Brf379VNDFIAv64ZPgUMSOoruiwRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075340; c=relaxed/simple;
	bh=rDAS3gxFQkGx84z+5mChKIPQOCXxsvU+LYFSE3N3/PA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=REEeJqvaZkaWl7a0uUf7W6dE6UUCy5mgfG9f4mvEUSKm3C2uJxmjV/hEyZfpzif0TJ43CQn3DZ7ezG2YcjqBs46y7BcCmHnNF61qAwkCUVQf66Ud9fnnSVOTlv0TrNsO24RPXZzmb9QEOM7cKi6CeKFceM6rdX+WbJ/5eKYETrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1C3tWLh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1C3tWLh"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so1192953a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 17:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784075335; x=1784680135; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ftTY6hTUShaj3iSHGB+R65zugY4amQnONmDFuo3xbcE=;
        b=I1C3tWLhXutzQC0BmUK0Pg8M7ubIMdoB+8ODwNqx4Q6ZWBNwaU8rZHOnaVrBlx+L5C
         Cj4FcqVSogYRuYYG+KUKyIB7FHvmhHBUEM4t9YUNjOyYY9x9Mkb7g0b9JtenR+s0pzFZ
         f46i9YpmnYLhqmR1N/4Du6F/elimHcFquGaTbF5E78trM/mq+ql7vM6Wa0ocL8NvjAPg
         Tox2uXo6h8U1pIB5bVEuLIXrA2GCj/bap4ile99ffZwG3eEA+e7rW8h8tt8+5UuFWOLv
         PenikzUccV+XdcJkPnW0FxuhN9+gFqFecG2wg7u2fYi423wECjW8qLekVplHvt25xxxp
         4tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784075335; x=1784680135;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftTY6hTUShaj3iSHGB+R65zugY4amQnONmDFuo3xbcE=;
        b=tHlPTu6bq3Oi+lNI4kukqTbpy8XDFvdjKhpuUUkicY0DPj+nM44MIybCLX3E7GkE+T
         4T0NMBqvanmvh/VKuxBWKu/b4HCkiKO/pIiJjmGLqdmGrgfgwkjm9BVy/9h+BdVYuf9l
         /nQ8S4sigpwqGEsJAt9nSbs3sPYZ0DGRJZ4GupbZVNTh9sViug7VpGXdNqgK505gA7kj
         1V7BLRKy0wfnOOzusN5CAMiTLepLD1Q52kKDzUEYJXXp6MRBzF1TjeUF3V9u5Tp3wfzq
         I6DdfVax1LTUZAEeTSAQJdRWgBZC1BtWOWpK1xO7LO2LeFH0SXKtFPm01YxpfVJo7otc
         JMWQ==
X-Forwarded-Encrypted: i=1; AHgh+RooJODQ1WL1VYIm5gZd9d+joe/9lJa/IWuQEMTwvhGIp9GrfXg0gxU9aH1wicpTxIFBSTHVVSR/yAIxqRjw@vger.kernel.org
X-Gm-Message-State: AOJu0YwN37ThH1/oj0W/TgwD3s3tj0TjC0HMGrS30FgGT3ITLVrqMKqn
	X01R9bponFwomHVXbUDTApXDo30DWbGAlhTe6CmVP0D/ZfNREqkOewbs
X-Gm-Gg: AfdE7clXVFciBb5yNoy6xXkGwChbj5+XXIdExSUJq//UYrstHOstvIhNS11kVad/Fdp
	WOsKvvUb/kuZVHuM8wDFo/EM5dD4EBekPVUkBDS14b1TtU/jgWKG3/T0pT27+AWE+hJkx5TCtny
	aicXgzyIrv4Lx/kobx+JUxDTxoIFcvZgimlhO5Db9m7O024f4zUBMZ51QmSgAFdsBXl7yGL02YQ
	MFVyLWcFLnICdIZ7ZlxBqOqgzBU5vdLuEyib3Z1n9EeoB5HYd6ejapPNOFyd8koeVUdDnk3y2av
	ywLkwv60TbX9I2n/5jOs2Q33nqpU7Tsx7WwumN0AQNk0iAU199xJ4na0O6qEqj/GLd9P1wGxxcn
	+wROlcw5UGBo46gztW7W1AmwjgVmGc/cle4vXSHQMCg2tMQas3N4mDFtOTJ5+l6/oo6BJi57Lvx
	auTE3sfv/CUf8+UDhO
X-Received: by 2002:a17:90b:560f:b0:389:8f6c:4d59 with SMTP id 98e67ed59e1d1-38dc7779d1bmr15305942a91.24.1784075335188;
        Tue, 14 Jul 2026 17:28:55 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm86075098eec.18.2026.07.14.17.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/9] exec: stash bpf-selected interpreter state in
 struct linux_binprm
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260714-work-bpf-binfmt_misc-v2-1-57b7529c002c@kernel.org>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <20260714-work-bpf-binfmt_misc-v2-1-57b7529c002c@kernel.org>
Date: Tue, 14 Jul 2026 17:28:38 -0700
Message-Id: <178407531870.2243172.45650472171661452.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 14 Jul 2026 21:58:06 +0200, Christian Brauner <brauner@kernel.org> wrote:
> The upcoming bpf-backed binfmt_misc handlers decide how a binary is run
> programmatically at exec time: the interpreter itself, an optional
> single argument to pass to it, and the invocation flags that a static
> binfmt_misc entry fixes at registration time. The selection runs before
> load_misc_binary() has copied the binary path from bprm->interp into
> the argument vector, so the selecting program cannot go through
> bprm_change_interp() directly without clobbering argv[1].
> 
> [...]

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
