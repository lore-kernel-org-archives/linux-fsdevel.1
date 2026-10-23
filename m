Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.3.242.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720489;
	b=ppn1LXmy01zmJA3U72htKW+sk50u7+yabc9Fw8/PpQVTIeXCVuaR+RUESFkbXKPAiSPK
	 H2+W2mPL/UmKm8aM5Y31iKOww2oEICK8oARl9vO1KBJ6jtEY4i08rpNmWg18lzjhbY6fg
	 BqZEmxxLaEKSpGmekKRtuUsC/vyAFq8hr+tW3JnVjGNNp/jdFB7McJRQoNvTTzjlBDrBJ
	 xo+Jb3IU1SnNQYmuYFioyolT/HNTlaOQp2bAqg3uaui9kYZ/tLQJ0jAMsLJQ6ybTOQcZa
	 yHOxhjuFA/vKEYthise6GZ/t4+9vmjbQ1581cJS+yE/4Wub7EFhl5DWT91SoBCET77Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720489;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CO-INDEX;
	bh=PJkZhkXXrchYq4gsC5K2d7L85eJ1XLiR7+w6n85/cPg=;
	b=wSI5z0ZOED8x0ZVF1t/WBrkCH/LV9ski38yD7usluUEGo2icpD/YAoXvI8e2hiCq2O3b
	 DRHa4Lke1Z9tZlpoe0nF7mlZlVo6jg2YiA3kKKvIb9lg2ZKJKEp19SdrYyl8WJI5KYo0P
	 BNhaUcHpEVsAyfBj7X1PxIhBaBY8WEfp021Tp1OtSgyOdYjOIjH7i8R6xivyHpOi/1GuR
	 yfhTlye+5Sy/TpSG7EMEHsnMXFGuBfHnwdtl66o8Xy8tALFcfctMzeMLZx2kbp7hf9DG+
	 igRkD8fWqlJFjfdVsAupHHXPD4FiWJ/7t2gRqPzwwP2RLH73F5aooi+x1oDtmugLHag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailfence.com;
	spf=pass smtp.mailfrom=mailfence.com;
	dkim=pass header.d=mailfence.com header.i=brianwitte@mailfence.com header.a=rsa-sha256 header.s=20240605-akrp header.b=FubXlR6z;
	arc=none smtp.remote-ip=212.3.242.97
Received: from mailout-l3b-97.contactoffice.com (mailout-l3b-97.contactoffice.com [212.3.242.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E06606A31A;
	Fri, 23 Oct 2026 01:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00E06606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailfence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailfence.com header.i=brianwitte@mailfence.com header.a=rsa-sha256 header.s=20240605-akrp header.b=FubXlR6z
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
	by mailout-l3b-97.contactoffice.com (Postfix) with ESMTP id 1EB2A60A8;
	Fri, 23 Oct 2026 03:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792720477;
	s=20240605-akrp; d=mailfence.com; i=brianwitte@mailfence.com;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From;
	bh=PJkZhkXXrchYq4gsC5K2d7L85eJ1XLiR7+w6n85/cPg=;
	b=FubXlR6z1yM5mVmHNiqSXEFKDp30ljJDES3DB5U9Ify16xMUoLFYMQ//XPSHuHNO
	N/MjJqVhRoCj1/eRDwfWz6ovg1HmcOT7Mn2WrSks/5hhVGzXekxABaPQt1o7N+Y8l/7
	Tk1CSB1xneHqutOwSrNY3Gk3FQUkzR1TtwNKBErskGd4fr+sviDRirHXtoqGQWWU2QC
	aWt4P+iWGupxjYi+VKbuBbFZ7e9q2+oLf9ryhkb0q0JHGjPPkAT2LRnb5mfM0SXdjvS
	K8cWA2xZN/d9Nre63mB/6KyYaj7TAwqDa1XJqn5iHwV9et72wdJulRJci+pjoWUXPEA
	hGjF9g1UFA==
Received: by smtp.mailfence.com with ESMTPSA ; Fri, 23 Oct 2026 03:54:36 +0200 (CEST)
From: Brian Witte <brianwitte@mailfence.com>
To: Kees Cook <kees@kernel.org>
Cc: Brian Witte <brianwitte@mailfence.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Jann Horn <jannh@google.com>,
	Helge Deller <deller@gmx.de>,
	Justin Stitt <justinstitt@google.com>,
	Daniel Micay <danielmicay@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] exec: randomize the argument block's in-page offset
Date: Fri, 23 Oct 2026 03:54:37 +0200 (CEST)
Message-ID: <20261023015345.1594514-1-brianwitte@mailfence.com>
X-Mailer: git-send-email 2.47.3
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
X-CO-INDEX: xeqgj8PHouPosme+woQh6pFtig5yQF5AvYLqRg7GJhc=

Patch 1 randomizes where the argv, envp and execfn strings sit within
the first stack page, as KSPP issue 283 asks; today their low address
bits never change. Patch 2 adds a selftest.

Patch 1 repeats bprm_fill_uid()'s set-id checks; I can send a shared
helper as a preparatory patch if preferred.

Tested in QEMU, compared with unpatched for-next/execve (b36b990c50b1),
on x86_64 with ia32, arm64 (4K pages with AArch32, and 64K pages), and
parisc 32-bit and 64-bit (STACK_GROWSUP):

 - The selftest passes; unpatched, it fails.
 - 10000 execs give 3709-3764 distinct offsets with 4K pages and 9259
   with 64K, as a uniform draw predicts.
 - Cost: about 0.5 more minor page faults per exec on average, and up
   to a page of RLIMIT_STACK; exec time is within noise.
 - No change in LTP execve and execveat, CRIU dump and restore, or
   programs that rewrite argv[0] (setproctitle(), sshd, postgres), and
   no KASAN, UBSAN or lockdep reports under exec and chmod races.

The series is based on mainline (864c07de0c7d), which now includes
for-next/execve and the const mnt_idmap conversion. On that base it adds
no W=1 warnings with GCC 14 or clang 19 on x86_64 and arm64, and the
selftest passes on x86_64.

Brian Witte (2):
  exec: randomize the argument block's offset within its page
  selftests/exec: test the argument block's in-page offset

 fs/exec.c                                     |  32 +++
 tools/testing/selftests/exec/.gitignore       |   3 +
 tools/testing/selftests/exec/Makefile         |   5 +
 .../testing/selftests/exec/argblock-offset.c  | 214 ++++++++++++++++++
 .../testing/selftests/exec/argblock-report.c  |  24 ++
 5 files changed, 278 insertions(+)
 create mode 100644 tools/testing/selftests/exec/argblock-offset.c
 create mode 100644 tools/testing/selftests/exec/argblock-report.c


base-commit: 864c07de0c7dcbca58b61625dfa2e461ae63b242
-- 
2.47.3

