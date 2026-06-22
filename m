Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA67533ADB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782103183; cv=none; b=fvq1DcskhsULMJBe6lyBxzLABhqfEq1cLm2U1FaRk5y4mAiqjsJSUXBjHLTMirv8dVkiPY9WJ909n98+G4cAwn8JmxfuJFoHwsHgkzTLuDQP3ApXgj7VnZF7TPDyK3KiRGJuYqci876ibWuZxeywXlMKn7uAm7x/266coDnY0RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782103183; c=relaxed/simple;
	bh=QRlGIdhxVJez3ArgaIw3nHcRgcOp/IS9Jhys52DHq5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMDsRCiz03J0KT/XdHnPdFfP0FyRaaTCkA5p92QbaA4Nf5Q3q7EZXAzxPlRHqKU1YK2quxTOIXai+375BaS+ANDIBhdRZgzlI/BP6fBdcXEIcz4yQEBWkglqEjhTjL3PXwx4jZ/3oNMEgAaOkq5KK0Ec/ianfSoHmY6hCD+UQNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfFXE/RY; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfFXE/RY"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e71dd64ea2so1973790a34.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2026 21:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782103181; x=1782707981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LWLk8vwBsRQV/8chPVVuiTE+2TLYOW07i2z27bitdoE=;
        b=bfFXE/RYlxUv40EUqJ5obhRsAH5b7ql29tGvdA3nlKTxLHonmjAjQmQWSRlWm+qeGh
         0bZh6SKWi/r6hOAf8G2ft0y9gqi0ldUbaxdtiVQ0u7FJoDBTnkhhaLbQJI5V89SSx+/x
         fR64tGb4bb4w5rEb3WWU4GSuPfoHfTV7pn4PuFveOorKAcQhaKTyr+S0H975/7qKWNM8
         +Z45+f9evpl5hSb3l/nYkh1YuibdS8J01/LM2PQmnBxJFECJUrF73Sbu7d91P0qRbzrt
         6bRZFSgc07wxfaA/BQwrCI61pB+LA3efb6frq9VKzSbYQucSFf9pDgfItb9PA8bd0E1C
         JsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782103181; x=1782707981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWLk8vwBsRQV/8chPVVuiTE+2TLYOW07i2z27bitdoE=;
        b=WmjXfTxfnM0hn9E9hFeYJNJIpF2hxYbRYEP9AKDQuA8Gb9NJqP0gaC49GEIylihV8o
         lPbs5iSW+1XlkRE//dbtMv0YvzcyifElMY20lvKF9XQXU5+eI3vfoFf9zre5AIVKoBU2
         0YV1clMpKx8zGa9gIIGo9QuvzylxWKxpRHmJYQpSBOQHtTnKGcdAPL8mFOkKrKRCfdCs
         ahKl1yTMiUjkXGvKmuwx/3vaaGBz5PZ7mVUdDsXn3gGiVPuQd+pJjAlIQ5pc4oWir/hK
         j+FsfKP3EIyJ3SIGtC4ptLXVGO513bMiC/0kSLfbltCyQrUdLVyubSrtRwiW5uLc2RIg
         vKsA==
X-Forwarded-Encrypted: i=1; AFNElJ8p2CQDHpBK6YvySEWL6LQYuj1sjRfh26P0zA7HzCY6XHlWb69ppbLtILHnwu3yCeYq0SALtA7WQirmIutb@vger.kernel.org
X-Gm-Message-State: AOJu0YzHb4Rce0k6Gy+2HMN0n8yn0sK9jAb9KUCDtHJSX/VSbigk2ouL
	LdHq8V/j/StdCPyOrfhjD0Ej4zyhy7xMv4d1pejt/6Fb8X3sSOCUfOdL
