Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494467;
	b=eSF76F0CCZBxzu2X/9CxLuN4Kwi4F2g+RAif4K+z4w2WMiDkFz3h1G8eKLn4QXEXqwzx
	 BMP4SzjYDz8fdIiwpPLVtCn0OADrnUDcaK7912G8mGcFcLhF0GNn0P1x1iIc8vV7YTp5h
	 Dq7cIzfOjN//XpgrdmF5goRAnpNE2HdhSvZ3M2K2WvFYIevkZLFJsCP8E+7GqDGyf+8zh
	 t3xoRJx+HRmJe+PbVuVBZRSjn9gYRhwvAo+9di8EK4WxT1K8jmz0Pk+MbR/SvMXSbJZyN
	 wNvU1B3vC1gpgmWJBozmWaQyxPzeI8wAFhkQF9sddIwXFSWFUd2G1jvBgLS6DpGe5sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494467;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=sKy1jUZA7RLgVib6ZebQIdzgVIZ+BsYQkyQaJ0c2W5M=;
	b=ewiZ6uh9MFiRDBuljT5CKBt5xj5JSqt4pTSjjn5c1Z9wRo616ePIKqcryKFzYnz4puqv
	 heApZV9BvaNaphK+23IuxVmfJPsgwiBc9hDZj5ZbBqxn4Q1cCqpHwIoZhBIhqRF0XnZa/
	 tydIK2pJdFvbkYIEVxtkPNTyD/TqCQSQJ8BUQPQd0o/AsZ0V+TxufJA2zTRB+zT4gm6L+
	 sT3oRRBlQ9oLxuGBIwerQE0KwmPG9nArX+noqulzGu8SOCXETvnGjY3FqPy1Au8JGwsOV
	 ADRIp/UjR64YzsRBGpujNuOhIJ2Sapragd1vs4FWMN5dXcAAc0gSCnNLKADlGkJXeOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CGYGQpkC;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A93606A31A;
	Tue, 20 Oct 2026 11:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14A93606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CGYGQpkC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sK
	y1jUZA7RLgVib6ZebQIdzgVIZ+BsYQkyQaJ0c2W5M=; b=CGYGQpkCRPZj5RrbhU
	PFlxfpruG4ipV0xJeFxq9H+R365vFftHI4Q9R9G66ev5k7nkYzfSBmdEQs0rotRe
	lKxsHQpzxASzwfaLRHzSfs0Q/yifhWLItjROC/h92ifhHy/fGI4bu+ufTlhR64pG
	FlSxt180h7YhwIrPtUv690FAE=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnD0x1S9dqNFYiBg--.2734S2;
	Tue, 20 Oct 2026 19:07:34 +0800 (CST)
From: shaos <shawnq1@163.com>
To: brauner@kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] fs: listns and listmount wrap UINT64_MAX cursors
Date: Tue, 20 Oct 2026 11:07:32 +0000
Message-Id: <20261020110732.959552-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wDnD0x1S9dqNFYiBg--.2734S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1rGF15XFWDKw1rKw1kuFg_yoW8trykpa
	93tayFk3ZrK3WUGw4vqFW8ua1Ikr97Kw4UJFn8X348Zay3JwsFkr1fC3WYqFWUur95Ga4F
	yay0q3WUuws8XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKJPiUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzxaAjmrXS3ZHnwAA3P

Hello,

Both listns() and listmount() use a cursor representing the last returned ID, then advance it by one before looking up the next entry. With UINT64_MAX, that addition wraps to zero and restarts enumeration at the first visible entry.

The unprivileged probe reproduced this in listns() with unified, user-type, and owner filters: a UINT64_MAX cursor returned the same first page as cursor zero, while UINT64_MAX-1 returned ENOENT. It also reproduced the wrap in listmount(): with mnt_id=LSMT_ROOT selecting the root mount and param as the pagination cursor, param=UINT64_MAX returned the same first mount ID as param=0, while UINT64_MAX-1 returned no entries. LSMT_ROOT is the mount selector here; param is the cursor.

The test ran as UID 65534. This is an enumeration correctness bug; I do not claim a permission bypass or security-boundary impact.

HEAD commit:    24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
source version: Linux 7.3.0-rc7
architecture:   x86-64
compiler:       gcc 11.4.0, GNU ld 2.38
QEMU:           6.2.0

console output: https://gist.githubusercontent.com/shaos26/b969791763b73e5897a3e749e31ea0af/raw/6abe5584dcb21dabe3f1e32611885bafe469a67a/console-output.txt
kernel config: https://gist.githubusercontent.com/shaos26/b969791763b73e5897a3e749e31ea0af/raw/9f9827ed98f86fd3364ef758da73936884e02ea3/kernel-config.txt
reproducer: https://gist.githubusercontent.com/shaos26/b969791763b73e5897a3e749e31ea0af/raw/986396bf363269b001cee6adac6a69781d52f6d6/poc.c

Build the kernel from the revision above with the attached config and place the static probe at /init in the supplied initramfs. A fresh unprivileged replay used:

    timeout 120 qemu-system-x86_64 -accel tcg,thread=single -cpu max \
        -m 1024 -smp 1 -kernel artifacts/bzImage \
        -initrd artifacts/initramfs-r02-unpriv.cpio.gz \
        -append "console=ttyS0 rdinit=/init panic=-1 oops=panic nokaslr loglevel=7" \
        -nographic -no-reboot

The guest reported RESULT=CURSOR_WRAP_OBSERVED as UID 65534 and exited cleanly. I checked the affected cursor additions at f47d223627f8; runtime validation was on v7.3-rc7.

Thanks,

shaos

