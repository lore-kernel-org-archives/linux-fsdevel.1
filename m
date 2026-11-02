Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616453;
	b=ei6dp0iHOeZ8hRLMfjrrVUpDynlqJLMc+9QlMkMzyquax1pcgzaP66giNw0BCmztQB/5
	 WnfSkebdtdoiUoJXEQchxazloRNHhieNHwBIa4A1aJeSOael9SY4rhMzcmv9KZ8vEsU7Z
	 eEgAQ7Az3wGaCJK/rhOhBCMCf3kBid0tBnLU1otJR4uDOVySOkeMzwn5OHyh1OuZ8zDus
	 YaV2yc/c81VU+o5RO+CX0Kc/ieIgW8CfXpSVELS8apcTTMXTpH7uZ7ZqZ0NDHdUusbPQ/
	 l9k+35twNwdYAg67lx1nfJLFl/WnlqXQXuPhuC24EVdZ+jlvt/Z/rcMbSEsrZghjvug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+wYgEbXatInkhlPGnHVcGcwQYZRiNvBT23gLhEtY+s8=;
	b=fHe11J576vwf4awbgPcLp0U4+rMM6D12zVvsoPnLGAWnpTK3ia2pGb3Fbq/ix8+FtyOI
	 3y17Wtf3rJzX71RjSNCPgjUc7PjZctop113qF13NGiQFo4unTx1Y1l8zoGal0o8kyvs0q
	 +SRN/f/CofanXx9n8+ElXrEyo1vfqj7czCK1au0jOoJ9+kVTS7+xCOabkLEfKZdNgMbRp
	 2b8B49OUGF4MrMMc2EanwjKOETIAxf/rmBwPc4pNO/shgIFgcE/jhkhUn0yO/9Hznt7pK
	 vL7jCPykErwHtBaWKaezcMdHFGYLwVyhHOtayf3VX9NOZ43EZsW4RNpEH1SqXw5vJNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sqjGWtQ2;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D7606A32E
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 10:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 591D7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sqjGWtQ2
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso24709795e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 02:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793616452; x=1794221252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wYgEbXatInkhlPGnHVcGcwQYZRiNvBT23gLhEtY+s8=;
        b=sqjGWtQ2vRyV8uRUrKbKazN0/I5yAXVv0XsmmtzJP2PWcgyWFv0XwS4JyAkNm7if5T
         z7+tFrnln7t+7w0TjwsmYJnYzdWcY/mMqA/tXmzfQjuxNa0aG8/11k7V5jih1qwPZwT9
         fnfQpaJ1AYrWYq7Tpuviy+oezxAHgjZgnHFVj4RQctBmluhqGP1BEbZQGqFwfhmZqKNH
         Uw+JjXtuRV9y5pG/ir0cneBBuMBfxVJOK5/1B0eByYgQ9plGzJwNDkfAqcXFhJ07Jyhr
         RKeSFOEzpZJkfOthYqigZXqihmV4FRH2ABIBvIHX6o9crUJDy/pQeQVT223PDBjAxXmq
         dMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616452; x=1794221252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wYgEbXatInkhlPGnHVcGcwQYZRiNvBT23gLhEtY+s8=;
        b=pxWW+nNgiQBLYcDzD7wfj44gQLY2xy0KJu2wBAwvVHIXmAHh1ED1PiPLyzxhq+dTJO
         xvfofboTRAHG9ClmA1Rcn9fy9n4RgXEv14AnG0hNLjLgDEY1UHy1x2MpewXpunU5672D
         1KX7M+vrekNdMfrVHSwD0sZGSnua/P3+JzOBdfWalSIIGW/Uk9jS/8xiYQBWK4XBd0Wx
         sq5K2/JaJ872WatzkquvKUir70aJVPDg1rCEjdqSC8uICnsOX3dRQXrt3VvPTCA4hPLH
         5TLSrKSWgWdAdaEp1lDE/ePR6IP+yWLcTPbh0LR3ZTqKhMcc7OIWuoZ53MCWz3SXxEwi
         NEgg==
X-Forwarded-Encrypted: i=1; AKwUvBzqKKDzkl4d8FLy/F4aaZW9714qoU59GOEvSvYeaqY0jvb50XACu99UH57zgYh/sbj2wgjauwjvhbdTuXM8@vger.kernel.org
X-Gm-Message-State: AFq9FYJjnSII0xe1KRrhs1qaWrK4+cwsZsh4+X9MV8OfNu34Kl1di8Dr
	I2Ctwos9CK3zyIsGtmw22xQEHiqw0ss8sBBnyYyDmiwvnjElCiwM+8Up