X-Gm-Gg: AfdE7clBDgnF3ZNdmrnr1aovMJPDJz+KR0DpYjcGNqsqlsRzSF5Ik5F16oGJzVXlSgN
	fIzZrvf+E+A7DDpXDQS+aO88mh6MsW85mmCxD/EUUmpnjWiW0ob0zsOuT9X4rozy17qXRYRcLtm
	7drfppwjBh4PbhGK8fBIfEf6ELwDneI7U79pMJqm0y8h1fRYhkIpkWtgkJaA6Ld6YC/6aPzACab
	yUPTueAGfRln7KAjo37FFVxHs7liCyUYZ2JBrTHGJeQYyTqGeCt7gOWuavw7SvusFcuF2tUaKpS
	DRvyNrDNHwSJIpA0AvKc24cHBQRfYfB2lanLO/o2aUExhLizBBdMBxVy9K2+KieY0ayNxGo4mjX
	Ytz/B9YXoDbKTat1Z/HxeCX4+pGvstkYzY9pqxZ/jp67L1g/il1zHBnyU1kT+MfGXWnw5yQgJNY
	jySPV9mizaFRnWqzWizxrEPVcLOhRg46wMH6Zm6mWu/ATA
X-Received: by 2002:a05:6830:83aa:b0:7e6:f5bc:496 with SMTP id 46e09a7af769-7e92d8eedc8mr11244425a34.16.1782103180884;
        Sun, 21 Jun 2026 21:39:40 -0700 (PDT)
Received: from nyx.tail25a6.ts.net ([2605:59c8:74db:6e0c:3a80:a3f:f9f0:1b3c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9442ea144sm5428453a34.27.2026.06.21.21.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 21:39:40 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: kees@kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	shuah@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: [PATCH 0/2] fs: support $ORIGIN in ELF interpreter paths
Date: Sun, 21 Jun 2026 21:39:32 -0700
Message-ID: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, standard ELF and ELF FDPIC loaders require a fixed, absolute
path to the dynamic linker/interpreter (specified via PT_INTERP). This
creates significant inflexibility for relocatable dynamic interpreters,
where binaries are packaged independent of global system paths.

The primary goal of this patch series is to support relocatable binaries
in Nix, where packages are stored in a read-only store (typically /nix/store).
Allowing the ELF interpreter path to be resolved dynamically relative to
the binary's location via $ORIGIN enables Nix packages to be relocated
without needing patchelf or wrapper scripts.

For details on the design and motivation for this in Nix, see:
https://fzakaria.com/2026/06/21/nix-needs-relocatable-binaries

This series introduces support for resolving the $ORIGIN placeholder in 
the ELF interpreter path, bringing the kernel's binary loading behavior
in line with user-space dynamic linker origin resolution. 

To achieve this cleanly:
- We introduce a shared 'resolve_elf_interpreter()' helper in the VFS
  exec subsystem to avoid code duplication across loader implementations.
- For security, we restrict detection strictly to the prefix string
  "$ORIGIN" to prevent complex parsing exploits in kernel space.

Testing & Verification:
- Added a KUnit test case verifying path resolution logic.
- Added a kselftests integration test checking that a dynamically
  linked binary with its interpreter set to '$ORIGIN/mock_interp' successfully
  loads the mock interpreter (built statically using nolibc to avoid
  glibc TLS setup constraints during interpreter load-time).
- Verified end-to-end correct execution (PASS) using a minimal initramfs
  under QEMU.

Farid Zakaria (2):
  fs: support $ORIGIN in ELF interpreter paths
  selftests/exec: add test suites for $ORIGIN interpreter resolution

 fs/binfmt_elf.c                               | 11 ++++-
 fs/binfmt_elf_fdpic.c                         | 15 ++++++-
 fs/exec.c                                     | 42 +++++++++++++++++++
 fs/tests/exec_kunit.c                         | 26 ++++++++++++
 include/linux/binfmts.h                       |  2 +
 tools/testing/selftests/exec/Makefile         | 12 ++++--
 tools/testing/selftests/exec/mock_interp.c    |  6 +++
 tools/testing/selftests/exec/origin_interp.sh | 16 +++++++
 tools/testing/selftests/exec/test_prog.c      |  5 +++
 9 files changed, 128 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/exec/mock_interp.c
 create mode 100755 tools/testing/selftests/exec/origin_interp.sh
 create mode 100644 tools/testing/selftests/exec/test_prog.c

-- 
2.51.2

