Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608066;
	b=L6ztasObaQ5aOUGyRQILFODvjCpEkAUzaQlbDKLW9j8JBfm+Ea3j70TvP+2Kxg8xg9e0
	 Q1ZGygMEXlJHHfMhAc8hzEXYYBpIHADdJpCMmQzZgEscUQ6PSuIHxw/OjdIMYji4XpsKN
	 8C2JpJCFPEMD8qwZ7A+NDr7zWRFEeDFW3oCb3Kr1yzCqia3Txz3kX530TuWZNtmf/eM8S
	 E4Sx356108FMARO0gil97SIF1QtYBjH4AoN7KsjDCqTiJBKgz1Wy81U+HfVAQM6ZdkGQm
	 SrW5kS4tc1pcchTvx/Bb2AxGU3vALveEkp0eGU3IHGw5lBtTR4WWvvwho23V3vJZMQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=VHi+ZeXinLJkVfkfboNP114V/6h0aWxNJE4DAqAGB1U=;
	b=Ri0HsiKWrlniFv7YJ5UOzQCRItQATUHAsDH9xeq7EMaQrLIDYZCMNbJSurXdLucXev2u
	 lMygr18ue1l6pt4uxxITZL9Lp3KU4N+OtdKNJLEP8xcIJ4KZTyTde0C9ScUxIPBQmEV/8
	 tStZ2J+oBkVOA9rT50sWZ8aQdfquDw2Juaw5HoPrWkLC3wGpGQlwIYN1RXG7/7Y3YL8fI
	 cZBCvi/xtWtv5hxoIEt4igbdKOg2g4B/bc3z1PKsPHwp2XllClYvaA2WQ6FDTSHbyJWYw
	 NW2mdFs0Xb9mf14zfxR8x3LvFnXbDf/RzysQDkQ/XVlnzk4sC1C0XswGr5aI6HfQi4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fjMOIPEu;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D7606A8AA
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 22:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A60D7606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fjMOIPEu
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c55ba309c2so2088953b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 14:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794608064; x=1795212864; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHi+ZeXinLJkVfkfboNP114V/6h0aWxNJE4DAqAGB1U=;
        b=fjMOIPEujQ80OPuCk/2PwfPYl4muqyhEYEkrnqU2gj6MiPamTimEwjYFMt/H/9w7Wi
         UTuuENUdduvK1Ox2OM9j6e9GAJEMPHdc53tzSSDAj1a6+ARSpQiJsqLxzv9iHK/mIhuf
         S7bDxajxb9GFPHBWxjr2+Cfgm9DIP4GdAUYAQ7eGXov/HX/WKBKO8Vtt/FaZMGUFO88G
         zMbzVQgLhL2PpkBGRoAQhEpGUZU/UEjt0UKMkpAYQ9N6m2bW/Wte6R88jCKB3aczvlkk
         m3wa2cFuDRz1ah8RH2GBQgPRgT6KSKqZSiMGkxEnsF2VUy7YKRxWdFGIaSzdaXSeadYS
         e9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608064; x=1795212864;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHi+ZeXinLJkVfkfboNP114V/6h0aWxNJE4DAqAGB1U=;
        b=lHNY7dfT+ZHxUDUZKudaxdvCSeFl3ebZ5r5Jdc4f2+v45AlPuRO5sTRLEAD7U201G2
         tonqVYxMs/zwgYbD8s6tal3Sn31ynNlXD4PZseq21s4KxbuCnv1ORcxWKZMxHoV3ycvm
         z/w7EJWReGb8hh713n8hK6jPSXwN9Nuni9GzJxM1Fzwg4mNRXK96znXHJ60RDnq4sDCT
         TFZkv2Eug+ItJE7wgBIEEJfAOsB1tC8Uf+8hUCFANxU4W7QQKwBH9GfAdbttKp7BihU8
         w1aMeUmpBCLTjmylZbf/+2xUWsxXMTnPINW2bxgBg8G4SzQFjbq2nCsReVrQlaREva5V
         x4xA==
X-Forwarded-Encrypted: i=1; AL+hErG7hpN/UV50AS9P8xXYuScaScoOZnTxyrBmXP3Gg92LeYKX7sGj4MBmYdYDff8WF2zFgdPkywqn/K8PNn2s@vger.kernel.org
X-Gm-Message-State: APuU4Z+DpUrj+krOZRSRrrlGGfWFWrAJyDhXIzFUSrhhQNg/IelQeE6Y
	V9rUuVxovGKt8VbwoRsn5rgEk8VlNU+kgqVy7HdGT5bB52w8JnZCJd8wKFEZEngVQYi7cuV/+0C
	CSanUPUyGvLN03w==
X-Received: from ilbec7.prod.google.com ([2002:a05:6e02:4707:b0:53c:f2dd:1e17])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3505:b0:536:611a:7fd9 with SMTP id 5614622812f47-56e6015e8cfmr3125630b6e.7.1794608064235;
 Fri, 13 Nov 2026 14:14:24 -0800 (PST)
Date: Fri, 13 Nov 2026 14:12:50 -0800
In-Reply-To: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261113221248.3535369-16-wusamuel@google.com>
Subject: [PATCH bpf-next v3 5/9] docs/procfs: Document KALLSYMS_QUERY_* ioctls
 on /proc/kallsyms
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Add kallsyms to the /proc file table, and a short section that refers to
the KALLSYMS_QUERY_* definitions in include/uapi/linux/fs.h.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 Documentation/filesystems/proc.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index fa7a468e8edf..442aae9ebd9e 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -761,6 +761,7 @@ files are there, and which are missing.
  ioports      I/O port usage
  irq 	      Masks for irq to cpu affinity			(2.4)(smp?)
  isapnp       ISA PnP (Plug&Play) Info				(2.4)
+ kallsyms     All kernel symbols (see text)
  kcore        Kernel core image (can be ELF or A.OUT(deprecated in 2.4))
  kmsg         Kernel messages
  ksyms        Kernel symbol table
@@ -1368,6 +1369,14 @@ Provides counts of softirq handlers serviced since boot time, for each CPU.
     HRTIMER:         0          0          0          0
 	RCU:      1678       1769       2178       2250
 
+kallsyms
+~~~~~~~~
+
+Lists the kernel symbols of vmlinux, loaded modules, and dynamic sources such
+as BPF JIT images. The ``KALLSYMS_QUERY_BY_NAME`` and ``KALLSYMS_QUERY_BY_ADDR``
+ioctls find one symbol by name or by address without parsing the text. See
+``include/uapi/linux/fs.h`` for their structs and errors.
+
 1.3 Networking info in /proc/net
 --------------------------------
 
-- 
2.56.0.679.gc527c65306-goog