X-Gm-Gg: AYBFou2TT6KI//8gov9iD/2d4wVuQ6FITSYxjJqEtXNUNISVPB5O5hKz59C1FqkqbD4
	CT4dOMIeREmEoB418eki2foyETXS4Yqu3gq21kEfHB5n6KUAe/WQ9KarNLZgOZiVyMuUIdws1E8
	6w+bbgHzUsnto1o7ETJh53FUebnzF9KWbarg1gbWj+c0l8Ykx15jU1M7eGfM7WNZSxGZPWz/DRA
	b3Ww2BDSEMI542syv25CvqJblCWZbmE6lkZSHNxMos/++0QHJji28vqNgilNG1Clowi3rugK3JZ
	zO8rfp8MaXM913C2ER74UMJvO0GnZZ1tAzqo/ZheZzjDS3yVerL9JSndHS/tC3rbXDogCWJIszR
	6LXwWXTvmiUbxMgQMtyWwkJcQdPW6qpGyiycle38s3U7ijxiBJu+UR2BXeuw2GmPLddqkMzUhZM
	M0qCd+aXhOqoa+BmCm0FtHObSpI/srhtUFu/OqC/QGM+/sU7OwytGA/QdQySyvBcSy1cNsMVhsD
	M6ggnA2D0O60JxFaq6q8D88KWhJBRFehIM2OHbZJJJuJqPM1AaKJBWel9+TlW+zQZaTfFhWmmae
	pTZaY8GdG4RI8REvuwK2VTyfGwfPtpfLBh4mVC0JhO5J
X-Received: by 2002:a05:600c:c09b:b0:4b0:c1ae:829 with SMTP id 5b1f17b1804b1-4b0c1ae0ad5mr54814305e9.30.1793616451558;
        Mon, 02 Nov 2026 02:47:31 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c7852esm248939695e9.11.2026.11.02.02.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:47:30 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: brauner@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	tasos.papagiannnis@gmail.com
Subject: [PATCH vfs-7.5.bpf v2 0/3] bpf: Add bpf_path_getattr()
Date: Mon,  2 Nov 2026 12:46:52 +0200
Message-ID: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Userspace code can populate BPF maps using file identities obtained from
stat() and related system calls. BPF LSM programs need matching inode and
device numbers to look up those entries. Reading inode fields directly can
give different values on overlayfs and miss filesystem-specific getattr
behavior.

bpf_real_data_inode() resolves the inode hosting a file's data, whose
identity and metadata can differ from those reported by stat() and related
system calls on overlayfs. It does not invoke the filesystem's getattr
operation.

This series adds bpf_path_getattr() for sleepable LSM programs. It takes a
trusted path and calls vfs_getattr_nosec() to avoid calling back into
security_inode_getattr().

The kfunc returns struct kstat. Inode and device identity follow the
filesystem's getattr operation.

Selftests compare basic fields with statx() on tmpfs and on overlayfs
before and after copy-up, accounting for device encoding, and exercise
verifier restrictions. The series also updates the relevant documentation.

Changes in v2:
- Use a thin vfs_getattr_nosec() wrapper returning struct kstat. (Alexei)
- Remove struct bpf_file_stat. (Alexei)
- Update the documentation and tests.
- Rebase onto vfs-7.5.bpf for merging through the VFS tree. (Daniel)

v1:
https://lore.kernel.org/bpf/20261029095952.44833-1-tasos.papagiannnis@gmail.com/

Anastasios Papagiannis (3):
  bpf: Add bpf_path_getattr()
  docs/bpf: Document bpf_path_getattr()
  selftests/bpf: Test bpf_path_getattr()

 Documentation/bpf/fs_kfuncs.rst               |  13 ++
 fs/bpf_fs_kfuncs.c                            |  38 +++-
 .../selftests/bpf/prog_tests/path_getattr.c   | 162 ++++++++++++++++++
 .../selftests/bpf/progs/path_getattr.c        |  42 +++++
 .../bpf/progs/verifier_path_getattr.c         |  57 ++++++
 5 files changed, 311 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_getattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_getattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_path_getattr.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

