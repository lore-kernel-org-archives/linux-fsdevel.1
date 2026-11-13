Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608036;
	b=RsNhYVIvikwnwusUxeExwh9At2i+HLmyHD56y+n3ZybQxBoPhVPonkr/vr4tLSYbmFYt
	 MVXMqw5t5NSpCCtFFw84WLNtEB1aVjgOt7gR4QeElUZBswqW5jZWyvecIScMVZEOHvdM6
	 Usu1iUa+50xnu3gM5jjnpytbiX6x9M5f2HX3akTQlxjnmcQ5LveuDIz0d5UK6eGNToNJc
	 DfwwklhMcSMAIjQv2UzzWixEENe3UKurHVq8kQ502OxLiN7uki+rAoVa1JOvPyTr4bP54
	 1SqYfIStr/rjmSsQ0ZmZv4zm1BFyybh8u0Uh4b5+mv8pvslDxSmVTB+D539M06sv++A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=NexZ2xLQ4LexIAyhPn8eStBsD+iuDC+wM/nvMrZ5LMk=;
	b=5Y/f1Yw8B8PyNp7A+RO34jKNd9GZrhMk30SmHiW5hD/DSOqxyaRhUylTAcr8JtPYabgE
	 q9Xsa0yEZQ6NJB9LSrCxd3ld4AsCMhhKyOW0yGv6NydoNwk5FLgHQtBSLVBU3a6EnoP6p
	 +0iGOAU+UpioxUNoP/AGq3nj13Bp4GXimwPzdcE7y9P4YA/jkgobOR7KEuJ8qJFRtb0Qv
	 DToh9z4W5df0Hzg4PW8a/d/EAusz+FbTDDnNNXp8MKFAyvsnhYBRk1BJcruJTAScoS7Lj
	 BpkGNnUI+4qmyeSlfZVwsSEiYxXoWW/4dzIl2DC9KYM7U3i4PDgj2Drl1O1jY1iyARw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d9EHKR6J;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289EB606A333
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 22:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 289EB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d9EHKR6J
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b62317d0so311712c88.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 14:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794608034; x=1795212834; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NexZ2xLQ4LexIAyhPn8eStBsD+iuDC+wM/nvMrZ5LMk=;
        b=d9EHKR6JclNFrRqlma/gegOnYEs8CGlfm9OVyxkdh+j70S4CRO8bf4suzcL32L/erp
         HjpKEftmM3vX2rkwT8iKePx6VhubP/KQG4uDrYMfeckOw1ZElyXNNE+broyp3f458C9F
         FvpCpznCuOUVu+KcA+kPeRPzOfOqjOCmMHku9AX1eDLdNhRslm/FCrJUxkZJBqQYJPtE
         IXhnbRk+8/9PUktOL1LwrT9pHTMocIPg27t5enT0/pe3q/j3cMJrXf0xgoS9gKpV7qjW
         x9BYaCCTO+sQ13y0dPs3KyTwbciGZCPcPs38bAc9sGLe3QCjEn6iQXCLaVvyP1J4Poqz
         Um3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608034; x=1795212834;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NexZ2xLQ4LexIAyhPn8eStBsD+iuDC+wM/nvMrZ5LMk=;
        b=XZOH2dyjXaZbJ9O0hn4Vy/kgWhH/K+b5Pq4jgC4V7IX34cUIHXatgw5SY4U2mCo+wT
         /VazW21aJKltYwRPJ8gV9wiBcaWOPNbakMsmuY42vNXvZJDG6Y/nIB+ZIqAyAY4f37ho
         3j7IF+b8dtrsXbBhk5Ceoj2X2t56Iu4XnB1KUBWjN8g3ldu5QYv9YFhbopUH9j8nfkqR
         OEHGcxNTudLlqqNlT+x4XA5FpEOSmZSmq6b+nZGwft4yiLAEU5hFixaGllokSeTOJ8Ek
         v5eZtOw6fxV1s9kyJz9/fUbykhqpiixCjL9pGnqo25fuIcF3JjH8cOnUrKKDfbuEbu3d
         4nuA==
X-Forwarded-Encrypted: i=1; AL+hErF+PIshxplo81f+jsoebhXpMny7IHbmD3A5/7iPrBmYZ0MzWaGmBGIhLXZbzoceUpB6Gmwulpnmaq+jJ5w0@vger.kernel.org
X-Gm-Message-State: APuU4Z/ucPsSl75l9pbV2+aIQEs1o2h2XmMFPmlP3SQyo/A5VkQ5q+Tq
	/TkmTqMawFhEO0t0l1sj8zpC4Tt8csg/JWBkFE+4tBJe4+3oWDuu88/PzSHJ1rFyM/qoTYL/+Gh
	nU4q6BO3nt+9haA==
X-Received: from dlep20-n1.prod.google.com ([2002:a05:701b:4594:10b0:1b2:375c:827])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:21c3:b0:1b3:a8a3:c6de with SMTP id a92af1059eb24-1b50306c4e1mr3614192c88.5.1794608033867;
 Fri, 13 Nov 2026 14:13:53 -0800 (PST)
