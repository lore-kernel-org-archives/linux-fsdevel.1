Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714637;
	b=ID96wz8UsHDUYeHQq8aMvJxjK2S/DkcFnXF4X1xw3a/GmxxH7mjjz+nH3sDtPUJrjfGi
	 iAH9IUX95E7e0j+UvJsCSolv35Qmgep5Dx0cKoka062BdziQyZETuuubQC8we8jkwRn4T
	 CcY8mjyV6Ka2bmvhao2/Hm6V8S95rCxhkeL3xnlQKQ94arPCDJ00Hpk1Iuj1J/vreJH/i
	 GnMQdoX+P0DpaM/RwUNlpd9TCH6A2Aa/8i7P7pxOJHVSGx6yrqqfyqutcE+Pow4s9gdOg
	 H94WS5YAmH9HOhD1Tnqgu6sOXmYHozx2rFROow5T5ELnn6hxwYhCqOo0nrkYHZx3hjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=k9AsLihF+plfOh4bix9+PxHbqUaaLj3NetmJnD5B0HA=;
	b=BYaQsZq06MKO/UVkNvsaOwgcccvhmb7uKD//LqwNe3h6QFVLEXJXqRX2lZ/hAnH9PS41
	 qfaZuDFvgYMGxDIPWB5Mlk4W8QQA4w89eYW1eMKdLwXjKzocJp0aggy2zvYPPHwvD4ftX
	 ynOZMF+8MT9tfrR64ysYCdLK1a1tgxduZ7W3EUCCLfGuDFZK82V3G1zZdUuydM4dIWz+V
	 CaVBAAnJLhTxJrumbVovYW7dkbdAO4JoU1bQxIvNMYwx+YJZqpckXWL+XpQOFCfP7if8N
	 oggjsKoYuXXClZfd7mOOJKm+r9vBaHkDLxpt/Dl43SKg9Rq4j4Xo6Pcqx8VRMMm38Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=b+lefz++;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8ED606A319
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 00:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F8ED606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=b+lefz++
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3552883bd19so1116758eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 17:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792714635; x=1793319435; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k9AsLihF+plfOh4bix9+PxHbqUaaLj3NetmJnD5B0HA=;
        b=b+lefz++RY2Vf+vwPTZKdVHK2gPGoWcL5qKzIYEIZlGq1QuO7Fb+Langj4r599r0pZ
         SgowuDwyHZQIUwoSDKrZ1tm7P2Y00cpjASYrPKTmPttnr3qBfGqLPw0eikfWOWQBvgoT
         G9HA+Rloyr9LKBsBo44Fwh4ORzs9F6yo/t+UcyOuEFcHhJl1g1pypjL2wmKG576A9zXP
         7j7fch9H4Piad2uCHWgA3ljFsGw4zw8PwW2Uj3GW+MdWXNj2YoutMVXrJO7jgeNW2jcr
         9/rh0STYq871H+QY6H8mx28wdSRwy3yGI92/+49RlhDLIMlDnLINFr9ZhzDhPDeYWJKG
         gvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714635; x=1793319435;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k9AsLihF+plfOh4bix9+PxHbqUaaLj3NetmJnD5B0HA=;
        b=avytbNp86tfhl7cQVWQe/Ll88C+FsnCmqicF6q5kTsil9huBmvxNnKt5143JWX9ztD
         UocWVfK5C+m8kcl1HgvG1kBwcgR57j+bNpil/XvxNQ8DSKT289am4HRR7gQTYNOoZW0E
         n656hxGUUV/14BwyOrycYwI8CC4o4l1P+7SgGZNI1k6VpNVuUBUFhDX2uGUD2qZRCYun
         dCbXQ9w6idrTRlzNVwDbFEeMCCGNCZL2thoiuvwcnQ2h8BtOcwLMcv4jmP9wznP9bL1D
         cKuVpuDDygu9NQfdhl/DSoRbxKYaMQnigDj9CfmIfOBRqcFDy2QM20TWT2IU7jMt/LBO
         1Nvw==
X-Forwarded-Encrypted: i=1; AKwUvBzdP9OR5/4GrqzAP11yKDIS8PzPGDBnCCQo8/vvbowG+mCLQZ4bD4uc3Yl7umI7nCA1McvayKvtWfqQzjS8@vger.kernel.org
X-Gm-Message-State: AFq9FYKp50IjDD5IFnlKPkCTDqJMtHGDGfmFlJeZahKIXCvHwsqNgoF1
	T94ieSts2tI40CXXV9pa3y+MGna+rXrxRVm3D0sjGU/i5mN8GJ7H3R+JIrJasv19jyyedMNYCF8
	oqhP13eoEbJuybQ==
