Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF648C3FD
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630136; cv=none; b=UeciEHf51ac9A3ACgeFQ5TMRVOvvozoGgxg8WtayN6ord7lS3h2eiOA6Z+a3Dy302h/uuAmCSweZZr5F2pWB24jzfNl1sMIErOtp+dpdMFUtYdZ1gHGVDolHOEkRc+EAfVyXOm/BejpsUZEdTek2P/7qhX4SgNxmpd7e7W54RlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630136; c=relaxed/simple;
	bh=dmNg9lAj5Y8tykAu2B+ztBcDmp1PpPWAHKFeqRnrelg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQGw7nDmzgwzNifEiZ8oHxHYVq0N8mqKnIAgmKHwX+O2Rx1eDgXce9soXno+eGoQEMKeqe1iQZrbhi13fPboXYOEvG/LS/OY8R4ToQEwaA33yJevhnCsot+7ko2yElI9rN6+ReIdNR1HtOHRfHZKwuXHUWS0lIrkyT9/mGNG1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtahaOW7; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtahaOW7"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c95d0a54ea5so8142414a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 03:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784630134; x=1785234934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5u2ao+Sq2Fj0mcPWhJLeoRnDPXPF0xpJUdkE+3TKpDM=;
        b=BtahaOW7bJciYy5+8cDHBWmF1mQA8Q/yXf82P5YkpIaWofRkF3VgUrhWn5DaXE6TDO
         49vaZk2g9ykxacBn+a2uicIbnAbWBnmnjjKvOgNtz6EPn+k1IOvT2eMjsjyFYdtXG2p9
         1MfUJSwXytapWFS4O4M83ajnTaBY7o1ZWwv1wrJxvCuFAkru2rnhwKFV9R43GDHyim9F
         9T49Nsal5EC5JpIU9B6k+hdX3JNDftiBVqE2agHuEMlkVu0EiRAJnsrMW+TCQ95LSX+V
         TbZA9MFagXsjTPtTeUw05GKGx0rlE0jaT4TqqVpyyt9fU2Qj4X4YsqZbeUklQs6rxhWS
         4MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630134; x=1785234934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5u2ao+Sq2Fj0mcPWhJLeoRnDPXPF0xpJUdkE+3TKpDM=;
        b=EV8/+kCGUMLCWuA9lgmtN04KpgpANfBkop8ajmkEWIKpP6ab85GAyG62hC/ZkN+OdG
         axlAgbJfdwQLEe75tlUymu41fSlFSxsdcmd5qUGU++Xks7NmL9f2Wqm0SKyN0Wbf38aX
         0ucrCgZfI6+rfCJWH8KLrOiSroawYa8MRY3R0ksQMhR5FqblDaugRspmrzT+lz7FIizl
         NAv1EqODBhRTIh/uqIOoNyOj9VJhQkERV4Iwmo6GqUN2UbKLJXVoGjwtcFET1kd4qfm9
         fn5GqfNYqoJIJTzof1SvJ/3mbbVYbYo/IeSjMPW36BGiezGEjAEWeJPrA2uAwfPAcqBO
         rtIA==
X-Forwarded-Encrypted: i=1; AHgh+Rpu6Traj5VWwdAEDXprKPhisMeARI8AWvVsseXN91hpVPPEGl4hex6c2G6GU3+1ZTKGErGsIQNUe8SskjOM@vger.kernel.org
X-Gm-Message-State: AOJu0YwkG6dZiwChCHO0Srt5mat4nvb82ooi+LHHjAup9nh91N9nZh/h
	fdPWZ6bmCB2qJGhGOp9dnRpsTMo3mwho/p9o45zS4AOKDM6jOnkv2B+L
X-Gm-Gg: AfdE7cmV4nRIoj1Y69QqY3dWFEWd/SC490A36T8EhsghTDiQ8Exx1ES3SsNe13djWk7
	tiRuOgYxf/dXeHt2heEzq1lHYJoh7GPYB64C9PDGHXBtqWJdnvCa4hW1RusdAG2wQiW+mHnN7gg
	M3bA/5AFeuP2T+0HPpUaUXanpFnDg8i2dO+zuxGlzP5C0gjSI2S2CWiStIxegmHlwvbFiUJGluo
	vKhtYAx6SK9xovL98uMfRmgUF7+OvmO/3/C4T/MsT+upduEYN75v+Xvcbh+2Jf9Vsr6vRlNL4m1
	PcuKxGXFg3HfN7RwlU2A5o6Z8Nugo/jFVvN3qP9erje96BSLrRWg/qUX+moNPC5vC6iysYZAZCf
	cneTuV/PWnY9kfAlwDT6VTvaGqDvcPCQm+p3TlILsr7+qGyTL6RADrD7brBu6MbFeQJUnC2a6T5
	hbETVf3Jx60wdx44s5BXq0oOW7JpTYxjJKj1W/mB2fj5tBWP+4W4kqPfpaRHwfV5yPWC+WSFJ1b
	HoBbOECK3B6xEmcU8XxN4UDroXCXr9MyFWb8tZn7mZllTTIYx3bmWWesp8EC+Nzrsp9j4RPYtFF
	T30DjVP3bV4GMTg=
X-Received: by 2002:a05:6a21:114c:b0:3c3:9ed1:2549 with SMTP id adf61e73a8af0-3c3ad95f80fmr18828549637.41.1784630134237;
        Tue, 21 Jul 2026 03:35:34 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-a.c.z168d0f9edf9bc766-tp.internal (114.107.87.34.bc.googleusercontent.com. [34.87.107.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20c158sm49922929eec.29.2026.07.21.03.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:35:33 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH v3 0/2] io_uring: add fremovexattr and flistxattr support
Date: Tue, 21 Jul 2026 10:35:12 +0000
Message-ID: <20260721103514.2716-1-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series completes io_uring's FD-based xattr operations by adding
support for:
- IORING_OP_FREMOVEXATTR
- IORING_OP_FLISTXATTR

This allows asynchronous xattr removal and listing.

New test cases have been added to the liburing test suite (test/xattr.c)
and verified to pass. A separate userspace patch implementing the matching
prep helpers, sanitizers, and test cases is submitted in parallel.

- Patch 1 makes the necessary VFS-layer list/remove helpers non-static
  and declares them in fs/internal.h.
- Patch 2 implements the io_uring operational support (opcodes, opdefs,
  preparation, and issue handlers) and invokes these exposed helpers.

Changes since v2:
- Revert unnecessary formatting changes to filename_listxattr in Patch 1.

Changes since v1:
- Omit path-based opcodes to prioritize optimal FD-based variants.
- Limit exported VFS helpers to only file_listxattr and file_removexattr.
- Rewrite standalone test program into a standard liburing testcase.

Aditya Prakash Srivastava (2):
  fs: make file_listxattr and file_removexattr helpers non-static
  io_uring: add fremovexattr and flistxattr support

 fs/internal.h                       |  2 +
 fs/xattr.c                          |  3 +-
 include/uapi/linux/io_uring.h       |  2 +
 io_uring/opdef.c                    | 18 +++++++
 io_uring/xattr.c                    | 74 +++++++++++++++++++++++++++++
 io_uring/xattr.h                    |  6 +++
 tools/include/uapi/linux/io_uring.h | 13 +++++
 7 files changed, 116 insertions(+), 2 deletions(-)

-- 
2.47.3