Date: Fri, 13 Nov 2026 14:12:45 -0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261113221248.3535369-11-wusamuel@google.com>
Subject: [PATCH bpf-next v3 0/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME and
 KALLSYMS_QUERY_BY_ADDR ioctls
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

/proc/kallsyms is the primary interface for userspace to query the kernel
symbol table. However, resolving even a handful of symbols or addresses
requires reading and parsing the entire text file, which is often several
megabytes and takes thousands of read() syscalls.

This patchseries adds two ioctl() commands to interface /proc/kallsyms:
1. KALLSYMS_QUERY_BY_NAME: Finds a symbol by name, or be prefix with the
   KALLSYMS_QUERY_NAME_PREFIX flag. The default is to search vmlinux
   followed by modules, but userspace can specify a specific section with
   the optional module_filter. Each call returns one match along with the
   match position, such that subsequent ioctl() calls can continue with a
   (position + 1) call.
2. KALLSYMS_QUERY_BY_ADDR: Finds the symbol that covers query_addr. A
   caller that needs an exact match can compare input, query_addr, with
   the output, sym_addr.

Both commands fill a shared struct kallsyms_query_sym, with fields:
address, size, and optional name and module buffers. Buffer lengths are
in/out; on -ENAMETOOLONG the required sizes are still returned. As with
the text file, return values adhere to the same permissions (such as at
open() time), otherwise the ioctls fails with -EPERM.

For version compatibility, each struct carries its own size, so the
command values do not change when the structs grow.

libbpf uses KALLSYMS_QUERY_BY_NAME to resolve typeless ksyms. It matches
exact names plus "<name>.llvm." prefixes, as well as indicates if there
is name ambiguitiy; this keeps the semantics identical, while still
getting the performance benefit.

1. libbpf typeless ksym (8CPU Cuttlefish VM, BPF):
   Metric                      Text parse  KALLSYMS_QUERY   Change
   --------------------------  ----------  ---------------  ------------
   Resolve 11 typeless ksyms   152.6 ms    4.41 ms          ~35x

2. Perfetto symbolization (8CPU x86-64 VM, 175k-line):
   Metric                      Text parse  KALLSYMS_QUERY   Change
   --------------------------  ----------  ---------------  -------
   Init                        131.0 ms    0.04 ms          ~3000x
   50k symbolizations          28.6 ms     3.5 ms           ~8x
   traced_probes VmRSS         15.0 MB     4.5 MB           -70%
   traced_probes VmHWM         23.7 MB     4.5 MB           -80%

Note: Main reason v3 numbers are slower than v2 is that ambiguity
resolution in libbpf requires extra ioctl() calls.

Changes in v3:
- Add new and missing ioctls in ioctl-number.rst (Randy)
- Split into two ioctls() BY_NAME and BY_ADDR (Andrii, David)
- Add shared struct for both commands (Andrii)
- Add optional name and module inputs (Andrii)
- Encode size 0 in commands and keep the sizes in structs (Andrii)
- Add an optional module_filter (Andrii)
- BY_NAME searches vmlinux, modules, ftrace, BPF JIT and kprobes (Andrii)
- Add one-by-one pagination for BY_NAME (Andrii, David)
- Add prefix matching (David)
- Do not return hidden BPF JIT symbols (bpf-ci)
- libbpf: retain semantics (match ".llvm", fail on ambiguous matches) and
  fall back to text parser on error (bpf-ci, Andrii)
- Added module_kallsyms_find_name() as a separate patch
- Selftests: report skips with a reason (sashiko)
- v2 link: https://lore.kernel.org/all/20261023001603.560210-8-wusamuel@google.com/

Changes in v2:
- Replaced the BPF syscall approach in libbpf with the more generalizable
  KALLSYMS_QUERY ioctl() on /proc/kallsyms, per Andrii
- Added KALLSYMS_QUERY_BY_ADDR for address-to-symbol lookup
- Added proc and bpf selftests and procfs documentation
- v1 link: https://lore.kernel.org/all/20261009130708.1370675-1-wusamuel@google.com/

Samuel Wu (9):
  Documentation: ioctl-number: Add PROCFS_IOCTL_MAGIC range 0x10-0x11
  module: Add module_kallsyms_find_name()
  kallsyms: Add KALLSYMS_QUERY_BY_NAME ioctl to /proc/kallsyms
  kallsyms: Add KALLSYMS_QUERY_BY_ADDR ioctl to /proc/kallsyms
  docs/procfs: Document KALLSYMS_QUERY_* ioctls on /proc/kallsyms
  tools: Copy KALLSYMS_QUERY_* definitions to linux/fs.h
  selftests/proc: Add KALLSYMS_QUERY_* ioctl tests
  libbpf: Resolve typeless ksyms via KALLSYMS_QUERY_BY_NAME ioctl
  selftests/bpf: Test typeless module ksym resolution

 Documentation/filesystems/proc.rst            |   9 +
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 include/linux/kallsyms.h                      |   7 +
 include/linux/module.h                        |  13 +
 include/uapi/linux/fs.h                       |  56 +++
 kernel/kallsyms.c                             | 379 ++++++++++++++++++
 kernel/module/kallsyms.c                      |  57 +++
 tools/include/uapi/linux/fs.h                 |  56 +++
 tools/lib/bpf/libbpf.c                        |  99 ++++-
 .../testing/selftests/bpf/prog_tests/ksyms.c  |   9 +
 .../testing/selftests/bpf/progs/test_ksyms.c  |   4 +
 tools/testing/selftests/proc/.gitignore       |   1 +
 tools/testing/selftests/proc/Makefile         |   1 +
 .../selftests/proc/proc-kallsyms-query.c      | 248 ++++++++++++
 14 files changed, 939 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/proc/proc-kallsyms-query.c

-- 
2.56.0.679.gc527c65306-goog