X-Received: from dyuq24.prod.google.com ([2002:a05:693c:66d8:b0:351:4a2a:1ece])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:a225:b0:351:6b27:d67d with SMTP id 5a478bee46e88-369d9802e3amr774839eec.30.1792714635111;
 Thu, 22 Oct 2026 17:17:15 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:16:01 -0700
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023001603.560210-8-wusamuel@google.com>
Subject: [PATCH bpf-next v2 0/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

/proc/kallsyms is the primary interface for userspace to query the kernel
symbol table. However, resolving even a handful of symbols or addresses
requires reading and parsing the entire text file, which is often several
megabytes and takes thousands of read() syscalls.

This patchseries adds an extensible KALLSYMS_QUERY ioctl() to
/proc/kallsyms with two query modes:
1. KALLSYMS_QUERY_BY_SYMBOL: Resolves a NUL-terminated symbol name to its
   address. Searches vmlinux first with binary search, then falls back to
   loaded modules. Matches names exactly (without stripping .llvm.<hash>
   suffixes) and rejects ambiguous symbols with different addresses.
2. KALLSYMS_QUERY_BY_ADDR: Resolves a kernel address to the symbol's
   name, covering vmlinux, loaded modules, BPF JIT programs, and ftrace
   trampolines.

Access control matches reading /proc/kallsyms directly: the ioctl checks
the kallsyms_show_value() result cached at open() time and returns -EPERM
whenever symbol addresses would be masked to zero.

There were significant performance improvements with this patchseries:

1. libbpf typeless ksym resolution (8-CPU x86-64 Cuttlefish VM, BPF
   object with 11 typeless ksyms):

   Metric                      Text parse  KALLSYMS_QUERY   Change
   --------------------------  ----------  ---------------  ------------
   Resolve 11 typeless ksyms   157 ms      0.7 ms           ~220x faster

2. Perfetto symbolization & callstack sampling (8-CPU x86-64 VM,
   175k-line /proc/kallsyms):

   Metric                      Text parse  KALLSYMS_QUERY   Change
   --------------------------  ----------  ---------------  ------------
   Init                        155.7 ms    0.44 ms          352x faster
   50k lookups                 25.2 ms     2.2 ms           11.7x faster
   traced_probes VmRSS         15.1 MB     4.8 MB           -68%
   traced_probes VmHWM         23.9 MB     4.8 MB           -80%

Changes in v2:
- Replaced the BPF syscall approach in libbpf with the more generalizable
  KALLSYMS_QUERY ioctl() on /proc/kallsyms, per Andrii
- Added KALLSYMS_QUERY_BY_ADDR for address-to-symbol lookup
- Added proc and bpf selftests and procfs documentation
- v1 link: https://lore.kernel.org/all/20261009130708.1370675-1-wusamuel@google.com/

Samuel Wu (6):
  kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
  tools: Copy KALLSYMS_QUERY definitions to linux/fs.h
  docs/procfs: Document KALLSYMS_QUERY ioctl on /proc/kallsyms
  libbpf: Resolve typeless ksyms via KALLSYMS_QUERY ioctl
  selftests/bpf: Test typeless module ksym resolution
  selftests/proc: Add KALLSYMS_QUERY tests

 Documentation/filesystems/proc.rst            |  15 ++
 include/uapi/linux/fs.h                       |  41 ++++
 kernel/kallsyms.c                             | 132 +++++++++++
 tools/include/uapi/linux/fs.h                 |  41 ++++
 tools/lib/bpf/libbpf.c                        |  78 ++++++-
 .../testing/selftests/bpf/prog_tests/ksyms.c  |   7 +
 .../testing/selftests/bpf/progs/test_ksyms.c  |   3 +
 tools/testing/selftests/proc/.gitignore       |   1 +
 tools/testing/selftests/proc/Makefile         |   1 +
 .../selftests/proc/proc-kallsyms-query.c      | 213 ++++++++++++++++++
 10 files changed, 530 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/proc/proc-kallsyms-query.c

-- 
2.56.0.257.gf7497c7d27-goog

